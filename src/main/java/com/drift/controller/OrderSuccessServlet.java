package com.drift.controller;

import java.io.IOException;

import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // User must be logged in
        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("pages/login.html");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        request.setAttribute(
                "userName",
                user.getName()
        );

        request.getRequestDispatcher(
                "pages/order-success.jsp"
        ).forward(request, response);
    }
}