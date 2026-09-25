<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Collaboration" %>
<%@ page import="model.dao.VoteDAO" %>

<%
    /* Pull filter state set by CollaborationServlet */
    String currentKeyword  = (String) request.getAttribute("keyword");
    String currentCategory = (String) request.getAttribute("category");
    String currentSortBy   = (String) request.getAttribute("sortBy");

    if (currentKeyword  == null) currentKeyword  = "";
    if (currentCategory == null) currentCategory = "";
    if (currentSortBy   == null) currentSortBy   = "latest";

    boolean hasActiveFilter =
        !currentKeyword.isEmpty() || !currentCategory.isEmpty()
        || "votes".equals(currentSortBy);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Browse Collaborations - Campus Collab</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/style.css">

    <style>

        /* -------------------------
           COLLABORATIONS PAGE
           ------------------------- */

        .collaborations-page {
            padding: 65px 0;
            background: #f7fbfd;
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


        /* -------------------------
           MESSAGE
           ------------------------- */

        .message {
            margin-bottom: 25px;
            padding: 13px 16px;
            border-radius: 7px;
            font-size: 0.82rem;
            font-weight: 700;
        }

        .success-message {
            background: var(--green-bg);
            border: 1px solid #b8dcc8;
            color: #4f896b;
        }

        .error-message {
            background: #fff0f3;
            border: 1px solid #f2c7d2;
            color: #a65368;
        }


        /* -------------------------
           FILTER BAR
           ------------------------- */

        .filter-bar {
            margin-bottom: 30px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        /* Row 1: search + sort */
        .filter-row {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .search-wrapper {
            position: relative;
            flex: 1;
            min-width: 200px;
            max-width: 420px;
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--muted);
            font-size: 0.85rem;
            pointer-events: none;
        }

        .search-input {
            width: 100%;
            height: 40px;
            padding: 0 12px 0 34px;
            border: 1px solid var(--line);
            border-radius: 7px;
            background: white;
            color: var(--text);
            font-family: inherit;
            font-size: 0.82rem;
            transition: 0.2s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--blue);
        }

        .sort-select {
            height: 40px;
            padding: 0 32px 0 12px;
            border: 1px solid var(--line);
            border-radius: 7px;
            background-color: white;
            color: var(--text);
            font-family: inherit;
            font-size: 0.82rem;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2371838d' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px 12px;
            transition: 0.2s ease;
        }

        .sort-select:focus {
            outline: none;
            border-color: var(--blue);
        }

        .filter-submit-btn {
            height: 40px;
            padding: 0 16px;
            background: var(--blue);
            border: 1px solid var(--blue);
            border-radius: 7px;
            color: white;
            font-family: inherit;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .filter-submit-btn:hover {
            background: var(--dark-blue);
            border-color: var(--dark-blue);
            transform: translateY(-1px);
        }

        /* Row 2: category chips */
        .chip-row {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 7px;
        }

        .chip-label {
            font-size: 0.72rem;
            font-weight: 700;
            color: var(--muted);
            margin-right: 3px;
        }

        .chip {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 11px;
            border-radius: 20px;
            border: 1px solid var(--line);
            background: white;
            color: var(--muted);
            font-family: inherit;
            font-size: 0.74rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: 0.15s ease;
        }

        .chip:hover {
            border-color: var(--blue);
            color: var(--dark-blue);
            background: var(--light-blue);
        }

        .chip.active {
            background: var(--blue);
            border-color: var(--blue);
            color: white;
        }

        /* Clear filters link */
        .clear-filters {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 12px;
            border-radius: 20px;
            border: 1px solid #f2c7d2;
            background: #fff0f3;
            color: #a65368;
            font-family: inherit;
            font-size: 0.74rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: 0.15s ease;
        }

        .clear-filters:hover {
            background: #ffe0e8;
            border-color: #e8a0b4;
        }

        /* Active filter summary */
        .filter-summary {
            font-size: 0.78rem;
            color: var(--muted);
            margin-bottom: 16px;
        }

        .filter-summary strong {
            color: var(--dark-blue);
        }


        /* -------------------------
           CARD ACTIONS
           ------------------------- */

        .collaboration-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid var(--line);
        }

        .action-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .apply-button {
            min-height: 38px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 0 14px;
            border-radius: 7px;
            background: var(--blue);
            border: 1px solid var(--blue);
            color: white;
            font-size: 0.78rem;
            font-weight: 700;
            transition: 0.2s ease;
        }

        .apply-button:hover {
            background: var(--dark-blue);
            border-color: var(--dark-blue);
            transform: translateY(-1px);
        }

        .creator-profile-link {
            min-height: 38px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            padding: 0 12px;
            border-radius: 7px;
            background: white;
            border: 1px solid var(--line);
            color: var(--muted);
            font-size: 0.76rem;
            font-weight: 700;
            transition: 0.2s ease;
            white-space: nowrap;
        }

        .creator-profile-link:hover {
            background: var(--light-blue);
            border-color: var(--blue);
            color: var(--dark-blue);
            transform: translateY(-1px);
        }

        .vote-form {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .vote-input {
            width: 105px;
            height: 38px;
            padding: 0 10px;
            background: white;
            border: 1px solid var(--line);
            border-radius: 7px;
            color: var(--text);
            font-family: inherit;
            font-size: 0.76rem;
        }

        .vote-input:focus {
            outline: none;
            border-color: var(--blue);
        }

        .vote-button {
            min-height: 38px;
            padding: 0 14px;
            background: white;
            border: 1px solid #a8d3e4;
            border-radius: 7px;
            color: var(--dark-blue);
            font-family: inherit;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .vote-button:hover {
            background: var(--light-blue);
            transform: translateY(-1px);
        }


        /* -------------------------
           VOTE COUNT
           ------------------------- */

        .vote-count {
            color: var(--muted);
            font-size: 0.75rem;
            font-weight: 700;
        }


        /* -------------------------
           EMPTY STATE
           ------------------------- */

        .empty-state {
            padding: 45px 25px;
            background: white;
            border: 1px solid var(--line);
            border-radius: 10px;
            text-align: center;
        }

        .empty-state h3 {
            margin-bottom: 7px;
            color: var(--navy);
        }

        .empty-state p {
            color: var(--muted);
            font-size: 0.84rem;
            margin-bottom: 16px;
        }


        /* -------------------------
           DARK MODE PAGE OVERRIDES
           ------------------------- */

        body.dark-mode .collaborations-page {
            background: #101c22;
        }

        body.dark-mode .search-input {
            background: #182a33;
            color: #dcecf2;
            border-color: #3a5662;
        }

        body.dark-mode .search-input:focus {
            border-color: var(--blue);
        }

        body.dark-mode .search-input::placeholder {
            color: #8299a4;
        }

        body.dark-mode .sort-select {
            background-color: #182a33;
            color: #dcecf2;
            border-color: #3a5662;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%239db0b9' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px 12px;
        }

        body.dark-mode .chip {
            background: #1b303a;
            border-color: #2d4652;
            color: #9db0b9;
        }

        body.dark-mode .chip:hover {
            border-color: var(--blue);
            color: var(--dark-blue);
            background: #1d3845;
        }

        body.dark-mode .chip.active {
            background: #286582;
            border-color: #286582;
            color: white;
        }

        body.dark-mode .clear-filters {
            background: #2a1a1f;
            border-color: #5a2f3c;
            color: #cf8090;
        }

        body.dark-mode .clear-filters:hover {
            background: #351f26;
        }

        body.dark-mode .vote-input {
            background: #182a33;
            color: #dcecf2;
            border-color: #3a5662;
        }

        body.dark-mode .vote-button {
            background: #1b303a;
            border-color: #416574;
            color: var(--dark-blue);
        }

        body.dark-mode .vote-button:hover {
            background: #243e49;
        }

        body.dark-mode .creator-profile-link {
            background: #1b303a;
            border-color: #2d4652;
            color: #9db0b9;
        }

        body.dark-mode .creator-profile-link:hover {
            background: #1d3845;
            border-color: var(--blue);
            color: var(--dark-blue);
        }

        body.dark-mode .empty-state {
            background: #182a33;
        }


        /* -------------------------
           MOBILE
           ------------------------- */

        @media (max-width: 600px) {

            .collaborations-page {
                padding: 45px 0;
            }

            .filter-row {
                flex-direction: column;
                align-items: stretch;
            }

            .search-wrapper {
                max-width: 100%;
            }

            .sort-select {
                width: 100%;
            }

            .filter-submit-btn {
                width: 100%;
            }

            .collaboration-actions {
                align-items: stretch;
                flex-direction: column;
            }

            .action-buttons {
                width: 100%;
            }

            .apply-button {
                width: 100%;
            }

            .vote-form {
                width: 100%;
            }

            .vote-input {
                flex: 1;
                width: auto;
            }

            .vote-button {
                width: auto;
            }
        }

    </style>

</head>


<body>


<!-- =========================
     NAVBAR
     ========================= -->

<header class="navbar">

    <div class="navbar-container">

        <a href="${pageContext.request.contextPath}/"
           class="logo">

            <span class="logo-mark">
                CC
            </span>

            <span class="logo-text">
                Campus Collab
            </span>

        </a>


        <nav class="nav-links">

            <a href="${pageContext.request.contextPath}/"
               class="nav-link">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/collaborations"
               class="nav-link active">
                Browse Collaborations
            </a>

            <% if (session.getAttribute("loggedInStudent") != null) { %>
            <a href="${pageContext.request.contextPath}/create-collaboration"
               class="nav-link">
                Create Collaboration
            </a>
            <a href="${pageContext.request.contextPath}/profile"
               class="nav-link">
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

            <!-- DARK MODE TOGGLE -->

            <button
                    type="button"
                    id="themeToggle"
                    class="theme-toggle"
                    aria-label="Toggle dark mode">
                ☾
            </button>

        </div>


        <button class="mobile-menu-button"
                aria-label="Open menu">
            ☰
        </button>

    </div>

</header>


<!-- =========================
     MAIN CONTENT
     ========================= -->

<main>

<section class="collaborations-page">

    <div class="container">


        <!-- PAGE HEADER -->

        <div class="page-header">

            <span class="section-label">
                Browse opportunities
            </span>

            <h1>
                Find something worth building.
            </h1>

            <p>
                Explore projects created by students looking for
                talented collaborators. Filter by interest, search
                by keyword, or sort by most voted.
            </p>

        </div>


        <!-- =========================
             MESSAGES
             ========================= -->

        <%
            String message = request.getParameter("message");

            if ("vote-success".equals(message)) {
        %>

            <div class="message success-message">
                &#10003; Vote submitted successfully!
            </div>

        <%
            } else if ("already-voted".equals(message)) {
        %>

            <div class="message error-message">
                &#9888; You have already voted for this collaboration.
            </div>

        <%
            } else if ("invalid-student".equals(message)) {
        %>

            <div class="message error-message">
                &#9888; Student ID not found. Please enter a valid Student ID.
            </div>

        <%
            } else if ("vote-error".equals(message)) {
        %>

            <div class="message error-message">
                &#9888; Unable to submit your vote. Please try again.
            </div>

        <%
            }
        %>


        <!-- =========================
             FILTER BAR
             ========================= -->

        <div class="filter-bar">

            <%-- All filter controls POST back to the same /collaborations URL as GET --%>
            <form method="get"
                  action="${pageContext.request.contextPath}/collaborations"
                  id="filterForm">

                <!-- Row 1: Search + Sort + Submit -->

                <div class="filter-row" style="margin-bottom: 14px;">

                    <div class="search-wrapper">
                        <span class="search-icon">&#128269;</span>
                        <input
                            type="text"
                            name="keyword"
                            id="keywordInput"
                            class="search-input"
                            placeholder="Search by title or description…"
                            value="<%= currentKeyword %>"
                            autocomplete="off"
                        >
                    </div>

                    <select name="sortBy" class="sort-select"
                            onchange="document.getElementById('filterForm').submit()">
                        <option value="latest"
                            <%= "latest".equals(currentSortBy) ? "selected" : "" %>>
                            ↕ Latest
                        </option>
                        <option value="votes"
                            <%= "votes".equals(currentSortBy) ? "selected" : "" %>>
                            ♥ Most Voted
                        </option>
                    </select>

                    <%-- Hidden field so the category chip choice survives the submit --%>
                    <input type="hidden" name="category" id="categoryHidden"
                           value="<%= currentCategory %>">

                    <button type="submit" class="filter-submit-btn">
                        Search
                    </button>

                </div>


                <!-- Row 2: Category / Interest Chips -->

                <div class="chip-row">

                    <span class="chip-label">Interests:</span>

                    <%
                        String[] categories = {
                            "Design", "Video Editing", "Photography",
                            "Podcast", "Development", "Music", "Writing", "Other"
                        };
                    %>

                    <%-- "All" chip --%>
                    <a href="${pageContext.request.contextPath}/collaborations?keyword=<%= java.net.URLEncoder.encode(currentKeyword, "UTF-8") %>&sortBy=<%= currentSortBy %>"
                       class="chip <%= currentCategory.isEmpty() ? "active" : "" %>">
                        All
                    </a>

                    <% for (String cat : categories) {
                           boolean isActive = cat.equals(currentCategory);
                           String encodedKeyword  = java.net.URLEncoder.encode(currentKeyword, "UTF-8");
                           String encodedCategory = java.net.URLEncoder.encode(cat, "UTF-8");
                    %>
                    <a href="${pageContext.request.contextPath}/collaborations?keyword=<%= encodedKeyword %>&category=<%= encodedCategory %>&sortBy=<%= currentSortBy %>"
                       class="chip <%= isActive ? "active" : "" %>">
                        <%= cat %>
                    </a>
                    <% } %>

                </div>

            </form>


            <!-- Clear Filters — only shown when any filter is active -->

            <% if (hasActiveFilter) { %>
            <div style="margin-top: 4px;">
                <a href="${pageContext.request.contextPath}/collaborations"
                   class="clear-filters">
                    &#10005; Clear filters
                </a>

                <span class="filter-summary" style="margin-left: 12px;">
                    Showing results for
                    <% if (!currentKeyword.isEmpty()) { %>
                        <strong>"<%= currentKeyword %>"</strong>
                    <% } %>
                    <% if (!currentCategory.isEmpty()) { %>
                        in <strong><%= currentCategory %></strong>
                    <% } %>
                    <% if ("votes".equals(currentSortBy)) { %>
                        &mdash; sorted by <strong>most voted</strong>
                    <% } %>
                </span>
            </div>
            <% } %>

        </div>


        <!-- =========================
             COLLABORATION CARDS
             ========================= -->

        <div class="collaboration-grid">

            <%
                List<Collaboration> collaborations =
                        (List<Collaboration>)
                        request.getAttribute("collaborations");

                VoteDAO voteDAO = new VoteDAO();

                if (collaborations != null && !collaborations.isEmpty()) {

                    for (Collaboration collaboration : collaborations) {

                        String icon = "✦";

                        if ("Video Editing".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "▶";

                        } else if ("Podcast".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "♪";

                        } else if ("Photography".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "◎";

                        } else if ("Design".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "✎";

                        } else if ("Development".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "⌨";

                        } else if ("Music".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "♫";

                        } else if ("Writing".equalsIgnoreCase(
                                collaboration.getCategory())) {

                            icon = "✍";
                        }
            %>


                <article class="collaboration-card">


                    <!-- CARD TOP -->

                    <div class="collaboration-top">

                        <div class="collaboration-icon">
                            <%= icon %>
                        </div>


                        <span class="status-badge">

                            <span class="status-dot"></span>

                            <%= collaboration.getStatus() %>

                        </span>

                    </div>


                    <!-- TITLE -->

                    <h3>
                        <%= collaboration.getTitle() %>
                    </h3>


                    <!-- DESCRIPTION -->

                    <p class="collaboration-description">
                        <%= collaboration.getDescription() %>
                    </p>


                    <!-- CATEGORY -->

                    <span class="category-tag">
                        <%= collaboration.getCategory() %>
                    </span>


                    <!-- ACTIONS -->

                    <div class="collaboration-actions">


                        <div class="action-buttons">

                            <!-- APPLY -->

                            <a
                                    href="${pageContext.request.contextPath}/apply?collabId=<%= collaboration.getCollabId() %>"
                                    class="apply-button">
                                Apply
                                <span>→</span>
                            </a>

                            <!-- VIEW CREATOR PROFILE -->

                            <a
                                    href="${pageContext.request.contextPath}/profile?studentId=<%= collaboration.getCreatorId() %>"
                                    class="creator-profile-link"
                                    title="View creator's portfolio">
                                &#128100; View Creator
                            </a>

                        </div>


                        <!-- VOTE -->
                        <% if (session.getAttribute("loggedInStudent") != null) { %>
                        <form
                                method="post"
                                action="${pageContext.request.contextPath}/vote"
                                class="vote-form">

                            <input
                                    type="hidden"
                                    name="collabId"
                                    value="<%= collaboration.getCollabId() %>"
                            >

                            <button
                                    type="submit"
                                    class="vote-button">
                                Vote
                            </button>

                        </form>
                        <% } else { %>
                        <a href="${pageContext.request.contextPath}/login" class="vote-button" style="text-decoration:none; display:inline-flex; align-items:center;">
                            Login to Vote
                        </a>
                        <% } %>


                    </div>


                    <!-- VOTE COUNT -->

                    <div style="margin-top: 12px;">

                        <span class="vote-count">

                            &#9829;

                            <%= voteDAO.getVoteCount(
                                    collaboration.getCollabId()
                            ) %>

                            vote(s)

                        </span>

                    </div>


                </article>


            <%
                    }

                } else {
            %>


                <!-- EMPTY STATE -->

                <div class="empty-state">

                    <h3>
                        <% if (hasActiveFilter) { %>
                            No collaborations match your current filters.
                        <% } else { %>
                            No open collaborations yet.
                        <% } %>
                    </h3>

                    <p>
                        <% if (hasActiveFilter) { %>
                            Try adjusting your search terms or category selection.
                        <% } else { %>
                            Be the first to create one and find your
                            next collaborator!
                        <% } %>
                    </p>

                    <% if (hasActiveFilter) { %>
                    <a href="${pageContext.request.contextPath}/collaborations"
                       class="clear-filters">
                        &#10005; Clear filters &amp; browse all
                    </a>
                    <% } %>

                </div>


            <%
                }
            %>

        </div>

    </div>

</section>

</main>


<!-- =========================
     FOOTER
     ========================= -->

<footer class="footer">

    <div class="container">

        <div class="footer-grid">


            <!-- BRAND -->

            <div class="footer-brand">

                <a href="${pageContext.request.contextPath}/"
                   class="logo">

                    <span class="logo-mark">
                        CC
                    </span>

                    <span class="logo-text">
                        Campus Collab
                    </span>

                </a>

                <p class="footer-description">
                    A student collaboration hub for discovering
                    projects, meeting creators, and building ideas
                    together.
                </p>

            </div>


            <!-- PLATFORM -->

            <div class="footer-column">

                <h4>
                    Platform
                </h4>

                <ul class="footer-links">

                    <li>
                        <a href="${pageContext.request.contextPath}/">
                            Home
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/collaborations">
                            Browse Collaborations
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/create-collaboration">
                            Create Collaboration
                        </a>
                    </li>

                </ul>

            </div>


            <!-- COMMUNITY -->

            <div class="footer-column">

                <h4>
                    Community
                </h4>

                <ul class="footer-links">

                    <li>
                        <a href="${pageContext.request.contextPath}/collaborations">
                            Explore
                        </a>
                    </li>

                    <li>
                        <a href="#">
                            About
                        </a>
                    </li>

                    <li>
                        <a href="#">
                            Contact
                        </a>
                    </li>

                </ul>

            </div>


        </div>


        <div class="footer-bottom">

            <span>
                &copy; 2026 Campus Collab. All rights reserved.
            </span>

            <span>
                Made for student creators.
            </span>

        </div>

    </div>

</footer>


<!-- THEME JAVASCRIPT -->

<script src="${pageContext.request.contextPath}/theme.js"></script>


</body>
</html>