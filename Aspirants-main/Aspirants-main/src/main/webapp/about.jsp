<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Aspirants</title>
    <!-- Include Bootstrap for styling -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <link rel="stylesheet" href="static/css/styles.css">
    <style>
        /* Header Styling */
        h2.section-header {
            background: linear-gradient(90deg, #007bff, #00c6ff);
            color: white;
            padding: 15px;
            border-radius: 8px;
            font-size: 2rem;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Box Styling */
        .info-box {
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        /* Text Styling */
        .info-box h3 {
            color: #007bff;
            font-weight: bold;
            margin-bottom: 15px;
        }

        /* Image Styling */
        .about-image {
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Aspirants</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="jobs.jsp">Jobs</a></li>
                    <li class="nav-item"><a class="nav-link active" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    <li class="nav-item"><a class="btn btn-primary" href="login.jsp">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- About Us Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <!-- Header -->
            <h2 class="text-center section-header">About Us</h2>
            <p class="text-center mb-5">We are dedicated to connecting aspirants with the best government job opportunities that match their skills and interests.</p>

            <div class="row align-items-center">
                <!-- Image -->
                <div class="col-md-6">
                    <img src="img/group1.jpg" class="img-fluid about-image" alt="About Us">
                </div>

                <!-- Text Content -->
                <div class="col-md-6">
                    <!-- Our Mission -->
                    <div class="info-box">
                        <h3>Our Mission</h3>
                        <p>At Aspirants, our mission is to streamline the job-seeking process for government job aspirants. By using advanced algorithms, we ensure personalized recommendations for every user.</p>
                    </div>

                    <!-- Why Choose Us -->
                    <!-- Why Choose Us -->
<div class="info-box">
    <h3>Why Choose Us?</h3>
    <ul class="list-unstyled">
        <li><i class="bi bi-check-circle-fill text-success me-2"></i>Accurate job matching based on your profile.</li>
        <li><i class="bi bi-check-circle-fill text-success me-2"></i>Comprehensive database of government jobs.</li>
        <li><i class="bi bi-check-circle-fill text-success me-2"></i>User-friendly interface for easy navigation.</li>
        <li><i class="bi bi-check-circle-fill text-success me-2"></i>Dedicated support to guide you through the process.</li>
    </ul>
</div>

                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3">
        <p>&copy; 2025 Aspirants. All Rights Reserved.</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
