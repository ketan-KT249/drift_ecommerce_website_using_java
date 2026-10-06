package com.drift.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.drift.dao.ContactDAO;
import com.drift.model.ContactMessage;
import com.drift.util.DBConnection;

public class ContactDAOImpl implements ContactDAO {

    @Override
    public boolean saveMessage(ContactMessage message) {

        String sql =
                "INSERT INTO contact_messages " +
                "(name, email, subject, message) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql)) {

            ps.setString(
                    1,
                    message.getName()
            );

            ps.setString(
                    2,
                    message.getEmail()
            );

            ps.setString(
                    3,
                    message.getSubject()
            );

            ps.setString(
                    4,
                    message.getMessage()
            );

            int rows =
                    ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }


    @Override
    public List<ContactMessage> getAllMessages() {

        List<ContactMessage> messages =
                new ArrayList<>();

        String sql =
                "SELECT * FROM contact_messages " +
                "ORDER BY message_id DESC";

        try (Connection connection =
                    DBConnection.getConnection();
             PreparedStatement ps =
                    connection.prepareStatement(sql);
             ResultSet rs =
                    ps.executeQuery()) {

            while (rs.next()) {

                ContactMessage message =
                        new ContactMessage();

                message.setMessageId(
                        rs.getInt("message_id")
                );

                message.setName(
                        rs.getString("name")
                );

                message.setEmail(
                        rs.getString("email")
                );

                message.setSubject(
                        rs.getString("subject")
                );

                message.setMessage(
                        rs.getString("message")
                );

                message.setCreatedAt(
                        rs.getTimestamp("created_at")
                );

                messages.add(message);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return messages;
    }
}