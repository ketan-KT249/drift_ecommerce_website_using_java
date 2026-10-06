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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

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

        List<Product> products = productDAO.getAllProducts();

        request.setAttribute("products", products);

        request.getRequestDispatcher("pages/shop.jsp")
               .forward(request, response);
    }
}