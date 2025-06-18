<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    
    String adminUsername = (String) session.getAttribute("adminUser");
    if (adminUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String userId = request.getParameter("user_id");
    String firstName = "", lastName = "", email = "", mobile = "", gender = "", dob = "", category = "";
    
    if (userId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE user_id = ?");
            ps.setInt(1, Integer.parseInt(userId));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                firstName = rs.getString("first_name");
                lastName = rs.getString("last_name");
                email = rs.getString("email");
                mobile = rs.getString("mobile");
                gender = rs.getString("gender");
                dob = rs.getString("dob");
                category = rs.getString("category");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - Aspirants</title>
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
        <h4>Aspirants Admin</h4>
        <hr>
        <a href="adminDashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
        <a href="manageJobs.jsp"><i class="fas fa-briefcase"></i> Manage Jobs</a>
        <a href="manageUsers.jsp"><i class="fas fa-users"></i> Manage Users</a>
        <a href="logout.jsp" class="text-danger"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    <div class="content">
        <h2 class="mb-4">Edit User</h2>
        <div class="card p-4">
            <form action="updateUser.jsp" method="post">
                <input type="hidden" name="user_id" value="<%= userId %>">
                <div class="mb-3">
                    <label>First Name</label>
                    <input type="text" name="first_name" class="form-control" value="<%= firstName %>" required>
                </div>
                <div class="mb-3">
                    <label>Last Name</label>
                    <input type="text" name="last_name" class="form-control" value="<%= lastName %>" required>
                </div>
                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control" value="<%= email %>" required>
                </div>
                <div class="mb-3">
                    <label>Mobile</label>
                    <input type="text" name="mobile" class="form-control" value="<%= mobile %>" required>
                </div>
                <div class="mb-3">
                    <label>Gender</label>
                    <select name="gender" class="form-control">
                        <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= gender.equals("Other") ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Date of Birth</label>
                    <input type="date" name="dob" class="form-control" value="<%= dob %>" required>
                </div>
                <div class="mb-3">
                    <label>Category</label>
                    <select name="category" class="form-control">
                        <option value="General" <%= category.equals("General") ? "selected" : "" %>>General</option>
                        <option value="OBC" <%= category.equals("OBC") ? "selected" : "" %>>OBC</option>
                        <option value="SC" <%= category.equals("SC") ? "selected" : "" %>>SC</option>
                        <option value="ST" <%= category.equals("ST") ? "selected" : "" %>>ST</option>
                        <option value="EWS" <%= category.equals("EWS") ? "selected" : "" %>>EWS</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>
</body>
</html>
