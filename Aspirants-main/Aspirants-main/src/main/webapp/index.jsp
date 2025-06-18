<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aspirants - Find Your Dream Government Job</title>
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
                    <li class="nav-item"><a class="nav-link" href="jobs.jsp">Jobs</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item"><a class="btn btn-primary" href="login.jsp">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="bg-primary text-white text-center py-5">
        <div class="container">
            <h1>Find Your Dream Government Job</h1>
            <p class="lead">Personalized job recommendations based on your profile</p>
            <!-- Search Form with a Single Field -->
            <form method="get" action="index.jsp" class="d-flex justify-content-center mt-4">
                <input type="text" class="form-control w-50 me-2" name="search_query" placeholder="Search by Job Title or Eligibility">
                <button class="btn btn-secondary" type="submit">Search</button>
            </form>
        </div>
    </header>

    <!-- Featured Jobs Section -->
    <section id="jobs" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Featured Jobs</h2>
            <div class="row">
                <% 
                    // Get search query parameter
                    String searchQuery = request.getParameter("search_query");

                    Connection con = null;
                    Statement stmt1 = null;
                    ResultSet rs1 = null;
                    int jobCount = 0; // Track the number of jobs displayed
                    boolean showViewAll = false; // Flag to control "View All" button visibility

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");

                        String query;
                        if (searchQuery != null && !searchQuery.isEmpty()) {
                            // Search query provided
                            query = "SELECT * FROM jobs WHERE job_title LIKE ? OR eligibility LIKE ? LIMIT 6";
                            PreparedStatement stmt = con.prepareStatement(query);
                            stmt.setString(1, "%" + searchQuery + "%");
                            stmt.setString(2, "%" + searchQuery + "%");

                            rs1 = stmt.executeQuery();
                            
                            while (rs1.next()) {
                                jobCount++;
                %>
                <div class="col-md-4 mb-3">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><%= rs1.getString("job_title") %></h5>
                            <p class="card-text">Eligibility: <%= rs1.getString("eligibility") %> | Last Date: <%= rs1.getString("last_date") %></p>
                            <a href="<%= rs1.getString("link") != null ? rs1.getString("link") : "#" %>" class="btn btn-primary" target="_blank">Apply Now</a>
                        </div>
                    </div>
                </div>
                <% 
                            }
                            
                            // Show "View All" if more than 6 results are found
                            if (jobCount == 6) {
                                showViewAll = true;
                            }
                        } else {
                            // No search query - show featured jobs
                            query = "SELECT * FROM jobs LIMIT 6";
                            stmt1 = con.createStatement();
                            rs1 = stmt1.executeQuery(query);
                            
                            while (rs1.next()) {
                                jobCount++;
                %>
                <div class="col-md-4 mb-3">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><%= rs1.getString("job_title") %></h5>
                            <p class="card-text">Eligibility: <%= rs1.getString("eligibility") %> | Last Date: <%= rs1.getString("last_date") %></p>
                            <a href="#" class="btn btn-primary">Apply Now</a>
                        </div>
                    </div>
                </div>
                <% 
                            }
                            // Always show the "View All" button for initial page load
                            showViewAll = true;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs1 != null) rs1.close();
                            if (stmt1 != null) stmt1.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>

            <!-- View All button logic -->
            <% if (showViewAll) { %>
            <div class="text-center">
                <a href="<%= (searchQuery != null && !searchQuery.isEmpty()) ? "job.jsp?search_query=" + searchQuery : "jobs.jsp" %>" class="btn btn-primary">
                    View All
                </a>
            </div>
            <% } %>
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
