<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Student" %>
<%@ page import="model.StudentProfile" %>

<%
    Student student = (Student) request.getAttribute("student");
    StudentProfile profile = (StudentProfile) request.getAttribute("profile");
    String message = request.getParameter("message");

    // Split skills string into individual tags for display
    String[] skillTags = new String[0];
    if (profile != null && profile.getSkills() != null
            && !profile.getSkills().trim().isEmpty()) {
        skillTags = profile.getSkills().split(",");
    }

    boolean hasPortfolioLink = profile != null
            && profile.getPortfolioLink() != null
            && !profile.getPortfolioLink().trim().isEmpty();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= student.getName() %> — Student Profile — Campus Collab</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/style.css">

    <style>

        /* -------------------------
           PROFILE PAGE
           ------------------------- */

        .profile-page {
            padding: 65px 0;
            background: #f7fbfd;
            min-height: calc(100vh - 68px);
        }

        .profile-container {
            max-width: 720px;
            margin: 0 auto;
        }

        .profile-card {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 38px;
            box-shadow: var(--shadow);
        }

        /* ---- header ---- */

        .profile-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 30px;
            padding-bottom: 24px;
            border-bottom: 1px solid var(--line);
            flex-wrap: wrap;
        }

        .profile-avatar {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            background: var(--baby-blue);
            border: 2px solid #a0d4e9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: var(--dark-blue);
            font-weight: 800;
            flex-shrink: 0;
        }

        .profile-identity {
            flex: 1;
        }

        .profile-name {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--navy);
            letter-spacing: -0.025em;
            margin-bottom: 4px;
        }

        .profile-email {
            font-size: 0.82rem;
            color: var(--muted);
        }

        .profile-id-badge {
            display: inline-block;
            padding: 4px 9px;
            background: var(--light-blue);
            border: 1px solid #cfe8f1;
            border-radius: 5px;
            color: var(--dark-blue);
            font-size: 0.7rem;
            font-weight: 700;
            margin-top: 6px;
        }

        /* ---- sections ---- */

        .profile-section {
            margin-bottom: 26px;
        }

        .profile-section:last-child {
            margin-bottom: 0;
        }

        .profile-section-label {
            font-size: 0.7rem;
            font-weight: 800;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.07em;
            margin-bottom: 10px;
        }

        .profile-bio {
            color: var(--text);
            font-size: 0.9rem;
            line-height: 1.7;
        }

        /* ---- skill chips ---- */

        .skill-chips {
            display: flex;
            flex-wrap: wrap;
            gap: 7px;
        }

        .skill-chip {
            display: inline-block;
            padding: 5px 11px;
            background: var(--light-blue);
            border: 1px solid #cfe8f1;
            border-radius: 20px;
            color: var(--dark-blue);
            font-size: 0.76rem;
            font-weight: 700;
        }

        /* ---- portfolio link ---- */

        .portfolio-link-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 9px 16px;
            background: white;
            border: 1px solid #a8d3e4;
            border-radius: 7px;
            color: var(--dark-blue);
            font-size: 0.82rem;
            font-weight: 700;
            text-decoration: none;
            transition: 0.2s ease;
            word-break: break-all;
        }

        .portfolio-link-btn:hover {
            background: var(--light-blue);
            transform: translateY(-1px);
        }

        .no-portfolio-note {
            font-size: 0.84rem;
            color: var(--muted);
            font-style: italic;
        }

        /* ---- actions ---- */

        .profile-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 28px;
            padding-top: 22px;
            border-top: 1px solid var(--line);
        }

        /* ---- success message ---- */

        .message {
            margin-bottom: 20px;
            padding: 12px 16px;
            border-radius: 7px;
            font-size: 0.82rem;
            font-weight: 700;
        }

        .success-message {
            background: var(--green-bg);
            border: 1px solid #b8dcc8;
            color: #4f896b;
        }

        /* ---- no profile state ---- */

        .no-profile-box {
            text-align: center;
            padding: 40px 24px;
        }

        .no-profile-box h3 {
            color: var(--navy);
            margin-bottom: 8px;
        }

        .no-profile-box p {
            color: var(--muted);
            font-size: 0.84rem;
            margin-bottom: 20px;
        }

        /* ---- dark mode ---- */

        body.dark-mode .profile-page {
            background: #101c22;
        }

        body.dark-mode .profile-card {
            background: #182a33;
            border-color: var(--line);
        }

        body.dark-mode .profile-avatar {
            background: #1d3845;
            border-color: #31596b;
            color: var(--dark-blue);
        }

        body.dark-mode .skill-chip {
            background: #1d3845;
            border-color: #31596b;
            color: #8bd0ef;
        }

        body.dark-mode .portfolio-link-btn {
            background: #1b303a;
            border-color: #416574;
            color: #8bd0ef;
        }

        body.dark-mode .portfolio-link-btn:hover {
            background: #243e49;
        }

        body.dark-mode .profile-header {
            border-color: var(--line);
        }

        body.dark-mode .profile-actions {
            border-color: var(--line);
        }

        /* ---- mobile ---- */

        @media (max-width: 600px) {

            .profile-page {
                padding: 45px 0;
            }

            .profile-card {
                padding: 24px;
            }

            .profile-header {
                flex-direction: column;
            }
        }

    </style>

</head>

<body>

