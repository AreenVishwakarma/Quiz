<%-- 
    Document   : AdminDashboard
    Created on : 15 Apr 2025, 3:12:38 pm
    Author     : hp
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard</title>
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

    .admin-info {
      margin-bottom: 40px;
    }

    .admin-info div {
      margin-bottom: 10px;
    }

    .main-content {
      flex: 1;
      padding: 40px;
    }

    .admin-buttons {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
    }

    .admin-button {
      flex: 1 1 30%;
      background-color: white;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      text-align: center;
      transition: 0.3s;
      cursor: pointer;
    }

    .admin-button:hover {
      transform: translateY(-5px);
      background-color: #ede9fe;
    }

    .admin-button h3 {
      margin: 0 0 10px;
      color: #4c1d95;
    }

    .admin-button p {
      color: #6b7280;
    }
    a{
        text-decoration: none;
        width: 455px;
    }
    button {
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
  <div class="sidebar">
    <h2>Admin Panel</h2>
    <div class="admin-info">
        
        <%
            HttpSession sess = request.getSession();
            String Email = (String) sess.getAttribute("StEmail"); // Correct session object usage\ email taking from admin.jsp

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
                String data = "SELECT * FROM admin WHERE email = ?";
                PreparedStatement ps = con.prepareStatement(data);
                ps.setString(1, Email);

                // Execute query
                ResultSet rs = ps.executeQuery();

                // Check if any data is returned
                if (rs.next()) {
                    String name = rs.getString("username");
                    String email = rs.getString("email");
                    String id = rs.getString("admin_id");
        %>
                    <p><b>Name:</b> <%=name%></p>
                    <p><b>Email:</b> <%=email%></p>
                    <p><b>ID:</b> <%=id%></p>
        <%
                } else {
                    // No data found
                    response.getWriter().print("<p>No admin found with the given email.</p>");
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
        <br>
        <form action="logout.jsp" method="post">
            <button type="submit">Logout</button>
        </form>
    </div>
  </div>
  <div class="main-content">
      <h1>Welcome to Admin Dashboard</h1>
    <p>Manage student records and quizzes:</p>
    <div class="admin-buttons">
        <!--ADD STUDENT-->
        <a href="A-AddStudent.jsp">
            <div class="admin-button">
            <h3>Add Student</h3>
            <p>Register a new student in the system.</p>
            </div>
        </a>
        <!--REMOVE STUDENT-->
        <a href="A-DeleteStudent.jsp">
            <div class="admin-button">
            <h3>Delete Student</h3>
            <p>Remove an existing student profile.</p>
            </div>
        </a>    
        <!--CHECK RESULT-->
        <a href="AdminResult.jsp">
            <div class="admin-button">
            <h3>Check Results</h3>
            <p>View quiz results for all students.</p>
        </div>
        </a>
        <!--ADD QUESTION-->
        <a href="A-createquiz.jsp">
            <div class="admin-button">
            <h3>Add New Quiz</h3>
            <p>Create and assign a new quiz.</p>
        </div>
        </a>
    </div>
  </div>
</body>
</html>
