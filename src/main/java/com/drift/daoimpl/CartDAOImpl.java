package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.CartDAO;
import com.drift.model.CartItem;
import com.drift.util.DBConnection;

public class CartDAOImpl implements CartDAO {

    @Override
    public boolean addToCart(int userId, int productId, int quantity) {

        try (Connection connection = DBConnection.getConnection()) {

            String findCartSql =
                    "SELECT cart_id FROM cart WHERE user_id = ?";

            int cartId = 0;

            try (PreparedStatement ps =
                    connection.prepareStatement(findCartSql)) {

                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                }
            }

            if (cartId == 0) {

                String createCartSql =
                        "INSERT INTO cart (user_id) VALUES (?)";

                try (PreparedStatement ps =
                        connection.prepareStatement(
                                createCartSql,
                                Statement.RETURN_GENERATED_KEYS)) {

                    ps.setInt(1, userId);

                    ps.executeUpdate();

                    ResultSet rs = ps.getGeneratedKeys();

                    if (rs.next()) {
                        cartId = rs.getInt(1);
                    }
                }
            }

            String checkItemSql =
                    "SELECT cart_item_id, quantity " +
                    "FROM cart_items " +
                    "WHERE cart_id = ? AND product_id = ?";

            try (PreparedStatement ps =
                    connection.prepareStatement(checkItemSql)) {

                ps.setInt(1, cartId);
                ps.setInt(2, productId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    int cartItemId =
                            rs.getInt("cart_item_id");

                    int oldQuantity =
                            rs.getInt("quantity");

                    String updateSql =
                            "UPDATE cart_items " +
                            "SET quantity = ? " +
                            "WHERE cart_item_id = ?";

                    try (PreparedStatement updatePs =
                            connection.prepareStatement(updateSql)) {

                        updatePs.setInt(
                                1,
                                oldQuantity + quantity
                        );

                        updatePs.setInt(
                                2,
                                cartItemId
                        );

                        return updatePs.executeUpdate() > 0;
                    }

                } else {

                    String insertSql =
                            "INSERT INTO cart_items " +
                            "(cart_id, product_id, quantity) " +
                            "VALUES (?, ?, ?)";

                    try (PreparedStatement insertPs =
                            connection.prepareStatement(insertSql)) {

                        insertPs.setInt(1, cartId);
                        insertPs.setInt(2, productId);
                        insertPs.setInt(3, quantity);

                        return insertPs.executeUpdate() > 0;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public List<CartItem> getCartItems(int userId) {

        List<CartItem> cartItems = new ArrayList<>();

        String sql =
                "SELECT " +
                "ci.cart_item_id, " +
                "ci.cart_id, " +
                "ci.product_id, " +
                "ci.quantity, " +
                "p.product_name, " +
                "p.price, " +
                "p.image " +
                "FROM cart_items ci " +
                "JOIN cart c " +
                "ON ci.cart_id = c.cart_id " +
                "JOIN products p " +
                "ON ci.product_id = p.product_id " +
                "WHERE c.user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItem item = new CartItem();

                item.setCartItemId(
                        rs.getInt("cart_item_id")
                );

                item.setCartId(
                        rs.getInt("cart_id")
                );

                item.setProductId(
                        rs.getInt("product_id")
                );

                item.setQuantity(
                        rs.getInt("quantity")
                );

                item.setProductName(
                        rs.getString("product_name")
                );

                item.setPrice(
                        rs.getDouble("price")
                );

                item.setImage(
                        rs.getString("image")
                );

                cartItems.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }


    @Override
    public boolean updateQuantity(
            int cartItemId,
            int quantity,
            int userId) {

        if (quantity < 1) {
            return false;
        }

        String sql =
                "UPDATE cart_items ci " +
                "JOIN cart c " +
                "ON ci.cart_id = c.cart_id " +
                "SET ci.quantity = ? " +
                "WHERE ci.cart_item_id = ? " +
                "AND c.user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean removeFromCart(
            int cartItemId,
            int userId) {

        String sql =
                "DELETE ci " +
                "FROM cart_items ci " +
                "JOIN cart c " +
                "ON ci.cart_id = c.cart_id " +
                "WHERE ci.cart_item_id = ? " +
                "AND c.user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean clearCart(int userId) {

        String sql =
                "DELETE ci " +
                "FROM cart_items ci " +
                "JOIN cart c " +
                "ON ci.cart_id = c.cart_id " +
                "WHERE c.user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps =
                     connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() >= 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}