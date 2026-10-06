<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.drift.model.Product" %>

<%
    Product product =
            (Product) request.getAttribute("product");

    if (product == null) {

        response.sendRedirect(
                request.getContextPath() + "/shop"
        );

        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        DRIFT | <%= product.getProductName() %>
    </title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* ================= PRODUCT DETAILS ================= */

        .product-details-page {

            min-height: 100vh;

            padding: 150px 8% 100px;

            background:
                radial-gradient(
                    circle at 15% 30%,
                    rgba(255, 37, 37, 0.10),
                    transparent 30%
                ),
                #050505;
        }


        .product-details-container {

            max-width: 1200px;

            margin: auto;

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 70px;

            align-items: center;
        }


        /* ================= PRODUCT IMAGE ================= */

/* ================= PRODUCT IMAGE ================= */

.product-details-image {
    position: relative;
    width: 100%;
    aspect-ratio: 1 / 1;
    min-height: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;

    border: 1px solid #222;

    background:
        radial-gradient(
            circle,
            #191919 0%,
            #080808 65%,
            #050505 100%
        );
}

.product-details-image::before {
    content: "";
    position: absolute;

    width: 10%;
    aspect-ratio: 1 / 1;

    border-radius: 40%;

    border: 1px solid
        rgba(255, 37, 37, 0.25);

    box-shadow:
        0 0 80px
        rgba(255, 37, 37, 0.08);
}

.product-details-image img {
    position: relative;
    z-index: 2;

    width: 98%;
    height: 98%;

    max-width: none;
    object-fit: contain;

    transform: scale(1);
    transition:
        transform 0.45s ease;
}

/* ONLY ZOOM — NO ROTATION */
.product-details-image:hover img {
    transform: scale(1.05);
}

        /* ================= PRODUCT INFO ================= */

        .product-details-info {

            padding: 20px 0;
        }


        .product-category {

            color: #ff2525;

            font-size: 12px;

            font-weight: 800;

            letter-spacing: 4px;

            margin-bottom: 20px;
        }


        .product-details-info h1 {

            font-size:
                clamp(45px, 6vw, 80px);

            line-height: 0.95;

            margin: 0 0 25px;

            letter-spacing: -3px;
        }


        .product-description {

            color: #888;

            line-height: 1.8;

            font-size: 16px;

            max-width: 550px;

            margin-bottom: 30px;
        }


        .product-rating {

            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 25px;
        }


        .stars {

            color: #ff2525;

            letter-spacing: 3px;

            font-size: 18px;
        }


        .rating-number {

            color: #aaa;

            font-size: 14px;
        }


        .product-price {

            font-size: 34px;

            font-weight: 900;

            margin-bottom: 30px;
        }


        .product-meta {

            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 15px;

            margin-bottom: 30px;
        }


        .meta-box {

            border: 1px solid #252525;

            padding: 18px;

            background: #0b0b0b;
        }


        .meta-label {

            display: block;

            color: #666;

            font-size: 11px;

            letter-spacing: 2px;

            margin-bottom: 8px;
        }


        .meta-value {

            color: #eee;

            font-size: 15px;

            font-weight: 700;
        }


        /* ================= QUANTITY ================= */

        .quantity-wrapper {

            display: flex;

            align-items: center;

            gap: 15px;

            margin-bottom: 25px;
        }


        .quantity-wrapper label {

            color: #aaa;

            font-size: 13px;

            font-weight: 700;

            letter-spacing: 2px;
        }


        .quantity-control {

            display: flex;

            border: 1px solid #333;
        }


        .quantity-control button {

            width: 42px;

            height: 42px;

            border: none;

            background: #111;

            color: #fff;

            font-size: 20px;

            cursor: pointer;
        }


        .quantity-control button:hover {

            background: #ff2525;
        }


        .quantity-control input {

            width: 50px;

            height: 42px;

            border: none;

            border-left: 1px solid #333;

            border-right: 1px solid #333;

            background: #050505;

            color: #fff;

            text-align: center;

            font-size: 16px;

            outline: none;
        }


        /* ================= ACTION BUTTONS ================= */

        .product-action-buttons {

            display: flex;

            flex-direction: column;

            gap: 12px;
        }


        .details-cart-btn {

            width: 100%;

            padding: 18px;

            border: none;

            background: #ff2525;

            color: #fff;

            font-size: 14px;

            font-weight: 900;

            letter-spacing: 3px;

            cursor: pointer;

            transition: 0.3s ease;
        }


        .details-cart-btn:hover {

            background: #fff;

            color: #000;

            transform:
                translateY(-3px);
        }


        /* ================= WISHLIST ================= */

        .wishlist-detail-btn {

            width: 100%;

            padding: 17px;

            border: 1px solid #333;

            background: transparent;

            color: #fff;

            font-size: 13px;

            font-weight: 800;

            letter-spacing: 3px;

            cursor: pointer;

            transition:
                0.3s ease;
        }


        .wishlist-detail-btn:hover {

            background: #ff2525;

            border-color: #ff2525;

            color: #fff;

            transform:
                translateY(-3px);
        }


        .back-shop {

            display: inline-block;

            margin-top: 25px;

            color: #777;

            text-decoration: none;

            font-size: 13px;

            letter-spacing: 2px;
        }


        .back-shop:hover {

            color: #fff;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 850px) {

            .product-details-page {

                padding:
                    130px 5% 70px;
            }


            .product-details-container {

                grid-template-columns: 1fr;

                gap: 40px;
            }


            .product-details-image {

                min-height: 400px;
            }


            .product-details-info h1 {

                font-size: 55px;
            }

        }

    </style>

</head>


<body>


    <!-- ================= NAVBAR ================= -->

    <header class="navbar">

        <div class="logo">
            DRIFT
        </div>


        <nav>

            <a href="<%= request.getContextPath() %>/index.html">
                HOME
            </a>

            <a href="<%= request.getContextPath() %>/shop">
                SHOP
            </a>

            <a href="<%= request.getContextPath() %>/pages/about.html">
                ABOUT
            </a>

            <a href="<%= request.getContextPath() %>/pages/contact.jsp">
                CONTACT
            </a>

            <a href="<%= request.getContextPath() %>/pages/login.html">
                LOGIN
            </a>

            <a href="<%= request.getContextPath() %>/orders">
                MY ORDERS
            </a>

            <a href="<%= request.getContextPath() %>/wishlist">
                WISHLIST
            </a>

            <a href="<%= request.getContextPath() %>/cart"
               class="cart-link">

                CART

                <span id="cart-count">
                    0
                </span>

            </a>

        </nav>

    </header>


    <!-- ================= PRODUCT ================= -->

    <main class="product-details-page">


        <section class="product-details-container">


            <!-- PRODUCT IMAGE -->

            <div class="product-details-image">

                <img
                    src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
                    alt="<%= product.getProductName() %>"
                >

            </div>


            <!-- PRODUCT INFORMATION -->

            <div class="product-details-info">


                <p class="product-category">
                    DRIFT COLLECTION
                </p>


                <h1>
                    <%= product.getProductName() %>
                </h1>


                <div class="product-rating">

                    <span class="stars">

                        &#9733;&#9733;&#9733;&#9733;&#9733;

                    </span>

                    <span class="rating-number">

                        <%= product.getRating() %> / 5

                    </span>

                </div>


                <p class="product-description">

                    <%= product.getDescription() != null
                        ? product.getDescription()
                        : "Built for movement. Designed for those who move different." %>

                </p>


                <div class="product-price">

                    &#8377;<%= String.format(
                            "%,.2f",
                            product.getPrice()
                    ) %>

                </div>


                <div class="product-meta">


                    <div class="meta-box">

                        <span class="meta-label">
                            COLOR
                        </span>

                        <span class="meta-value">

                            <%= product.getColor() %>

                        </span>

                    </div>


                    <div class="meta-box">

                        <span class="meta-label">
                            SIZE
                        </span>

                        <span class="meta-value">

                            <%= product.getSize() != null
                                ? product.getSize()
                                : "STANDARD" %>

                        </span>

                    </div>


                    <div class="meta-box">

                        <span class="meta-label">
                            STOCK
                        </span>

                        <span class="meta-value">

                            <%= product.getStock() %>
                            AVAILABLE

                        </span>

                    </div>


                    <div class="meta-box">

                        <span class="meta-label">
                            PRODUCT ID
                        </span>

                        <span class="meta-value">

                            #<%= product.getProductId() %>

                        </span>

                    </div>


                </div>


                <!-- QUANTITY + ACTIONS -->

                <form
                    action="<%= request.getContextPath() %>/add-to-cart"
                    method="post">


                    <input
                        type="hidden"
                        name="productId"
                        value="<%= product.getProductId() %>"
                    >


                    <div class="quantity-wrapper">

                        <label for="quantity">
                            QUANTITY
                        </label>


                        <div class="quantity-control">


                            <button
                                type="button"
                                onclick="decreaseQuantity()">

                                -

                            </button>


                            <input
                                type="number"
                                id="quantity"
                                name="quantity"
                                value="1"
                                min="1"
                                max="<%= product.getStock() %>"
                            >


                            <button
                                type="button"
                                onclick="increaseQuantity()">

                                +

                            </button>


                        </div>

                    </div>


                    <div class="product-action-buttons">


                        <button
                            type="submit"
                            class="details-cart-btn">

                            ADD TO CART &#8594;

                        </button>


                </form>


                <form
                    action="<%= request.getContextPath() %>/add-to-wishlist"
                    method="post">

                    <input
                        type="hidden"
                        name="productId"
                        value="<%= product.getProductId() %>"
                    >

                    <button
                        type="submit"
                        class="wishlist-detail-btn">

                        &#9825; ADD TO WISHLIST

                    </button>

                </form>


                    </div>


                <a
                    href="<%= request.getContextPath() %>/shop"
                    class="back-shop">

                    &#8592; BACK TO SHOP

                </a>


            </div>


        </section>


    </main>


    <!-- ================= FOOTER ================= -->

    <footer>

        <div class="footer-logo">
            DRIFT
        </div>

        <p>
            MOVE DIFFERENT.
        </p>


        <div class="footer-links">

            <a href="#">
                Instagram
            </a>

            <a href="#">
                Twitter
            </a>

            <a href="#">
                Privacy
            </a>

            <a href="#">
                Terms
            </a>

        </div>


        <p class="copyright">

            © 2026 DRIFT.

            ALL RIGHTS RESERVED.

        </p>

    </footer>


    <!-- ================= JAVASCRIPT ================= -->

    <script>

        function increaseQuantity() {

            const quantity =
                document.getElementById("quantity");

            const max =
                parseInt(quantity.max);

            let value =
                parseInt(quantity.value);

            if (value < max) {

                quantity.value =
                    value + 1;
            }
        }


        function decreaseQuantity() {

            const quantity =
                document.getElementById("quantity");

            let value =
                parseInt(quantity.value);

            if (value > 1) {

                quantity.value =
                    value - 1;
            }
        }

    </script>


    <script src="<%= request.getContextPath() %>/js/script.js"></script>


</body>

</html>