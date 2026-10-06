package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.ProductDAO;
import com.drift.model.Product;
import com.drift.util.DBConnection;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql =
                "SELECT * FROM products " +
                "WHERE is_active = TRUE";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql);
             ResultSet rs =
                    ps.executeQuery()) {

            while (rs.next()) {

                Product product =
                        createProductFromResultSet(rs);

                products.add(product);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }


    @Override
    public List<Product> getAllProductsForAdmin() {

        List<Product> products =
                new ArrayList<>();

        String sql =
                "SELECT * FROM products " +
                "ORDER BY product_id DESC";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql);
             ResultSet rs =
                    ps.executeQuery()) {

            while (rs.next()) {

                Product product =
                        createProductFromResultSet(rs);

                products.add(product);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return products;
    }


    @Override
    public Product getProductById(int productId) {

        Product product = null;

        String sql =
                "SELECT * FROM products " +
                "WHERE product_id = ?";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, productId);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                product =
                        createProductFromResultSet(rs);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return product;
    }


    @Override
    public boolean addProduct(Product product) {

        String sql =
                "INSERT INTO products " +
                "(category_id, product_name, description, " +
                "price, stock, color, size, image, rating, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getColor());
            ps.setString(7, product.getSize());
            ps.setString(8, product.getImage());
            ps.setDouble(9, product.getRating());
            ps.setBoolean(10, product.isActive());

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean updateProduct(Product product) {

        String sql =
                "UPDATE products SET " +
                "category_id = ?, " +
                "product_name = ?, " +
                "description = ?, " +
                "price = ?, " +
                "stock = ?, " +
                "color = ?, " +
                "size = ?, " +
                "image = ?, " +
                "rating = ?, " +
                "is_active = ? " +
                "WHERE product_id = ?";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, product.getCategoryId());
            ps.setString(2, product.getProductName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getStock());
            ps.setString(6, product.getColor());
            ps.setString(7, product.getSize());
            ps.setString(8, product.getImage());
            ps.setDouble(9, product.getRating());
            ps.setBoolean(10, product.isActive());
            ps.setInt(11, product.getProductId());

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean deleteProduct(int productId) {

        String sql =
                "UPDATE products " +
                "SET is_active = FALSE " +
                "WHERE product_id = ?";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, productId);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    private Product createProductFromResultSet(
            ResultSet rs) throws Exception {

        Product product =
                new Product();

        product.setProductId(
                rs.getInt("product_id")
        );

        product.setCategoryId(
                rs.getInt("category_id")
        );

        product.setProductName(
                rs.getString("product_name")
        );

        product.setDescription(
                rs.getString("description")
        );

        product.setPrice(
                rs.getDouble("price")
        );

        product.setStock(
                rs.getInt("stock")
        );

        product.setColor(
                rs.getString("color")
        );

        product.setSize(
                rs.getString("size")
        );

        product.setImage(
                rs.getString("image")
        );

        product.setRating(
                rs.getDouble("rating")
        );

        product.setActive(
                rs.getBoolean("is_active")
        );

        return product;
    }
}