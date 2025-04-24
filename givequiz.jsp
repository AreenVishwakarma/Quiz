<%@ page import="java.sql.*" %>
<%@page import ="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .quiz-container {
            background: #ffffff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
        }
        h1 {
            color: #333333;
            margin-bottom: 20px;
        }
        .question {
            margin-bottom: 20px;
            text-align: left;
        }
        .question p {
            font-size: 16px;
            color: #444444;
        }
        label {
            font-size: 14px;
            color: #555555;
        }
        .submit-btn {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="quiz-container">
        <h1>Quiz Time</h1>
        <form id="quiz-form" action="SubmitPage.jsp" method="post">
            
        <%
            HttpSession sess = request.getSession();
            String email = (String) sess.getAttribute("StEmail");  // email taking from student.jsp
            out.print(email);
            
            // Get the selected table name from the query parameter
            String tableName = request.getParameter("tableName");
        %>
            <input type="hidden" value="<%=email%>" name="StEmail">
            <input type="hidden" value="<%=tableName%>" name="tableName">
        <%
            if (tableName != null && !tableName.isEmpty()) {
                try {
                    // Load MySQL Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

                    // Query to fetch questions from the selected table
                    String quiz = "SELECT * FROM " + tableName;
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(quiz);

                    // Dynamically generate the quiz
                    while (rs.next()) {
                        int qid = rs.getInt("id");
                        String question = rs.getString("question");
                        String opt1 = rs.getString("opt1");
                        String opt2 = rs.getString("opt2");
                        String opt3 = rs.getString("opt3");
                        String opt4 = rs.getString("opt4");              
        %>
                        <div class="question">
                            <p><%= qid%>. <%= question %></p>
                            <label><input type="radio" name="q<%= qid %>" value="<%= opt1 %>"> A) <%= opt1 %></label><br>
                            <label><input type="radio" name="q<%= qid %>" value="<%= opt2 %>"> B) <%= opt2 %></label><br>
                            <label><input type="radio" name="q<%= qid %>" value="<%= opt3 %>"> C) <%= opt3 %></label><br>
                            <label><input type="radio" name="q<%= qid %>" value="<%= opt4 %>"> D) <%= opt4 %></label>
                        </div>
        <%
                    }
                    // Close resources
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            } else {
        %>
                <p>No table selected. Please go back and select a quiz.</p>
        <%
            }
        %>
            <button type="submit" class="submit-btn">Submit Quiz</button>
        </form>
    </div>
</body>
</html>