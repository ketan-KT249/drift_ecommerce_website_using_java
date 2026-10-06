package com.drift.dao;

import java.util.List;

import com.drift.model.Order;

public interface OrderHistoryDAO {

    List<Order> getOrdersByUserId(int userId);

    List<Order> getAllOrders();

    boolean updateOrderStatus(int orderId, String status);
}