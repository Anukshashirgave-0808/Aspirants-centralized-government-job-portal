<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.sql.*" %>

<%
    // Prevent page caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Session validation
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("userId") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String firstName = (String) session1.getAttribute("first_name");
    int userId = (Integer) session1.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eligible Jobs - Aspirants</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #007bff !important;
            color: white;
        }
        .navbar-brand, .nav-link {
            color: white !important;
            font-weight: 600;
        }
        .navbar-nav .nav-link:hover {
            color: #ffc107 !important;
        }
        .separator {
            width: 100%;
            height: 5px;
            background-color: white;
        }
        .dashboard-header {
            background-color: #007bff;
            color: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .dashboard-header h2 {
            margin: 0;
            font-weight: 700;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .list-group-item {
            border: none;
            padding: 15px;
            font-size: 16px;
            font-weight: 500;
        }
        .list-group-item:hover {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            margin-top: 40px;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="../index.jsp">Aspirants</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="profile_update.jsp">Update Profile</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Separator -->
    <div class="separator"></div>

    <!-- Dashboard Header -->
    <div class="dashboard-header">
        <h3>Find job opportunities based on your education qualifications.</h3>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <!-- Left Section: Navigation -->
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header bg-primary text-white text-center">
                        Quick Links
                    </div>
                    <div class="list-group list-group-flush">
                        <a href="all_jobs.jsp" class="list-group-item">All Jobs</a>
                        <a href="eligible_jobs.jsp" class="list-group-item">Eligible Jobs</a>                        
                    </div>
                </div>
            </div>

            <!-- Right Section: Jobs Display -->
            <div class="col-md-9">
                <div class="row">
                    <%
                        Connection con = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");

                            // Get user's educational details and category
                            String userQuery = "SELECT tenth, twelfth, diploma, graduation, post_graduation, category FROM users WHERE user_id = ?";
                            PreparedStatement userStmt = con.prepareStatement(userQuery);
                            userStmt.setInt(1, userId);
                            ResultSet userRs = userStmt.executeQuery();

                            boolean has10th = false, has12th = false, hasDiploma = false, hasGraduation = false, hasPostGraduation = false;
                            String userCategory = "General";

                            if (userRs.next()) {
                                has10th = userRs.getBoolean("tenth");
                                has12th = userRs.getBoolean("twelfth");
                                hasDiploma = userRs.getBoolean("diploma");
                                hasGraduation = userRs.getBoolean("graduation");
                                hasPostGraduation = userRs.getBoolean("post_graduation");
                                userCategory = userRs.getString("category");
                            }

                            userRs.close();
                            userStmt.close();

                            // Fetch jobs matching user qualifications and category
                            String query = "SELECT * FROM jobs WHERE " +
                                "(has_10th = 0 OR has_10th = ?) AND " +
                                "(has_12th = 0 OR has_12th = ?) AND " +
                                "(has_diploma = 0 OR has_diploma = ?) AND " +
                                "(has_graduation = 0 OR has_graduation = ?) AND " +
                                "(has_post_graduation = 0 OR has_post_graduation = ?) AND " +
                                "(category = ? OR category = 'General') " +
                                "LIMIT 20";

                            stmt = con.prepareStatement(query);
                            stmt.setBoolean(1, has10th);
                            stmt.setBoolean(2, has12th);
                            stmt.setBoolean(3, hasDiploma);
                            stmt.setBoolean(4, hasGraduation);
                            stmt.setBoolean(5, hasPostGraduation);
                            stmt.setString(6, userCategory);

                            rs = stmt.executeQuery();

                            while (rs.next()) {
                    %>
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title"><%= rs.getString("job_title") %></h5>
                                    <p class="card-text">Eligibility: <%= rs.getString("eligibility") %> | Last Date: <%= rs.getString("last_date") %></p>
                                    <a href="<%= rs.getString("link") != null ? rs.getString("link") : "#" %>" class="btn btn-primary" target="_blank">Apply Now</a>
                                </div>
                            </div>
                        </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (con != null) con.close();
                            } catch (SQLException ex) {
                                ex.printStackTrace();
                            }
                        }
                    %>

                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Aspirants | Your Gateway to Government Jobs</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
