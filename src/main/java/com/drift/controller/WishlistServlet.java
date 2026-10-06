package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.WishlistDAO;
import com.drift.daoimpl.WishlistDAOImpl;
import com.drift.model.Wishlist;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private WishlistDAO wishlistDAO;

    @Override
    public void init() throws ServletException {

        wishlistDAO =
                new WishlistDAOImpl();
    }

    @Override
    protected void doGet(
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

        List<Wishlist> wishlist =
                wishlistDAO.getWishlistByUserId(
                        userId
                );

        request.setAttribute(
                "wishlist",
                wishlist
        );

        request.getRequestDispatcher(
                "pages/wishlist.jsp"
        ).forward(
                request,
                response
        );
    }
}