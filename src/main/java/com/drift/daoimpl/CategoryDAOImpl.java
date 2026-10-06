package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.CategoryDAO;
import com.drift.model.Category;
import com.drift.util.DBConnection;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> getAllCategories() {

        List<Category> categories = new ArrayList<>();

        String sql = "SELECT * FROM categories";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Category category = new Category();

                category.setCategoryId(
                    rs.getInt("category_id")
                );

                category.setCategoryName(
                    rs.getString("category_name")
                );

                category.setDescription(
                    rs.getString("description")
                );

                categories.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }
}