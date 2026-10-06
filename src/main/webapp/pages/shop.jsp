<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.Product" %>
<%@ page import="com.drift.model.Category" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Shop</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">


    <style>

        /* ================= PRODUCT DETAILS LINK ================= */

        .product-details-link {

            display: block;

            margin-top: 12px;

            padding: 12px;

            border: 1px solid #333;

            color: #fff;

            text-align: center;

            text-decoration: none;

            font-size: 12px;

            font-weight: 800;

            letter-spacing: 2px;

            transition: 0.3s ease;
        }


        .product-details-link:hover {

            background: #ff2525;

            border-color: #ff2525;

            color: #fff;

            transform: translateY(-2px);
        }


        .product-name-link {

            color: inherit;

            text-decoration: none;

            transition: 0.3s ease;
        }


        .product-name-link:hover {

            color: #ff2525;
        }


        /* ================= STOCK STATUS ================= */

        .stock-status {

            margin: 10px 0;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 1.5px;

            color: #111;
        }


        .stock-status.low-stock {

            color: #ff2525;

            animation: stockPulse 1.8s ease-in-out infinite;
        }


        .stock-status.out-stock {

            color: #888;
        }


        @keyframes stockPulse {

            0% {
                opacity: 1;
            }

            50% {
                opacity: 0.55;
            }

            100% {
                opacity: 1;
            }

        }


        /* ================= SOLD OUT BUTTON ================= */

        .add-cart:disabled {

            cursor: not-allowed;

            opacity: 0.45;

            background: #777;

            border-color: #777;
        }


        /* ================= LOW STOCK CARD ================= */

        .low-stock-card {

            position: relative;
        }


        .low-stock-card::after {

            content: "LIMITED";

            position: absolute;

            top: 12px;

            right: 12px;

            padding: 6px 8px;

            background: #ff2525;

            color: #fff;

            font-size: 8px;

            font-weight: 900;

            letter-spacing: 1px;

            z-index: 5;
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

        <a href="${pageContext.request.contextPath}/index.html">
            HOME
        </a>


        <a href="${pageContext.request.contextPath}/shop">
            SHOP
        </a>


        <a href="${pageContext.request.contextPath}/pages/about.html">
            ABOUT
        </a>


        <a href="${pageContext.request.contextPath}/pages/contact.jsp">
            CONTACT
        </a>


        <a href="${pageContext.request.contextPath}/pages/login.html">
            LOGIN
        </a>


        <a href="${pageContext.request.contextPath}/orders">
            MY ORDERS
        </a>


        <a href="${pageContext.request.contextPath}/cart"
           class="cart-link">

            CART

            <span id="cart-count">
                0
            </span>

        </a>

    </nav>

</header>



<!-- ================= MAIN ================= -->

<main>


    <!-- ================= SHOP HERO ================= -->

    <section class="shop-hero">

        <p>
            DRIFT COLLECTION
        </p>

        <h1>

            SHOP

            <span>
                DIFFERENT.
            </span>

        </h1>

        <p>
            Explore the latest DRIFT drops.
        </p>

    </section>



    <!-- ================= CATEGORY SECTION ================= -->

    <section class="category-section">

        <div class="category-bar">


            <!-- ALL -->

            <button
                class="category active"
                data-category-id="all">

                ALL

            </button>


            <!-- DATABASE CATEGORIES -->

            <%

                List<Category> categories =
                    (List<Category>)
                    request.getAttribute("categories");


                if (categories != null) {

                    for (Category category : categories) {

            %>


            <button
                class="category"
                data-category-id="<%= category.getCategoryId() %>">

                <%= category.getCategoryName() %>

            </button>


            <%

                    }

                }

            %>


        </div>

    </section>



    <!-- ================= PRODUCTS ================= -->

    <section class="shop-products">


        <div class="section-heading">

            <p>
                THE COLLECTION
            </p>

            <h2>

                ALL

                <span>
                    PRODUCTS
                </span>

            </h2>

        </div>



        <!-- PRODUCT GRID -->

        <div class="shop-product-grid">


            <%

                List<Product> products =
                    (List<Product>)
                    request.getAttribute("products");


                if (products != null &&
                    !products.isEmpty()) {


                    for (Product product : products) {


                        boolean inStock =
                            product.getStock() > 0;


                        boolean lowStock =
                            product.getStock() > 0 &&
                            product.getStock() <= 5;

            %>


            <!-- ================= PRODUCT CARD ================= -->

            <div
                class="shop-card <%= lowStock ? "low-stock-card" : "" %>"
                data-category-id="<%= product.getCategoryId() %>">


                <!-- PRODUCT IMAGE -->

                <div class="shop-image">


                    <a
                        href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>">

                        <img
                            src="${pageContext.request.contextPath}/images/<%= product.getImage() %>"
                            alt="<%= product.getProductName() %>">

                    </a>


                    <!-- WISHLIST -->

                    <button
                        class="shop-wishlist"
                        type="button">

                        &#9825;

                    </button>


                    <!-- DROP TAG -->

                    <div class="drop-tag">

                        DRIFT DROP

                    </div>


                </div>



                <!-- PRODUCT INFORMATION -->

                <div class="shop-info">


                    <h3>

                        <a
                            href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>"
                            class="product-name-link">

                            <%= product.getProductName() %>

                        </a>

                    </h3>



                    <p class="shop-price">

                        &#8377;<%= String.format(
                            "%,.2f",
                            product.getPrice()
                        ) %>

                    </p>



                    <p class="shop-rating">

                        &#9733;
                        <%= product.getRating() %>

                    </p>



                    <p class="shop-color">

                        COLOR:

                        <%= product.getColor() %>

                    </p>



                    <!-- ================= STOCK ================= -->

                    <%

                        if (product.getStock() <= 0) {

                    %>


                    <p class="stock-status out-stock">

                        OUT OF STOCK

                    </p>


                    <%

                        } else if (product.getStock() <= 5) {

                    %>


                    <p class="stock-status low-stock">

                        ONLY
                        <%= product.getStock() %>
                        LEFT

                    </p>


                    <%

                        } else {

                    %>


                    <p class="stock-status">

                        IN STOCK

                    </p>


                    <%

                        }

                    %>



                    <!-- ================= ADD TO CART ================= -->

                    <%

                        if (inStock) {

                    %>


                    <form
                        action="${pageContext.request.contextPath}/add-to-cart"
                        method="post">


                        <input
                            type="hidden"
                            name="productId"
                            value="<%= product.getProductId() %>">


                        <input
                            type="hidden"
                            name="quantity"
                            value="1">


                        <button
                            class="add-cart"
                            type="submit">

                            ADD TO CART

                        </button>


                    </form>


                    <%

                        } else {

                    %>


                    <button
                        class="add-cart"
                        type="button"
                        disabled>

                        SOLD OUT

                    </button>


                    <%

                        }

                    %>



                    <!-- PRODUCT DETAILS -->

                    <a
                        href="${pageContext.request.contextPath}/product-details?id=<%= product.getProductId() %>"
                        class="product-details-link">

                        VIEW PRODUCT DETAILS
                        &#8594;

                    </a>


                </div>

            </div>


            <%

                    }

                } else {

            %>


            <!-- ================= NO PRODUCTS ================= -->

            <div class="no-products">

                <h2>

                    NO PRODUCTS AVAILABLE.

                </h2>

                <p>

                    DRIFT is preparing the next drop.

                </p>

            </div>


            <%

                }

            %>


        </div>

    </section>



    <!-- ================= STATEMENT ================= -->

    <section class="statement">

        <p>
            NOT FOR EVERYONE.
        </p>

        <h2>

            CREATE YOUR

            <br>

            <span>
                OWN LANE.
            </span>

        </h2>

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

        &copy; 2026 DRIFT.

        ALL RIGHTS RESERVED.

    </p>

</footer>



<!-- ================= JAVASCRIPT ================= -->

<script
    src="${pageContext.request.contextPath}/js/script.js">
</script>



<!-- ================= CATEGORY FILTER ================= -->

<script>

    const categoryButtons =
        document.querySelectorAll(".category");


    const productCards =
        document.querySelectorAll(".shop-card");


    categoryButtons.forEach(button => {

        button.addEventListener("click", function () {


            categoryButtons.forEach(btn => {

                btn.classList.remove("active");

            });


            this.classList.add("active");


            const selectedCategory =
                this.getAttribute(
                    "data-category-id"
                );


            productCards.forEach(card => {

                const productCategory =
                    card.getAttribute(
                        "data-category-id"
                    );


                if (
                    selectedCategory === "all"
                    ||
                    productCategory === selectedCategory
                ) {

                    card.style.display = "";

                } else {

                    card.style.display = "none";

                }

            });

        });

    });

</script>


</body>

</html>