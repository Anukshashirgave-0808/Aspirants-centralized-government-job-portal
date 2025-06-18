<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.security.MessageDigest, java.security.NoSuchAlgorithmException, javax.servlet.http.*, javax.servlet.*" %>

<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/asp";
    String dbUsername = "root";
    String dbPassword = "";

    // Get email and password from login form
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

        // Query to check email existence
        String query = "SELECT user_id, first_name, password FROM users WHERE email = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        rs = stmt.executeQuery();

        if (rs.next()) {
            String storedPassword = rs.getString("password");
            
            // Compare entered password with stored password
            if (password.equals(storedPassword)) {  // ⚠️ If using hashing, replace this with proper hashing check
                
                // Create session and store user info
                HttpSession session1 = request.getSession();
                session1.setAttribute("userId", rs.getInt("user_id"));
                session1.setAttribute("email", email);
                session1.setAttribute("first_name", rs.getString("first_name"));
                
                // Redirect to user dashboard
                response.sendRedirect("user/dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } else {
            response.sendRedirect("login.jsp?error=notfound");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp?error=server");
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>