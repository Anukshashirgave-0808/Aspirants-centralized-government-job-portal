<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");


    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");



    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");

    // SQL Insert Query
    String sql = "INSERT INTO contact_us (name, email, subject, message) VALUES (?, ?, ?, ?)";

    try {
        PreparedStatement pstmt = con.prepareStatement(sql);

        // Set parameters
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, subject);
        pstmt.setString(4, message);

        // Execute the query
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
            out.println("<script>alert('Your message has been sent successfully!'); window.location='contact.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to send message. Please try again.'); window.location='contact.jsp';</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred. Please try again later.'); window.location='contact.jsp';</script>");
    } finally {
        if (con != null) {
            try {
            	con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
