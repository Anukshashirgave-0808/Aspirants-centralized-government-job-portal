<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);


    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("userId") == null) {
        response.sendRedirect("../login.jsp?error=Session Expired");
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
    <title>User Dashboard - Aspirants</title>
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
        <h2>Welcome, <%= firstName %>!</h2>
        <p>Your personalized dashboard to explore and apply for government jobs.</p>
    </div>

    <!-- Dashboard Main Content -->
    <div class="container">
        <div class="row">
            <!-- Left Section: Navigation -->
            <div class="col-md-4 mb-4">
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

            <!-- Right Section: Dynamic Content -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        Dashboard Insights
                    </div>
                    <div class="card-body">
                        <p>Welcome to your dashboard! Here, you can:</p>
                        <ul>
                            <li>View all available government jobs.</li>
                            <li>Check jobs you’re eligible for based on your profile.</li>
                            <li>Track the status of your applications.</li>
                            <li>Receive important notifications and updates.</li>
                        </ul>
                        <p>Start exploring now!</p>
                        <a href="all_jobs.jsp" class="btn btn-primary mt-3">Explore All Jobs</a>
                    </div>
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
