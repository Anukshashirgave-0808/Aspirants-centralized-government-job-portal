<%@ page import="java.sql.*" %>
<%
    String idStr = request.getParameter("job_id");

    if (idStr == null || idStr.isEmpty()) {
        response.sendRedirect("manageJobs.jsp");
        return;
    }

    int jobId = Integer.parseInt(idStr);
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");
        ps = conn.prepareStatement("DELETE FROM jobs WHERE job_id = ?");
        ps.setInt(1, jobId);
        int rowsDeleted = ps.executeUpdate();

        if (rowsDeleted > 0) {
            System.out.println("Job deleted successfully.");
        } else {
            System.out.println("No job found with ID: " + jobId);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("manageJobs.jsp");
%>
