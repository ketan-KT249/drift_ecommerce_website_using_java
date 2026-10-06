package com.drift.controller;

import java.io.IOException;

import com.drift.dao.ProductDAO;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String productIdParameter =
                request.getParameter("id");


        if (productIdParameter == null ||
            productIdParameter.trim().isEmpty()) {

            response.sendRedirect("shop");
            return;
        }


        int productId;

        try {

            productId =
                    Integer.parseInt(
                            productIdParameter
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect("shop");
            return;
        }


        Product product =
                productDAO.getProductById(productId);


        if (product == null) {

            response.sendRedirect("shop");
            return;
        }


        request.setAttribute(
                "product",
                product
        );


        request.getRequestDispatcher(
                "pages/product-details.jsp"
        ).forward(
                request,
                response
        );
    }
}