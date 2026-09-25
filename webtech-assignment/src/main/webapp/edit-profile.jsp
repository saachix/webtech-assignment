<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Student" %>
<%@ page import="model.StudentProfile" %>

<%
    Student student = (Student) request.getAttribute("student");
    StudentProfile profile = (StudentProfile) request.getAttribute("profile");
    String errorMessage = (String) request.getAttribute("errorMessage");

    // Pre-fill values if editing an existing profile
    String prefillBio      = (profile != null && profile.getBio() != null)
                             ? profile.getBio() : "";
    String prefillSkills   = (profile != null && profile.getSkills() != null)
                             ? profile.getSkills() : "";
    String prefillPortfolio = (profile != null && profile.getPortfolioLink() != null)
                              ? profile.getPortfolioLink() : "";
    int prefillStudentId   = (student != null) ? student.getStudentId() : 0;
    String prefillName     = (student != null) ? student.getName() : "";

    boolean isEditing = (student != null);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= isEditing ? "Edit Profile" : "Student Profile" %> — Campus Collab</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/style.css">

    <style>

        .form-section {
            padding: 70px 0;
            background: var(--light-blue);
            min-height: calc(100vh - 68px);
        }

        .form-box {
            max-width: 650px;
            margin: 0 auto;
            padding: 35px;
            background: white;
            border: 1px solid var(--line);
            border-radius: 10px;
            box-shadow: var(--shadow);
        }

        .form-box h1 {
            margin-bottom: 5px;
            color: var(--navy);
        }

        .form-box > .form-subtitle {
            margin-bottom: 28px;
            color: var(--muted);
            font-size: 0.85rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: var(--navy);
            font-size: 0.82rem;
            font-weight: 700;
        }

        .form-group .field-hint {
            display: block;
            margin-bottom: 7px;
            color: var(--muted);
            font-size: 0.74rem;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 11px 12px;
            border: 1px solid var(--line);
            border-radius: 7px;
            font-family: inherit;
            font-size: 0.85rem;
            color: var(--text);
            background: white;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--blue);
        }

        .form-group textarea {
            min-height: 110px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
            flex-wrap: wrap;
        }

        /* student ID lookup section */

        .id-lookup-note {
            background: var(--light-blue);
            border: 1px solid #cfe8f1;
            border-radius: 7px;
            padding: 12px 15px;
            margin-bottom: 24px;
            font-size: 0.8rem;
            color: var(--dark-blue);
        }

        /* student info badge shown when editing */

        .student-info-banner {
            display: flex;
            align-items: center;
            gap: 12px;
            background: var(--green-bg);
            border: 1px solid #b8dcc8;
            border-radius: 7px;
            padding: 12px 15px;
            margin-bottom: 24px;
        }

        .student-info-avatar {
            width: 38px;
            height: 38px;
            border-radius: 8px;
            background: var(--baby-blue);
            border: 1px solid #a0d4e9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            font-weight: 800;
            color: var(--dark-blue);
            flex-shrink: 0;
        }

        .student-info-text {
            font-size: 0.82rem;
            color: #4f896b;
            font-weight: 700;
        }

        .student-info-subtext {
            font-size: 0.76rem;
            color: #6aaa88;
        }

        /* error */

        .error-message {
            background: #fff0f3;
            border: 1px solid #f2c7d2;
            color: #a65368;
            padding: 12px 15px;
            border-radius: 7px;
            font-size: 0.82rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        /* dark mode */

        body.dark-mode .form-box {
            background: #182a33;
            border-color: var(--line);
        }

        body.dark-mode .form-group input,
        body.dark-mode .form-group textarea {
            background: #101c22;
            color: #dcecf2;
            border-color: #3a5662;
        }

        body.dark-mode .form-group input::placeholder,
        body.dark-mode .form-group textarea::placeholder {
            color: #8299a4;
        }

        body.dark-mode .form-group input:focus,
        body.dark-mode .form-group textarea:focus {
            border-color: var(--blue);
        }

        body.dark-mode .id-lookup-note {
            background: #1a3340;
            border-color: #2d5566;
            color: #8bd0ef;
        }

        body.dark-mode .student-info-banner {
            background: #183328;
            border-color: #2e5540;
        }

        body.dark-mode .student-info-text {
            color: #79bd98;
        }

        body.dark-mode .student-info-subtext {
            color: #5e9878;
        }

        body.dark-mode .student-info-avatar {
            background: #1d3845;
            border-color: #31596b;
            color: #8bd0ef;
        }

        @media (max-width: 600px) {
            .form-section {
                padding: 45px 0;
            }
            .form-box {
                padding: 24px;
            }
            .form-actions {
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

<section class="form-section">

    <div class="container">

        <div class="form-box">

            <h1>
                Edit Your Profile
            </h1>

            <p class="form-subtitle">
                Update your skills and portfolio information.
            </p>


            <!-- ERROR MESSAGE -->

            <% if (errorMessage != null) { %>
            <div class="error-message">
                &#9888; <%= errorMessage %>
            </div>
            <% } %>


            <!-- STUDENT CONFIRMED BANNER (shown when student is loaded) -->

            <div class="student-info-banner">
                <div class="student-info-avatar">
                    <%= prefillName.substring(0, 1).toUpperCase() %>
                </div>
                <div>
                    <div class="student-info-text">Profile for: <%= prefillName %></div>
                    <div class="student-info-subtext">Student ID: <%= prefillStudentId %></div>
                </div>
            </div>


            <!-- FORM -->

            <form method="post"
                  action="${pageContext.request.contextPath}/profile">


                <!-- BIO -->

                <div class="form-group">
                    <label for="bio">Short Bio</label>
                    <span class="field-hint">A sentence or two about yourself.</span>
                    <textarea
                        id="bio"
                        name="bio"
                        placeholder="e.g. CS student interested in UI/UX and mobile development."
                    ><%= prefillBio %></textarea>
                </div>


                <!-- SKILLS -->

                <div class="form-group">
                    <label for="skills">Skills</label>
                    <span class="field-hint">Comma-separated list of your skills. e.g. Java, Python, Figma, UI/UX</span>
                    <input
                        type="text"
                        id="skills"
                        name="skills"
                        placeholder="Java, Python, Figma, UI/UX"
                        value="<%= prefillSkills %>"
                    >
                </div>


                <!-- PORTFOLIO LINK -->

                <div class="form-group">
                    <label for="portfolioLink">Portfolio / Project Link</label>
                    <span class="field-hint">Link to your GitHub, Behance, portfolio site, or project showcase.</span>
                    <input
                        type="url"
                        id="portfolioLink"
                        name="portfolioLink"
                        placeholder="https://github.com/yourname"
                        value="<%= prefillPortfolio %>"
                    >
                </div>


                <!-- ACTIONS -->

                <div class="form-actions">

                    <button type="submit" class="btn btn-primary">
                        Save Profile →
                    </button>

                    <a href="${pageContext.request.contextPath}/profile"
                       class="btn btn-secondary">
                        Cancel
                    </a>

                </div>

            </form>

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
