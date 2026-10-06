package com.drift.util;

import java.util.List;

import com.drift.dao.CategoryDAO;
import com.drift.daoimpl.CategoryDAOImpl;
import com.drift.model.Category;

public class CategoryTest {

    public static void main(String[] args) {

        CategoryDAO categoryDAO = new CategoryDAOImpl();

        List<Category> categories =
                categoryDAO.getAllCategories();

        System.out.println("=================================");
        System.out.println("       DRIFT CATEGORIES");
        System.out.println("=================================");

        for (Category category : categories) {

            System.out.println(
                category.getCategoryId()
                + " | "
                + category.getCategoryName()
                + " | "
                + category.getDescription()
            );
        }

        System.out.println("=================================");
        System.out.println(
            "Total Categories: " + categories.size()
        );
    }
}