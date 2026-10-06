package com.drift.dao;

import java.util.List;

import com.drift.model.CartItem;

public interface CartDAO {

    boolean addToCart(int userId, int productId, int quantity);

    List<CartItem> getCartItems(int userId);

    boolean updateQuantity(
            int cartItemId,
            int quantity,
            int userId
    );

    boolean removeFromCart(
            int cartItemId,
            int userId
    );

    boolean clearCart(int userId);
}