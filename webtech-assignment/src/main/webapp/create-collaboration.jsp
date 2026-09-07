<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Collaboration - Campus Collab</title>

    <link rel="stylesheet" href="style.css">

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
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 11px 12px;
            border: 1px solid var(--line);
            border-radius: 7px;
            font-family: inherit;
            font-size: 0.85rem;
            color: var(--text);
            background: white;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--blue);
        }

        .form-group textarea {
            min-height: 130px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
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
            <a href="${pageContext.request.contextPath}/"
               class="nav-link">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/collaborations"
               class="nav-link">
                Browse Collaborations
            </a>

            <a href="${pageContext.request.contextPath}/create-collaboration"
               class="nav-link active">
                Create Collaboration
            </a>
        </nav>

    </div>

</header>


<main>

<section class="form-section">

    <div class="container">

        <div class="form-box">

            <h1>Create a Collaboration</h1>

            <p>
                Have an idea? Tell other students what you're looking for.
            </p>


            <form method="post"
                  action="${pageContext.request.contextPath}/create-collaboration">

                <div class="form-group">

                    <label for="creatorId">
                        Creator Student ID
                    </label>

                    <input
                            type="number"
                            id="creatorId"
                            name="creatorId"
                            min="1"
                            required
                    >

                </div>


                <div class="form-group">

                    <label for="title">
                        Collaboration Title
                    </label>

                    <input
                            type="text"
                            id="title"
                            name="title"
                            maxlength="255"
                            placeholder="e.g. Need a Video Editor"
                            required
                    >

                </div>


                <div class="form-group">

                    <label for="category">
                        Category
                    </label>

                    <select id="category"
                            name="category"
                            required>

                        <option value="">
                            Select a category
                        </option>

                        <option value="Video Editing">
                            Video Editing
                        </option>

                        <option value="Podcast">
                            Podcast
                        </option>

                        <option value="Photography">
                            Photography
                        </option>

                        <option value="Music">
                            Music
                        </option>

                        <option value="Design">
                            Design
                        </option>

                        <option value="Programming">
                            Programming
                        </option>

                        <option value="Writing">
                            Writing
                        </option>

                        <option value="Other">
                            Other
                        </option>

                    </select>

                </div>


                <div class="form-group">

                    <label for="description">
                        Description
                    </label>

                    <textarea
                            id="description"
                            name="description"
                            placeholder="Describe your project and the kind of collaborator you're looking for..."
                            required
                    ></textarea>

                </div>


                <div class="form-actions">

                    <button type="submit"
                            class="btn btn-primary">
                        Create Collaboration
                        <span>→</span>
                    </button>

                    <a href="${pageContext.request.contextPath}/collaborations"
                       class="btn btn-secondary">
                        Cancel
                    </a>

                </div>

            </form>

        </div>

    </div>

</section>

</main>

</body>
</html>