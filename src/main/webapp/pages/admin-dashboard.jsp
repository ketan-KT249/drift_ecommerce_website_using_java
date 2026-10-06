<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String adminName =
            (String) request.getAttribute("adminName");

    if (adminName == null) {
        adminName = "ADMIN";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | ADMIN DASHBOARD</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        /* =====================================================
           DRIFT ADMIN DASHBOARD
           ===================================================== */

        .admin-dashboard {

            min-height: 100vh;

            padding:
                130px 5% 80px;

            background:
                radial-gradient(
                    circle at 10% 10%,
                    rgba(255, 37, 37, 0.10),
                    transparent 28%
                ),
                radial-gradient(
                    circle at 90% 90%,
                    rgba(255, 37, 37, 0.06),
                    transparent 30%
                ),
                #050505;
        }


        .admin-dashboard-container {

            max-width: 1500px;

            margin: auto;
        }


        /* =====================================================
           HEADER
           ===================================================== */

        .admin-dashboard-header {

            display: flex;

            justify-content: space-between;

            align-items: flex-end;

            gap: 30px;

            margin-bottom: 55px;

            padding-bottom: 30px;

            border-bottom: 1px solid #222;
        }


        .admin-dashboard-label {

            color: #ff2525;

            font-size: 11px;

            font-weight: 900;

            letter-spacing: 4px;

            margin-bottom: 12px;
        }


        .admin-dashboard-header h1 {

            margin: 0;

            color: #fff;

            font-size:
                clamp(45px, 7vw, 85px);

            line-height: 0.9;

            letter-spacing: -4px;

            font-weight: 900;
        }


        .admin-welcome {

            color: #777;

            font-size: 13px;

            letter-spacing: 1px;

            line-height: 1.7;

            text-align: right;
        }


        .admin-welcome strong {

            display: block;

            color: #fff;

            font-size: 17px;

            margin-top: 5px;
        }


        /* =====================================================
           STATUS BAR
           ===================================================== */

        .admin-status-bar {

            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 35px;

            color: #777;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: 2px;
        }


        .admin-status-dot {

            width: 8px;

            height: 8px;

            border-radius: 50%;

            background: #3cff78;

            box-shadow:
                0 0 12px
                rgba(60, 255, 120, 0.7);
        }


        /* =====================================================
           DASHBOARD CARDS
           ===================================================== */

        .admin-dashboard-grid {

            display: grid;

            grid-template-columns:
                repeat(4, minmax(0, 1fr));

            gap: 20px;
        }


        .admin-card {

            position: relative;

            min-height: 230px;

            padding: 30px;

            display: flex;

            flex-direction: column;

            justify-content: space-between;

            background:
                linear-gradient(
                    145deg,
                    #121212,
                    #080808
                );

            border: 1px solid #252525;

            overflow: hidden;

            text-decoration: none;

            transition:
                transform 0.35s ease,
                border-color 0.35s ease,
                box-shadow 0.35s ease;
        }


        .admin-card::before {

            content: "";

            position: absolute;

            width: 160px;

            height: 160px;

            border-radius: 50%;

            right: -80px;

            top: -80px;

            border: 1px solid
                rgba(255, 37, 37, 0.15);
        }


        .admin-card:hover {

            transform:
                translateY(-8px);

            border-color: #ff2525;

            box-shadow:
                0 25px 60px
                rgba(0, 0, 0, 0.6),
                0 0 30px
                rgba(255, 37, 37, 0.06);
        }


        .admin-card-number {

            color: #444;

            font-size: 11px;

            font-weight: 900;

            letter-spacing: 2px;
        }


        .admin-card-icon {

            font-size: 38px;

            line-height: 1;

            margin: 20px 0;
        }


        .admin-card h2 {

            margin: 0;

            color: #fff;

            font-size: 22px;

            font-weight: 900;

            letter-spacing: 1px;
        }


        .admin-card p {

            margin: 10px 0 0;

            color: #666;

            font-size: 11px;

            line-height: 1.6;

            letter-spacing: 1px;
        }


        .admin-card-arrow {

            color: #ff2525;

            font-size: 22px;

            font-weight: 900;

            align-self: flex-end;
        }


        /* =====================================================
           FEATURED WIDE CARD
           ===================================================== */

        .admin-feature-card {

            grid-column:
                span 2;

            min-height: 270px;

            background:
                linear-gradient(
                    135deg,
                    #171717,
                    #080808
                );
        }


        .admin-feature-card h2 {

            font-size: 34px;

            max-width: 500px;
        }


        .admin-feature-card p {

            max-width: 550px;

            font-size: 12px;

            line-height: 1.8;
        }


        /* =====================================================
           QUICK LINKS
           ===================================================== */

        .admin-quick-section {

            margin-top: 70px;
        }


        .admin-section-label {

            margin-bottom: 20px;

            color: #ff2525;

            font-size: 10px;

            font-weight: 900;

            letter-spacing: 3px;
        }


        .admin-quick-links {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 15px;
        }


        .admin-quick-link {

            padding: 20px;

            border: 1px solid #222;

            background: #0b0b0b;

            color: #aaa;

            text-decoration: none;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 1px;

            transition:
                color 0.3s ease,
                border-color 0.3s ease,
                background 0.3s ease;
        }


        .admin-quick-link:hover {

            color: #fff;

            border-color: #ff2525;

            background: #111;
        }


        /* =====================================================
           ADMIN FOOTER
           ===================================================== */

        .admin-footer {

            margin-top: 70px;

            padding-top: 25px;

            border-top: 1px solid #222;

            display: flex;

            justify-content: space-between;

            align-items: center;

            color: #555;

            font-size: 10px;

            letter-spacing: 2px;
        }


        .admin-logout {

            color: #ff2525;

            text-decoration: none;

            font-weight: 800;
        }


        .admin-logout:hover {

            color: #fff;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 1100px) {

            .admin-dashboard-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }

            .admin-feature-card {

                grid-column:
                    span 2;
            }

        }


        @media (max-width: 700px) {

            .admin-dashboard {

                padding:
                    110px 20px 60px;
            }


            .admin-dashboard-header {

                flex-direction: column;

                align-items: flex-start;
            }


            .admin-welcome {

                text-align: left;
            }


            .admin-dashboard-grid {

                grid-template-columns: 1fr;
            }


            .admin-feature-card {

                grid-column:
                    span 1;
            }


            .admin-quick-links {

                grid-template-columns: 1fr;
            }


            .admin-feature-card h2 {

                font-size: 27px;
            }


            .admin-footer {

                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     DASHBOARD
     ===================================================== -->

<main class="admin-dashboard">


    <div class="admin-dashboard-container">


        <!-- HEADER -->

        <header class="admin-dashboard-header">


            <div>

                <p class="admin-dashboard-label">
                    DRIFT CONTROL SYSTEM
                </p>


                <h1>
                    DASHBOARD
                </h1>

            </div>


            <div class="admin-welcome">

                AUTHENTICATED ADMINISTRATOR

                <strong>
                    <%= adminName %>
                </strong>

            </div>


        </header>


        <!-- STATUS -->

        <div class="admin-status-bar">

            <span class="admin-status-dot"></span>

            SYSTEM ONLINE

        </div>


        <!-- DASHBOARD CARDS -->

        <section class="admin-dashboard-grid">


            <!-- PRODUCTS -->

            <a
    href="<%= request.getContextPath() %>/admin-products"
    class="admin-card">

                <span class="admin-card-number">
                    01
                </span>


                <div class="admin-card-icon">
                    &#9670;
                </div>


                <div>

                    <h2>
                        PRODUCTS
                    </h2>

                   <p>
    <%= request.getAttribute("productCount") %>
    ACTIVE PRODUCTS
</p>

                </div>


                <span class="admin-card-arrow">
                    &#8594;
                </span>

            </a>


            <!-- USERS -->

            <!-- USERS -->

<a
    href="<%= request.getContextPath() %>/admin-users"
    class="admin-card">

                <span class="admin-card-number">
                    02
                </span>


                <div class="admin-card-icon">
                    &#9673;
                </div>


                <div>

                    <h2>
                        USERS
                    </h2>

                  <p>
    <%= request.getAttribute("userCount") %>
    REGISTERED USERS
</p>

                </div>


                <span class="admin-card-arrow">
                    &#8594;
                </span>

            </a>


            <!-- ORDERS -->

           <a
    href="<%= request.getContextPath() %>/admin-orders"
    class="admin-card">

                <span class="admin-card-number">
                    03
                </span>


                <div class="admin-card-icon">
                    &#9632;
                </div>


                <div>

                    <h2>
                        ORDERS
                    </h2>

                  <p>
    <%= request.getAttribute("orderCount") %>
    TOTAL ORDERS
</p>
                </div>


                <span class="admin-card-arrow">
                    &#8594;
                </span>

            </a>


            <!-- CONTACT -->

            <a
    href="<%= request.getContextPath() %>/admin-messages"
    class="admin-card">
                <span class="admin-card-number">
                    04
                </span>


                <div class="admin-card-icon">
                    &#9993;
                </div>


                <div>

                    <h2>
                        MESSAGES
                    </h2>

                  <p>
    <%= request.getAttribute("messageCount") %>
    CUSTOMER MESSAGES
</p>
                </div>


                <span class="admin-card-arrow">
                    &#8594;
                </span>

            </a>


            <!-- FEATURE -->

            <div class="admin-card admin-feature-card">


                <span class="admin-card-number">
                    DRIFT / ADMIN
                </span>


                <div>

                    <h2>
                        CONTROL THE
                        WHOLE STORE.
                    </h2>


                    <p>
                        THIS CONTROL CENTER WILL
                        EVENTUALLY HANDLE PRODUCTS,
                        USERS, ORDERS, INVENTORY AND
                        CUSTOMER MESSAGES FROM ONE
                        CENTRALIZED ADMIN SYSTEM.
                    </p>

                </div>


                <span class="admin-card-arrow">
                    &#8594;
                </span>


            </div>


            <!-- SETTINGS -->

            <a
                href="#"
                class="admin-card">

                <span class="admin-card-number">
                    05
                </span>


                <div class="admin-card-icon">
                    &#9881;
                </div>


                <div>

                    <h2>
                        SETTINGS
                    </h2>

                    <p>
                        STORE CONFIGURATION
                        AND ADMIN CONTROLS.
                    </p>

                </div>


                <span class="admin-card-arrow">
                    &#8594;
                </span>

            </a>


        </section>


        <!-- QUICK LINKS -->

        <section class="admin-quick-section">


            <p class="admin-section-label">
                QUICK ACCESS
            </p>


            <div class="admin-quick-links">


                <a
                    href="<%= request.getContextPath() %>/shop"
                    class="admin-quick-link">

                    VIEW STORE &#8594;

                </a>


                <a
                    href="<%= request.getContextPath() %>/orders"
                    class="admin-quick-link">

                    CUSTOMER ORDERS &#8594;

                </a>


                <a
                    href="<%= request.getContextPath() %>/index.html"
                    class="admin-quick-link">

                    DRIFT HOME &#8594;

                </a>


            </div>


        </section>


        <!-- FOOTER -->

        <footer class="admin-footer">


            <span>
                DRIFT ADMIN SYSTEM
            </span>


            <a
                href="<%= request.getContextPath() %>/admin-logout"
                class="admin-logout">

                LOGOUT &#8594;

            </a>


        </footer>


    </div>


</main>


<script
    src="<%= request.getContextPath() %>/js/script.js">
</script>


</body>

</html>