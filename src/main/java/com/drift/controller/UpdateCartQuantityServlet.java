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

@WebServlet("/update-cart-quantity")
public class UpdateCartQuantityServlet extends HttpServlet {

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

        HttpSession session =
                request.getSession(false);

        // User must be logged in
        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("pages/login.html");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        int userId = user.getUserId();

        String cartItemIdParameter =
                request.getParameter("cartItemId");

        String quantityParameter =
                request.getParameter("quantity");

        if (cartItemIdParameter == null ||
            quantityParameter == null ||
            cartItemIdParameter.isEmpty() ||
            quantityParameter.isEmpty()) {

            response.sendRedirect("cart");
            return;
        }

        int cartItemId;
        int quantity;

        try {

            cartItemId =
                    Integer.parseInt(cartItemIdParameter);

            quantity =
                    Integer.parseInt(quantityParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect("cart");
            return;
        }

        // Quantity must be at least 1
        if (quantity < 1) {

            response.sendRedirect("cart");
            return;
        }

        boolean updated =
                cartDAO.updateQuantity(
                        cartItemId,
                        quantity,
                        userId
                );

        if (updated) {

            response.sendRedirect("cart");

        } else {

            response.sendRedirect(
                    "cart?error=quantity"
            );
        }
    }
}