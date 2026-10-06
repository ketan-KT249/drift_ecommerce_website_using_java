package com.drift.controller;

import java.io.IOException;

import com.drift.dao.ProductDAO;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-delete-product")
public class AdminDeleteProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /* =====================================================
           1. CHECK ADMIN SESSION
           ===================================================== */

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("admin") == null) {

            response.sendRedirect(
                    "pages/admin-login.jsp"
            );

            return;
        }


        /* =====================================================
           2. CHECK ADMIN ROLE
           ===================================================== */

        User admin =
                (User) session.getAttribute("admin");

        if (!"ADMIN".equalsIgnoreCase(
                admin.getRole())) {

            session.removeAttribute("admin");

            response.sendRedirect(
                    "pages/admin-login.jsp?error=invalid"
            );

            return;
        }


        /* =====================================================
           3. GET PRODUCT ID
           ===================================================== */

        String productIdParameter =
                request.getParameter("productId");

        if (productIdParameter == null ||
            productIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                    "admin-products"
            );

            return;
        }


        int productId;

        try {

            productId =
                    Integer.parseInt(
                            productIdParameter
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "admin-products"
            );

            return;
        }


        /* =====================================================
           4. SOFT DELETE PRODUCT
           ===================================================== */

        boolean deleted =
                productDAO.deleteProduct(
                        productId
                );


        /* =====================================================
           5. REDIRECT
           ===================================================== */

        if (deleted) {

            response.sendRedirect(
                    "admin-products"
            );

        } else {

            response.sendRedirect(
                    "admin-products?error=delete"
            );
        }
    }
}