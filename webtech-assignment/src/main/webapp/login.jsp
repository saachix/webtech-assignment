<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Student" %>
<%
    Student loggedInStudent = (Student) session.getAttribute("loggedInStudent");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Campus Collab</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <style>
        .form-section { padding: 70px 0; background: var(--light-blue); min-height: calc(100vh - 68px); }
        .form-box { max-width: 450px; margin: 0 auto; padding: 35px; background: white; border: 1px solid var(--line); border-radius: 10px; box-shadow: var(--shadow); }
        .form-box h1 { margin-bottom: 5px; color: var(--navy); text-align: center; }
        .form-subtitle { margin-bottom: 28px; color: var(--muted); font-size: 0.85rem; text-align: center; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 6px; color: var(--navy); font-size: 0.82rem; font-weight: 700; }
        .form-group input { width: 100%; padding: 11px 12px; border: 1px solid var(--line); border-radius: 7px; font-family: inherit; font-size: 0.85rem; color: var(--text); background: white; box-sizing: border-box; }
        .form-group input:focus { outline: none; border-color: var(--blue); }
        .form-actions { margin-top: 25px; }
        .form-actions .btn { width: 100%; justify-content: center; }
        .form-footer { margin-top: 20px; text-align: center; font-size: 0.82rem; color: var(--muted); }
        .form-footer a { color: var(--blue); font-weight: 700; text-decoration: none; }
        .error-message { background: #fff0f3; border: 1px solid #f2c7d2; color: #a65368; padding: 12px 15px; border-radius: 7px; font-size: 0.82rem; font-weight: 700; margin-bottom: 20px; }
        .success-message { background: var(--green-bg); border: 1px solid #b8dcc8; color: #4f896b; padding: 12px 15px; border-radius: 7px; font-size: 0.82rem; font-weight: 700; margin-bottom: 20px; }
        
        body.dark-mode .form-box { background: #182a33; border-color: var(--line); }
        body.dark-mode .form-group input { background: #101c22; color: #dcecf2; border-color: #3a5662; }
    </style>
</head>
<body>
<header class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="logo"><span class="logo-mark">CC</span><span class="logo-text">Campus Collab</span></a>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/" class="nav-link">Home</a>
            <a href="${pageContext.request.contextPath}/collaborations" class="nav-link">Browse Collaborations</a>
        </nav>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a>
            <button type="button" id="themeToggle" class="theme-toggle" aria-label="Toggle dark mode">☾</button>
        </div>
        <button class="mobile-menu-button" aria-label="Open menu">☰</button>
    </div>
</header>
<main>
<section class="form-section">
    <div class="container">
        <div class="form-box">
            <h1>Welcome Back</h1>
            <p class="form-subtitle">Login to access your profile and collaborations.</p>
            
            <% if ("registered".equals(message)) { %>
            <div class="success-message">&#10003; Registration successful! Please log in.</div>
            <% } %>
            
            <% if (errorMessage != null) { %>
            <div class="error-message">&#9888; <%= errorMessage %></div>
            <% } %>
            
            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Login →</button>
                </div>
            </form>
            <div class="form-footer">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
            </div>
        </div>
    </div>
</section>
</main>
<script src="${pageContext.request.contextPath}/theme.js"></script>
</body>
</html>
