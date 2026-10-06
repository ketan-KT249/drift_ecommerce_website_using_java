<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.Wishlist" %>
<%@ page import="com.drift.model.Product" %>
<%@ page import="com.drift.dao.ProductDAO" %>
<%@ page import="com.drift.daoimpl.ProductDAOImpl" %>

<%
    List<Wishlist> wishlist =
            (List<Wishlist>) request.getAttribute("wishlist");

    ProductDAO productDAO =
            new ProductDAOImpl();

    String contextPath =
            request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | MY WISHLIST</title>


    <!-- GLOBAL CSS -->

    <link rel="stylesheet"
          href="<%= contextPath %>/css/style.css">


    <!-- WISHLIST CSS -->

    <link rel="stylesheet"
          href="<%= contextPath %>/css/wishlist.css">

</head>


<body>


<!-- =====================================================
     NAVBAR
     ===================================================== -->

<header class="navbar">

    <div class="logo">
        DRIFT
    </div>


    <nav>

        <a href="<%= contextPath %>/index.html">
            HOME
        </a>

        <a href="<%= contextPath %>/shop">
            SHOP
        </a>

        <a href="<%= contextPath %>/pages/about.html">
            ABOUT
        </a>

        <a href="<%= contextPath %>/pages/contact.jsp">
            CONTACT
        </a>

        <a href="<%= contextPath %>/orders">
            MY ORDERS
        </a>

        <a href="<%= contextPath %>/wishlist"
           class="active">
            WISHLIST
        </a>

        <a href="<%= contextPath %>/cart"
           class="cart-link">

            CART

            <span id="cart-count">
                0
            </span>

        </a>

        <a href="<%= contextPath %>/logout">
            LOGOUT
        </a>

    </nav>

</header>


<!-- =====================================================
     WISHLIST PAGE
     ===================================================== -->

<section class="wishlist-page">


    <div class="wishlist-header">

        <p class="wishlist-label">
            SAVED FOR LATER
        </p>


        <h1>
            MY WISHLIST
        </h1>


        <p class="wishlist-subtitle">
            YOUR PICKS. YOUR STYLE. YOUR DRIFT.
        </p>

    </div>


    <div class="wishlist-container">


        <%
            if (wishlist == null ||
                wishlist.isEmpty()) {
        %>


            <!-- EMPTY WISHLIST -->

            <div class="wishlist-empty">

                <div class="empty-icon">
                    &#9825;
                </div>


                <h2>
                    YOUR WISHLIST IS EMPTY
                </h2>


                <p>
                    Find something you love
                    and save it here.
                </p>


                <a href="<%= contextPath %>/shop"
                   class="wishlist-shop-btn">

                    EXPLORE PRODUCTS &#8594;

                </a>

            </div>


        <%
            } else {
        %>


            <!-- WISHLIST PRODUCTS -->

            <div class="wishlist-grid">


                <%
                    for (Wishlist item : wishlist) {

                        Product product =
                                productDAO.getProductById(
                                        item.getProductId()
                                );

                        if (product == null) {
                            continue;
                        }
                %>


                    <div class="wishlist-card">


                        <!-- PRODUCT IMAGE -->

                        <div class="wishlist-image">

                            <a href="<%= contextPath %>/product-details?id=<%= product.getProductId() %>">

                                <img
                                    src="<%= contextPath %>/images/<%= product.getImage() %>"
                                    alt="<%= product.getProductName() %>"
                                >

                            </a>

                        </div>


                        <!-- PRODUCT INFORMATION -->

                        <div class="wishlist-info">


                            <p class="wishlist-category">
                                DRIFT COLLECTION
                            </p>


                            <h2>

                                <a href="<%= contextPath %>/product-details?id=<%= product.getProductId() %>">

                                    <%= product.getProductName() %>

                                </a>

                            </h2>


                            <div class="wishlist-rating">

                                &#9733;
                                <%= product.getRating() %>

                            </div>


                            <div class="wishlist-price">

                                &#8377;<%= String.format(
                                        "%.2f",
                                        product.getPrice()
                                ) %>

                            </div>


                            <!-- ACTIONS -->

                            <div class="wishlist-actions">


                                <!-- ADD TO CART -->

                                <form
                                    action="<%= contextPath %>/add-to-cart"
                                    method="post">

                                    <input
                                        type="hidden"
                                        name="productId"
                                        value="<%= product.getProductId() %>"
                                    >

                                    <input
                                        type="hidden"
                                        name="quantity"
                                        value="1"
                                    >

                                    <button
                                        type="submit"
                                        class="wishlist-cart-btn">

                                        ADD TO CART &#8594;

                                    </button>

                                </form>


                                <!-- REMOVE -->

                                <form
                                    action="<%= contextPath %>/remove-from-wishlist"
                                    method="post">

                                    <input
                                        type="hidden"
                                        name="productId"
                                        value="<%= product.getProductId() %>"
                                    >

                                    <button
                                        type="submit"
                                        class="wishlist-remove-btn">

                                        REMOVE

                                    </button>

                                </form>


                            </div>


                        </div>


                    </div>


                <%
                    }
                %>


            </div>


        <%
            }
        %>


    </div>


</section>


<!-- =====================================================
     FOOTER
     ===================================================== -->

<footer class="footer">

    <div class="footer-logo">
        DRIFT
    </div>


    <p>
        MOVE DIFFERENT.
    </p>


    <p class="footer-copy">

        &copy; 2026 DRIFT.
        ALL RIGHTS RESERVED.

    </p>

</footer>


<!-- =====================================================
     JAVASCRIPT
     ===================================================== -->

<script src="<%= contextPath %>/js/script.js"></script>


</body>

</html>