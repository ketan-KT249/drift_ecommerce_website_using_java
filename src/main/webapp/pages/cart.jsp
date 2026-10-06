<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.CartItem" %>
<%
    List<CartItem> cartItems =
        (List<CartItem>) request.getAttribute("cartItems");

    int cartQuantity = 0;

    if (cartItems != null) {
        for (CartItem cartItem : cartItems) {
            cartQuantity += cartItem.getQuantity();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Cart</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

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

            <a href="${pageContext.request.contextPath}/pages/login.html">
                LOGIN
            </a>

            <a href="${pageContext.request.contextPath}/cart"
               class="cart-link">

                CART

               <span id="cart-count">
    <%= cartQuantity %>
</span>

            </a>

        </div>

    </header>



    <!-- =====================================================
         MAIN CART PAGE
         ===================================================== -->

    <main>

        <section class="cart-page">


            <!-- =================================================
                 CART HEADER
                 ================================================= -->

            <div class="cart-header">

                <div class="cart-header-label">
                    YOUR SELECTION
                </div>

                <h1>
                    YOUR
                    <span>CART.</span>
                </h1>

                <p>
                    REVIEW YOUR DRIFT COLLECTION
                </p>

            </div>



            <%

              

                double subtotal = 0;

                if (cartItems != null &&
                    !cartItems.isEmpty()) {

            %>


            <!-- =================================================
                 CART CONTENT
                 ================================================= -->

            <div class="cart-container">


                <!-- =================================================
                     LEFT SIDE — CART ITEMS
                     ================================================= -->

                <div class="cart-items">

                    <div class="cart-items-header">

                        <div>

                            <span>
                                YOUR ITEMS
                            </span>

                            <h2>
                                CART
                            </h2>

                        </div>

                        <div class="cart-items-count">

                        <%= cartQuantity %>

ITEM<%= cartQuantity > 1 ? "S" : "" %>

                        </div>

                    </div>



                    <%

                        for (CartItem item : cartItems) {

                            double itemTotal =
                                item.getPrice()
                                * item.getQuantity();

                            subtotal += itemTotal;

                    %>


                    <!-- =================================================
                         SINGLE CART ITEM
                         ================================================= -->

                    <div class="cart-item">


                        <!-- PRODUCT IMAGE -->

                        <div class="cart-item-image">

                            <div class="cart-image-number">
                                0<%= item.getProductId() %>
                            </div>

                            <img
                                src="${pageContext.request.contextPath}/images/<%= item.getImage() %>"
                                alt="<%= item.getProductName() %>"
                            >

                        </div>



                        <!-- PRODUCT INFORMATION -->

                        <div class="cart-item-details">


                            <div class="cart-product-top">

                                <div>

                                    <span class="cart-product-label">
                                        DRIFT PRODUCT
                                    </span>

                                    <h3>
                                        <%= item.getProductName() %>
                                    </h3>

                                </div>


                                <div class="cart-item-total">

                                    ₹<%= String.format(
                                            "%,.2f",
                                            itemTotal
                                        ) %>

                                </div>

                            </div>



                            <!-- PRICE -->

                            <div class="cart-product-price">

                                UNIT PRICE

                                <strong>
                                    ₹<%= String.format(
                                            "%,.2f",
                                            item.getPrice()
                                        ) %>
                                </strong>

                            </div>



                            <!-- QUANTITY -->

                            <div class="quantity-section">

                                <span class="quantity-label">
                                    QUANTITY
                                </span>


                                <div class="quantity-controls">


                                    <!-- DECREASE -->

                                    <form
                                        action="${pageContext.request.contextPath}/update-cart-quantity"
                                        method="post"
                                    >

                                        <input
                                            type="hidden"
                                            name="cartItemId"
                                            value="<%= item.getCartItemId() %>"
                                        >

                                        <input
                                            type="hidden"
                                            name="quantity"
                                            value="<%= item.getQuantity() - 1 %>"
                                        >

                                        <button
                                            type="submit"
                                            class="quantity-btn minus-btn"
                                            <%= item.getQuantity() <= 1
                                                ? "disabled"
                                                : "" %>
                                        >
                                            −
                                        </button>

                                    </form>



                                    <!-- CURRENT QUANTITY -->

                                    <span class="quantity-value">

                                        <%= item.getQuantity() %>

                                    </span>



                                    <!-- INCREASE -->

                                    <form
                                        action="${pageContext.request.contextPath}/update-cart-quantity"
                                        method="post"
                                    >

                                        <input
                                            type="hidden"
                                            name="cartItemId"
                                            value="<%= item.getCartItemId() %>"
                                        >

                                        <input
                                            type="hidden"
                                            name="quantity"
                                            value="<%= item.getQuantity() + 1 %>"
                                        >

                                        <button
                                            type="submit"
                                            class="quantity-btn plus-btn"
                                        >
                                            +
                                        </button>

                                    </form>


                                </div>

                            </div>



                            <!-- REMOVE -->

                            <form
                                action="${pageContext.request.contextPath}/remove-from-cart"
                                method="post"
                                class="remove-form"
                            >

                                <input
                                    type="hidden"
                                    name="cartItemId"
                                    value="<%= item.getCartItemId() %>"
                                >

                                <button
                                    type="submit"
                                    class="remove-cart"
                                >
                                    REMOVE ITEM
                                </button>

                            </form>


                        </div>


                    </div>


                    <%

                        }

                    %>


                </div>



                <!-- =================================================
                     RIGHT SIDE — ORDER SUMMARY
                     ================================================= -->

                <aside class="cart-summary">


                    <div class="summary-top">

                        <span>
                            DRIFT CHECKOUT
                        </span>

                        <div class="summary-symbol">
                            //
                        </div>

                    </div>


                    <h2>
                        ORDER
                        <span>SUMMARY</span>
                    </h2>



                    <!-- SUBTOTAL -->

                    <div class="summary-row">

                        <span>
                            SUBTOTAL
                        </span>

                        <strong>
                            ₹<%= String.format(
                                    "%,.2f",
                                    subtotal
                                ) %>
                        </strong>

                    </div>



                    <!-- SHIPPING -->

                    <div class="summary-row">

                        <span>
                            SHIPPING
                        </span>

                        <strong class="free-shipping">
                            FREE
                        </strong>

                    </div>



                    <!-- INFO -->

                    <div class="summary-info">

                        <span class="summary-dot"></span>

                        <p>
                            FREE SHIPPING ON YOUR DRIFT ORDER
                        </p>

                    </div>



                    <div class="summary-divider">
                    </div>



                    <!-- TOTAL -->

                    <div class="summary-total">

                        <span>
                            TOTAL
                        </span>

                        <strong>
                            ₹<%= String.format(
                                    "%,.2f",
                                    subtotal
                                ) %>
                        </strong>

                    </div>



                    <!-- CHECKOUT -->

                 <a href="${pageContext.request.contextPath}/checkout"
   class="checkout-btn">

    PROCEED TO CHECKOUT

    <span>→</span>

</a>


                    <p class="checkout-note">

                        SECURE CHECKOUT · DRIFT STANDARD

                    </p>


                </aside>


            </div>


            <%

                } else {

            %>


            <!-- =================================================
                 EMPTY CART
                 ================================================= -->

            <div class="empty-cart">

                <div class="empty-cart-icon">
                    +
                </div>

                <span>
                    DRIFT CART // 00
                </span>

                <h2>
                    YOUR CART
                    <br>
                    <strong>IS EMPTY.</strong>
                </h2>

                <p>
                    Your next move is waiting.
                </p>

                <a
                    href="${pageContext.request.contextPath}/shop"
                    class="btn primary-btn"
                >
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

            © 2026 DRIFT.
            ALL RIGHTS RESERVED.

        </p>

    </footer>



    <!-- =====================================================
         JAVASCRIPT
         ===================================================== -->

    <script
        src="${pageContext.request.contextPath}/js/script.js">
    </script>


</body>

</html>