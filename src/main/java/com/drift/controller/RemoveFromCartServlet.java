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

@WebServlet("/remove-from-cart")
public class RemoveFromCartServlet extends HttpServlet {

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

        if (cartItemIdParameter == null ||
            cartItemIdParameter.isEmpty()) {

            response.sendRedirect("cart");
            return;
        }

        int cartItemId;

        try {

            cartItemId =
                    Integer.parseInt(cartItemIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect("cart");
            return;
        }

        boolean removed =
                cartDAO.removeFromCart(
                        cartItemId,
                        userId
                );

        if (removed) {

            response.sendRedirect("cart");

        } else {

            response.sendRedirect(
                    "cart?error=remove"
            );
        }
    }
}