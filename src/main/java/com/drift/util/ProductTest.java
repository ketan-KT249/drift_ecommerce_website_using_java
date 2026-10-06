package com.drift.util;

import java.util.List;

import com.drift.dao.ProductDAO;
import com.drift.daoimpl.ProductDAOImpl;
import com.drift.model.Product;

public class ProductTest {

    public static void main(String[] args) {

        ProductDAO productDAO = new ProductDAOImpl();

        List<Product> products = productDAO.getAllProducts();

        System.out.println("=================================");
        System.out.println("       DRIFT PRODUCTS");
        System.out.println("=================================");

        for (Product product : products) {

            System.out.println(
                product.getProductId() + " | "
                + product.getProductName() + " | ₹"
                + product.getPrice() + " | "
                + product.getColor() + " | Rating: "
                + product.getRating()
            );
        }

        System.out.println("=================================");
        System.out.println("Total Products: " + products.size());
    }
}