package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.CartDAO;
import com.drift.daoimpl.CartDAOImpl;
import com.drift.model.CartItem;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;

    @Override
    public void init() throws ServletException {

        cartDAO = new CartDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
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

        // Get the logged-in user's cart
        List<CartItem> cartItems =
                cartDAO.getCartItems(userId);

        // Do not allow checkout with an empty cart
        if (cartItems == null ||
            cartItems.isEmpty()) {

            response.sendRedirect("cart?error=empty");
            return;
        }

        // Calculate total from database cart data
        double subtotal = 0;

        int totalQuantity = 0;

        for (CartItem item : cartItems) {

            subtotal +=
                    item.getPrice() *
                    item.getQuantity();

            totalQuantity +=
                    item.getQuantity();
        }

        // Shipping is currently free
        double shipping = 0;

        double total =
                subtotal + shipping;

        // Send cart information to JSP
        request.setAttribute(
                "cartItems",
                cartItems
        );

        request.setAttribute(
                "totalQuantity",
                totalQuantity
        );

        request.setAttribute(
                "subtotal",
                subtotal
        );

        request.setAttribute(
                "shipping",
                shipping
        );

        request.setAttribute(
                "total",
                total
        );

        // Open checkout page
        request.getRequestDispatcher(
                "pages/checkout.jsp"
        ).forward(request, response);
    }
}