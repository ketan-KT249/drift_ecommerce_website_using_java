<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.drift.model.Product" %>

<%
    List<Product> products =
            (List<Product>) request.getAttribute("products");

    if (products == null) {
        products = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | ADMIN PRODUCTS</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* =====================================================
           DRIFT ADMIN PRODUCTS
           ===================================================== */

        body {
            background: #050505;
        }


        .admin-products-page {

            min-height: 100vh;

            padding:
                120px 5% 70px;

            background:
                radial-gradient(
                    circle at 5% 5%,
                    rgba(255, 37, 37, 0.08),
                    transparent 25%
                ),
                #050505;
        }


        .admin-products-container {

            max-width: 1500px;

            margin: auto;
        }


        /* =====================================================
           HEADER
           ===================================================== */

        .products-header {

            display: flex;

            justify-content: space-between;

            align-items: flex-end;

            gap: 30px;

            padding-bottom: 30px;

            margin-bottom: 35px;

            border-bottom: 1px solid #222;
        }


        .products-label {

            margin: 0 0 12px;

            color: #ff2525;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 4px;
        }


        .products-header h1 {

            margin: 0;

            color: #fff;

            font-size:
                clamp(42px, 6vw, 78px);

            line-height: 0.9;

            letter-spacing: -4px;

            font-weight: 900;
        }


        .products-header-info {

            color: #666;

            font-size: 11px;

            line-height: 1.8;

            letter-spacing: 1px;

            text-align: right;
        }


        .products-header-info strong {

            display: block;

            color: #fff;

            font-size: 16px;

            margin-top: 3px;
        }


        /* =====================================================
           TOP ACTION BAR
           ===================================================== */

        .products-toolbar {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;

            margin-bottom: 25px;
        }


        .products-count {

            color: #777;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 2px;
        }


        .products-count span {

            color: #ff2525;

            font-size: 18px;

            margin-right: 6px;
        }


        .add-product-btn {

            display: inline-flex;

            align-items: center;

            gap: 10px;

            padding: 15px 22px;

            background: #ff2525;

            color: #fff;

            text-decoration: none;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;

            border: 1px solid #ff2525;

            transition:
                background 0.3s ease,
                color 0.3s ease,
                transform 0.3s ease;
        }


        .add-product-btn:hover {

            background: transparent;

            color: #ff2525;

            transform: translateY(-2px);
        }


        /* =====================================================
           PRODUCT TABLE
           ===================================================== */

        .products-table-wrapper {

            overflow-x: auto;

            border:
                1px solid #222;

            background: #090909;
        }


        .products-table {

            width: 100%;

            min-width: 1000px;

            border-collapse: collapse;
        }


        .products-table thead {

            background: #111;
        }


        .products-table th {

            padding: 18px 16px;

            color: #666;

            font-size: 9px;

            font-weight: 900;

            letter-spacing: 2px;

            text-align: left;

            border-bottom:
                1px solid #252525;
        }


        .products-table td {

            padding: 18px 16px;

            color: #aaa;

            font-size: 12px;

            border-bottom:
                1px solid #181818;

            vertical-align: middle;
        }


        .products-table tbody tr {

            transition:
                background 0.25s ease;
        }


        .products-table tbody tr:hover {

            background: #101010;
        }


        /* =====================================================
           PRODUCT IMAGE
           ===================================================== */

        .product-image {

            width: 70px;

            height: 70px;

            object-fit: cover;

            background: #111;

            border: 1px solid #252525;

            display: block;
        }


        .product-id {

            color: #555;

            font-size: 10px;

            font-weight: 900;
        }


        .product-name {

            color: #fff;

            font-weight: 900;

            font-size: 13px;

            letter-spacing: 0.5px;
        }


        .product-description {

            margin-top: 5px;

            max-width: 220px;

            color: #555;

            font-size: 10px;

            line-height: 1.5;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }


        .product-price {

            color: #fff;

            font-weight: 900;

            white-space: nowrap;
        }


        .product-stock {

            font-weight: 800;
        }


        .stock-good {

            color: #3cff78;
        }


        .stock-low {

            color: #ffc107;
        }


        .stock-out {

            color: #ff3b3b;
        }


        /* =====================================================
           STATUS
           ===================================================== */

        .product-status {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding: 7px 10px;

            border: 1px solid #252525;

            font-size: 9px;

            font-weight: 900;

            letter-spacing: 1px;
        }


        .status-dot {

            width: 6px;

            height: 6px;

            border-radius: 50%;
        }


        .status-active {

            color: #3cff78;
        }


        .status-active .status-dot {

            background: #3cff78;

            box-shadow:
                0 0 8px
                rgba(60, 255, 120, 0.6);
        }


        .status-inactive {

            color: #ff3b3b;
        }


        .status-inactive .status-dot {

            background: #ff3b3b;
        }


        /* =====================================================
           ACTIONS
           ===================================================== */

        .product-actions {

            display: flex;

            gap: 8px;

            flex-wrap: wrap;
        }


        .action-btn {

            display: inline-block;

            padding: 9px 12px;

            border: 1px solid #292929;

            color: #aaa;

            background: transparent;

            text-decoration: none;

            font-size: 9px;

            font-weight: 900;

            letter-spacing: 1px;

            transition:
                color 0.25s ease,
                border-color 0.25s ease,
                background 0.25s ease;
        }


        .action-btn:hover {

            color: #fff;

            border-color: #ff2525;

            background: #151515;
        }


        .delete-btn:hover {

            color: #ff3b3b;

            border-color: #ff3b3b;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .empty-products {

            padding: 90px 30px;

            text-align: center;

            border:
                1px solid #222;

            background: #090909;
        }


        .empty-products-icon {

            color: #333;

            font-size: 55px;

            margin-bottom: 20px;
        }


        .empty-products h2 {

            margin: 0;

            color: #fff;

            font-size: 25px;

            font-weight: 900;
        }


        .empty-products p {

            color: #666;

            font-size: 11px;

            margin-top: 10px;

            letter-spacing: 1px;
        }


        /* =====================================================
           BOTTOM NAV
           ===================================================== */

        .products-bottom-nav {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-top: 35px;

            padding-top: 25px;

            border-top: 1px solid #222;
        }


        .back-dashboard {

            color: #888;

            text-decoration: none;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;

            transition:
                color 0.25s ease;
        }


        .back-dashboard:hover {

            color: #fff;
        }


        .admin-logout-link {

            color: #ff2525;

            text-decoration: none;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;
        }


        .admin-logout-link:hover {

            color: #fff;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 750px) {

            .admin-products-page {

                padding:
                    105px 18px 60px;
            }


            .products-header {

                flex-direction: column;

                align-items: flex-start;
            }


            .products-header-info {

                text-align: left;
            }


            .products-toolbar {

                align-items: flex-start;

                flex-direction: column;
            }


            .products-bottom-nav {

                align-items: flex-start;

                flex-direction: column;

                gap: 18px;
            }

        }

    </style>

</head>


<body>


<main class="admin-products-page">


    <div class="admin-products-container">


        <!-- =================================================
             HEADER
             ================================================= -->

        <header class="products-header">


            <div>

                <p class="products-label">
                    DRIFT CONTROL SYSTEM / INVENTORY
                </p>


                <h1>
                    PRODUCTS
                </h1>

            </div>


            <div class="products-header-info">

                PRODUCT MANAGEMENT

                <strong>
                    ADMIN CONTROL
                </strong>

            </div>


        </header>


        <!-- =================================================
             TOOLBAR
             ================================================= -->

        <div class="products-toolbar">


            <div class="products-count">

                <span>
                    <%= products.size() %>
                </span>

                TOTAL PRODUCTS

            </div>


          <a
    href="<%= request.getContextPath() %>/pages/admin-add-product.jsp"
    class="add-product-btn">

    + ADD PRODUCT

</a>


        </div>


        <!-- =================================================
             PRODUCT LIST
             ================================================= -->

        <% if (products.isEmpty()) { %>


            <div class="empty-products">


                <div class="empty-products-icon">
                    &#9670;
                </div>


                <h2>
                    NO PRODUCTS FOUND
                </h2>


                <p>
                    THE DRIFT INVENTORY IS CURRENTLY EMPTY.
                </p>


            </div>


        <% } else { %>


            <div class="products-table-wrapper">


                <table class="products-table">


                    <thead>

                        <tr>

                            <th>
                                IMAGE
                            </th>

                            <th>
                                ID
                            </th>

                            <th>
                                PRODUCT
                            </th>

                            <th>
                                PRICE
                            </th>

                            <th>
                                STOCK
                            </th>

                            <th>
                                COLOR
                            </th>

                            <th>
                                RATING
                            </th>

                            <th>
                                STATUS
                            </th>

                            <th>
                                ACTIONS
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (Product product : products) { %>


                        <tr>


                            <!-- IMAGE -->

                            <td>

                                <img
                                    src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
                                    alt="<%= product.getProductName() %>"
                                    class="product-image">

                            </td>


                            <!-- ID -->

                            <td>

                                <span class="product-id">

                                    #<%= product.getProductId() %>

                                </span>

                            </td>


                            <!-- PRODUCT -->

                            <td>

                                <div class="product-name">

                                    <%= product.getProductName() %>

                                </div>


                                <div class="product-description">

                                    <%= product.getDescription() == null
                                        ? "NO DESCRIPTION"
                                        : product.getDescription() %>

                                </div>

                            </td>


                            <!-- PRICE -->

                            <td>

                                <span class="product-price">

                                    &#8377;<%= String.format(
                                        "%.2f",
                                        product.getPrice()
                                    ) %>

                                </span>

                            </td>


                            <!-- STOCK -->

                            <td>

                                <%
                                    String stockClass;

                                    if (product.getStock() == 0) {

                                        stockClass =
                                                "stock-out";

                                    } else if (product.getStock() <= 5) {

                                        stockClass =
                                                "stock-low";

                                    } else {

                                        stockClass =
                                                "stock-good";
                                    }
                                %>

                                <span
                                    class="product-stock <%= stockClass %>">

                                    <%= product.getStock() %>

                                </span>

                            </td>


                            <!-- COLOR -->

                            <td>

                                <%= product.getColor() == null
                                    ? "-"
                                    : product.getColor() %>

                            </td>


                            <!-- RATING -->

                            <td>

                                &#9733;
                                <%= product.getRating() %>

                            </td>


                            <!-- STATUS -->

                            <td>


                                <% if (product.isActive()) { %>


                                    <span
                                        class="product-status status-active">

                                        <span
                                            class="status-dot">
                                        </span>

                                        ACTIVE

                                    </span>


                                <% } else { %>


                                    <span
                                        class="product-status status-inactive">

                                        <span
                                            class="status-dot">
                                        </span>

                                        INACTIVE

                                    </span>


                                <% } %>


                            </td>


                            <!-- ACTIONS -->

                            <td>


                                <div class="product-actions">


                                    <a
                                        href="<%= request.getContextPath() %>/product-details?id=<%= product.getProductId() %>"
                                        class="action-btn">

                                        VIEW

                                    </a>


                                   <a
    href="<%= request.getContextPath() %>/admin-edit-product?id=<%= product.getProductId() %>"
    class="action-btn">

    EDIT

</a>

     <form
    action="<%= request.getContextPath() %>/admin-delete-product"
    method="post"
    style="display:inline;"
    onsubmit="return confirm('DELETE THIS PRODUCT FROM THE STORE?');">

    <input
        type="hidden"
        name="productId"
        value="<%= product.getProductId() %>">

    <button
        type="submit"
        class="action-btn delete-btn">

        DELETE

    </button>

</form>
                                </div>


                            </td>


                        </tr>


                    <% } %>


                    </tbody>


                </table>


            </div>


        <% } %>


        <!-- =================================================
             BOTTOM NAV
             ================================================= -->

        <div class="products-bottom-nav">


            <a
                href="<%= request.getContextPath() %>/admin-dashboard"
                class="back-dashboard">

                &#8592; ADMIN DASHBOARD

            </a>


            <a
                href="<%= request.getContextPath() %>/admin-logout"
                class="admin-logout-link">

                LOGOUT &#8594;

            </a>


        </div>


    </div>


</main>


<script
    src="<%= request.getContextPath() %>/js/script.js">
</script>


</body>

</html>