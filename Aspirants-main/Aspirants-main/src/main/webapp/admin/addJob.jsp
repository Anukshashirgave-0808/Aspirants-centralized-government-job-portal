<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    String adminUsername = (String) session.getAttribute("adminUser");
    if (adminUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Job - Aspirants</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 bg-dark text-white vh-100 p-3">
                <h4>Aspirants Admin</h4>
                <hr>
                <a href="adminDashboard.jsp" class="d-block text-white p-2">Dashboard</a>
                <a href="manageJobs.jsp" class="d-block text-white p-2">Manage Jobs</a>
                <a href="manageUsers.jsp" class="d-block text-white p-2">Manage Users</a>
                <a href="addJob.jsp" class="d-block text-white p-2">Add Job</a>
                <a href="logout.jsp" class="d-block text-danger p-2">Logout</a>
            </div>

            <!-- Content -->
            <div class="col-md-10 p-4">
                <h2>Add Job</h2>
                <form action="addJobHandler.jsp" method="POST" style="border: 2px solid #007bff; border-radius: 10px; padding: 30px; background-color: #f8f9fa; box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);">
    <div class="row">
        <!-- Left Column -->
        <div class="col-md-6">
            <div class="mb-3">
                <label class="form-label">Job Title</label>
                <input type="text" name="job_title" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="4" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Location</label>
                <input type="text" name="location" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Salary</label>
                <input type="number" name="salary" class="form-control">
            </div>
            <div class="mb-3">
    <label class="form-label d-block">Education Requirements</label>
    <div class="d-flex flex-wrap gap-3">
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="tenth" id="tenth">
            <label class="form-check-label" for="tenth">10th</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="twelfth" id="twelfth">
            <label class="form-check-label" for="twelfth">12th</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="diploma" id="diploma">
            <label class="form-check-label" for="diploma">Diploma</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="graduation" id="graduation">
            <label class="form-check-label" for="graduation">Graduation</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" name="post_graduation" id="post_graduation">
            <label class="form-check-label" for="post_graduation">Post-Graduation</label>
        </div>
    </div>
</div>

        </div>

        <!-- Right Column -->
        <div class="col-md-6">
            <div class="mb-3">
                <label class="form-label">Eligibility</label>
                <select name="eligibility" class="form-control" required>
                <option value="10th">10th</option>
                    <option value="12th">12th</option>
                    <option value="Diploma">Diploma</option>
                    <option value="Graduation">Graduation</option>
                    <option value="Post-Graduation">Post-Graduation</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Last Date</label>
                <input type="date" name="last_date" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Age Limit</label>
                <input type="number" name="age_limit" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Job Link</label>
                <input type="url" name="link" class="form-control">
            </div>
            <div class="col-md-6 mb-3">
                                    <label class="form-label">Category</label>
                                    <select name="category" class="form-control" required>
                                        <option value="General">General</option>
                                        <option value="OBC">OBC</option>
                                        <option value="SC">SC</option>
                                        <option value="ST">ST</option>
                                        <option value="EWS">EWS</option>
                                    </select>
                                </div>
        </div>
    </div>

    <div class="text-center mt-4">
        <button type="submit" class="btn btn-primary px-5">Add Job</button>
    </div>
</form>
                

            </div>
        </div>
    </div>
</body>
</html>