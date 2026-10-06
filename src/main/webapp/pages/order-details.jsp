<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.Order" %>
<%@ page import="com.drift.model.CartItem" %>

<%
    Order order =
        (Order) request.getAttribute("order");

    List<CartItem> orderItems =
        (List<CartItem>) request.getAttribute("orderItems");

    String status =
        order != null ? order.getOrderStatus() : "PLACED";

    if (status == null) {
        status = "PLACED";
    }

    status = status.toUpperCase();
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        DRIFT | Order Details
    </title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/orders.css">


    <style>

        /* =====================================================
           ORDER DETAILS PAGE
           ===================================================== */

        .order-details-page {

            max-width: 1200px;

            margin: 0 auto;

            padding: 100px 30px 80px;

        }


        .details-back {

            display: inline-block;

            margin-bottom: 35px;

            color: #555;

            text-decoration: none;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 1.5px;

            transition: color 0.3s ease;

        }


        .details-back:hover {

            color: #ff2525;

        }


        .details-header {

            display: flex;

            justify-content: space-between;

            align-items: flex-end;

            gap: 30px;

            margin-bottom: 45px;

            padding-bottom: 25px;

            border-bottom: 1px solid #ddd;

        }


        .details-label {

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;

            color: #777;

            margin-bottom: 10px;

        }


        .details-header h1 {

            margin: 0;

            font-size: clamp(38px, 6vw, 72px);

            line-height: 0.9;

            letter-spacing: -3px;

            font-weight: 900;

        }


        .details-header h1 span {

            color: #ff2525;

        }


        .details-status {

            padding: 12px 18px;

            border: 1px solid #111;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 1.5px;

            white-space: nowrap;

        }


        /* =====================================================
           ORDER INFORMATION
           ===================================================== */

        .details-info {

            display: grid;

            grid-template-columns:
                repeat(4, 1fr);

            gap: 1px;

            background: #ddd;

            border: 1px solid #ddd;

            margin-bottom: 45px;

        }


        .details-info-box {

            background: #fff;

            padding: 22px;

        }


        .details-info-box span {

            display: block;

            margin-bottom: 8px;

            font-size: 9px;

            font-weight: 900;

            letter-spacing: 1.5px;

            color: #888;

        }


        .details-info-box strong {

            display: block;

            font-size: 13px;

            font-weight: 900;

            color: #111;

        }


        /* =====================================================
           PRODUCTS SECTION
           ===================================================== */

        .details-section-label {

            margin-bottom: 15px;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;

            color: #777;

        }


        .details-products {

            border-top: 2px solid #111;

            margin-bottom: 35px;

        }


        .details-product {

            display: grid;

            grid-template-columns:
                90px 1fr auto auto;

            align-items: center;

            gap: 25px;

            padding: 20px 0;

            border-bottom: 1px solid #ddd;

        }


        .details-product-image {

            width: 90px;

            height: 90px;

            background: #f3f3f3;

            overflow: hidden;

            display: flex;

            align-items: center;

            justify-content: center;

        }


        .details-product-image img {

            width: 100%;

            height: 100%;

            object-fit: cover;

            transition: transform 0.4s ease;

        }


        .details-product:hover
        .details-product-image img {

            transform: scale(1.08);

        }


        .details-product-name {

            font-size: 14px;

            font-weight: 900;

            letter-spacing: 0.5px;

            text-transform: uppercase;

        }


        .details-product-id {

            margin-top: 6px;

            font-size: 9px;

            font-weight: 700;

            letter-spacing: 1px;

            color: #999;

        }


        .details-product-quantity {

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 1px;

            color: #666;

        }


        .details-product-price {

            min-width: 110px;

            text-align: right;

            font-size: 14px;

            font-weight: 900;

        }


        /* =====================================================
           TOTAL
           ===================================================== */

        .details-total {

            display: flex;

            justify-content: flex-end;

            margin-bottom: 45px;

        }


        .details-total-box {

            width: 320px;

            border-top: 2px solid #111;

            padding-top: 18px;

        }


        .details-total-row {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 12px;

        }


        .details-total-row span {

            font-size: 10px;

            font-weight: 800;

            letter-spacing: 1.5px;

            color: #777;

        }


        .details-total-row strong {

            font-size: 13px;

            font-weight: 900;

        }


        .details-total-final {

            margin-top: 18px;

            padding-top: 18px;

            border-top: 1px solid #ddd;

        }


        .details-total-final span {

            color: #111;

        }


        .details-total-final strong {

            font-size: 22px;

        }


        /* =====================================================
           SHIPPING ADDRESS
           ===================================================== */

        .details-address {

            padding: 25px;

            border: 1px solid #ddd;

            background: #fafafa;

        }


        .details-address-label {

            display: block;

            margin-bottom: 10px;

            font-size: 9px;

            font-weight: 900;

            letter-spacing: 1.5px;

            color: #888;

        }


        .details-address p {

            margin: 0;

            font-size: 13px;

            font-weight: 700;

            line-height: 1.6;

            color: #222;

        }


        /* =====================================================
           EMPTY ORDER
           ===================================================== */

        .details-empty {

            padding: 50px;

            border: 1px solid #ddd;

            text-align: center;

        }


        .details-empty p {

            margin: 0;

            font-size: 11px;

            font-weight: 900;

            letter-spacing: 1.5px;

        }


        /* =====================================================
           MOBILE
           ===================================================== */

        @media (max-width: 750px) {

            .order-details-page {

                padding: 80px 20px 60px;

            }


            .details-header {

                align-items: flex-start;

                flex-direction: column;

            }


            .details-info {

                grid-template-columns:
                    repeat(2, 1fr);

            }


            .details-product {

                grid-template-columns:
                    70px 1fr;

                gap: 15px;

            }


            .details-product-image {

                width: 70px;

                height: 70px;

            }


            .details-product-quantity {

                grid-column: 2;

            }


            .details-product-price {

                grid-column: 2;

                text-align: left;

            }


            .details-total {

                justify-content: stretch;

            }


            .details-total-box {

                width: 100%;

            }

        }


        @media (max-width: 450px) {

            .details-info {

                grid-template-columns:
                    1fr;

            }

        }

    </style>

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

        <a href="${pageContext.request.contextPath}/index.html">
            HOME
        </a>

        <a href="${pageContext.request.contextPath}/shop">
            SHOP
        </a>

        <a href="${pageContext.request.contextPath}/pages/about.html">
            ABOUT
        </a>

        <a href="${pageContext.request.contextPath}/pages/contact.html">
            CONTACT
        </a>

    </nav>


    <div class="nav-actions">

        <a href="${pageContext.request.contextPath}/cart">
            CART
        </a>

    </div>

