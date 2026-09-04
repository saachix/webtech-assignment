<%@ page import="java.util.List" %>
<%@ page import="model.Collaboration" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Collaborations - Campus Collab</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 40px;
            background: #f5f5f5;
        }

        h1 {
            text-align: center;
        }

        .collaborations {
            max-width: 900px;
            margin: 30px auto;
        }

        .card {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 10px;
        }

        .card h2 {
            margin-top: 0;
        }

        .category {
            font-weight: bold;
        }

        .status {
            font-weight: bold;
        }
    </style>
</head>

<body>

<h1>Open Collaborations</h1>

<div class="collaborations">

    <%
        List<Collaboration> collaborations =
                (List<Collaboration>) request.getAttribute("collaborations");

        for (Collaboration collaboration : collaborations) {
    %>

        <div class="card">

            <h2><%= collaboration.getTitle() %></h2>

            <p class="category">
                Category: <%= collaboration.getCategory() %>
            </p>

            <p>
                <%= collaboration.getDescription() %>
            </p>

            <p class="status">
                Status: <%= collaboration.getStatus() %>
            </p>

        </div>

    <%
        }
    %>

</div>

</body>
</html>