<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/asp";
    String user = "root";
    String password = "";

    // Get form parameters
    int userId = Integer.parseInt(request.getParameter("user_id"));
    String firstName = request.getParameter("first_name");
    String middleName = request.getParameter("middle_name");
    String lastName = request.getParameter("last_name");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");
    String maritalStatus = request.getParameter("marital_status");
    String nationality = request.getParameter("nationality");
    String category = request.getParameter("category");
    boolean tenth = request.getParameter("tenth") != null;
    boolean twelfth = request.getParameter("twelfth") != null;
    boolean diploma = request.getParameter("diploma") != null;
    boolean graduation = request.getParameter("graduation") != null;
    boolean postGraduation = request.getParameter("post_graduation") != null;

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load MySQL driver
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Update user query
        String sql = "UPDATE users SET first_name=?, middle_name=?, last_name=?, dob=?, gender=?, mobile=?, email=?, marital_status=?, nationality=?, category=?, tenth=?, twelfth=?, diploma=?, graduation=?, post_graduation=? WHERE user_id=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, firstName);
        stmt.setString(2, middleName);
        stmt.setString(3, lastName);
        stmt.setString(4, dob);
        stmt.setString(5, gender);
        stmt.setString(6, mobile);
        stmt.setString(7, email);
        stmt.setString(8, maritalStatus);
        stmt.setString(9, nationality);
        stmt.setString(10, category);
        stmt.setBoolean(11, tenth);
        stmt.setBoolean(12, twelfth);
        stmt.setBoolean(13, diploma);
        stmt.setBoolean(14, graduation);
        stmt.setBoolean(15, postGraduation);
        stmt.setInt(16, userId);

        // Execute update
        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("manageUsers.jsp?success=1");
        } else {
            response.sendRedirect("editUser.jsp?user_id=" + userId + "&error=1");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("editUser.jsp?user_id=" + userId + "&error=1");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
