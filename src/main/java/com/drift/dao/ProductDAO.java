package com.drift.dao;

import java.util.List;

import com.drift.model.Product;

public interface ProductDAO {

    List<Product> getAllProducts();

    List<Product> getAllProductsForAdmin();

    Product getProductById(int productId);

    boolean addProduct(Product product);

    boolean updateProduct(Product product);

    boolean deleteProduct(int productId);
}