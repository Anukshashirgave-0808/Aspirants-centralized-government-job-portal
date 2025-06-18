<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Prevent caching so that users can't access the page after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Check if admin session is set; if not, redirect to login page
    String adminUsername = (String) session.getAttribute("adminUser");
    if (adminUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection settings
    String dbURL = "jdbc:mysql://localhost:3306/asp"; // Replace with your DB name
    String dbUser = "root"; // Change if using a different user
    String dbPass = ""; // Change if your MySQL has a password

    Connection conn = null;
    Statement stmt = null;
    ResultSet jobRs = null, userRs = null;

    int totalJobs = 0, totalUsers = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        stmt = conn.createStatement();

        // Query to count total jobs
        jobRs = stmt.executeQuery("SELECT COUNT(*) FROM jobs");
        if (jobRs.next()) {
            totalJobs = jobRs.getInt(1);
        }

        // Query to count total users
        userRs = stmt.executeQuery("SELECT COUNT(*) FROM users");
        if (userRs.next()) {
            totalUsers = userRs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (jobRs != null) jobRs.close();
            if (userRs != null) userRs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { width: 250px; height: 100vh; background: #202123; color: white; position: fixed; padding: 20px; }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px; border-radius: 5px; }
        .sidebar a:hover { background: #343541; }
        .content { margin-left: 260px; padding: 20px; }
        .card { border: none; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
    </style>
</head>
<body>
    <div class="sidebar">
        <h4>Admin Panel</h4>
        <hr>
        <a href="#"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="manageJobs.jsp"><i class="fas fa-briefcase"></i> Manage Jobs</a>
        <a href="manageUsers.jsp"><i class="fas fa-users"></i> Manage Users</a>
        <a href="addJob.jsp"><i class="fas fa-users"></i> Add Jobs</a>
        <a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    <div class="content">
        <h2 class="mb-4">Welcome, <%= adminUsername %></h2>
        <div class="row">
            <div class="col-md-6">
                <div class="card p-3 text-center bg-primary text-white">
                    <h4>Total Jobs</h4>
                    <h2><%= totalJobs %></h2>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card p-3 text-center bg-success text-white">
                    <h4>Total Users</h4>
                    <h2><%= totalUsers %></h2>
                </div>
            </div>
        </div>
    </div>
</body>
</html>