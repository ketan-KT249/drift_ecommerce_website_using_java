package com.drift.controller;

import java.io.IOException;

import com.drift.dao.ContactDAO;
import com.drift.daoimpl.ContactDAOImpl;
import com.drift.model.ContactMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ContactDAO contactDAO;

    @Override
    public void init() throws ServletException {

        contactDAO = new ContactDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String subject =
                request.getParameter("subject");

        String message =
                request.getParameter("message");


        if (name == null ||
            email == null ||
            subject == null ||
            message == null ||
            name.trim().isEmpty() ||
            email.trim().isEmpty() ||
            subject.trim().isEmpty() ||
            message.trim().isEmpty()) {

            response.sendRedirect(
                    "pages/contact.jsp?error=empty"
            );

            return;
        }


        ContactMessage contactMessage =
                new ContactMessage(
                        name.trim(),
                        email.trim(),
                        subject.trim(),
                        message.trim()
                );


        boolean saved =
                contactDAO.saveMessage(
                        contactMessage
                );


        if (saved) {

            response.sendRedirect(
                    "pages/contact.jsp?success=true"
            );

        } else {

            response.sendRedirect(
                    "pages/contact.jsp?error=failed"
            );
        }
    }
}