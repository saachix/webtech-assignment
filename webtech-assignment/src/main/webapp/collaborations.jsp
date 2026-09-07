<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Collaboration" %>
<%@ page import="model.dao.VoteDAO" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Collaborations - Campus Collab</title>

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
        }


        /* -------------------------
           DARK MODE PAGE OVERRIDES
           ------------------------- */

        body.dark-mode .collaborations-page {
            background: #101c22;
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

            <a href="${pageContext.request.contextPath}/create-collaboration"
               class="nav-link">
                Create Collaboration
            </a>

        </nav>


        <div class="nav-actions">

            <a href="${pageContext.request.contextPath}/create-collaboration"
               class="btn btn-primary">
                Create
            </a>

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
                Recent opportunities
            </span>

            <h1>
                Find something worth building.
            </h1>

            <p>
                Explore projects created by students looking for
                talented collaborators.
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

                        </div>


                        <!-- VOTE -->

                        <form
                                method="post"
                                action="${pageContext.request.contextPath}/vote"
                                class="vote-form">

                            <input
                                    type="number"
                                    name="voterId"
                                    placeholder="Student ID"
                                    min="1"
                                    required
                                    class="vote-input"
                            >

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
                        No open collaborations yet.
                    </h3>

                    <p>
                        Be the first to create one and find your
                        next collaborator!
                    </p>

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
                © 2026 Campus Collab. All rights reserved.
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