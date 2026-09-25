<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Application" %>
<%@ page import="model.Collaboration" %>
<%@ page import="model.Student" %>

<%
    Collaboration collaboration = (Collaboration) request.getAttribute("collaboration");
    List<Application> applications = (List<Application>) request.getAttribute("applications");
    Map<Integer, Student> applicants =
            (Map<Integer, Student>) request.getAttribute("applicants");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Applications - Campus Collab</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/style.css">

    <style>

        .manage-page {
            padding: 65px 0;
            background: var(--light-blue);
            min-height: calc(100vh - 68px);
        }

        .page-header {
            margin-bottom: 28px;
        }

        .page-header .section-label {
            margin-bottom: 9px;
        }

        .page-header h1 {
            margin-bottom: 8px;
            font-size: 2rem;
            line-height: 1.2;
            letter-spacing: -0.025em;
            color: var(--navy);
        }

        .page-header p {
            color: var(--muted);
            font-size: 0.88rem;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 18px;
            color: var(--dark-blue);
            font-size: 0.82rem;
            font-weight: 700;
        }

        .applicant-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 16px;
            max-width: 760px;
        }

        .applicant-card {
            padding: 22px;
            background: white;
            border: 1px solid var(--line);
            border-radius: 10px;
        }

        .applicant-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 10px;
        }

        .applicant-card h3 {
            margin: 0 0 4px;
            color: var(--navy);
            font-size: 1.05rem;
        }

        .applicant-email {
            color: var(--muted);
            font-size: 0.82rem;
        }

        .pitch-label {
            margin: 14px 0 6px;
            color: var(--navy);
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.04em;
            text-transform: uppercase;
        }

        .pitch-text {
            margin: 0;
            color: var(--text);
            font-size: 0.88rem;
            line-height: 1.5;
            white-space: pre-wrap;
        }

        .applicant-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 18px;
        }

        .status-chip {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 999px;
            font-size: 0.75rem;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-pending {
            background: #eef6fb;
            color: var(--dark-blue);
        }

        .status-accepted {
            background: var(--green-bg);
            color: #4f896b;
        }

        .status-rejected {
            background: #fff0f3;
            color: #a65368;
        }

        .btn-reject {
            background: white;
            border: 1px solid #f2c7d2;
            color: #a65368;
        }

        .btn-reject:hover {
            background: #fff0f3;
        }

        .empty-state {
            padding: 40px 24px;
            background: white;
            border: 1px solid var(--line);
            border-radius: 10px;
            text-align: center;
            color: var(--muted);
            max-width: 760px;
        }

        .empty-state h3 {
            margin-bottom: 8px;
            color: var(--navy);
        }

        body.dark-mode .manage-page {
            background: #101c22;
        }

        body.dark-mode .applicant-card,
        body.dark-mode .empty-state {
            background: #182a33;
            border-color: var(--line);
        }

        body.dark-mode .status-pending {
            background: #1d3845;
            color: #9ec9dc;
        }

        body.dark-mode .status-accepted {
            background: var(--green-bg);
            color: #8bcba6;
        }

        body.dark-mode .status-rejected {
            background: #3a2430;
            color: #e5a0b2;
        }

        body.dark-mode .btn-reject {
            background: #182a33;
            border-color: #6a3d4c;
            color: #e5a0b2;
        }

        body.dark-mode .btn-reject:hover {
            background: #3a2430;
        }

    </style>

</head>

<body>

<header class="navbar">

    <div class="navbar-container">

        <a href="${pageContext.request.contextPath}/" class="logo">
            <span class="logo-mark">CC</span>
            <span class="logo-text">Campus Collab</span>
        </a>

        <nav class="nav-links">

            <a href="${pageContext.request.contextPath}/" class="nav-link">Home</a>

            <a href="${pageContext.request.contextPath}/collaborations" class="nav-link">
                Browse Collaborations
            </a>

            <a href="${pageContext.request.contextPath}/create-collaboration" class="nav-link">
                Create Collaboration
            </a>

            <a href="${pageContext.request.contextPath}/my-collaborations" class="nav-link active">
                My Collaborations
            </a>

            <a href="${pageContext.request.contextPath}/profile" class="nav-link">
                My Profile
            </a>

        </nav>

        <div class="nav-actions">

            <a href="${pageContext.request.contextPath}/create-collaboration" class="btn btn-primary">
                Create
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-ghost">
                Logout
            </a>

            <button type="button" id="themeToggle" class="theme-toggle" aria-label="Toggle dark mode">
                ☾
            </button>

        </div>

        <button class="mobile-menu-button" aria-label="Open menu">☰</button>

    </div>

</header>

<main>

<section class="manage-page">

    <div class="container">

        <a href="${pageContext.request.contextPath}/my-collaborations" class="back-link">
            ← Back to My Collaborations
        </a>

        <div class="page-header">
            <div class="section-label">Applications</div>
            <h1><%= collaboration != null ? collaboration.getTitle() : "Applications" %></h1>
            <p>Review pitches and accept or reject each applicant individually.</p>
        </div>

        <%
            if (applications != null && !applications.isEmpty()) {
        %>

        <div class="applicant-grid">

            <%
                for (Application app : applications) {
                    Student applicant = applicants != null
                            ? applicants.get(app.getApplicantId())
                            : null;

                    String applicantName = applicant != null ? applicant.getName() : "Unknown student";
                    String applicantEmail = applicant != null ? applicant.getEmail() : "—";
                    String status = app.getStatus() != null ? app.getStatus() : "Pending";
                    String chipClass = "status-pending";
                    if ("Accepted".equals(status)) {
                        chipClass = "status-accepted";
                    } else if ("Rejected".equals(status)) {
                        chipClass = "status-rejected";
                    }
            %>

                <article class="applicant-card">

                    <div class="applicant-top">
                        <div>
                            <h3><%= applicantName %></h3>
                            <div class="applicant-email"><%= applicantEmail %></div>
                        </div>
                        <span class="status-chip <%= chipClass %>"><%= status %></span>
                    </div>

                    <div class="pitch-label">Pitch</div>
                    <p class="pitch-text"><%= app.getPitchText() %></p>

                    <div class="applicant-actions">

                        <a href="${pageContext.request.contextPath}/profile?studentId=<%= app.getApplicantId() %>"
                           class="btn btn-secondary">
                            View Profile
                        </a>

                        <form method="post"
                              action="${pageContext.request.contextPath}/collaboration-applications"
                              style="display:inline;">
                            <input type="hidden" name="applicationId"
                                   value="<%= app.getApplicationId() %>">
                            <input type="hidden" name="status" value="Accepted">
                            <button type="submit" class="btn btn-primary">Accept</button>
                        </form>

                        <form method="post"
                              action="${pageContext.request.contextPath}/collaboration-applications"
                              style="display:inline;">
                            <input type="hidden" name="applicationId"
                                   value="<%= app.getApplicationId() %>">
                            <input type="hidden" name="status" value="Rejected">
                            <button type="submit" class="btn btn-reject">Reject</button>
                        </form>

                    </div>

                </article>

            <%
                }
            %>

        </div>

        <%
            } else {
        %>

            <div class="empty-state">
                <h3>No applications yet</h3>
                <p>When students apply to this collaboration, their pitches will appear here.</p>
            </div>

        <%
            }
        %>

    </div>

</section>

</main>

<script src="${pageContext.request.contextPath}/theme.js"></script>

</body>
</html>
