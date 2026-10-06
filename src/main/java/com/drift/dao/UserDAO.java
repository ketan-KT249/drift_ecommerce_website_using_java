package com.drift.dao;

import java.util.List;

import com.drift.model.User;

public interface UserDAO {

    boolean registerUser(User user);

    User loginUser(String email, String password);

    List<User> getAllUsers();
}