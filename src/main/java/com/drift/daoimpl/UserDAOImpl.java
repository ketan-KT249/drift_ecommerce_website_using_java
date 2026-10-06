package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.UserDAO;
import com.drift.model.User;
import com.drift.util.DBConnection;

public class UserDAOImpl implements UserDAO {

    @Override
    public boolean registerUser(User user) {

        String sql = "INSERT INTO users "
                   + "(name, email, password, phone, address, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    @Override
    public User loginUser(String email, String password) {

        String sql = "SELECT * FROM users "
                   + "WHERE email = ? AND password = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setName(
                        rs.getString("name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setPassword(
                        rs.getString("password")
                );

                user.setPhone(
                        rs.getString("phone")
                );

                user.setAddress(
                        rs.getString("address")
                );

                user.setRole(
                        rs.getString("role")
                );

                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    @Override
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = "SELECT * FROM users "
                   + "ORDER BY user_id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setName(
                        rs.getString("name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setPassword(
                        rs.getString("password")
                );

                user.setPhone(
                        rs.getString("phone")
                );

                user.setAddress(
                        rs.getString("address")
                );

                user.setRole(
                        rs.getString("role")
                );

                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }
}