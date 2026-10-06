package com.drift.controller;

import java.io.IOException;

import com.drift.dao.ContactDAO;
import com.drift.dao.OrderHistoryDAO;
import com.drift.dao.ProductDAO;
import com.drift.dao.UserDAO;
import com.drift.daoimpl.ContactDAOImpl;
import com.drift.daoimpl.OrderHistoryDAOImpl;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.daoimpl.UserDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private UserDAO userDAO;
    private OrderHistoryDAO orderHistoryDAO;
    private ContactDAO contactDAO;

    @Override
    public void init() throws ServletException {

        productDAO =
                new ProductDAOImpl();

        userDAO =
                new UserDAOImpl();

        orderHistoryDAO =
                new OrderHistoryDAOImpl();

        contactDAO =
                new ContactDAOImpl();
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

        // Get logged-in admin
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

        // Admin name
        request.setAttribute(
                "adminName",
                admin.getName()
        );

        // =================================================
        // REAL DASHBOARD STATISTICS
        // =================================================

        int productCount =
                productDAO.getAllProducts().size();

        int userCount =
                userDAO.getAllUsers().size();

        int orderCount =
                orderHistoryDAO.getAllOrders().size();

        int messageCount =
                contactDAO.getAllMessages().size();

        // Send statistics to JSP

        request.setAttribute(
                "productCount",
                productCount
        );

        request.setAttribute(
                "userCount",
                userCount
        );

        request.setAttribute(
                "orderCount",
                orderCount
        );

        request.setAttribute(
                "messageCount",
                messageCount
        );

        // Open dashboard

        request.getRequestDispatcher(
                "pages/admin-dashboard.jsp"
        ).forward(
                request,
                response
        );
    }
}