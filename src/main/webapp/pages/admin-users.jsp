<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.util.List"
         import="com.drift.model.User" %>

<%
    List<User> users =
            (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Users</title>

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

        .users-page {
            min-height: 100vh;
            padding: 40px;
        }

        .users-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .users-title h1 {
            margin: 0;
            font-size: 42px;
            letter-spacing: 4px;
            font-weight: 900;
        }

        .users-title p {
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

        .users-stats {
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

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #252525;
            background: #0d0d0d;
        }

        .users-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
        }

        .users-table th {
            background: #151515;
            color: #888;
            padding: 18px 15px;
            text-align: left;
            font-size: 10px;
            letter-spacing: 2px;
            border-bottom: 1px solid #292929;
        }

        .users-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #1d1d1d;
            font-size: 13px;
            color: #ddd;
        }

        .users-table tr:hover {
            background: #131313;
        }

        .user-id {
            color: #666;
            font-weight: 700;
        }

        .user-name {
            color: #fff;
            font-weight: 800;
        }

        .user-email {
            color: #aaa;
        }

        .user-phone {
            color: #aaa;
        }

        .user-address {
            color: #888;
            max-width: 220px;
        }

        .role {
            display: inline-block;
            padding: 6px 10px;
            border: 1px solid #333;
            font-size: 9px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .role-admin {
            color: #ff2525;
            border-color: #ff2525;
        }

        .role-user {
            color: #aaa;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #666;
            letter-spacing: 2px;
            font-size: 12px;
        }

        @media (max-width: 700px) {

            .users-page {
                padding: 20px;
            }

            .users-header {
                align-items: flex-start;
                gap: 20px;
                flex-direction: column;
            }

            .users-title h1 {
                font-size: 30px;
            }

            .users-stats {
                flex-direction: column;
            }

            .stat-box {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="users-page">

    <!-- HEADER -->

    <div class="users-header">

        <div class="users-title">

            <h1>USERS</h1>

            <p>
                DRIFT CUSTOMER DATABASE /
                ADMIN CONTROL
            </p>

        </div>

        <a
            href="<%= request.getContextPath() %>/admin-dashboard"
            class="back-btn">

            &larr; DASHBOARD

        </a>

    </div>


    <!-- STATISTICS -->

    <div class="users-stats">

        <div class="stat-box">

            <span>TOTAL USERS</span>

            <strong>
                <%= users == null ? 0 : users.size() %>
            </strong>

        </div>

        <div class="stat-box">

            <span>SYSTEM</span>

            <strong>ONLINE</strong>

        </div>

    </div>


    <!-- USERS TABLE -->

    <div class="table-wrapper">

        <table class="users-table">

            <thead>

                <tr>

                    <th>ID</th>

                    <th>NAME</th>

                    <th>EMAIL</th>

                    <th>PHONE</th>

                    <th>ADDRESS</th>

                    <th>ROLE</th>

                </tr>

            </thead>


            <tbody>

            <%
                if (users != null && !users.isEmpty()) {

                    for (User user : users) {
            %>

                <tr>

                    <td class="user-id">
                        #<%= user.getUserId() %>
                    </td>

                    <td class="user-name">
                        <%= user.getName() %>
                    </td>

                    <td class="user-email">
                        <%= user.getEmail() %>
                    </td>

                    <td class="user-phone">
                        <%= user.getPhone() == null
                                ? "-"
                                : user.getPhone() %>
                    </td>

                    <td class="user-address">
                        <%= user.getAddress() == null
                                ? "-"
                                : user.getAddress() %>
                    </td>

                    <td>

                        <%
                            if ("ADMIN".equalsIgnoreCase(
                                    user.getRole())) {
                        %>

                            <span class="role role-admin">
                                ADMIN
                            </span>

                        <%
                            } else {
                        %>

                            <span class="role role-user">
                                USER
                            </span>

                        <%
                            }
                        %>

                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>

                    <td colspan="6">

                        <div class="empty-state">
                            NO USERS FOUND
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