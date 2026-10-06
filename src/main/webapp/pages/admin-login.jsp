<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | ADMIN LOGIN</title>

    <link rel="stylesheet"
          href="../css/style.css">

    <style>

        /* =====================================================
           DRIFT — ADMIN LOGIN
           ===================================================== */

        .admin-login-page {

            min-height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 120px 20px 80px;

            background:
                radial-gradient(
                    circle at 20% 20%,
                    rgba(255, 37, 37, 0.12),
                    transparent 30%
                ),
                radial-gradient(
                    circle at 80% 80%,
                    rgba(255, 37, 37, 0.08),
                    transparent 30%
                ),
                #050505;
        }


        .admin-login-box {

            width: 100%;

            max-width: 500px;

            padding: 55px 45px;

            background:
                linear-gradient(
                    145deg,
                    #111,
                    #080808
                );

            border: 1px solid #292929;

            position: relative;

            overflow: hidden;

            box-shadow:
                0 30px 80px
                rgba(0, 0, 0, 0.7);
        }


        .admin-login-box::before {

            content: "";

            position: absolute;

            top: 0;
            left: 0;

            width: 100%;

            height: 3px;

            background: #ff2525;
        }


        .admin-login-box::after {

            content: "";

            position: absolute;

            width: 200px;

            height: 200px;

            border-radius: 50%;

            right: -100px;

            top: -100px;

            border: 1px solid
                rgba(255, 37, 37, 0.2);

            box-shadow:
                0 0 80px
                rgba(255, 37, 37, 0.08);
        }


        /* =====================================================
           HEADER
           ===================================================== */

        .admin-login-header {

            margin-bottom: 40px;

            position: relative;

            z-index: 2;
        }


        .admin-label {

            color: #ff2525;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 4px;

            margin-bottom: 15px;
        }


        .admin-login-header h1 {

            margin: 0;

            color: #fff;

            font-size:
                clamp(40px, 7vw, 65px);

            font-weight: 900;

            letter-spacing: -3px;

            line-height: 0.95;
        }


        .admin-subtitle {

            margin-top: 18px;

            color: #777;

            font-size: 13px;

            letter-spacing: 1px;

            line-height: 1.7;
        }


        /* =====================================================
           FORM
           ===================================================== */

        .admin-login-form {

            position: relative;

            z-index: 2;
        }


        .admin-form-group {

            margin-bottom: 22px;
        }


        .admin-form-group label {

            display: block;

            margin-bottom: 9px;

            color: #aaa;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 2px;
        }


        .admin-form-group input {

            width: 100%;

            box-sizing: border-box;

            padding: 16px 18px;

            background: #080808;

            border: 1px solid #303030;

            color: #fff;

            outline: none;

            font-size: 14px;

            transition:
                border-color 0.3s ease,
                box-shadow 0.3s ease;
        }


        .admin-form-group input:focus {

            border-color: #ff2525;

            box-shadow:
                0 0 20px
                rgba(255, 37, 37, 0.08);
        }


        .admin-login-btn {

            width: 100%;

            margin-top: 10px;

            padding: 17px;

            border: none;

            background: #ff2525;

            color: #fff;

            font-size: 12px;

            font-weight: 900;

            letter-spacing: 3px;

            cursor: pointer;

            transition:
                background 0.3s ease,
                color 0.3s ease,
                transform 0.3s ease;
        }


        .admin-login-btn:hover {

            background: #fff;

            color: #000;

            transform:
                translateY(-3px);
        }


        /* =====================================================
           BACK LINK
           ===================================================== */

        .admin-back-link {

            display: block;

            margin-top: 25px;

            text-align: center;

            color: #666;

            text-decoration: none;

            font-size: 11px;

            letter-spacing: 2px;

            transition:
                color 0.3s ease;
        }


        .admin-back-link:hover {

            color: #fff;
        }


        /* =====================================================
           SECURITY NOTE
           ===================================================== */

        .admin-security {

            margin-top: 30px;

            padding-top: 20px;

            border-top: 1px solid #222;

            color: #555;

            text-align: center;

            font-size: 10px;

            letter-spacing: 1px;

            line-height: 1.7;
        }


        /* =====================================================
           ERROR
           ===================================================== */

        .admin-error {

            margin-bottom: 20px;

            padding: 12px 15px;

            border: 1px solid
                rgba(255, 37, 37, 0.4);

            background:
                rgba(255, 37, 37, 0.08);

            color: #ff5555;

            font-size: 11px;

            font-weight: 700;

            letter-spacing: 1px;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 600px) {

            .admin-login-page {

                padding:
                    100px 15px 50px;
            }


            .admin-login-box {

                padding:
                    40px 25px;
            }


            .admin-login-header h1 {

                font-size: 48px;
            }

        }

    </style>

</head>


<body>


<!-- =====================================================
     ADMIN LOGIN
     ===================================================== -->

<section class="admin-login-page">


    <div class="admin-login-box">


        <div class="admin-login-header">

            <p class="admin-label">
                DRIFT CONTROL SYSTEM
            </p>


            <h1>
                ADMIN
                <br>
                LOGIN
            </h1>


            <p class="admin-subtitle">
                AUTHORIZED PERSONNEL ONLY.
                ACCESS THE DRIFT MANAGEMENT SYSTEM.
            </p>

        </div>


        <!-- ERROR MESSAGE -->

        <%
            String error =
                    request.getParameter("error");

            if ("invalid".equals(error)) {
        %>

            <div class="admin-error">

                &#10005;
                INVALID ADMIN CREDENTIALS.

            </div>

        <%
            }
        %>


        <!-- LOGIN FORM -->

        <form
            action="../admin-login"
            method="post"
            class="admin-login-form">


            <div class="admin-form-group">

                <label for="email">
                    ADMIN EMAIL
                </label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="admin@drift.com"
                    required>

            </div>


            <div class="admin-form-group">

                <label for="password">
                    PASSWORD
                </label>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter admin password"
                    required>

            </div>


            <button
                type="submit"
                class="admin-login-btn">

                ACCESS DASHBOARD &#8594;

            </button>


        </form>


        <a
            href="../index.html"
            class="admin-back-link">

            &#8592; BACK TO DRIFT

        </a>


        <div class="admin-security">

            &#128274;
            THIS AREA IS RESTRICTED TO
            AUTHORIZED DRIFT ADMINISTRATORS.

        </div>


    </div>


</section>


<script src="../js/script.js"></script>

</body>

</html>