/* =========================================================
   DRIFT — GLOBAL JAVASCRIPT
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    /* =====================================================
       CONTEXT PATH
       ===================================================== */

    const pathParts = window.location.pathname.split("/");

    const contextPath =
        pathParts.length > 1
            ? "/" + pathParts[1]
            : "";


    /* =====================================================
       NAVBAR SCROLL EFFECT
       ===================================================== */

    const navbar = document.querySelector(".navbar");

    if (navbar) {

        window.addEventListener("scroll", function () {

            if (window.scrollY > 50) {

                navbar.classList.add("scrolled");

            } else {

                navbar.classList.remove("scrolled");

            }

        });

    }


    /* =====================================================
       LOGIN / LOGOUT SESSION STATUS
       ===================================================== */

    /*
     * Find the LOGIN / LOGOUT link anywhere inside
     * the navigation area.
     *
     * Different DRIFT pages have slightly different
     * navbar structures, so we don't depend only on
     * .nav-actions.
     */

    const navLinks = document.querySelectorAll(
        ".navbar a, nav a"
    );

    let sessionLink = null;

    navLinks.forEach(function (link) {

        const text =
            link.textContent.trim().toUpperCase();

        const href =
            link.getAttribute("href") || "";

        if (
            text === "LOGIN" ||
            text === "LOGOUT" ||
            href.includes("login.html") ||
            href === "logout" ||
            href.endsWith("/logout")
        ) {
            sessionLink = link;
        }

    });


    /* =====================================================
       CHECK LOGIN SESSION
       ===================================================== */

    if (sessionLink) {

        fetch(
            contextPath + "/session-status",
            {
                cache: "no-store"
            }
        )

        .then(function (response) {

            if (!response.ok) {

                throw new Error(
                    "Session status request failed"
                );

            }

            return response.json();

        })

        .then(function (data) {

            if (data.loggedIn) {

                /* ===============================
                   USER IS LOGGED IN
                   =============================== */

                sessionLink.textContent = "LOGOUT";

                sessionLink.href =
                    contextPath + "/logout";


            } else {

                /* ===============================
                   USER IS LOGGED OUT
                   =============================== */

                sessionLink.textContent = "LOGIN";

                sessionLink.href =
                    contextPath + "/pages/login.html";

            }

        })

        .catch(function (error) {

            console.error(
                "Session status error:",
                error
            );

            /*
             * If session check fails,
             * safely show LOGIN.
             */

            sessionLink.textContent = "LOGIN";

            sessionLink.href =
                contextPath + "/pages/login.html";

        });

    }


    /* =====================================================
       CART COUNT
       ===================================================== */

    const cartCount =
        document.getElementById("cart-count");


    if (cartCount) {

        fetch(
            contextPath + "/cart-count",
            {
                cache: "no-store"
            }
        )

        .then(function (response) {

            if (!response.ok) {

                throw new Error(
                    "Cart count request failed"
                );

            }

            return response.json();

        })

        .then(function (data) {

            cartCount.textContent =
                data.cartCount;

        })

        .catch(function (error) {

            console.error(
                "Cart count error:",
                error
            );

        });


        /* =================================================
           CART COUNT HOVER ANIMATION
           ================================================= */

        cartCount.style.transition =
            "transform 0.25s ease";


        cartCount.addEventListener(
            "mouseenter",
            function () {

                cartCount.style.transform =
                    "scale(1.2)";

            }
        );


        cartCount.addEventListener(
            "mouseleave",
            function () {

                cartCount.style.transform =
                    "scale(1)";

            }
        );

    }


    /* =====================================================
       BUTTON CLICK ANIMATION
       ===================================================== */

    const buttons =
        document.querySelectorAll(
            "button, .btn"
        );


    buttons.forEach(function (button) {

        button.addEventListener(
            "click",
            function () {

                button.classList.add(
                    "button-clicked"
                );


                setTimeout(function () {

                    button.classList.remove(
                        "button-clicked"
                    );

                }, 200);

            }
        );

    });


    /* =====================================================
       PRODUCT IMAGE HOVER
       ===================================================== */

    const productImages =
        document.querySelectorAll(
            ".product-card img, .cart-item-image img"
        );


    productImages.forEach(function (image) {

        image.addEventListener(
            "mouseenter",
            function () {

                image.style.transform =
                    "scale(1.05)";

            }
        );


        image.addEventListener(
            "mouseleave",
            function () {

                image.style.transform =
                    "scale(1)";

            }
        );

    });


    /* =====================================================
       SMOOTH SCROLL
       ===================================================== */

    const scrollLinks =
        document.querySelectorAll(
            'a[href^="#"]'
        );


    scrollLinks.forEach(function (link) {

        link.addEventListener(
            "click",
            function (event) {

                const targetId =
                    link.getAttribute("href");


                if (
                    targetId &&
                    targetId !== "#"
                ) {

                    const target =
                        document.querySelector(
                            targetId
                        );


                    if (target) {

                        event.preventDefault();

                        target.scrollIntoView({
                            behavior: "smooth"
                        });

                    }

                }

            }
        );

    });


    /* =====================================================
       PAGE LOAD EFFECT
       ===================================================== */

    document.body.classList.add(
        "page-loaded"
    );


    /* =====================================================
       FORM SUBMIT PROTECTION
       ===================================================== */

    const forms =
        document.querySelectorAll("form");


    forms.forEach(function (form) {

        form.addEventListener(
            "submit",
            function () {

                const submitButton =
                    form.querySelector(
                        'button[type="submit"], input[type="submit"]'
                    );


                if (submitButton) {

                    setTimeout(function () {

                        submitButton.disabled =
                            true;

                    }, 50);

                }

            }
        );

    });


    /* =====================================================
       DRIFT CONSOLE
       ===================================================== */

    console.log(
        "%c DRIFT ",
        "background:#ff2525;color:#fff;font-size:20px;font-weight:bold;padding:8px 15px;"
    );


    console.log(
        "%c MOVE DIFFERENT. ",
        "color:#ff2525;font-size:14px;font-weight:bold;"
    );

});