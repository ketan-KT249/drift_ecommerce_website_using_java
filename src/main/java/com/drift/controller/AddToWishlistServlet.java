package com.drift.controller;

import java.io.IOException;

import com.drift.dao.WishlistDAO;
import com.drift.daoimpl.WishlistDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-to-wishlist")
public class AddToWishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {

        wishlistDAO =
                new WishlistDAOImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect(
                    "pages/login.html"
            );

            return;
        }

        User user =
                (User) session.getAttribute("user");

        int userId =
                user.getUserId();

        String productIdParameter =
                request.getParameter("productId");

        if (productIdParameter == null ||
            productIdParameter.trim().isEmpty()) {

            response.sendRedirect("shop");

            return;
        }

        int productId;

        try {

            productId =
                    Integer.parseInt(
                            productIdParameter
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect("shop");

            return;
        }

        boolean alreadyExists =
                wishlistDAO.isProductInWishlist(
                        userId,
                        productId
                );

        if (!alreadyExists) {

            wishlistDAO.addToWishlist(
                    userId,
                    productId
            );
        }

        response.sendRedirect(
                "wishlist"
        );
    }
}