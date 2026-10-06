package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.ContactDAO;
import com.drift.daoimpl.ContactDAOImpl;
import com.drift.model.ContactMessage;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-messages")
public class AdminMessagesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ContactDAO contactDAO;

    @Override
    public void init() throws ServletException {

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

        // Get all contact messages
        List<ContactMessage> messages =
                contactDAO.getAllMessages();

        // Send messages to JSP
        request.setAttribute(
                "messages",
                messages
        );

        // Open admin messages page
        request.getRequestDispatcher(
                "pages/admin-messages.jsp"
        ).forward(
                request,
                response
        );
    }
}