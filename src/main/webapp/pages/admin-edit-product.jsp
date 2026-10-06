<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.drift.model.Product" %>

<%
    Product product =
            (Product) request.getAttribute("product");

    if (product == null) {
        response.sendRedirect(
                request.getContextPath() + "/admin-products"
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

    <title>DRIFT | EDIT PRODUCT</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        body {
            background: #050505;
        }

        .edit-product-page {

            min-height: 100vh;

            padding: 120px 5% 80px;

            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(255, 37, 37, 0.09),
                    transparent 28%
                ),
                #050505;
        }

        .edit-product-container {

            max-width: 1100px;

            margin: auto;
        }

        .edit-product-header {

            padding-bottom: 30px;

            margin-bottom: 35px;

            border-bottom: 1px solid #222;
        }

        .edit-product-label {

            margin: 0 0 12px;

            color: #ff2525;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 4px;
        }

        .edit-product-header h1 {

            margin: 0;

            color: #fff;

            font-size:
                clamp(45px, 7vw, 80px);

            line-height: 0.9;

            letter-spacing: -4px;

            font-weight: 900;
        }

        .edit-product-header p {

            margin-top: 20px;

            color: #666;

            font-size: 11px;

            line-height: 1.8;

            letter-spacing: 1px;
        }

        .edit-product-id {

            color: #ff2525;

            font-weight: 900;
        }

        .product-form {

            padding: 35px;

            background:
                linear-gradient(
                    145deg,
                    #111,
                    #080808
                );

            border: 1px solid #252525;
        }

        .form-section {

            margin-bottom: 40px;
        }

        .form-section-title {

            margin-bottom: 22px;

            padding-bottom: 12px;

            border-bottom: 1px solid #202020;

            color: #ff2525;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 3px;
        }

        .form-grid {

            display: grid;

            grid-template-columns:
                repeat(2, 1fr);

            gap: 22px;
        }

        .form-group {

            display: flex;

            flex-direction: column;

            gap: 9px;
        }

        .form-group.full {

            grid-column: span 2;
        }

        .form-group label {

            color: #777;

            font-size: 9px;

            font-weight: 900;

            letter-spacing: 2px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {

            width: 100%;

            box-sizing: border-box;

            padding: 15px;

            background: #080808;

            color: #fff;

            border: 1px solid #292929;

            outline: none;

            font-family: inherit;

            font-size: 12px;

            transition:
                border-color 0.25s ease,
                box-shadow 0.25s ease;
        }

        .form-group textarea {

            min-height: 130px;

            resize: vertical;

            line-height: 1.6;
        }

        .form-group select {

            cursor: pointer;
        }

        .form-group select option {

            background: #111;

            color: #fff;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {

            border-color: #ff2525;

            box-shadow:
                0 0 0 1px
                rgba(255, 37, 37, 0.15);
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {

            color: #444;
        }

        .active-control {

            display: flex;

            align-items: center;

            gap: 12px;

            min-height: 48px;
        }

        .active-control input {

            width: 18px;

            height: 18px;

            accent-color: #ff2525;

            cursor: pointer;
        }

        .active-control label {

            margin: 0;

            color: #aaa;

            cursor: pointer;
        }

        .current-image {

            display: flex;

            align-items: center;

            gap: 20px;

            margin-bottom: 15px;

            padding: 15px;

            background: #090909;

            border: 1px solid #222;
        }

        .current-image img {

            width: 90px;

            height: 90px;

            object-fit: cover;

            background: #111;

            border: 1px solid #292929;
        }

        .current-image-info {

            color: #666;

            font-size: 10px;

            line-height: 1.8;

            letter-spacing: 1px;
        }

        .current-image-info strong {

            display: block;

            color: #fff;

            font-size: 12px;
        }

        .form-actions {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 20px;

            padding-top: 25px;

            border-top: 1px solid #222;
        }

        .back-btn {

            color: #777;

            text-decoration: none;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;

            transition: color 0.25s ease;
        }

        .back-btn:hover {

            color: #fff;
        }

        .submit-btn {

            padding: 16px 30px;

            border: 1px solid #ff2525;

            background: #ff2525;

            color: #fff;

            font-family: inherit;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 2px;

            cursor: pointer;

            transition:
                background 0.3s ease,
                color 0.3s ease,
                transform 0.3s ease;
        }

        .submit-btn:hover {

            background: transparent;

            color: #ff2525;

            transform: translateY(-2px);
        }

        .form-error {

            margin-bottom: 25px;

            padding: 15px;

            border: 1px solid #5c2020;

            background: #180909;

            color: #ff5a5a;

            font-size: 10px;

            font-weight: 800;

            letter-spacing: 1px;
        }

        @media (max-width: 700px) {

            .edit-product-page {

                padding: 105px 18px 60px;
            }

            .product-form {

                padding: 22px;
            }

            .form-grid {

                grid-template-columns: 1fr;
            }

            .form-group.full {

                grid-column: span 1;
            }

            .form-actions {

                align-items: flex-start;

                flex-direction: column-reverse;
            }

            .submit-btn {

                width: 100%;
            }

            .current-image {

                align-items: flex-start;

                flex-direction: column;
            }
        }

    </style>

</head>

<body>


<main class="edit-product-page">

    <div class="edit-product-container">


        <!-- HEADER -->

        <header class="edit-product-header">

            <p class="edit-product-label">
                DRIFT CONTROL SYSTEM / INVENTORY
            </p>

            <h1>
                EDIT PRODUCT
            </h1>

            <p>
                MODIFY PRODUCT INFORMATION,
                INVENTORY, PRICING AND STATUS.
                PRODUCT ID:
                <span class="edit-product-id">
                    #<%= product.getProductId() %>
                </span>
            </p>

        </header>


        <!-- FORM -->

        <form
            action="<%= request.getContextPath() %>/admin-update-product"
            method="post"
            class="product-form">


            <!-- HIDDEN PRODUCT ID -->

            <input
                type="hidden"
                name="productId"
                value="<%= product.getProductId() %>">


            <!-- PRODUCT INFORMATION -->

            <section class="form-section">

                <h2 class="form-section-title">
                    01 / PRODUCT INFORMATION
                </h2>

                <div class="form-grid">


                    <!-- PRODUCT NAME -->

                    <div class="form-group">

                        <label for="productName">
                            PRODUCT NAME *
                        </label>

                        <input
                            type="text"
                            id="productName"
                            name="productName"
                            value="<%= product.getProductName() %>"
                            required>

                    </div>


                    <!-- CATEGORY -->

                    <div class="form-group">

                        <label for="categoryId">
                            CATEGORY *
                        </label>

                        <select
                            id="categoryId"
                            name="categoryId"
                            required>

                            <option value="1"
                                <%= product.getCategoryId() == 1
                                    ? "selected"
                                    : "" %>>
                                SNEAKERS
                            </option>

                            <option value="2"
                                <%= product.getCategoryId() == 2
                                    ? "selected"
                                    : "" %>>
                                T-SHIRTS
                            </option>

                            <option value="3"
                                <%= product.getCategoryId() == 3
                                    ? "selected"
                                    : "" %>>
                                HOODIES
                            </option>

                            <option value="4"
                                <%= product.getCategoryId() == 4
                                    ? "selected"
                                    : "" %>>
                                CAPS
                            </option>

                            <option value="5"
                                <%= product.getCategoryId() == 5
                                    ? "selected"
                                    : "" %>>
                                ACCESSORIES
                            </option>

                        </select>

                    </div>


                    <!-- DESCRIPTION -->

                    <div class="form-group full">

                        <label for="description">
                            DESCRIPTION
                        </label>

                        <textarea
                            id="description"
                            name="description"><%= product.getDescription() == null
                                ? ""
                                : product.getDescription() %></textarea>

                    </div>

                </div>

            </section>


            <!-- PRICING -->

            <section class="form-section">

                <h2 class="form-section-title">
                    02 / PRICING &amp; INVENTORY
                </h2>

                <div class="form-grid">


                    <!-- PRICE -->

                    <div class="form-group">

                        <label for="price">
                            PRICE *
                        </label>

                        <input
                            type="number"
                            id="price"
                            name="price"
                            value="<%= product.getPrice() %>"
                            min="0"
                            step="0.01"
                            required>

                    </div>


                    <!-- STOCK -->

                    <div class="form-group">

                        <label for="stock">
                            STOCK *
                        </label>

                        <input
                            type="number"
                            id="stock"
                            name="stock"
                            value="<%= product.getStock() %>"
                            min="0"
                            required>

                    </div>


                    <!-- COLOR -->

                    <div class="form-group">

                        <label for="color">
                            COLOR
                        </label>

                        <input
                            type="text"
                            id="color"
                            name="color"
                            value="<%= product.getColor() == null
                                ? ""
                                : product.getColor() %>">

                    </div>


                    <!-- SIZE -->

                    <div class="form-group">

                        <label for="size">
                            SIZE
                        </label>

                        <input
                            type="text"
                            id="size"
                            name="size"
                            value="<%= product.getSize() == null
                                ? ""
                                : product.getSize() %>">

                    </div>

                </div>

            </section>


            <!-- MEDIA -->

            <section class="form-section">

                <h2 class="form-section-title">
                    03 / MEDIA &amp; RATING
                </h2>


                <div class="form-grid">


                    <!-- CURRENT IMAGE -->

                    <div class="form-group full">

                        <label>
                            CURRENT IMAGE
                        </label>


                        <div class="current-image">

                            <img
                                src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
                                alt="<%= product.getProductName() %>">


                            <div class="current-image-info">

                                CURRENT IMAGE FILE

                                <strong>
                                    <%= product.getImage() == null ||
                                        product.getImage().trim().isEmpty()
                                        ? "NO IMAGE"
                                        : product.getImage() %>
                                </strong>

                            </div>

                        </div>

                    </div>


                    <!-- IMAGE -->

                    <div class="form-group">

                        <label for="image">
                            IMAGE FILE NAME
                        </label>

                        <input
                            type="text"
                            id="image"
                            name="image"
                            value="<%= product.getImage() == null
                                ? ""
                                : product.getImage() %>">

                    </div>


                    <!-- RATING -->

                    <div class="form-group">

                        <label for="rating">
                            RATING
                        </label>

                        <input
                            type="number"
                            id="rating"
                            name="rating"
                            value="<%= product.getRating() %>"
                            min="0"
                            max="5"
                            step="0.1">

                    </div>


                    <!-- ACTIVE STATUS -->

                    <div class="form-group full">

                        <label>
                            PRODUCT STATUS
                        </label>


                        <div class="active-control">

                            <input
                                type="checkbox"
                                id="isActive"
                                name="isActive"
                                value="true"
                                <%= product.isActive()
                                    ? "checked"
                                    : "" %>>


                            <label for="isActive">
                                MAKE PRODUCT ACTIVE
                            </label>

                        </div>

                    </div>

                </div>

            </section>


            <!-- ERROR -->

            <% if ("failed".equals(
                    request.getParameter("error"))) { %>

                <div class="form-error">

                    &#10005;
                    PRODUCT COULD NOT BE UPDATED.
                    PLEASE CHECK THE DETAILS AND TRY AGAIN.

                </div>

            <% } %>


            <!-- ACTIONS -->

            <div class="form-actions">


                <a
                    href="<%= request.getContextPath() %>/admin-products"
                    class="back-btn">

                    &#8592; BACK TO PRODUCTS

                </a>


                <button
                    type="submit"
                    class="submit-btn">

                    UPDATE PRODUCT &#8594;

                </button>


            </div>


        </form>

    </div>

</main>


<script
    src="<%= request.getContextPath() %>/js/script.js">
</script>


</body>

</html>