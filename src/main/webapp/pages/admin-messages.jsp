<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.util.List"
         import="com.drift.model.ContactMessage" %>

<%
    List<ContactMessage> messages =
            (List<ContactMessage>) request.getAttribute("messages");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>DRIFT | Messages</title>

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

        .messages-page {
            min-height: 100vh;
            padding: 40px;
        }

        .messages-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 35px;
        }

        .messages-title h1 {
            margin: 0;
            font-size: 42px;
            letter-spacing: 4px;
            font-weight: 900;
        }

        .messages-title p {
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

        .messages-stats {
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

        .messages-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1100px;
        }

        .messages-table th {
            background: #151515;
            color: #888;
            padding: 18px 15px;
            text-align: left;
            font-size: 10px;
            letter-spacing: 2px;
            border-bottom: 1px solid #292929;
        }

        .messages-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #1d1d1d;
            font-size: 13px;
            color: #ddd;
            vertical-align: top;
        }

        .messages-table tr:hover {
            background: #131313;
        }

        .message-id {
            color: #ff2525;
            font-weight: 800;
        }

        .sender-name {
            color: #fff;
            font-weight: 800;
        }

        .sender-email {
            color: #aaa;
        }

        .subject {
            color: #fff;
            font-weight: 700;
        }

        .message-content {
            color: #888;
            line-height: 1.6;
            max-width: 350px;
        }

        .message-date {
            color: #666;
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

            .messages-page {
                padding: 20px;
            }

            .messages-header {
                align-items: flex-start;
                gap: 20px;
                flex-direction: column;
            }

            .messages-title h1 {
                font-size: 30px;
            }

            .messages-stats {
                flex-direction: column;
            }

            .stat-box {
                width: 100%;
            }
        }

    </style>

</head>

<body>

<div class="messages-page">

    <!-- HEADER -->

    <div class="messages-header">

        <div class="messages-title">

            <h1>MESSAGES</h1>

            <p>
                DRIFT CUSTOMER COMMUNICATION /
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

    <div class="messages-stats">

        <div class="stat-box">

            <span>TOTAL MESSAGES</span>

            <strong>
                <%= messages == null ? 0 : messages.size() %>
            </strong>

        </div>

        <div class="stat-box">

            <span>SYSTEM</span>

            <strong>ONLINE</strong>

        </div>

    </div>


    <!-- MESSAGES TABLE -->

    <div class="table-wrapper">

        <table class="messages-table">

            <thead>

                <tr>

                    <th>ID</th>

                    <th>NAME</th>

                    <th>EMAIL</th>

                    <th>SUBJECT</th>

                    <th>MESSAGE</th>

                    <th>DATE</th>

                </tr>

            </thead>


            <tbody>

            <%
                if (messages != null && !messages.isEmpty()) {

                    for (ContactMessage message : messages) {
            %>

                <tr>

                    <td class="message-id">
                        #<%= message.getMessageId() %>
                    </td>

                    <td class="sender-name">
                        <%= message.getName() %>
                    </td>

                    <td class="sender-email">
                        <%= message.getEmail() %>
                    </td>

                    <td class="subject">
                        <%= message.getSubject() %>
                    </td>

                    <td class="message-content">
                        <%= message.getMessage() %>
                    </td>

                    <td class="message-date">
                        <%= message.getCreatedAt() == null
                                ? "-"
                                : message.getCreatedAt() %>
                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>

                    <td colspan="6">

                        <div class="empty-state">
                            NO MESSAGES FOUND
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