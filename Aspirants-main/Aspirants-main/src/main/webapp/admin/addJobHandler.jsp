<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/asp";
    String dbUser = "root";
    String dbPass = "";

    // Fetch form data
    String jobTitle = request.getParameter("job_title");
    String description = request.getParameter("description");
    String location = request.getParameter("location");
    String salary = request.getParameter("salary");
    String category = request.getParameter("category");
    String eligibility = request.getParameter("eligibility");
    String lastDate = request.getParameter("last_date");

    String has10th = request.getParameter("tenth") != null ? "1" : "0";
    String has12th = request.getParameter("twelfth") != null ? "1" : "0";
    String hasDiploma = request.getParameter("diploma") != null ? "1" : "0";
    String hasGraduation = request.getParameter("graduation") != null ? "1" : "0";
    String hasPostGraduation = request.getParameter("post_graduation") != null ? "1" : "0";

    String ageLimit = request.getParameter("age_limit");
    String link = request.getParameter("link");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String sql = "INSERT INTO jobs (job_title, description, location, salary, eligibility, last_date, has_10th, has_12th, has_diploma, has_graduation, has_post_graduation, age_limit, link, category) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, jobTitle);
        pstmt.setString(2, description);
        pstmt.setString(3, location);
        pstmt.setBigDecimal(4, (salary != null && !salary.isEmpty()) ? new java.math.BigDecimal(salary) : null);
        pstmt.setString(5, eligibility);
        pstmt.setDate(6, java.sql.Date.valueOf(lastDate));
        pstmt.setBoolean(7, has10th.equals("1"));
        pstmt.setBoolean(8, has12th.equals("1"));
        pstmt.setBoolean(9, hasDiploma.equals("1"));
        pstmt.setBoolean(10, hasGraduation.equals("1"));
        pstmt.setBoolean(11, hasPostGraduation.equals("1"));
        if (ageLimit != null && !ageLimit.isEmpty()) {
            pstmt.setInt(12, Integer.parseInt(ageLimit));
        } else {
            pstmt.setNull(12, java.sql.Types.INTEGER);
        }
        pstmt.setString(13, (link != null && !link.isEmpty()) ? link : null);
        pstmt.setString(14, category);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.sendRedirect("adminDashboard.jsp?success=Job added successfully");
        } else {
            response.sendRedirect("addJob.jsp?error=Failed to add job");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("addJob.jsp?error=Something went wrong");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
