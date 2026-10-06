<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String userName =
            (String) request.getAttribute("userName");

    if (userName == null) {
        userName = "DRIFT USER";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Order Confirmed</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/checkout.css">

</head>

<body>

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


<main>

<section class="order-success-page">

    <div class="success-glow"></div>


    <div class="success-number">
        01 // CONFIRMED
    </div>


    <div class="success-icon">
        &#10003;
    </div>


    <div class="success-label">
        DRIFT ORDER SYSTEM
    </div>


    <h1>

        ORDER

        <span>
            CONFIRMED.
        </span>

    </h1>


    <p class="success-message">

        THANK YOU,
        <strong>
            <%= userName %>
        </strong>.

        <br>

        YOUR DRIFT ORDER HAS BEEN
        PLACED SUCCESSFULLY.

    </p>


    <!-- ORDER STATUS -->

    <div class="success-status">


        <div class="status-line">

            <span class="status-dot"></span>

            <span>
                ORDER STATUS
            </span>

            <strong>
                PLACED
            </strong>

        </div>


        <div class="status-line">

            <span class="status-dot"></span>

            <span>
                SHIPPING
            </span>

            <strong>
                FREE
            </strong>

        </div>


        <div class="status-line">

            <span class="status-dot"></span>

            <span>
                PAYMENT
            </span>

            <strong>
                SELECTED
            </strong>

        </div>


    </div>


    <!-- ACTION BUTTONS -->

    <div class="success-actions">


        <a
            href="${pageContext.request.contextPath}/shop"
            class="success-btn primary">

            CONTINUE SHOPPING

            <span>
                &#8594;
            </span>

        </a>


        <a
            href="${pageContext.request.contextPath}/index.html"
            class="success-btn secondary">

            BACK TO HOME

        </a>


    </div>


    <div class="success-footer-text">

        MOVE DIFFERENT. &middot; DRIFT STANDARD.

    </div>


</section>

</main>


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