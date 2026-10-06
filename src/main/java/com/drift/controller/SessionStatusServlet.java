package com.drift.controller;

import java.io.IOException;

import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/session-status")
public class SessionStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        if (session != null &&
            session.getAttribute("user") != null) {

            User user =
                    (User) session.getAttribute("user");

            response.getWriter().write(
                    "{\"loggedIn\":true,\"name\":\""
                    + user.getName()
                    + "\"}"
            );

        } else {

            response.getWriter().write(
                    "{\"loggedIn\":false}"
            );
        }
    }
}