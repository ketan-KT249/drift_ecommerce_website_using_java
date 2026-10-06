package com.drift.controller;

import java.io.IOException;
import java.util.List;

import com.drift.dao.OrderDAO;
import com.drift.dao.OrderHistoryDAO;
import com.drift.daoimpl.OrderDAOImpl;
import com.drift.daoimpl.OrderHistoryDAOImpl;
import com.drift.model.CartItem;
import com.drift.model.Order;
import com.drift.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order-details")
public class OrderDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAO orderDAO;

    private OrderHistoryDAO orderHistoryDAO;


    @Override
    public void init() throws ServletException {

        orderDAO =
                new OrderDAOImpl();

        orderHistoryDAO =
                new OrderHistoryDAOImpl();
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // =========================================
        // 1. CHECK LOGIN
        // =========================================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect(
                    "pages/login.html"
            );

            return;
        }


        // =========================================
        // 2. GET LOGGED-IN USER
        // =========================================

        User user =
                (User) session.getAttribute("user");

        int userId =
                user.getUserId();


        // =========================================
        // 3. GET ORDER ID
        // =========================================

        String orderIdParameter =
                request.getParameter("orderId");


        if (orderIdParameter == null ||
            orderIdParameter.trim().isEmpty()) {

            response.sendRedirect(
                    "orders?error=invalid"
            );

            return;
        }


        int orderId;

        try {

            orderId =
                    Integer.parseInt(
                            orderIdParameter
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "orders?error=invalid"
            );

            return;
        }


        // =========================================
        // 4. GET USER'S ORDERS
        // =========================================

        List<Order> orders =
                orderHistoryDAO.getOrdersByUserId(
                        userId
                );


        // =========================================
        // 5. FIND REQUESTED ORDER
        // =========================================

        Order selectedOrder = null;

        for (Order order : orders) {

            if (order.getOrderId() == orderId) {

                selectedOrder = order;

                break;
            }
        }


        // =========================================
        // 6. SECURITY CHECK
        // =========================================
        // User can only view their own order.

        if (selectedOrder == null) {

            response.sendRedirect(
                    "orders?error=notfound"
            );

            return;
        }


        // =========================================
        // 7. GET ORDER ITEMS
        // =========================================

        List<CartItem> orderItems =
                orderDAO.getOrderItems(
                        orderId
                );


        // =========================================
        // 8. SEND DATA TO JSP
        // =========================================

        request.setAttribute(
                "order",
                selectedOrder
        );

        request.setAttribute(
                "orderItems",
                orderItems
        );


        // =========================================
        // 9. OPEN ORDER DETAILS PAGE
        // =========================================

        request.getRequestDispatcher(
                "pages/order-details.jsp"
        ).forward(
                request,
                response
        );
    }
}