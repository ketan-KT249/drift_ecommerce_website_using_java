package com.drift.dao;

import java.util.List;

import com.drift.model.ContactMessage;

public interface ContactDAO {

    boolean saveMessage(ContactMessage message);

    List<ContactMessage> getAllMessages();
}