<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Campus Collab — Find Your Next Collaborator</title>

    <link rel="stylesheet" href="style.css">
</head>

<body>

<!-- =========================
     NAVBAR
     ========================= -->

<header class="navbar">
    <div class="navbar-container">

        <a href="#" class="logo">
            <span class="logo-mark">CC</span>
            <span class="logo-text">Campus Collab</span>
        </a>

        <nav class="nav-links">
            <a href="#" class="nav-link active">Home</a>

            <a href="${pageContext.request.contextPath}/collaborations"
               class="nav-link">
                Browse Collaborations
            </a>

            <a href="#create" class="nav-link">
                Create Collaboration
            </a>
        </nav>

        <div class="nav-actions">
            <a href="#login" class="btn btn-ghost">Login</a>

            <a href="#create" class="btn btn-primary">
                Get Started
            </a>
        </div>

        <button class="mobile-menu-button" aria-label="Open menu">
            ☰
        </button>

    </div>
</header>


<!-- =========================
     HERO
     ========================= -->

<main>

<section class="hero">

    <div class="hero-container">

        <div class="hero-badge">
            ✦ Built for student creators
        </div>

        <h1 class="hero-title">
            Find your next
            <span class="hero-title-highlight">collaborator.</span>
        </h1>

        <p class="hero-description">
            Discover exciting student projects, connect with people
            who have complementary skills, and turn your ideas into
            something bigger — together.
        </p>

        <div class="hero-actions">

            <a href="${pageContext.request.contextPath}/collaborations"
               class="btn btn-primary">
                Browse Collaborations
                <span>→</span>
            </a>

            <a href="#create" class="btn btn-secondary">
                Create a Collaboration
            </a>

        </div>

    </div>

</section>


<!-- =========================
     HOW IT WORKS
     ========================= -->

<section class="section how-it-works">

    <div class="container">

        <div class="section-header">

            <span class="section-label">
                How it works
            </span>

            <h2 class="section-title">
                From idea to collaboration.
            </h2>

            <p class="section-description">
                Campus Collab makes it simple to find the right people
                and bring student ideas to life.
            </p>

        </div>


        <div class="steps-grid">

            <article class="step-card">

                <div class="step-number">
                    01
                </div>

                <h3>Discover</h3>

                <p>
                    Find collaboration opportunities posted by
                    students across different interests and skills.
                </p>

            </article>


            <article class="step-card">

                <div class="step-number">
                    02
                </div>

                <h3>Connect</h3>

                <p>
                    Find people whose skills complement your project
                    and connect with potential teammates.
                </p>

            </article>


            <article class="step-card">

                <div class="step-number">
                    03
                </div>

                <h3>Create</h3>

                <p>
                    Have an idea? Post your own collaboration and
                    invite other students to join.
                </p>

            </article>


            <article class="step-card">

                <div class="step-number">
                    04
                </div>

                <h3>Collaborate</h3>

                <p>
                    Apply to projects, vote on collaborations,
                    and start building something together.
                </p>

            </article>

        </div>

    </div>

</section>


<!-- =========================
     FEATURED COLLABORATIONS
     ========================= -->

<section class="section featured" id="collaborations">

    <div class="container">

        <div class="section-header">

            <span class="section-label">
                Recent opportunities
            </span>

            <h2 class="section-title">
                Find something worth building.
            </h2>

            <p class="section-description">
                Explore projects created by students looking for
                talented collaborators.
            </p>

        </div>


        <div class="collaboration-grid">


            <!-- Collaboration 1 -->

            <article class="collaboration-card">

                <div class="collaboration-top">

                    <div class="collaboration-icon">
                        ▶
                    </div>

                    <span class="status-badge">
                        <span class="status-dot"></span>
                        Open
                    </span>

                </div>

                <h3>
                    Need Video Editor
                </h3>

                <p class="collaboration-description">
                    Looking for someone to edit YouTube videos
                    and help bring creative student content to life.
                </p>

                <span class="category-tag">
                    Video Editing
                </span>

            </article>


            <!-- Collaboration 2 -->

            <article class="collaboration-card">

                <div class="collaboration-top">

                    <div class="collaboration-icon">
                        ♪
                    </div>

                    <span class="status-badge">
                        <span class="status-dot"></span>
                        Open
                    </span>

                </div>

                <h3>
                    Podcast Co-host Wanted
                </h3>

                <p class="collaboration-description">
                    Looking for a co-host for a student podcast
                    covering campus life, ideas, and interesting stories.
                </p>

                <span class="category-tag">
                    Podcast
                </span>

            </article>


        </div>

    </div>

</section>


<!-- =========================
     CALL TO ACTION
     ========================= -->

<section class="cta" id="create">

    <div class="container">

        <div class="cta-box">

            <div class="cta-content">

                <h2>
                    Got an idea?
                    Find the people to build it.
                </h2>

                <p>
                    Create a collaboration opportunity and discover
                    students who can help turn your idea into reality.
                </p>

                <a href="#" class="btn btn-primary">
                    Create Collaboration
                    <span>→</span>
                </a>

            </div>

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


            <div class="footer-brand">

                <a href="#" class="logo">

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


            <div class="footer-column">

                <h4>
                    Platform
                </h4>

                <ul class="footer-links">

                    <li>
                        <a href="#">
                            Home
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/collaborations">
                            Browse Collaborations
                        </a>
                    </li>

                    <li>
                        <a href="#create">
                            Create Collaboration
                        </a>
                    </li>

                </ul>

            </div>


            <div class="footer-column">

                <h4>
                    Community
                </h4>

                <ul class="footer-links">

                    <li>
                        <a href="#login">
                            Login
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


</body>
</html>