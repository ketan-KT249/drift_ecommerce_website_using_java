package com.drift.util;

import java.util.List;

import com.drift.dao.CartDAO;
import com.drift.daoimpl.CartDAOImpl;
import com.drift.model.CartItem;

public class CartTest {

    public static void main(String[] args) {

        CartDAO cartDAO = new CartDAOImpl();

        // Use an existing user ID from your users table
        int userId = 1;

        // Use an existing product ID from your products table
        int productId = 1;

        // Add product to cart
        boolean added =
                cartDAO.addToCart(userId, productId, 1);

        System.out.println(
                "Product added to cart: " + added
        );


        // Get cart items
        List<CartItem> cartItems =
                cartDAO.getCartItems(userId);

        System.out.println(
                "Total cart items: " + cartItems.size()
        );


        for (CartItem item : cartItems) {

            System.out.println(
                    "Cart Item ID: "
                    + item.getCartItemId()
                    + " | Product ID: "
                    + item.getProductId()
                    + " | Quantity: "
                    + item.getQuantity()
            );
        }
    }
}