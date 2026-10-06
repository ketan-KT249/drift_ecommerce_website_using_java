package com.drift.controller;

import java.io.IOException;

import com.drift.dao.CartDAO;
import com.drift.daoimpl.CartDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {

        cartDAO = new CartDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check whether user is logged in
        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("pages/login.html");
            return;
        }

        // Get logged-in user
        User user =
            (User) session.getAttribute("user");

        int userId = user.getUserId();

        // Get product information
        int productId =
            Integer.parseInt(
                request.getParameter("productId")
            );

        int quantity = 1;

        String quantityParameter =
            request.getParameter("quantity");

        if (quantityParameter != null &&
            !quantityParameter.isEmpty()) {

            quantity =
                Integer.parseInt(quantityParameter);
        }

        // Add product to cart
        boolean added =
            cartDAO.addToCart(
                userId,
                productId,
                quantity
            );

        if (added) {

            response.sendRedirect("cart");

        } else {

            response.sendRedirect(
            		"shop?error=cart"
            );
        }
    }
}