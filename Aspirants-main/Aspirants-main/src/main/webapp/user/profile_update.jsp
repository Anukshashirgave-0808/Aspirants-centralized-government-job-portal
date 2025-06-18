<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/asp";
    String dbUsername = "root";
    String dbPassword = "";

    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) session.getAttribute("userId");
    String category = "", adhar = "", firstName = "", middleName = "", lastName = "", dob = "", gender = "", mobile = "", email = "", maritalStatus = "", nationality = "",password="";
    boolean tenth = false, twelfth = false, diploma = false, graduation = false, postGraduation = false;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
        String query = "SELECT * FROM users WHERE user_id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            adhar = rs.getString("adhar");
            firstName = rs.getString("first_name");
            middleName = rs.getString("middle_name");
            lastName = rs.getString("last_name");
            dob = rs.getString("dob");
            gender = rs.getString("gender");
            mobile = rs.getString("mobile");
            email = rs.getString("email");
            maritalStatus = rs.getString("marital_status");
            nationality = rs.getString("nationality");
            password= rs.getString("password");
            category = rs.getString("category");
            tenth = rs.getBoolean("tenth");
            twelfth = rs.getBoolean("twelfth");
            diploma = rs.getBoolean("diploma");
            graduation = rs.getBoolean("graduation");
            postGraduation = rs.getBoolean("post_graduation");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <style>
    footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            margin-top: 40px;
            text-align: center;
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
    </style>
</head>
<body>

<!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="dashboard.jsp">Aspirants</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                   
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    
      <!-- Separator -->
    
    
    <div class="container mt-5">
        <h2 class="text-center">Update Profile</h2>
        <form action="update_profile_process.jsp" method="post" class="p-4 border rounded shadow-lg" style="max-width: 600px; margin: auto; background: #f8f9fa;">
    
    
    <div class="mb-3 d-flex gap-3">
        <div class="w-50">
            <label class="form-label">Adhar:</label>
            <input type="text" class="form-control border border-dark" name="adhar" value="<%= adhar %>" readonly>
        </div>
        <div class="w-50">
            <label class="form-label">Date of Birth:</label>
            <input type="date" class="form-control border border-dark" name="dob" value="<%= dob %>" required>
        </div>
    </div>
    
    <div class="mb-3 d-flex gap-3">
        <div class="w-33">
            <label class="form-label">First Name:</label>
            <input type="text" class="form-control border border-dark" name="first_name" value="<%= firstName %>" required>
        </div>
        <div class="w-33">
            <label class="form-label">Middle Name:</label>
            <input type="text" class="form-control border border-dark" name="middle_name" value="<%= middleName %>">
        </div>
        <div class="w-33">
            <label class="form-label">Last Name:</label>
            <input type="text" class="form-control border border-dark" name="last_name" value="<%= lastName %>" required>
        </div>
    </div>
    
    <div class="mb-3 d-flex gap-3">
        <div class="w-50">
            <label class="form-label">Gender:</label>
            <select class="form-select border border-dark" name="gender" required>
                <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
                <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
                <option value="Other" <%= gender.equals("Other") ? "selected" : "" %>>Other</option>
            </select>
        </div>
        <div class="w-50">
            <label class="form-label">Category:</label>
            <select class="form-select border border-dark" name="category" required>
                <option value="General" <%= category.equals("General") ? "selected" : "" %>>General</option>
                <option value="OBC" <%= category.equals("OBC") ? "selected" : "" %>>OBC</option>
                <option value="SC" <%= category.equals("SC") ? "selected" : "" %>>SC</option>
                <option value="ST" <%= category.equals("ST") ? "selected" : "" %>>ST</option>
                <option value="EWS" <%= category.equals("EWS") ? "selected" : "" %>>EWS</option>
            </select>
        </div>
    </div>
    
    <div class="mb-3 d-flex gap-3">
        <div class="w-50">
            <label class="form-label">Mobile:</label>
            <input type="text" class="form-control border border-dark" name="mobile" value="<%= mobile %>" required>
        </div>
        <div class="w-50">
            <label class="form-label">Email:</label>
            <input type="email" class="form-control border border-dark" name="email" value="<%= email %>" required>
        </div>
    </div>
    
    <div class="mb-3 d-flex gap-3">
        <div class="w-50">
            <label class="form-label">Marital Status:</label>
            <select class="form-select border border-dark" name="marital_status" required>
                <option value="Single" <%= maritalStatus.equals("Single") ? "selected" : "" %>>Single</option>
                <option value="Married" <%= maritalStatus.equals("Married") ? "selected" : "" %>>Married</option>
            </select>
        </div>
        <div class="w-50">
            <label class="form-label">Nationality:</label>
            <input type="text" class="form-control border border-dark" name="nationality" value="<%= nationality %>" required>
        </div>
    </div>
    
    <div class="mb-3">
        <label class="form-label">Password:</label>
        <input type="password" class="form-control border border-dark w-100" name="password" value="<%= password %>"  required>
    </div>
    
    <div class="mb-3">
        <label class="form-label">Qualifications:</label><br>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="tenth" <%= tenth ? "checked" : "" %>> 10th
        </div>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="twelfth" <%= twelfth ? "checked" : "" %>> 12th
        </div>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="diploma" <%= diploma ? "checked" : "" %>> Diploma
        </div>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="graduation" <%= graduation ? "checked" : "" %>> Graduation
        </div>
        <div class="form-check form-check-inline">
            <input type="checkbox" class="form-check-input" name="post_graduation" <%= postGraduation ? "checked" : "" %>> Post Graduation
        </div>
    </div>
    
    <div class="text-center">
        <button type="submit" class="btn btn-primary w-100">Update Profile</button>
    </div>
</form>

        

    </div>
    <footer>
        <p>&copy; 2025 Aspirants | Your Gateway to Government Jobs</p>
    </footer>
</body>
</html>
