<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jobs - Aspirants</title>
    <!-- Include Bootstrap for styling -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Aspirants</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="jobs.jsp">Jobs</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item"><a class="btn btn-primary" href="login.jsp">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Section -->
    <header class="bg-primary text-white text-center py-4">
        <div class="container">
            <h3>Jobs</h3>
            
             <p class="lead">Login to view all jobs</p>
            <form method="get" action="jobs.jsp" class="d-flex justify-content-center mt-3">
                <input type="text" class="form-control w-50 me-2" name="search_query" placeholder="Search by Job Title or Eligibility">
                <button class="btn btn-secondary" type="submit">Search</button>
            </form>
        </div>
    </header>

    <!-- Jobs Section -->
    <section id="jobs" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Available Jobs</h2>
            <div class="row">
                <% 
                    // Get search query parameter
                    String searchQuery = request.getParameter("search_query");

                    Connection con = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");

                        // Default query to fetch first 12 jobs
                        String query = "SELECT * FROM jobs LIMIT 12";

                        // Modify query if search query is provided
                        if (searchQuery != null && !searchQuery.isEmpty()) {
                            query = "SELECT * FROM jobs WHERE job_title LIKE ? OR eligibility LIKE ? LIMIT 12";
                            stmt = con.prepareStatement(query);
                            stmt.setString(1, "%" + searchQuery + "%");
                            stmt.setString(2, "%" + searchQuery + "%");
                        } else {
                            stmt = con.prepareStatement(query);
                        }

                        rs = stmt.executeQuery();

                        // Display job results dynamically
                        while (rs.next()) {
                %>
                <div class="col-md-4 mb-3">
                    <div class="card h-100">
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
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3">
        <p>&copy; 2025 Aspirants. All Rights Reserved.</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
