package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.OrderDAO;
import com.drift.model.CartItem;
import com.drift.util.DBConnection;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public boolean placeOrder(
            int userId,
            String shippingAddress,
            String paymentMethod,
            double totalAmount,
            List<CartItem> cartItems) {

        Connection connection = null;

        try {

            connection = DBConnection.getConnection();

            if (connection == null) {
                return false;
            }

            // =========================================
            // START TRANSACTION
            // =========================================

            connection.setAutoCommit(false);


            // =========================================
            // 1. CHECK STOCK
            // =========================================

            String stockCheckSql =
                    "SELECT stock " +
                    "FROM products " +
                    "WHERE product_id = ? " +
                    "AND is_active = TRUE " +
                    "FOR UPDATE";

            try (PreparedStatement ps =
                    connection.prepareStatement(stockCheckSql)) {

                for (CartItem item : cartItems) {

                    ps.setInt(
                            1,
                            item.getProductId()
                    );

                    try (ResultSet rs =
                            ps.executeQuery()) {

                        if (!rs.next()) {

                            System.out.println(
                                    "Product not found or inactive: "
                                    + item.getProductId()
                            );

                            connection.rollback();

                            return false;
                        }

                        int availableStock =
                                rs.getInt("stock");

                        int requestedQuantity =
                                item.getQuantity();


                        // =================================
                        // INSUFFICIENT STOCK
                        // =================================

                        if (requestedQuantity <= 0 ||
                            requestedQuantity > availableStock) {

                            System.out.println(
                                    "Insufficient stock for product: "
                                    + item.getProductId()
                            );

                            System.out.println(
                                    "Available: "
                                    + availableStock
                                    + " | Requested: "
                                    + requestedQuantity
                            );

                            connection.rollback();

                            return false;
                        }
                    }
                }
            }


            // =========================================
            // 2. INSERT ORDER
            // =========================================

            String orderSql =
                    "INSERT INTO orders " +
                    "(user_id, total_amount, shipping_address, " +
                    "payment_method, order_status) " +
                    "VALUES (?, ?, ?, ?, ?)";

            int orderId;

            try (PreparedStatement ps =
                    connection.prepareStatement(
                            orderSql,
                            Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(
                        1,
                        userId
                );

                ps.setDouble(
                        2,
                        totalAmount
                );

                ps.setString(
                        3,
                        shippingAddress
                );

                ps.setString(
                        4,
                        paymentMethod
                );

                ps.setString(
                        5,
                        "PLACED"
                );


                int rows =
                        ps.executeUpdate();


                if (rows == 0) {

                    connection.rollback();

                    return false;
                }


                try (ResultSet rs =
                        ps.getGeneratedKeys()) {

                    if (!rs.next()) {

                        connection.rollback();

                        return false;
                    }

                    orderId =
                            rs.getInt(1);
                }
            }


            // =========================================
            // 3. INSERT ORDER ITEMS
            // =========================================

            String orderItemSql =
                    "INSERT INTO order_items " +
                    "(order_id, product_id, quantity, price) " +
                    "VALUES (?, ?, ?, ?)";

            try (PreparedStatement ps =
                    connection.prepareStatement(
                            orderItemSql)) {

                for (CartItem item : cartItems) {

                    ps.setInt(
                            1,
                            orderId
                    );

                    ps.setInt(
                            2,
                            item.getProductId()
                    );

                    ps.setInt(
                            3,
                            item.getQuantity()
                    );

                    ps.setDouble(
                            4,
                            item.getPrice()
                    );

                    ps.addBatch();
                }

                ps.executeBatch();
            }


            // =========================================
            // 4. DEDUCT STOCK
            // =========================================

            String stockUpdateSql =
                    "UPDATE products " +
                    "SET stock = stock - ? " +
                    "WHERE product_id = ? " +
                    "AND stock >= ? " +
                    "AND is_active = TRUE";


            try (PreparedStatement ps =
                    connection.prepareStatement(
                            stockUpdateSql)) {

                for (CartItem item : cartItems) {

                    int quantity =
                            item.getQuantity();


                    ps.setInt(
                            1,
                            quantity
                    );

                    ps.setInt(
                            2,
                            item.getProductId()
                    );

                    ps.setInt(
                            3,
                            quantity
                    );


                    int rows =
                            ps.executeUpdate();


                    /*
                     * If no row was updated,
                     * stock was not sufficient
                     * or product became inactive.
                     */

                    if (rows == 0) {

                        connection.rollback();

                        return false;
                    }
                }
            }


            // =========================================
            // 5. CLEAR USER CART
            // =========================================

            String clearCartSql =
                    "DELETE ci " +
                    "FROM cart_items ci " +
                    "JOIN cart c " +
                    "ON ci.cart_id = c.cart_id " +
                    "WHERE c.user_id = ?";


            try (PreparedStatement ps =
                    connection.prepareStatement(
                            clearCartSql)) {

                ps.setInt(
                        1,
                        userId
                );

                ps.executeUpdate();
            }


            // =========================================
            // 6. COMMIT TRANSACTION
            // =========================================

            connection.commit();

            System.out.println(
                    "Order placed successfully. Order ID: "
                    + orderId
            );

            return true;


        } catch (Exception e) {

            e.printStackTrace();


            // =========================================
            // ROLLBACK
            // =========================================

            if (connection != null) {

                try {

                    connection.rollback();

                } catch (SQLException rollbackException) {

                    rollbackException.printStackTrace();
                }
            }

            return false;


        } finally {

            if (connection != null) {

                try {

                    connection.setAutoCommit(true);

                    connection.close();

                } catch (SQLException e) {

                    e.printStackTrace();
                }
            }
        }
    }



    // =====================================================
    // GET ITEMS FOR A SPECIFIC ORDER
    // =====================================================

    @Override
    public List<CartItem> getOrderItems(int orderId) {

        List<CartItem> orderItems =
                new ArrayList<>();


        String sql =
                "SELECT oi.product_id, " +
                "       oi.quantity, " +
                "       oi.price, " +
                "       p.product_name, " +
                "       p.image " +
                "FROM order_items oi " +
                "JOIN products p " +
                "ON oi.product_id = p.product_id " +
                "WHERE oi.order_id = ? " +
                "ORDER BY oi.order_item_id ASC";


        try (Connection connection =
                    DBConnection.getConnection();

             PreparedStatement ps =
                    connection.prepareStatement(sql)) {


            ps.setInt(
                    1,
                    orderId
            );


            try (ResultSet rs =
                    ps.executeQuery()) {


                while (rs.next()) {

                    CartItem item =
                            new CartItem();


                    item.setProductId(
                            rs.getInt("product_id")
                    );


                    item.setQuantity(
                            rs.getInt("quantity")
                    );


                    item.setPrice(
                            rs.getDouble("price")
                    );


                    item.setProductName(
                            rs.getString(
                                    "product_name"
                            )
                    );


                    item.setImage(
                            rs.getString("image")
                    );


                    orderItems.add(item);
                }
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        return orderItems;
    }
}