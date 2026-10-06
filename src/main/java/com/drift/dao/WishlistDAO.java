package com.drift.dao;

import java.util.List;

import com.drift.model.Wishlist;

public interface WishlistDAO {

    boolean addToWishlist(
            int userId,
            int productId
    );

    boolean removeFromWishlist(
            int userId,
            int productId
    );

    boolean isProductInWishlist(
            int userId,
            int productId
    );

    List<Wishlist> getWishlistByUserId(
            int userId
    );
}