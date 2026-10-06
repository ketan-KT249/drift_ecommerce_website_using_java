package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.CategoryDAO;
import com.drift.dao.ProductDAO;
import com.drift.daoimpl.CategoryDAOImpl;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.model.Category;
import com.drift.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/shop")
public class CategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {

        categoryDAO = new CategoryDAOImpl();
        productDAO = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories =
                categoryDAO.getAllCategories();

        List<Product> products =
                productDAO.getAllProducts();

        request.setAttribute("categories", categories);
        request.setAttribute("products", products);

        request.getRequestDispatcher("pages/shop.jsp")
               .forward(request, response);
    }
}