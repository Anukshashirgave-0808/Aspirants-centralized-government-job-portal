<%@ page import="java.sql.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/asp";
    String dbUser = "root";
    String dbPassword = "";

    // Fetching form data
    String adhar = request.getParameter("adhar");
    String firstName = request.getParameter("first_name");
    String middleName = request.getParameter("middle_name");
    String lastName = request.getParameter("last_name");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");
    String maritalStatus = request.getParameter("marital_status");
    String nationality = request.getParameter("nationality");
    String password = request.getParameter("password");
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

        String sql = "INSERT INTO users (adhar, first_name, middle_name, last_name, dob, gender, mobile, email, marital_status, nationality, password, category, tenth, twelfth, diploma, graduation, post_graduation) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, adhar);
        pstmt.setString(2, firstName);
        pstmt.setString(3, middleName);
        pstmt.setString(4, lastName);
        pstmt.setString(5, dob);
        pstmt.setString(6, gender);
        pstmt.setString(7, mobile);
        pstmt.setString(8, email);
        pstmt.setString(9, maritalStatus);
        pstmt.setString(10, nationality);
        pstmt.setString(11, password);
        pstmt.setString(12, category);
        pstmt.setBoolean(13, tenth);
        pstmt.setBoolean(14, twelfth);
        pstmt.setBoolean(15, diploma);
        pstmt.setBoolean(16, graduation);
        pstmt.setBoolean(17, postGraduation);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("signup_error.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("signup_error.jsp");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
