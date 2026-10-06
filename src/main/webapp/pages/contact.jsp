<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | CONTACT</title>

    <link rel="stylesheet"
          href="../css/style.css">

    <style>

        /* ================= CONTACT PAGE ================= */

        .contact-page {
            min-height: 100vh;
            padding-top: 140px;
            background:
                radial-gradient(
                    circle at 20% 20%,
                    rgba(255, 30, 30, 0.12),
                    transparent 35%
                ),
                #050505;
        }

        .contact-hero {
            width: 85%;
            margin: auto;
            padding: 70px 0 50px;
        }

        .contact-label {
            color: #ff2525;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 6px;
            margin-bottom: 25px;
        }

        .contact-hero h1 {
            font-size: clamp(60px, 10vw, 140px);
            line-height: 0.9;
            margin: 0;
            font-weight: 900;
            letter-spacing: -5px;
        }

        .contact-hero h1 span {
            color: #ff2525;
        }

        .contact-hero p {
            max-width: 650px;
            color: #999;
            font-size: 19px;
            line-height: 1.8;
            margin-top: 40px;
        }

        .contact-container {
            width: 85%;
            margin: 30px auto 120px;

            display: grid;
            grid-template-columns: 1fr 1.3fr;
            gap: 30px;
        }

        /* ================= CONTACT INFO ================= */

        .contact-info {
            border: 1px solid #252525;
            padding: 40px;
            background: linear-gradient(
                145deg,
                #111,
                #070707
            );
        }

        .contact-info h2 {
            font-size: 32px;
            margin-top: 0;
        }

        .contact-info > p {
            color: #888;
            line-height: 1.7;
            margin-bottom: 40px;
        }

        .contact-item {
            border-top: 1px solid #252525;
            padding: 25px 0;
        }

        .contact-item span {
            display: block;
            color: #ff2525;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 3px;
            margin-bottom: 10px;
        }

        .contact-item p {
            margin: 0;
            color: #ddd;
            font-size: 16px;
        }

        /* ================= CONTACT FORM ================= */

        .contact-form {
            border: 1px solid #252525;
            padding: 40px;
            background: #0b0b0b;
        }

        .contact-form h2 {
            margin-top: 0;
            font-size: 32px;
        }

        /* ================= MESSAGE ================= */

        .contact-message {
            width: 85%;
            margin: 0 auto 30px;
            padding: 18px 25px;
            box-sizing: border-box;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 1px;
            border: 1px solid;
        }

        .contact-success {
            color: #65ff9a;
            border-color: #65ff9a;
            background: rgba(101, 255, 154, 0.06);
        }

        .contact-error {
            color: #ff5252;
            border-color: #ff5252;
            background: rgba(255, 82, 82, 0.06);
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            color: #aaa;
            font-size: 13px;
            letter-spacing: 2px;
            margin-bottom: 9px;
            font-weight: 700;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            box-sizing: border-box;

            padding: 16px;

            background: #050505;
            border: 1px solid #292929;

            color: #fff;

            font-family: inherit;
            font-size: 15px;

            outline: none;

            transition: 0.3s ease;
        }

        .form-group textarea {
            min-height: 160px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #ff2525;
            box-shadow:
                0 0 20px rgba(255, 37, 37, 0.08);
        }

        .contact-submit {
            width: 100%;
            padding: 17px;

            background: #ff2525;
            color: #fff;

            border: none;

            font-weight: 800;
            letter-spacing: 2px;

            cursor: pointer;

            transition: 0.3s ease;
        }

        .contact-submit:hover {
            background: #fff;
            color: #000;
            transform: translateY(-2px);
        }

        /* ================= MOBILE ================= */

        @media (max-width: 800px) {

            .contact-container {
                grid-template-columns: 1fr;
            }

            .contact-hero h1 {
                letter-spacing: -2px;
            }

            .contact-hero p {
                font-size: 17px;
            }

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

            <a href="../index.html">
                HOME
            </a>

            <a href="../shop">
                SHOP
            </a>

            <a href="about.html">
                ABOUT
            </a>

            <a href="contact.html">
                CONTACT
            </a>

            <a href="login.html">
                LOGIN
            </a>

            <a href="../orders">
                MY ORDERS
            </a>

            <a href="../cart"
               class="cart-link">

                CART

                <span id="cart-count">
                    0
                </span>

            </a>

        </nav>

    </header>


    <!-- ================= CONTACT ================= -->

    <main class="contact-page">


        <section class="contact-hero">

            <p class="contact-label">
                GET IN TOUCH
            </p>


            <h1>

                LET'S

                <br>

                <span>TALK.</span>

            </h1>


            <p>

                Have a question about an order,
                product or DRIFT? Send us a message
                and we'll get back to you.

            </p>

        </section>


        <!-- ================= SUCCESS / ERROR MESSAGE ================= -->

        <%
            String success =
                    request.getParameter("success");

            String error =
                    request.getParameter("error");
        %>


        <% if ("true".equals(success)) { %>

            <div class="contact-message contact-success">

               &#10003; MESSAGE SENT SUCCESSFULLY.
                THANK YOU FOR CONTACTING DRIFT.

            </div>

        <% } %>


        <% if ("empty".equals(error)) { %>

            <div class="contact-message contact-error">

                âœ• PLEASE FILL IN ALL THE FIELDS.

            </div>

        <% } %>


        <% if ("failed".equals(error)) { %>

            <div class="contact-message contact-error">

                âœ• SOMETHING WENT WRONG.
                PLEASE TRY AGAIN.

            </div>

        <% } %>


        <!-- ================= CONTACT CONTENT ================= -->

        <section class="contact-container">


            <!-- CONTACT INFORMATION -->

            <div class="contact-info">

                <h2>
                    CONTACT DRIFT
                </h2>

                <p>
                    We're here to help with your
                    DRIFT experience.
                </p>


                <div class="contact-item">

                    <span>
                        EMAIL
                    </span>

                    <p>
                        hello@driftwear.com
                    </p>

                </div>


                <div class="contact-item">

                    <span>
                        PHONE
                    </span>

                    <p>
                        +91 98765 43210
                    </p>

                </div>


                <div class="contact-item">

                    <span>
                        LOCATION
                    </span>

                    <p>
                        Bengaluru, India
                    </p>

                </div>


                <div class="contact-item">

                    <span>
                        RESPONSE
                    </span>

                    <p>
                        Usually within 24 hours.
                    </p>

                </div>

            </div>


            <!-- CONTACT FORM -->

            <div class="contact-form">

                <h2>
                    SEND A MESSAGE
                </h2>


                <form
                    action="../contact"
                    method="post">


                    <div class="form-group">

                        <label for="name">
                            NAME
                        </label>

                        <input
                            type="text"
                            id="name"
                            name="name"
                            placeholder="Your name"
                            required>

                    </div>


                    <div class="form-group">

                        <label for="email">
                            EMAIL
                        </label>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="your@email.com"
                            required>

                    </div>


                    <div class="form-group">

                        <label for="subject">
                            SUBJECT
                        </label>

                        <input
                            type="text"
                            id="subject"
                            name="subject"
                            placeholder="What's this about?"
                            required>

                    </div>


                    <div class="form-group">

                        <label for="message">
                            MESSAGE
                        </label>

                        <textarea
                            id="message"
                            name="message"
                            placeholder="Write your message..."
                            required></textarea>

                    </div>


                    <button
                        type="submit"
                        class="contact-submit">

                        SEND MESSAGE &#8594;†’

                    </button>


                </form>

            </div>


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

            Â© 2026 DRIFT.
            ALL RIGHTS RESERVED.

        </p>

    </footer>


    <!-- ================= JAVASCRIPT ================= -->

    <script src="../js/script.js"></script>


</body>

</html>