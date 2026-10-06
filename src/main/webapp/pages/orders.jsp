<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.Order" %>

<%
    List<Order> orders =
        (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | My Orders</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/orders.css">

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
     ORDERS PAGE
     ===================================================== -->

<main>

<section class="orders-page">


    <!-- PAGE HEADER -->

    <div class="orders-header">

        <div class="orders-label">
            DRIFT ACCOUNT //
        </div>

        <h1>

            MY

            <span>
                ORDERS.
            </span>

        </h1>

        <p>
            YOUR DRIFT ORDER HISTORY
        </p>

    </div>



<%

    if (orders != null && !orders.isEmpty()) {

%>


    <!-- =================================================
         ORDER LIST
         ================================================= -->

    <div class="orders-container">

<%

        for (Order order : orders) {

            String status = order.getOrderStatus();

            if (status == null) {
                status = "PLACED";
            }

            status = status.toUpperCase();

%>


        <!-- =================================================
             ORDER CARD
             ================================================= -->

        <article class="order-card">


            <!-- ORDER TOP -->

            <div class="order-top">

                <div>

                    <span class="order-label">
                        DRIFT ORDER
                    </span>

                    <h2>
                        #<%= order.getOrderId() %>
                    </h2>

                </div>


                <!-- CURRENT STATUS -->

                <div class="order-status status-<%= status.toLowerCase() %>">

                    <span class="status-dot"></span>

                    <%= status %>

                </div>

            </div>



            <!-- =================================================
                 ORDER STATUS TRACKER
                 ================================================= -->

            <div class="order-tracker">


                <!-- PLACED -->

                <div class="tracker-step
                    <%= status.equals("PLACED") ||
                        status.equals("CONFIRMED") ||
                        status.equals("SHIPPED") ||
                        status.equals("DELIVERED")
                        ? "completed" : "" %>">

                    <div class="tracker-dot">
                        01
                    </div>

                    <span>
                        PLACED
                    </span>

                </div>



                <div class="tracker-line
                    <%= status.equals("CONFIRMED") ||
                        status.equals("SHIPPED") ||
                        status.equals("DELIVERED")
                        ? "completed" : "" %>">
                </div>



                <!-- CONFIRMED -->

                <div class="tracker-step
                    <%= status.equals("CONFIRMED") ||
                        status.equals("SHIPPED") ||
                        status.equals("DELIVERED")
                        ? "completed" : "" %>">

                    <div class="tracker-dot">
                        02
                    </div>

                    <span>
                        CONFIRMED
                    </span>

                </div>



                <div class="tracker-line
                    <%= status.equals("SHIPPED") ||
                        status.equals("DELIVERED")
                        ? "completed" : "" %>">
                </div>



                <!-- SHIPPED -->

                <div class="tracker-step
                    <%= status.equals("SHIPPED") ||
                        status.equals("DELIVERED")
                        ? "completed" : "" %>">

                    <div class="tracker-dot">
                        03
                    </div>

                    <span>
                        SHIPPED
                    </span>

                </div>



                <div class="tracker-line
                    <%= status.equals("DELIVERED")
                        ? "completed" : "" %>">
                </div>



                <!-- DELIVERED -->

                <div class="tracker-step
                    <%= status.equals("DELIVERED")
                        ? "completed" : "" %>">

                    <div class="tracker-dot">
                        04
                    </div>

                    <span>
                        DELIVERED
                    </span>

                </div>


            </div>



<%

            if (status.equals("CANCELLED")) {

%>

            <!-- CANCELLED MESSAGE -->

            <div class="cancelled-order">

                <span class="cancelled-icon">
                    &#10005;
                </span>

                <div>

                    <strong>
                        ORDER CANCELLED
                    </strong>

                    <p>
                        THIS DRIFT ORDER HAS BEEN CANCELLED.
                    </p>

                </div>

            </div>

<%

            }

%>



            <!-- =================================================
                 ORDER DETAILS
                 ================================================= -->

            <div class="order-details">


                <div class="order-detail">

                    <span>
                        ORDER DATE
                    </span>

                    <strong>
                        <%= order.getOrderDate() %>
                    </strong>

                </div>



                <div class="order-detail">

                    <span>
                        PAYMENT
                    </span>

                    <strong>
                        <%= order.getPaymentMethod() %>
                    </strong>

                </div>



                <div class="order-detail">

                    <span>
                        SHIPPING
                    </span>

                    <strong>
                        FREE
                    </strong>

                </div>



                <div class="order-detail">

                    <span>
                        TOTAL
                    </span>

                    <strong class="order-total">

                        &#8377;<%= String.format(
                            "%,.2f",
                            order.getTotalAmount()
                        ) %>

                    </strong>

                </div>


            </div>



            <!-- =================================================
                 SHIPPING ADDRESS
                 ================================================= -->

            <div class="order-address">

                <span>
                    SHIPPING ADDRESS
                </span>

                <p>
                    <%= order.getShippingAddress() %>
                </p>

            </div>
<div class="order-actions">

    <a
        href="${pageContext.request.contextPath}/order-details?orderId=<%= order.getOrderId() %>"
        class="order-details-btn">

        VIEW ORDER DETAILS

        <span>
            &#8594;
        </span>

    </a>

</div>

        </article>


<%

        }

%>

    </div>


<%

    } else {

%>


    <!-- =================================================
         NO ORDERS
         ================================================= -->

    <div class="no-orders">

        <div class="no-orders-icon">
            +
        </div>

        <span>
            DRIFT ORDERS // 00
        </span>

        <h2>

            NO ORDERS

            <strong>
                YET.
            </strong>

        </h2>

        <p>
            YOUR NEXT MOVE IS WAITING.
        </p>

        <a
            href="${pageContext.request.contextPath}/shop"
            class="btn primary-btn">

            EXPLORE PRODUCTS

        </a>

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