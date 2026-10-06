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

@WebServlet("/admin-orders")
public class AdminOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderHistoryDAO orderHistoryDAO;

    @Override
    public void init() throws ServletException {

        orderHistoryDAO =
                new OrderHistoryDAOImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect(
                    "pages/admin-login.jsp"
            );

            return;
        }

        // Get admin
        User admin =
                (User) session.getAttribute("admin");

        // Verify role
        if (!"ADMIN".equalsIgnoreCase(
                admin.getRole())) {

            session.removeAttribute("admin");

            response.sendRedirect(
                    "pages/admin-login.jsp?error=invalid"
            );

            return;
        }

        // Get all orders
        List<Order> orders =
                orderHistoryDAO.getAllOrders();

        // Send orders to JSP
        request.setAttribute(
                "orders",
                orders
        );

        // Open admin orders page
        request.getRequestDispatcher(
                "pages/admin-orders.jsp"
        ).forward(
                request,
                response
        );
    }
}