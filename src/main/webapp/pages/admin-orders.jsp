<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.util.List"
         import="com.drift.model.Order" %>

<%
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Orders</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #080808;
            color: #ffffff;
            font-family: Arial, Helvetica, sans-serif;
        }

        .orders-page {
            min-height: 100vh;
            padding: 40px;
        }

        .orders-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .orders-title h1 {
            margin: 0;
            font-size: 42px;
            letter-spacing: 4px;
            font-weight: 900;
        }

        .orders-title p {
            margin-top: 10px;
            color: #777;
            font-size: 12px;
            letter-spacing: 2px;
        }

        .back-btn {
            text-decoration: none;
            color: #fff;
            border: 1px solid #333;
            padding: 13px 22px;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: #fff;
            color: #000;
        }

        .orders-stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-box {
            border: 1px solid #252525;
            background: #101010;
            padding: 20px 30px;
            min-width: 180px;
        }

        .stat-box span {
            display: block;
            color: #777;
            font-size: 10px;
            letter-spacing: 2px;
            margin-bottom: 8px;
        }

        .stat-box strong {
            font-size: 28px;
        }

        .error-message {
            margin-bottom: 25px;
            padding: 15px 20px;
            border: 1px solid #ff2525;
            background: rgba(255, 37, 37, 0.08);
            color: #ff2525;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #252525;
            background: #0d0d0d;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1250px;
        }

        .orders-table th {
            background: #151515;
            color: #888;
            padding: 18px 15px;
            text-align: left;
            font-size: 10px;
            letter-spacing: 2px;
            border-bottom: 1px solid #292929;
        }

        .orders-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #1d1d1d;
            font-size: 13px;
            color: #ddd;
            vertical-align: middle;
        }

        .orders-table tr:hover {
            background: #131313;
        }

        .order-id {
            color: #ff2525;
            font-weight: 800;
        }

        .user-id {
            color: #888;
        }

        .amount {
            color: #fff;
            font-weight: 800;
            white-space: nowrap;
        }

        .address {
            color: #888;
            max-width: 250px;
        }

        .payment {
            color: #aaa;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .status-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .status-select {
            min-width: 130px;
            padding: 9px 10px;
            background: #101010;
            color: #fff;
            border: 1px solid #333;
            outline: none;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 1px;
            cursor: pointer;
        }

        .status-select:focus {
            border-color: #ff2525;
        }

        .status-btn {
            padding: 9px 12px;
            background: #ff2525;
            color: #fff;
            border: 1px solid #ff2525;
            font-size: 9px;
            font-weight: 900;
            letter-spacing: 1px;
            cursor: pointer;
            transition: 0.3s;
        }

        .status-btn:hover {
            background: #fff;
            color: #000;
            border-color: #fff;
        }

        .current-status {
            display: inline-block;
            margin-top: 7px;
            color: #666;
            font-size: 9px;
            letter-spacing: 1px;
        }

        .date {
            color: #777;
            font-size: 11px;
            white-space: nowrap;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #666;
            letter-spacing: 2px;
            font-size: 12px;
        }

        @media (max-width: 700px) {

            .orders-page {
                padding: 20px;
            }

            .orders-header {
                align-items: flex-start;
                gap: 20px;
                flex-direction: column;
            }

            .orders-title h1 {
                font-size: 30px;
            }

            .orders-stats {
                flex-direction: column;
            }

            .stat-box {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="orders-page">

    <!-- HEADER -->

    <div class="orders-header">

        <div class="orders-title">

            <h1>ORDERS</h1>

            <p>
                DRIFT ORDER DATABASE /
                ADMIN CONTROL
            </p>

        </div>

        <a
            href="<%= request.getContextPath() %>/admin-dashboard"
            class="back-btn">

            &larr; DASHBOARD

        </a>

    </div>


    <!-- ERROR MESSAGE -->

    <%
        if ("invalid".equals(error)) {
    %>

        <div class="error-message">
            INVALID ORDER STATUS REQUEST.
        </div>

    <%
        } else if ("update".equals(error)) {
    %>

        <div class="error-message">
            ORDER STATUS UPDATE FAILED.
        </div>

    <%
        }
    %>


    <!-- STATISTICS -->

    <div class="orders-stats">

        <div class="stat-box">

            <span>TOTAL ORDERS</span>

            <strong>
                <%= orders == null ? 0 : orders.size() %>
            </strong>

        </div>

        <div class="stat-box">

            <span>SYSTEM</span>

            <strong>ONLINE</strong>

        </div>

    </div>


    <!-- ORDERS TABLE -->

    <div class="table-wrapper">

        <table class="orders-table">

            <thead>

                <tr>

                    <th>ORDER ID</th>

                    <th>USER ID</th>

                    <th>TOTAL</th>

                    <th>ADDRESS</th>

                    <th>PAYMENT</th>

                    <th>STATUS</th>

                    <th>DATE</th>

                </tr>

            </thead>


            <tbody>

            <%
                if (orders != null && !orders.isEmpty()) {

                    for (Order order : orders) {
            %>

                <tr>

                    <td class="order-id">
                        #<%= order.getOrderId() %>
                    </td>


                    <td class="user-id">
                        #<%= order.getUserId() %>
                    </td>


                    <td class="amount">
                        &#8377;
                        <%= String.format(
                                "%.2f",
                                order.getTotalAmount()
                            ) %>
                    </td>


                    <td class="address">
                        <%= order.getShippingAddress() == null
                                ? "-"
                                : order.getShippingAddress() %>
                    </td>


                    <td class="payment">
                        <%= order.getPaymentMethod() == null
                                ? "-"
                                : order.getPaymentMethod() %>
                    </td>


                    <td>

                        <form
                            action="<%= request.getContextPath() %>/admin-update-order-status"
                            method="post"
                            class="status-form">

                            <input
                                type="hidden"
                                name="orderId"
                                value="<%= order.getOrderId() %>">


                            <select
                                name="status"
                                class="status-select">

                                <option
                                    value="PLACED"
                                    <%= "PLACED".equalsIgnoreCase(
                                            order.getOrderStatus())
                                            ? "selected"
                                            : "" %>>

                                    PLACED

                                </option>


                                <option
                                    value="CONFIRMED"
                                    <%= "CONFIRMED".equalsIgnoreCase(
                                            order.getOrderStatus())
                                            ? "selected"
                                            : "" %>>

                                    CONFIRMED

                                </option>


                                <option
                                    value="SHIPPED"
                                    <%= "SHIPPED".equalsIgnoreCase(
                                            order.getOrderStatus())
                                            ? "selected"
                                            : "" %>>

                                    SHIPPED

                                </option>


                                <option
                                    value="DELIVERED"
                                    <%= "DELIVERED".equalsIgnoreCase(
                                            order.getOrderStatus())
                                            ? "selected"
                                            : "" %>>

                                    DELIVERED

                                </option>


                                <option
                                    value="CANCELLED"
                                    <%= "CANCELLED".equalsIgnoreCase(
                                            order.getOrderStatus())
                                            ? "selected"
                                            : "" %>>

                                    CANCELLED

                                </option>

                            </select>


                            <button
                                type="submit"
                                class="status-btn">

                                UPDATE

                            </button>

                        </form>


                        <span class="current-status">

                            CURRENT:
                            <%= order.getOrderStatus() == null
                                    ? "UNKNOWN"
                                    : order.getOrderStatus() %>

                        </span>

                    </td>


                    <td class="date">
                        <%= order.getOrderDate() == null
                                ? "-"
                                : order.getOrderDate() %>
                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>

                    <td colspan="7">

                        <div class="empty-state">
                            NO ORDERS FOUND
                        </div>

                    </td>

                </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

</body>

</html>