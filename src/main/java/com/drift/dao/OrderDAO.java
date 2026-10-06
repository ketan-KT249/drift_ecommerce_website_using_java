package com.drift.dao;

import java.util.List;

import com.drift.model.CartItem;

public interface OrderDAO {

    boolean placeOrder(
            int userId,
            String shippingAddress,
            String paymentMethod,
            double totalAmount,
            List<CartItem> cartItems
    );

    List<CartItem> getOrderItems(int orderId);
}