</header>



<!-- =====================================================
     ORDER DETAILS
     ===================================================== -->

<main>

<section class="order-details-page">


    <a
        href="${pageContext.request.contextPath}/orders"
        class="details-back">

        &#8592; BACK TO MY ORDERS

    </a>



<%

    if (order != null) {

%>


    <!-- =================================================
         HEADER
         ================================================= -->

    <div class="details-header">

        <div>

            <div class="details-label">
                DRIFT ORDER SYSTEM //
            </div>

            <h1>

                ORDER

                <span>
                    #<%= order.getOrderId() %>
                </span>

            </h1>

        </div>


        <div class="details-status">

            <%= status %>

        </div>

    </div>



    <!-- =================================================
         ORDER INFORMATION
         ================================================= -->

    <div class="details-info">


        <div class="details-info-box">

            <span>
                ORDER DATE
            </span>

            <strong>
                <%= order.getOrderDate() %>
            </strong>

        </div>


        <div class="details-info-box">

            <span>
                PAYMENT
            </span>

            <strong>
                <%= order.getPaymentMethod() %>
            </strong>

        </div>


        <div class="details-info-box">

            <span>
                SHIPPING
            </span>

            <strong>
                FREE
            </strong>

        </div>


        <div class="details-info-box">

            <span>
                STATUS
            </span>

            <strong>
                <%= status %>
            </strong>

        </div>


    </div>



    <!-- =================================================
         PRODUCTS
         ================================================= -->

    <div class="details-section-label">

        ORDER ITEMS //

    </div>


    <div class="details-products">


<%

        if (orderItems != null &&
            !orderItems.isEmpty()) {

            for (CartItem item : orderItems) {

                double itemTotal =
                    item.getPrice() *
                    item.getQuantity();

%>


        <div class="details-product">


            <!-- PRODUCT IMAGE -->

            <div class="details-product-image">

                <img
                    src="${pageContext.request.contextPath}/images/<%= item.getImage() %>"
                    alt="<%= item.getProductName() %>">

            </div>


            <!-- PRODUCT NAME -->

            <div>

                <div class="details-product-name">

                    <%= item.getProductName() %>

                </div>

                <div class="details-product-id">

                    PRODUCT ID //
                    <%= item.getProductId() %>

                </div>

            </div>


            <!-- QUANTITY -->

            <div class="details-product-quantity">

                QTY //
                <%= item.getQuantity() %>

            </div>


            <!-- PRICE -->

            <div class="details-product-price">

                &#8377;<%= String.format(
                    "%,.2f",
                    itemTotal
                ) %>

            </div>


        </div>


<%

            }

        } else {

%>


        <div class="details-empty">

            <p>
                NO ORDER ITEMS FOUND.
            </p>

        </div>


<%

        }

%>


    </div>



    <!-- =================================================
         TOTAL
         ================================================= -->

    <div class="details-total">

        <div class="details-total-box">


            <div class="details-total-row">

                <span>
                    SHIPPING
                </span>

                <strong>
                    FREE
                </strong>

            </div>


            <div class="details-total-row
                        details-total-final">

                <span>
                    ORDER TOTAL
                </span>

                <strong>

                    &#8377;<%= String.format(
                        "%,.2f",
                        order.getTotalAmount()
                    ) %>

                </strong>

            </div>


        </div>

    </div>



    <!-- =================================================
         SHIPPING ADDRESS
         ================================================= -->

    <div class="details-section-label">

        DELIVERY INFORMATION //

    </div>


    <div class="details-address">

        <span class="details-address-label">

            SHIPPING ADDRESS

        </span>


        <p>

            <%= order.getShippingAddress() %>

        </p>

    </div>


<%

    } else {

%>


    <div class="details-empty">

        <p>
            ORDER NOT FOUND.
        </p>

    </div>


<%

    }

%>


</section>

</main>



<!-- =====================================================
     FOOTER
     ===================================================== -->

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

        &copy; 2026 DRIFT.
        ALL RIGHTS RESERVED.

    </p>

</footer>



<script
    src="${pageContext.request.contextPath}/js/script.js">
</script>


</body>

</html>