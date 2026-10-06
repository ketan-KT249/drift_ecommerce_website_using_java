package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.WishlistDAO;
import com.drift.model.Wishlist;
import com.drift.util.DBConnection;

public class WishlistDAOImpl implements WishlistDAO {

    @Override
    public boolean addToWishlist(
            int userId,
            int productId) {

        String sql =
                "INSERT INTO wishlist " +
                "(user_id, product_id) " +
                "VALUES (?, ?)";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean removeFromWishlist(
            int userId,
            int productId) {

        String sql =
                "DELETE FROM wishlist " +
                "WHERE user_id = ? " +
                "AND product_id = ?";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    @Override
    public boolean isProductInWishlist(
            int userId,
            int productId) {

        String sql =
                "SELECT wishlist_id " +
                "FROM wishlist " +
                "WHERE user_id = ? " +
                "AND product_id = ?";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ResultSet rs =
                    ps.executeQuery();

            return rs.next();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    @Override
    public List<Wishlist> getWishlistByUserId(
            int userId) {

        List<Wishlist> wishlist =
                new ArrayList<>();

        String sql =
                "SELECT * " +
                "FROM wishlist " +
                "WHERE user_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Wishlist item =
                        new Wishlist();

                item.setWishlistId(
                        rs.getInt("wishlist_id")
                );

                item.setUserId(
                        rs.getInt("user_id")
                );

                item.setProductId(
                        rs.getInt("product_id")
                );

                wishlist.add(item);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return wishlist;
    }
}