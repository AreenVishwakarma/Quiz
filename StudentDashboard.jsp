<%-- 
    Document   : StudentDashboard
    Created on : 14 Apr 2025, 6:15:51 pm
    Author     : hp
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      margin: 0;
      background-color: #f5f3ff;
      display: flex;
    }

    .sidebar {
      width: 280px;
      background-color: #7c3aed;
      color: white;
      height: 100vh;
      padding: 30px 20px;
      box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
      border-top-left-radius: 20px;
      border-bottom-left-radius: 20px;
    }

    .sidebar h2 {
      margin-top: 0;
      font-size: 22px;
      margin-bottom: 30px;
    }

    .student-info {
      margin-bottom: 40px;
    }

    .student-info div {
      margin-bottom: 10px;
    }

    .main-content {
      flex: 1;
      padding: 40px;
    }

    .quiz-buttons {
      display: flex;
      gap: 30px;
    }

    .quiz-button {
      flex: 1;
      background-color: white;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      text-align: center;
      transition: 0.3s;
      cursor: pointer;
    }

    .quiz-button:hover {
      transform: translateY(-5px);
      background-color: #ede9fe;
    }

    .quiz-button h3 {
      margin: 0 0 10px;
      color: #4c1d95;
    }

    .quiz-button p {
      color: #6b7280;
    }
  </style>
</head>
<body>
  <div class="sidebar">
    <h2>Student Details</h2>
    <div class="student-info">
        <%
            HttpSession sess = request.getSession();
            String Email = (String) sess.getAttribute("StEmail"); // Correct session object usage

            sess.setAttribute("email", Email); // This is redundant if already set elsewhere

            try {
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setDateHeader("Expires", 0); // Prevents caching at the proxy server
                // Load MySQL Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establish connection
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

                // Query to retrieve student details
                String data = "SELECT * FROM student WHERE email = ?";
                PreparedStatement ps = con.prepareStatement(data);
                ps.setString(1, Email);

                // Execute query
                ResultSet rs = ps.executeQuery();

                // Check if any data is returned
                if (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String rollno = rs.getString("roll_no");
        %>
                    <p><b>Name:</b> <%=name%></p>
                    <p><b>Email:</b> <%=email%></p>
                    <p><b>Roll No.:</b> <%=rollno%></p>
        <%
                } else {
                    // No data found
                    response.getWriter().print("<p>No student found with the given email.</p>");
                }

                // Close resources
                rs.close();
                ps.close();
                con.close();

            } catch (Exception ex) {
                // Handle and display errors
                ex.printStackTrace();
                response.getWriter().print("Error: " + ex.getMessage());
            }
        %>
        <br><form action="logout.jsp" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
  </div>
  <div class="main-content">
    <h1>Welcome to Your Dashboard</h1>
    <p>Choose your quiz section below:</p>
    <div class="quiz-buttons">
        <a href="selectquiz.jsp">
            <div class="quiz-button">
            <h3>Daily Quiz</h3>
            <p>Take today's quiz and improve daily.</p>
            </div>
        </a>
        <a href="selectquiz.jsp">
            <div class="quiz-button">
            <h3>Weekly Quiz</h3>
            <p>Assess your progress this week.</p>
            </div>
        </a>
        <a href="select-sub.jsp">
            <div class="quiz-button">
            <h3>Quiz Results</h3>
            <p>View your quiz performances.</p>
            </div>
        </a>
    </div>
  </div>
</body>
</html>
