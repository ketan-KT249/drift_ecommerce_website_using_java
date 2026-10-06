package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.CartDAO;
import com.drift.dao.OrderDAO;
import com.drift.daoimpl.CartDAOImpl;
import com.drift.daoimpl.OrderDAOImpl;
import com.drift.model.CartItem;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {

        cartDAO = new CartDAOImpl();
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        // =========================================
        // 1. CHECK LOGIN
        // =========================================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("pages/login.html");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        int userId =
                user.getUserId();


        // =========================================
        // 2. GET CHECKOUT DATA
        // =========================================

        String shippingAddress =
                request.getParameter("address");

        String paymentMethod =
                request.getParameter("paymentMethod");


        // =========================================
        // 3. VALIDATE DATA
        // =========================================

        if (shippingAddress == null ||
            shippingAddress.trim().isEmpty()) {

            response.sendRedirect(
                    "checkout?error=address"
            );

            return;
        }

        if (paymentMethod == null ||
            paymentMethod.trim().isEmpty()) {

            response.sendRedirect(
                    "checkout?error=payment"
            );

            return;
        }


        // =========================================
        // 4. GET USER'S CART
        // =========================================

        List<CartItem> cartItems =
                cartDAO.getCartItems(userId);

        if (cartItems == null ||
            cartItems.isEmpty()) {

            response.sendRedirect(
                    "cart?error=empty"
            );

            return;
        }


        // =========================================
        // 5. CALCULATE TOTAL ON SERVER
        // =========================================

        double totalAmount = 0;

        for (CartItem item : cartItems) {

            totalAmount +=
                    item.getPrice() *
                    item.getQuantity();
        }


        // =========================================
        // 6. PLACE ORDER
        // =========================================

        boolean orderPlaced =
                orderDAO.placeOrder(
                        userId,
                        shippingAddress.trim(),
                        paymentMethod,
                        totalAmount,
                        cartItems
                );


        // =========================================
        // 7. RESULT
        // =========================================

        if (orderPlaced) {

            response.sendRedirect(
                    "order-success"
            );

        } else {

            response.sendRedirect(
                    "checkout?error=order"
            );
        }
    }
}