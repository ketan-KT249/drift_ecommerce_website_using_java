package com.drift.controller;

import java.io.IOException;

import com.drift.dao.ProductDAO;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.model.Product;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-edit-product")
public class AdminEditProductServlet extends HttpServlet {

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
                request.getParameter("id");

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
           4. GET PRODUCT FROM DATABASE
           ===================================================== */

        Product product =
                productDAO.getProductById(
                        productId
                );


        if (product == null) {

            response.sendRedirect(
                    "admin-products"
            );

            return;
        }


        /* =====================================================
           5. SEND PRODUCT TO JSP
           ===================================================== */

        request.setAttribute(
                "product",
                product
        );


        /* =====================================================
           6. OPEN EDIT PAGE
           ===================================================== */

        request.getRequestDispatcher(
                "pages/admin-edit-product.jsp"
        ).forward(
                request,
                response
        );
    }
}