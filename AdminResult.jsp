<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Select Quiz Table</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        select, button {
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Select a Quiz</h1>
        <form action="A-result.jsp" method="post">
                        <!--SELECT STUDENT TABLE-->
            <label for="tableSelect">Choose a Student:</label>
            <select name="StudentTable" id="tableSelect" required>
                <%
                    try {
                        // Load MySQL Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish connection
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

                        // Query to get table names
                        String subject = "select email from student";
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(subject);

                        // Populate the dropdown with table names
                        while (rs.next()) {
                            String table = rs.getString(1);
                %>
                            <option value="<%= table %>"><%= table %></option>
                <%
                        }
                        // Close resources
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
            </select>
            <br>
                            <!--SELECT QUIZ TABLE-->
            <label for="tableSelect">Choose a quiz table:</label>
            <select name="tableName" id="tableSelect" required>
                <%
                    try {
                        // Load MySQL Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        // Establish connection
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

                        // Query to get table names
                        String subject = "SHOW TABLES LIKE 'quiz%'";
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(subject);

                        // Populate the dropdown with table names
                        while (rs.next()) {
                            String table = rs.getString(1);
                %>
                            <option value="<%= table %>"><%= table %></option>
                <%
                        }
                        // Close resources
                        rs.close();
                        stmt.close();
                        con.close();
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
            </select><br>
            <button type="submit">Show Result</button>
        </form>
    </div>
</body>
</html>