<!-- NAVBAR -->
<header class="navbar">

    <div class="navbar-container">

        <a href="${pageContext.request.contextPath}/" class="logo">
            <span class="logo-mark">CC</span>
            <span class="logo-text">Campus Collab</span>
        </a>

        <nav class="nav-links">

            <a href="${pageContext.request.contextPath}/"
               class="nav-link">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/collaborations"
               class="nav-link">
                Browse Collaborations
            </a>

            <% if (session.getAttribute("loggedInStudent") != null) { %>
            <a href="${pageContext.request.contextPath}/create-collaboration"
               class="nav-link">
                Create Collaboration
            </a>
            <a href="${pageContext.request.contextPath}/profile"
               class="nav-link active">
                My Profile
            </a>
            <% } %>

        </nav>


        <div class="nav-actions">

            <% if (session.getAttribute("loggedInStudent") != null) { %>
            <a href="${pageContext.request.contextPath}/create-collaboration"
               class="btn btn-primary">
                Create
            </a>
            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-ghost">
                Logout
            </a>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/login"
               class="btn btn-ghost">
                Login
            </a>
            <a href="${pageContext.request.contextPath}/register"
               class="btn btn-primary">
                Register
            </a>
            <% } %>

            <button
                    type="button"
                    id="themeToggle"
                    class="theme-toggle"
                    aria-label="Toggle dark mode">
                ☾
            </button>

        </div>

        <button class="mobile-menu-button" aria-label="Open menu">☰</button>

    </div>

</header>

<!-- MAIN -->
<main>

<section class="profile-page">

    <div class="container">

        <div class="profile-container">

            <% if ("saved".equals(message)) { %>
            <div class="message success-message">
                &#10003; Profile saved successfully!
            </div>
            <% } %>

            <div class="profile-card">

                <!-- PROFILE HEADER -->

                <div class="profile-header">

                    <div class="profile-avatar">
                        <%= student.getName().substring(0, 1).toUpperCase() %>
                    </div>

                    <div class="profile-identity">

                        <div class="profile-name">
                            <%= student.getName() %>
                        </div>

                        <div class="profile-email">
                            <%= student.getEmail() %>
                        </div>

                        <span class="profile-id-badge">
                            Student ID: <%= student.getStudentId() %>
                        </span>

                    </div>

                </div>


                <% if (profile != null) { %>

                    <!-- BIO -->

                    <div class="profile-section">

                        <div class="profile-section-label">About</div>

                        <% if (profile.getBio() != null && !profile.getBio().trim().isEmpty()) { %>
                            <p class="profile-bio"><%= profile.getBio() %></p>
                        <% } else { %>
                            <p class="no-portfolio-note">No bio added yet.</p>
                        <% } %>

                    </div>


                    <!-- SKILLS -->

                    <div class="profile-section">

                        <div class="profile-section-label">Skills</div>

                        <% if (skillTags.length > 0) { %>
                        <div class="skill-chips">
                            <% for (String skill : skillTags) {
                                   String s = skill.trim();
                                   if (!s.isEmpty()) { %>
                            <span class="skill-chip"><%= s %></span>
                            <%     }
                               } %>
                        </div>
                        <% } else { %>
                            <p class="no-portfolio-note">No skills listed yet.</p>
                        <% } %>

                    </div>


                    <!-- PORTFOLIO LINK -->

                    <div class="profile-section">

                        <div class="profile-section-label">Portfolio / Project Link</div>

                        <% if (hasPortfolioLink) { %>
                            <a href="<%= profile.getPortfolioLink() %>"
                               class="portfolio-link-btn"
                               target="_blank"
                               rel="noopener noreferrer">
                                &#128279; View Portfolio
                                <span>↗</span>
                            </a>
                        <% } else { %>
                            <p class="no-portfolio-note">No portfolio link added yet.</p>
                        <% } %>

                    </div>

                <% } else { %>

                    <!-- NO PROFILE YET -->
                    <div class="no-profile-box">
                        <h3>No portfolio yet.</h3>
                        <p>This student hasn't added a portfolio yet.</p>
                        <% if (Boolean.TRUE.equals(request.getAttribute("isOwnProfile"))) { %>
                        <a href="${pageContext.request.contextPath}/profile?edit=true"
                           class="btn btn-primary">
                            Create Portfolio →
                        </a>
                        <% } %>
                    </div>

                <% } %>

                <!-- ACTIONS -->

                <div class="profile-actions">

                    <% if (Boolean.TRUE.equals(request.getAttribute("isOwnProfile"))) { %>
                    <a href="${pageContext.request.contextPath}/profile?edit=true"
                       class="btn btn-secondary">
                        ✎ Edit Profile
                    </a>
                    <% } %>

                    <a href="${pageContext.request.contextPath}/collaborations"
                       class="btn btn-ghost">
                        ← Back to Browse
                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

</main>

<!-- FOOTER -->
<footer class="footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-brand">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <span class="logo-mark">CC</span>
                    <span class="logo-text">Campus Collab</span>
                </a>
                <p class="footer-description">A student collaboration hub for discovering projects, meeting creators, and building ideas together.</p>
            </div>
            <div class="footer-column">
                <h4>Platform</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/collaborations">Browse Collaborations</a></li>
                    <li><a href="${pageContext.request.contextPath}/create-collaboration">Create Collaboration</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile">Student Profile</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Community</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/collaborations">Explore</a></li>
                    <li><a href="#">About</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <span>&copy; 2026 Campus Collab. All rights reserved.</span>
            <span>Made for student creators.</span>
        </div>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/theme.js"></script>

</body>
</html>
