<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | ADD PRODUCT</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* =====================================================
           DRIFT ADD PRODUCT
           ===================================================== */

        body {
            background: #050505;
        }


        .add-product-page {

            min-height: 100vh;

            padding:
                120px 5% 80px;

            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(255, 37, 37, 0.09),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 90% 80%,
                    rgba(255, 37, 37, 0.05),
                    transparent 25%
                ),
                #050505;
        }


        .add-product-container {

            max-width: 1100px;

            margin: auto;
        }


        /* =====================================================
           HEADER
           ===================================================== */

        .add-product-header {

            padding-bottom: 30px;

            margin-bottom: 35px;

            border-bottom: 1px solid #222;
        }


        .add-product-label {

            margin: 0 0 12px;

            color: #ff2525;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 4px;
        }


        .add-product-header h1 {

            margin: 0;

            color: #fff;

            font-size:
                clamp(45px, 7vw, 80px);

            line-height: 0.9;

            letter-spacing: -4px;

            font-weight: 900;
        }


        .add-product-header p {

            max-width: 600px;

            margin-top: 20px;

            color: #666;

            font-size: 11px;

            line-height: 1.8;

            letter-spacing: 1px;
        }


        /* =====================================================
           FORM
           ===================================================== */

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

            grid-column:
                span 2;
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


        /* =====================================================
           CHECKBOX
           ===================================================== */

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


        /* =====================================================
           BUTTONS
           ===================================================== */

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

            transition:
                color 0.25s ease;
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


        /* =====================================================
           ERROR MESSAGE
           ===================================================== */

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


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 700px) {

            .add-product-page {

                padding:
                    105px 18px 60px;
            }


            .product-form {

                padding: 22px;
            }


            .form-grid {

                grid-template-columns: 1fr;
            }


            .form-group.full {

                grid-column:
                    span 1;
            }


            .form-actions {

                align-items: flex-start;

                flex-direction: column-reverse;
            }


            .submit-btn {

                width: 100%;
            }

        }

    </style>

</head>


<body>


<main class="add-product-page">


    <div class="add-product-container">


        <!-- =================================================
             HEADER
             ================================================= -->

        <header class="add-product-header">

            <p class="add-product-label">
                DRIFT CONTROL SYSTEM / INVENTORY
            </p>

            <h1>
                ADD PRODUCT
            </h1>

            <p>
                CREATE A NEW PRODUCT FOR THE DRIFT STORE.
                ENTER THE PRODUCT INFORMATION BELOW AND
                ADD IT TO THE INVENTORY.
            </p>

        </header>


        <!-- =================================================
             FORM
             ================================================= -->

        <form
            action="<%= request.getContextPath() %>/admin-add-product"
            method="post"
            class="product-form">


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
                            placeholder="Example: DRIFT X4"
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

                            <option value="">
                                SELECT CATEGORY
                            </option>

                            <option value="1">
                                SNEAKERS
                            </option>

                            <option value="2">
                                T-SHIRTS
                            </option>

                            <option value="3">
                                HOODIES
                            </option>

                            <option value="4">
                                CAPS
                            </option>

                            <option value="5">
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
                            name="description"
                            placeholder="Enter product description..."></textarea>

                    </div>


                </div>

            </section>


            <!-- PRICING & INVENTORY -->

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
                            placeholder="12999"
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
                            placeholder="50"
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
                            placeholder="BLACK">

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
                            placeholder="UK 9 / L / FREE SIZE">

                    </div>


                </div>

            </section>


            <!-- MEDIA & RATING -->

            <section class="form-section">

                <h2 class="form-section-title">
                    03 / MEDIA &amp; RATING
                </h2>


                <div class="form-grid">


                    <!-- IMAGE -->

                    <div class="form-group">

                        <label for="image">
                            IMAGE FILE NAME
                        </label>

                        <input
                            type="text"
                            id="image"
                            name="image"
                            placeholder="drift-x4.png">

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
                            placeholder="0.0"
                            min="0"
                            max="5"
                            step="0.1"
                            value="0">

                    </div>


                    <!-- ACTIVE -->

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
                                checked>


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
                    PRODUCT COULD NOT BE ADDED.
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

                    CREATE PRODUCT &#8594;

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