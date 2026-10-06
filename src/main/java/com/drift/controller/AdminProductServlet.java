package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.ProductDAO;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.drift.model.User;

@WebServlet("/admin-products")
public class AdminProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check admin session
        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect(
                    "pages/admin-login.jsp"
            );

            return;
        }

        User admin =
                (User) session.getAttribute("admin");

        // Check admin role
        if (!"ADMIN".equalsIgnoreCase(
                admin.getRole())) {

            session.removeAttribute("admin");

            response.sendRedirect(
                    "pages/admin-login.jsp?error=invalid"
            );

            return;
        }

        // Get all products
        List<Product> products =
                productDAO.getAllProductsForAdmin();

        // Send products to JSP
        request.setAttribute(
                "products",
                products
        );

        // Open admin product page
        request.getRequestDispatcher(
                "pages/admin-products.jsp"
        ).forward(
                request,
                response
        );
    }
}