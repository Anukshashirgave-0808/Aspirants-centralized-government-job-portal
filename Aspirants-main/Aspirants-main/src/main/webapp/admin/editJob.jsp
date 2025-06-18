<%@ page import="java.sql.*" %>
<%
    String jobIdStr = request.getParameter("job_id");
    if (jobIdStr == null || jobIdStr.isEmpty()) {
        response.sendRedirect("manageJobs.jsp");
        return;
    }

    int jobId = Integer.parseInt(jobIdStr);

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String job_title = "", description = "", location = "", salary = "", eligibility = "", last_date = "", age_limit = "", job_link = "", category = "";
    boolean has_10th = false, has_12th = false, has_diploma = false, has_graduation = false, has_postgraduation = false;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/asp", "root", "");
        ps = conn.prepareStatement("SELECT * FROM jobs WHERE job_id = ?");
        ps.setInt(1, jobId);
        rs = ps.executeQuery();

        if (rs.next()) {
            job_title = rs.getString("job_title");
            description = rs.getString("description");
            location = rs.getString("location");
            salary = rs.getString("salary");
            eligibility = rs.getString("eligibility");
            last_date = rs.getString("last_date");
            age_limit = rs.getString("age_limit");
            job_link = rs.getString("link");
            category = rs.getString("category");

            has_10th = rs.getBoolean("has_10th");
            has_12th = rs.getBoolean("has_12th");
            has_diploma = rs.getBoolean("has_diploma");
            has_graduation = rs.getBoolean("has_graduation");
            has_postgraduation = rs.getBoolean("has_post_graduation");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Job</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="mb-4">Edit Job</h2>
        <form action="updateJobHandler.jsp" method="post">
            <input type="hidden" name="job_id" value="<%= jobId %>">

            <div class="mb-3">
                <label>Job Title</label>
                <input type="text" name="job_title" class="form-control" value="<%= job_title %>" required>
            </div>

            <div class="mb-3">
                <label>Description</label>
                <textarea name="description" class="form-control" rows="4" required><%= description %></textarea>
            </div>

            <div class="mb-3">
                <label>Location</label>
                <input type="text" name="location" class="form-control" value="<%= location %>" required>
            </div>

            <div class="mb-3">
                <label>Salary</label>
                <input type="number" step="0.01" name="salary" class="form-control" value="<%= salary %>">
            </div>

            <div class="mb-3">
                <label>Education Required</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="has_10th" value="1" <%= has_10th ? "checked" : "" %>>
                    <label class="form-check-label">10th</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="has_12th" value="1" <%= has_12th ? "checked" : "" %>>
                    <label class="form-check-label">12th</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="has_diploma" value="1" <%= has_diploma ? "checked" : "" %>>
                    <label class="form-check-label">Diploma</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="has_graduation" value="1" <%= has_graduation ? "checked" : "" %>>
                    <label class="form-check-label">Graduation</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="checkbox" name="has_post_graduation" value="1" <%= has_postgraduation ? "checked" : "" %>>
                    <label class="form-check-label">Post Graduation</label>
                </div>
            </div>

            <div class="mb-3">
                <label>Eligibility</label>
                <select name="eligibility" class="form-control" required>
                    <option <%= "12th".equalsIgnoreCase(eligibility) ? "selected" : "" %>>12th</option>
                    <option <%= "Diploma".equalsIgnoreCase(eligibility) ? "selected" : "" %>>Diploma</option>
                    <option <%= "Graduation".equalsIgnoreCase(eligibility) ? "selected" : "" %>>Graduation</option>
                    <option <%= "Post-Graduation".equalsIgnoreCase(eligibility) ? "selected" : "" %>>Post-Graduation</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Last Date to Apply</label>
                <input type="date" name="last_date" class="form-control" value="<%= last_date %>" required>
            </div>

            <div class="mb-3">
                <label>Age Limit</label>
                <input type="number" name="age_limit" class="form-control" value="<%= age_limit %>">
            </div>

            <div class="mb-3">
                <label>Job Link</label>
                <input type="text" name="job_link" class="form-control" value="<%= job_link %>">
            </div>

            <div class="mb-3">
                <label>Category</label>
                <select name="category" class="form-control">
                    <option <%= "General".equalsIgnoreCase(category) ? "selected" : "" %>>General</option>
                    <option <%= "OBC".equalsIgnoreCase(category) ? "selected" : "" %>>OBC</option>
                    <option <%= "SC".equalsIgnoreCase(category) ? "selected" : "" %>>SC</option>
                    <option <%= "ST".equalsIgnoreCase(category) ? "selected" : "" %>>ST</option>
                    <option <%= "EWS".equalsIgnoreCase(category) ? "selected" : "" %>>EWS</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Update Job</button>
            <a href="manageJobs.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
