package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.OrderHistoryDAO;
import com.drift.daoimpl.OrderHistoryDAOImpl;
import com.drift.model.Order;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderHistoryDAO orderHistoryDAO;

    @Override
    public void init() throws ServletException {

        orderHistoryDAO =
                new OrderHistoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // =========================================
        // 1. CHECK LOGIN
        // =========================================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect(
                    "pages/login.html"
            );

            return;
        }


        // =========================================
        // 2. GET LOGGED-IN USER
        // =========================================

        User user =
                (User) session.getAttribute("user");

        int userId =
                user.getUserId();


        // =========================================
        // 3. GET USER'S ORDERS
        // =========================================

        List<Order> orders =
                orderHistoryDAO.getOrdersByUserId(
                        userId
                );


        // =========================================
        // 4. SEND ORDERS TO JSP
        // =========================================

        request.setAttribute(
                "orders",
                orders
        );


        // =========================================
        // 5. OPEN ORDER HISTORY PAGE
        // =========================================

        request.getRequestDispatcher(
                "pages/orders.jsp"
        ).forward(
                request,
                response
        );
    }
}