package com.drift.controller;

import java.io.IOException;

import com.drift.dao.OrderHistoryDAO;
import com.drift.daoimpl.OrderHistoryDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-update-order-status")
public class AdminUpdateOrderStatusServlet
        extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderHistoryDAO orderHistoryDAO;

    @Override
    public void init() throws ServletException {

        orderHistoryDAO =
                new OrderHistoryDAOImpl();
    }

    @Override
    protected void doPost(
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

        // Verify admin role
        if (!"ADMIN".equalsIgnoreCase(
                admin.getRole())) {

            session.removeAttribute("admin");

            response.sendRedirect(
                    "pages/admin-login.jsp?error=invalid"
            );

            return;
        }

        // Get order ID
        String orderIdParameter =
                request.getParameter("orderId");

        // Get new status
        String status =
                request.getParameter("status");

        if (orderIdParameter == null ||
            orderIdParameter.trim().isEmpty() ||
            status == null ||
            status.trim().isEmpty()) {

            response.sendRedirect(
                    "admin-orders?error=invalid"
            );

            return;
        }

        int orderId;

        try {

            orderId =
                    Integer.parseInt(
                            orderIdParameter
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "admin-orders?error=invalid"
            );

            return;
        }

        status =
                status.trim().toUpperCase();

        // Allow only valid statuses
        if (!status.equals("PLACED") &&
            !status.equals("CONFIRMED") &&
            !status.equals("SHIPPED") &&
            !status.equals("DELIVERED") &&
            !status.equals("CANCELLED")) {

            response.sendRedirect(
                    "admin-orders?error=invalid"
            );

            return;
        }

        boolean updated =
                orderHistoryDAO.updateOrderStatus(
                        orderId,
                        status
                );

        if (updated) {

            response.sendRedirect(
                    "admin-orders"
            );

        } else {

            response.sendRedirect(
                    "admin-orders?error=update"
            );
        }
    }
}