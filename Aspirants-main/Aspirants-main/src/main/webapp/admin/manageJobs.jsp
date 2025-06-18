<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    // Check if admin is logged in
    String adminUsername = (String) session.getAttribute("adminUser");
    if (adminUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM jobs");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Jobs - Aspirants</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { width: 250px; height: 100vh; background: #202123; color: white; position: fixed; padding: 20px; }
        .sidebar a { color: white; text-decoration: none; display: block; padding: 10px; border-radius: 5px; }
        .sidebar a:hover { background: #343541; }
        .content { margin-left: 260px; padding: 20px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }
    </style>
</head>
<body>
    <div class="sidebar">
        <h4>Aspirants Admin</h4>
        <hr>
        <a href="adminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="manageJobs.jsp"><i class="fas fa-briefcase"></i> Manage Jobs</a>
        <a href="manageUsers.jsp"><i class="fas fa-users"></i> Manage Users</a>
        <a href="addJob.jsp"><i class="fas fa-users"></i> Add Jobs</a>
        <a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    <div class="content">
        <h2 class="mb-4">Manage Jobs</h2>
        <div class="table-container">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Location</th>
                        <th>Salary</th>
                        <th>Category</th>
                        <th>Last Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getInt("job_id") %></td>
                        <td><%= rs.getString("job_title") %></td>
                        <td><%= rs.getString("location") %></td>
                        <td><%= rs.getBigDecimal("salary") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getDate("last_date") %></td>
                        <td>
                            <a href="editJob.jsp?job_id=<%= rs.getInt("job_id") %>" class="btn btn-warning btn-sm">Edit</a>


                            <a href="deleteJob.jsp?id=<%= rs.getInt("job_id") %>" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

<%
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
%>