package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.OrderHistoryDAO;
import com.drift.model.Order;
import com.drift.util.DBConnection;

public class OrderHistoryDAOImpl implements OrderHistoryDAO {

    @Override
    public List<Order> getOrdersByUserId(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "WHERE user_id = ? " +
                "ORDER BY order_id DESC";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Order order =
                        createOrderFromResultSet(rs);

                orders.add(order);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    @Override
    public List<Order> getAllOrders() {

        List<Order> orders = new ArrayList<>();

        String sql =
                "SELECT * FROM orders " +
                "ORDER BY order_id DESC";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql);
             ResultSet rs =
                    ps.executeQuery()) {

            while (rs.next()) {

                Order order =
                        createOrderFromResultSet(rs);

                orders.add(order);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return orders;
    }


    @Override
    public boolean updateOrderStatus(
            int orderId,
            String status) {

        String sql =
                "UPDATE orders " +
                "SET order_status = ? " +
                "WHERE order_id = ?";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    private Order createOrderFromResultSet(
            ResultSet rs) throws Exception {

        Order order = new Order();

        order.setOrderId(
                rs.getInt("order_id")
        );

        order.setUserId(
                rs.getInt("user_id")
        );

        order.setTotalAmount(
                rs.getDouble("total_amount")
        );

        order.setShippingAddress(
                rs.getString("shipping_address")
        );

        order.setPaymentMethod(
                rs.getString("payment_method")
        );

        order.setOrderStatus(
                rs.getString("order_status")
        );

        order.setOrderDate(
                rs.getTimestamp("order_date")
        );

        return order;
    }
}