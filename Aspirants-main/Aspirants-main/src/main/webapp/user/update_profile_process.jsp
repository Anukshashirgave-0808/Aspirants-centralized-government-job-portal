<%@ page import="java.sql.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/asp";
    String dbUser = "root";
    String dbPassword = "";

    // Fetch form data and handle null values safely
    String adhar = request.getParameter("adhar");
    String firstName = request.getParameter("first_name") ;
    String middleName = request.getParameter("middle_name") ;
    String lastName = request.getParameter("last_name") ;
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");
    String maritalStatus = request.getParameter("marital_status");
    String nationality = request.getParameter("nationality");
    String category = request.getParameter("category");

    // Fetching boolean values for education levels (checkboxes)
    boolean tenth = request.getParameter("tenth") != null;
    boolean twelfth = request.getParameter("twelfth") != null;
    boolean diploma = request.getParameter("diploma") != null;
    boolean graduation = request.getParameter("graduation") != null;
    boolean postGraduation = request.getParameter("post_graduation") != null;

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "UPDATE users SET first_name = ?, middle_name = ?, last_name = ?, dob = ?, gender = ?, mobile = ?, email = ?, marital_status = ?, nationality = ?, category = ?, tenth = ?, twelfth = ?, diploma = ?, graduation = ?, post_graduation = ? WHERE adhar = ?";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, firstName);
        pstmt.setString(2, middleName);
        pstmt.setString(3, lastName);
        pstmt.setString(4, dob);
        pstmt.setString(5, gender);
        pstmt.setString(6, mobile);
        pstmt.setString(7, email);
        pstmt.setString(8, maritalStatus);
        pstmt.setString(9, nationality);
        pstmt.setString(10, category);
        pstmt.setBoolean(11, tenth);
        pstmt.setBoolean(12, twelfth);
        pstmt.setBoolean(13, diploma);
        pstmt.setBoolean(14, graduation);
        pstmt.setBoolean(15, postGraduation);
        pstmt.setString(16, adhar);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
        	
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("profile.jsp?update=failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("profile.jsp?update=error");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
