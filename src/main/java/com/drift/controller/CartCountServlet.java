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

@WebServlet("/cart-count")
public class CartCountServlet extends HttpServlet {

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

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int cartCount = 0;

        HttpSession session = request.getSession(false);

        if (session != null &&
            session.getAttribute("user") != null) {

            User user =
                (User) session.getAttribute("user");

            int userId = user.getUserId();

            List<CartItem> cartItems =
                cartDAO.getCartItems(userId);

            if (cartItems != null) {

                for (CartItem item : cartItems) {

                    cartCount += item.getQuantity();
                }
            }
        }

        response.getWriter().write(
            "{\"cartCount\":" + cartCount + "}"
        );
    }
}