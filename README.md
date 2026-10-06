# DRIFT — E-Commerce Web Application

> **MOVE DIFFERENT.**

DRIFT is a full-stack e-commerce web application designed for a modern streetwear and sneaker store. It provides a complete shopping experience for customers along with a dedicated admin management system.

The project is built using **Java, JSP, Servlets, JDBC, MySQL, HTML, CSS, and JavaScript**, and runs on **Apache Tomcat**.

---

## 🚀 Features

### 👤 Customer Features

- User registration
- User login and logout
- Session-based authentication
- Browse products
- Category-based product filtering
- Product details
- Product image hover effects
- Add products to cart
- Update cart quantity
- Remove products from cart
- Dynamic cart count
- Wishlist functionality
- Checkout
- Shipping address
- Multiple payment method selection
- Order placement
- Order history
- Order details
- Contact form
- Stock availability display
- Low-stock indication
- Out-of-stock handling

### 🛠️ Admin Features

- Admin authentication
- Admin dashboard
- Product management
  - Add products
  - Edit products
  - Soft delete products
  - Manage prices
  - Manage stock
  - Manage product information
- View registered users
- View customer orders
- Update order status
- View customer messages

---

## 🏗️ Architecture

DRIFT follows a layered architecture separating the application into controllers, DAO layers, models, and the web layer.

```text
DRIFT
│
├── Controller
│   └── Handles HTTP requests and application flow
│
├── DAO
│   └── Defines database operations
│
├── DAO Implementation
│   └── Implements database operations using JDBC
│
├── Model
│   └── Represents application entities
│
└── Web Layer
    ├── JSP
    ├── HTML
    ├── CSS
    └── JavaScript
```

---

## 🧰 Technologies Used

### Backend
- Java
- Jakarta Servlets
- JSP
- JDBC
- Apache Tomcat

### Frontend
- HTML5
- CSS3
- JavaScript
- JSP

### Database
- MySQL

### Tools
- Eclipse IDE
- MySQL
- Apache Tomcat
- Git
- GitHub

---

## 🗄️ Database

The project uses a MySQL database named:

```text
projectdrift
```

### Database Tables

```text
users
categories
products
cart
cart_items
wishlist
orders
order_items
contact_messages
```

The database script is included in the project's **database** folder.

---

## 🛒 Shopping Flow

```text
Register / Login
       ↓
Browse Shop
       ↓
View Product
       ↓
Add to Cart
       ↓
Review Cart
       ↓
Checkout
       ↓
Enter Shipping Details
       ↓
Select Payment Method
       ↓
Place Order
       ↓
Stock Updated
       ↓
Cart Cleared
       ↓
Order History
```

---

## 📦 Order & Stock Management

DRIFT uses transactional order processing to maintain consistency between orders, order items, product stock, and the customer's cart.

When an order is placed:

1. Cart items are checked.
2. Product stock is verified.
3. The order is created.
4. Order items are inserted.
5. Product stock is reduced.
6. Cart items are cleared.
7. The transaction is committed.

If an operation fails, the transaction is rolled back.

---

## 📋 Order Status

Administrators can update customer order statuses.

Available statuses:

```text
PLACED
CONFIRMED
SHIPPED
DELIVERED
CANCELLED
```

---

## 🖥️ Application Pages

### Customer

```text
Home
Shop
Product Details
Login
Register
Cart
Checkout
Order Success
Orders
Order Details
Wishlist
Contact
About
```

### Admin

```text
Admin Login
Admin Dashboard
Admin Products
Add Product
Edit Product
Admin Users
Admin Orders
Admin Messages
```

---

## 📁 Project Structure

```text
DRIFT
│
├── database/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── drift/
│       │           ├── controller/
│       │           ├── dao/
│       │           ├── daoimpl/
│       │           ├── model/
│       │           └── util/
│       │
│       └── webapp/
│           ├── css/
│           ├── js/
│           ├── images/
│           ├── pages/
│           ├── META-INF/
│           └── WEB-INF/
│
├── build/
├── .classpath
├── .project
└── README.md
```

---

## ⚙️ Setup & Installation

### 1. Clone the Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
```

### 2. Import the Project

Open the project in **Eclipse IDE** as a Dynamic Web Project.

### 3. Configure MySQL

Create the database:

```sql
CREATE DATABASE projectdrift;
```

Import the SQL file provided inside the:

```text
database/
```

folder.

### 4. Configure Database Connection

Update the database credentials in the database connection class:

```text
Database : projectdrift
Host     : localhost
Port     : 3306
Username : root
Password : YOUR_PASSWORD
```

### 5. Configure Apache Tomcat

Configure **Apache Tomcat 10** in Eclipse and add the DRIFT project to the server.

### 6. Run the Application

Start Tomcat and open:

```text
http://localhost:8080/DRIFT/
```

---

## 🔐 Admin

DRIFT includes a separate admin authentication system.

Administrators can access:

- Dashboard
- Products
- Users
- Orders
- Customer Messages

Admin credentials are managed through the database.

> For production deployment, sensitive credentials should not be stored directly in source code or committed to GitHub.

---

## 🧪 Testing

The application has been tested across the major customer and admin workflows:

```text
Registration
Login
Logout
Product Browsing
Product Details
Cart
Wishlist
Checkout
Order Placement
Stock Management
Order History
Admin Login
Product Management
User Management
Order Management
Message Management
```

---

## 🎯 Project Objectives

The main objectives of DRIFT are to:

- Develop a complete Java-based e-commerce application.
- Implement user authentication and session management.
- Implement product and category management.
- Implement cart and wishlist functionality.
- Implement checkout and order processing.
- Implement transactional stock management.
- Develop an admin management system.
- Integrate Java with MySQL using JDBC.
- Apply layered application architecture.
- Build a modern and responsive user interface.

---

## 🔮 Future Enhancements

- Password hashing using BCrypt
- Online payment gateway integration
- Email order notifications
- Product search
- Product reviews
- Pagination
- Advanced admin analytics
- Sales reports
- Improved input validation
- Enhanced role-based access control

---

## 👨‍💻 Developer

**Ketan**

**B.Tech- Dayananda Sagar University**

### Skills Demonstrated

```text
Java
JSP
Servlets
JDBC
MySQL
HTML5
CSS3
JavaScript
Layered Architecture
Session Management
Database Transactions
Git & GitHub
Apache Tomcat
```

---

## ⭐ DRIFT

> **MOVE DIFFERENT.**

A Java-based e-commerce web application built for a modern streetwear and sneaker shopping experience.
