<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.User" %>
<%@ page import="com.drift.model.CartItem" %>

<%
    User user =
        (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.html");
        return;
    }

    List<CartItem> cartItems =
        (List<CartItem>) request.getAttribute("cartItems");

    Integer totalQuantityObject =
        (Integer) request.getAttribute("totalQuantity");

    Double subtotalObject =
        (Double) request.getAttribute("subtotal");

    Double shippingObject =
        (Double) request.getAttribute("shipping");

    Double totalObject =
        (Double) request.getAttribute("total");

    int totalQuantity =
        totalQuantityObject != null
        ? totalQuantityObject
        : 0;

    double subtotal =
        subtotalObject != null
        ? subtotalObject
        : 0;

    double shipping =
        shippingObject != null
        ? shippingObject
        : 0;

    double total =
        totalObject != null
        ? totalObject
        : 0;
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Checkout</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/checkout.css">

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
     MAIN CHECKOUT
     ===================================================== -->

<main>

<section class="checkout-page">


    <!-- =================================================
         CHECKOUT HEADER
         ================================================= -->

    <div class="checkout-header">

        <div class="checkout-label">
            DRIFT CHECKOUT //
        </div>

        <h1>
            COMPLETE
            <span>ORDER.</span>
        </h1>

        <p>
            ONE LAST STEP BEFORE YOU MOVE DIFFERENT.
        </p>

    </div>


    <div class="checkout-container">


        <!-- =============================================
             LEFT SIDE
             ============================================= -->

        <section class="checkout-form-section">


            <!-- =========================================
                 SHIPPING DETAILS
                 ========================================= -->

            <div class="checkout-section-number">
                01
            </div>

            <div class="checkout-section-title">

                <span>
                    DELIVERY
                </span>

                <h2>
                    SHIPPING
                    <strong>DETAILS</strong>
                </h2>

            </div>


          <form action="${pageContext.request.contextPath}/place-order"
      method="post"
      class="checkout-form">


                <!-- NAME -->

                <div class="checkout-field full-width">

                    <label>
                        FULL NAME
                    </label>

                    <input
                        type="text"
                        name="name"
                        value="<%= user.getName() %>"
                        required
                    >

                </div>


                <!-- EMAIL -->

                <div class="checkout-field">

                    <label>
                        EMAIL
                    </label>

                    <input
                        type="email"
                        name="email"
                        value="<%= user.getEmail() %>"
                        required
                    >

                </div>


                <!-- PHONE -->

                <div class="checkout-field">

                    <label>
                        PHONE
                    </label>

                    <input
                        type="tel"
                        name="phone"
                        value="<%= user.getPhone() != null
                                ? user.getPhone()
                                : "" %>"
                        required
                    >

                </div>


                <!-- ADDRESS -->

                <div class="checkout-field full-width">

                    <label>
                        SHIPPING ADDRESS
                    </label>

                    <textarea
                        name="address"
                        rows="4"
                        required><%= user.getAddress() != null
                                ? user.getAddress()
                                : "" %></textarea>

                </div>


                <!-- =====================================
                     PAYMENT METHOD
                     ===================================== -->

                <div class="checkout-payment">


                    <div class="checkout-section-number">
                        02
                    </div>


                    <div class="checkout-section-title">

                        <span>
                            PAYMENT
                        </span>

                        <h2>
                            PAYMENT
                            <strong>METHOD</strong>
                        </h2>

                    </div>


                    <div class="payment-options">


                        <!-- COD -->

                        <label class="payment-option">

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="COD"
                                checked
                            >

                            <span class="payment-box">

                                <span class="payment-icon">
                                    ₹
                                </span>

                                <span>

                                    <strong>
                                        CASH ON DELIVERY
                                    </strong>

                                    <small>
                                        PAY WHEN YOUR DRIFT ARRIVES
                                    </small>

                                </span>

                            </span>

                        </label>


                        <!-- UPI -->

                        <label class="payment-option">

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="UPI"
                            >

                            <span class="payment-box">

                                <span class="payment-icon">
                                    UPI
                                </span>

                                <span>

                                    <strong>
                                        UPI PAYMENT
                                    </strong>

                                    <small>
                                        FAST DIGITAL PAYMENT
                                    </small>

                                </span>

                            </span>

                        </label>


                        <!-- CARD -->

                        <label class="payment-option">

                            <input
                                type="radio"
                                name="paymentMethod"
                                value="CARD"
                            >

                            <span class="payment-box">

                                <span class="payment-icon">
                                    CARD
                                </span>

                                <span>

                                    <strong>
                                        CARD PAYMENT
                                    </strong>

                                    <small>
                                        CREDIT / DEBIT CARD
                                    </small>

                                </span>

                            </span>

                        </label>


                    </div>

                </div>


                <!-- =====================================
                     PLACE ORDER
                     ===================================== -->

                <button
                    type="submit"
                    class="place-order-btn">

                    PLACE ORDER

                    <span>
                        →
                    </span>

                </button>


            </form>

        </section>


        <!-- =============================================
             RIGHT SIDE — ORDER SUMMARY
             ============================================= -->

        <aside class="checkout-preview">


            <div class="preview-label">
                DRIFT ORDER
            </div>


            <h2>
                YOUR
                <span>ORDER.</span>
            </h2>


            <!-- ITEMS -->

            <div class="preview-line">

                <span>
                    ITEMS
                </span>

                <strong>
                    <%= totalQuantity %>
                </strong>

            </div>


            <!-- SUBTOTAL -->

            <div class="preview-line">

                <span>
                    SUBTOTAL
                </span>

                <strong>
                    ₹<%= String.format("%,.2f", subtotal) %>
                </strong>

            </div>


            <!-- SHIPPING -->

            <div class="preview-line">

                <span>
                    SHIPPING
                </span>

                <strong>
                    <%= shipping == 0
                        ? "FREE"
                        : "₹" + String.format(
                            "%,.2f",
                            shipping
                        )
                    %>
                </strong>

            </div>


            <div class="preview-divider"></div>


            <!-- TOTAL -->

            <div class="preview-total">

                <span>
                    TOTAL
                </span>

                <strong>
                    ₹<%= String.format("%,.2f", total) %>
                </strong>

            </div>


            <!-- NOTE -->

            <div class="preview-note">

                <span class="preview-dot"></span>

                <p>
                    SECURE CHECKOUT ·
                    DRIFT STANDARD ·
                    FREE SHIPPING
                </p>

            </div>


        </aside>


    </div>

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
        © 2026 DRIFT. ALL RIGHTS RESERVED.
    </p>

</footer>


<script
    src="${pageContext.request.contextPath}/js/script.js">
</script>

</body>

</html>