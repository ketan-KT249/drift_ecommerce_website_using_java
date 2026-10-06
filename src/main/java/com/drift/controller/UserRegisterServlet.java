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

@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        User user = new User(
                name,
                email,
                password,
                phone,
                address,
                "USER"
        );

        boolean registered = userDAO.registerUser(user);

        if (registered) {
            response.sendRedirect("pages/login.html");
        } else {
            response.sendRedirect("pages/register.html?error=failed");
        }
    }
}