<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Apply - Campus Collab</title>

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
            margin-bottom: 8px;
            color: var(--navy);
        }

        .form-box > p {
            margin-bottom: 28px;
            color: var(--muted);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 7px;
            color: var(--navy);
            font-size: 0.82rem;
            font-weight: 700;
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
            min-height: 150px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }


        /* =========================
           DARK MODE FORM
           ========================= */

        body.dark-mode .form-box {
            background: #182a33;
            border-color: var(--line);
            box-shadow: var(--shadow);
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
               class="nav-link">
                Browse Collaborations
            </a>

        </nav>


        <div class="nav-actions">

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
     APPLICATION FORM
     ========================= -->

<main>

<section class="form-section">

    <div class="container">

        <div class="form-box">


            <h1>
                Apply for Collaboration
            </h1>


            <p>
                Tell the creator why you'd be a good fit for this project.
            </p>


            <form
                    method="post"
                    action="${pageContext.request.contextPath}/apply">


                <!-- COLLABORATION ID -->

                <div class="form-group">

                    <label for="collabId">
                        Collaboration ID
                    </label>


                    <input
                            type="number"
                            id="collabId"
                            name="collabId"
                            value="<%= request.getAttribute("collabId") %>"
                            readonly
                    >

                </div>


                <!-- APPLICANT ID -->

                <div class="form-group">

                    <label for="applicantId">
                        Your Student ID
                    </label>


                    <input
                            type="number"
                            id="applicantId"
                            name="applicantId"
                            min="1"
                            required
                    >

                </div>


                <!-- PITCH -->

                <div class="form-group">

                    <label for="pitchText">
                        Your Pitch
                    </label>


                    <textarea
                            id="pitchText"
                            name="pitchText"
                            placeholder="Tell the creator about your skills, experience, and why you're interested..."
                            required
                    ></textarea>

                </div>


                <!-- BUTTONS -->

                <div class="form-actions">

                    <button
                            type="submit"
                            class="btn btn-primary">

                        Submit Application

                        <span>
                            →
                        </span>

                    </button>


                    <a
                            href="${pageContext.request.contextPath}/collaborations"
                            class="btn btn-secondary">

                        Cancel

                    </a>

                </div>


            </form>

        </div>

    </div>

</section>

</main>


<!-- =========================
     DARK MODE SCRIPT
     ========================= -->

<script src="${pageContext.request.contextPath}/theme.js"></script>


</body>
</html>