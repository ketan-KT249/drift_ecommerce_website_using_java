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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

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

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("pages/login.html");
            return;
        }

        // Get logged-in user
        User user =
            (User) session.getAttribute("user");

        int userId = user.getUserId();

        // Get cart items
        List<CartItem> cartItems =
            cartDAO.getCartItems(userId);

        // Send cart items to JSP
        request.setAttribute("cartItems", cartItems);

        // Open cart page
        request.getRequestDispatcher("pages/cart.jsp")
               .forward(request, response);
    }
}