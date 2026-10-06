package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.UserDAO;
import com.drift.daoimpl.UserDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-users")
public class AdminUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {

        userDAO = new UserDAOImpl();
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

        // Get all users
        List<User> users =
                userDAO.getAllUsers();

        // Send users to JSP
        request.setAttribute(
                "users",
                users
        );

        // Open admin users page
        request.getRequestDispatcher(
                "pages/admin-users.jsp"
        ).forward(
                request,
                response
        );
    }
}