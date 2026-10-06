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

@WebServlet("/admin-add-product")
public class AdminAddProductServlet extends HttpServlet {

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


        User admin =
                (User) session.getAttribute("admin");


        /* =====================================================
           2. CHECK ADMIN ROLE
           ===================================================== */

        if (!"ADMIN".equalsIgnoreCase(
                admin.getRole())) {

            session.removeAttribute("admin");

            response.sendRedirect(
                    "pages/admin-login.jsp?error=invalid"
            );

            return;
        }


        /* =====================================================
           3. READ FORM DATA
           ===================================================== */

        String productName =
                request.getParameter("productName");

        String description =
                request.getParameter("description");

        String categoryIdParameter =
                request.getParameter("categoryId");

        String priceParameter =
                request.getParameter("price");

        String stockParameter =
                request.getParameter("stock");

        String color =
                request.getParameter("color");

        String size =
                request.getParameter("size");

        String image =
                request.getParameter("image");

        String ratingParameter =
                request.getParameter("rating");

        String activeParameter =
                request.getParameter("isActive");


        /* =====================================================
           4. BASIC VALIDATION
           ===================================================== */

        if (productName == null ||
            productName.trim().isEmpty() ||

            categoryIdParameter == null ||
            categoryIdParameter.trim().isEmpty() ||

            priceParameter == null ||
            priceParameter.trim().isEmpty() ||

            stockParameter == null ||
            stockParameter.trim().isEmpty()) {

            response.sendRedirect(
                    "pages/admin-add-product.jsp?error=failed"
            );

            return;
        }


        /* =====================================================
           5. CONVERT NUMERIC VALUES
           ===================================================== */

        int categoryId;
        double price;
        int stock;
        double rating = 0.0;

        try {

            categoryId =
                    Integer.parseInt(
                            categoryIdParameter
                    );

            price =
                    Double.parseDouble(
                            priceParameter
                    );

            stock =
                    Integer.parseInt(
                            stockParameter
                    );


            if (ratingParameter != null &&
                !ratingParameter.trim().isEmpty()) {

                rating =
                        Double.parseDouble(
                                ratingParameter
                        );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "pages/admin-add-product.jsp?error=failed"
            );

            return;
        }


        /* =====================================================
           6. VALIDATE VALUES
           ===================================================== */

        if (categoryId < 1 ||
            price < 0 ||
            stock < 0 ||
            rating < 0 ||
            rating > 5) {

            response.sendRedirect(
                    "pages/admin-add-product.jsp?error=failed"
            );

            return;
        }


        /* =====================================================
           7. ACTIVE STATUS
           ===================================================== */

        boolean active =
                "true".equalsIgnoreCase(
                        activeParameter
                );


        /* =====================================================
           8. CREATE PRODUCT OBJECT
           ===================================================== */

        Product product =
                new Product();

        product.setCategoryId(
                categoryId
        );

        product.setProductName(
                productName.trim()
        );

        product.setDescription(
                description == null
                        ? ""
                        : description.trim()
        );

        product.setPrice(
                price
        );

        product.setStock(
                stock
        );

        product.setColor(
                color == null
                        ? ""
                        : color.trim()
        );

        product.setSize(
                size == null
                        ? ""
                        : size.trim()
        );

        product.setImage(
                image == null
                        ? ""
                        : image.trim()
        );

        product.setRating(
                rating
        );

        product.setActive(
                active
        );


        /* =====================================================
           9. SAVE PRODUCT
           ===================================================== */

        boolean added =
                productDAO.addProduct(
                        product
                );


        /* =====================================================
           10. REDIRECT
           ===================================================== */

        if (added) {

            response.sendRedirect(
                    "admin-products"
            );

        } else {

            response.sendRedirect(
                    "pages/admin-add-product.jsp?error=failed"
            );
        }
    }
}