<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Collaboration" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Collaborations - Campus Collab</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/style.css">

    <style>

        .manage-page {
            padding: 65px 0;
            background: var(--light-blue);
            min-height: calc(100vh - 68px);
        }

        .page-header {
            margin-bottom: 35px;
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

        .empty-state {
            padding: 40px 24px;
            background: white;
            border: 1px solid var(--line);
            border-radius: 10px;
            text-align: center;
            color: var(--muted);
        }

        .empty-state h3 {
            margin-bottom: 8px;
            color: var(--navy);
        }

        .card-actions {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 18px;
            flex-wrap: wrap;
        }

        .app-count {
            font-size: 0.8rem;
            color: var(--muted);
            font-weight: 600;
        }

        body.dark-mode .manage-page {
            background: #101c22;
        }

        body.dark-mode .empty-state {
            background: #182a33;
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

        <div class="page-header">
            <div class="section-label">Creator tools</div>
            <h1>My Collaborations</h1>
            <p>Collaborations you created. Open any one to review applications.</p>
        </div>

        <div class="collaboration-grid">

            <%
                List<Collaboration> collaborations =
                        (List<Collaboration>) request.getAttribute("collaborations");
                Map<Integer, Integer> applicationCounts =
                        (Map<Integer, Integer>) request.getAttribute("applicationCounts");

                if (collaborations != null && !collaborations.isEmpty()) {

                    for (Collaboration collaboration : collaborations) {
                        Integer countValue = applicationCounts != null
                                ? applicationCounts.get(collaboration.getCollabId())
                                : null;
                        int applicationCount = countValue != null ? countValue : 0;
            %>

                <article class="collaboration-card">

                    <div class="collaboration-top">
                        <div class="collaboration-icon">✦</div>
                        <span class="status-badge">
                            <span class="status-dot"></span>
                            <%= collaboration.getStatus() %>
                        </span>
                    </div>

                    <h3><%= collaboration.getTitle() %></h3>

                    <p class="collaboration-description">
                        <%= collaboration.getDescription() %>
                    </p>

                    <span class="category-tag">
                        <%= collaboration.getCategory() %>
                    </span>

                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/collaboration-applications?collabId=<%= collaboration.getCollabId() %>"
                           class="btn btn-primary">
                            View Applications
                        </a>
                        <span class="app-count">
                            <%= applicationCount %> application<%= applicationCount == 1 ? "" : "s" %>
                        </span>
                    </div>

                </article>

            <%
                    }

                } else {
            %>

                <div class="empty-state" style="grid-column: 1 / -1;">
                    <h3>No collaborations yet</h3>
                    <p>When you create a collaboration, it will appear here so you can manage applications.</p>
                    <a href="${pageContext.request.contextPath}/create-collaboration"
                       class="btn btn-primary" style="margin-top: 16px;">
                        Create Collaboration
                    </a>
                </div>

            <%
                }
            %>

        </div>

    </div>

</section>

</main>

<script src="${pageContext.request.contextPath}/theme.js"></script>

</body>
</html>
