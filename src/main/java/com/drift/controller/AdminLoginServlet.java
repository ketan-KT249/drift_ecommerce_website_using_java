package com.drift.controller;

import java.io.IOException;

import com.drift.dao.UserDAO;
import com.drift.daoimpl.UserDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {

        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        User user =
                userDAO.loginUser(
                        email,
                        password
                );

        if (user != null &&
            "ADMIN".equalsIgnoreCase(
                    user.getRole())) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "admin",
                    user
            );

            response.sendRedirect(
                    "admin-dashboard"
            );

        } else {

            response.sendRedirect(
                    "pages/admin-login.jsp?error=invalid"
            );
        }
    }
}