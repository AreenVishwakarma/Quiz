<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .result-container {
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
        p {
            font-size: 16px;
            color: #444444;
        }
        .question {
            margin-bottom: 20px;
            text-align: left;
        }
        button {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h1>Quiz Results</h1>
        <%
                HttpSession sess = request.getSession();
                String student = (String) sess.getAttribute("StEmail"); // email taking from student.jsp
                String tableName = request.getParameter("tableName");
                String resultTableName = student.replaceAll("@", "_").replaceAll("\\.", "_") + "_" + tableName;
                
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

                String query = "SELECT tb1.question, tb1.opt1, tb1.opt2, tb1.opt3, tb1.opt4, tb1.correct_ans, " +
                               "tb2.submitted_answer, tb2.is_correct " +
                               "FROM "+ tableName +" tb1 " +
                               "JOIN " + resultTableName + " tb2 ON tb1.id = tb2.question_id";

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(query);

                while (rs.next()) {
                    String question = rs.getString("question");
                    String opt1 = rs.getString("opt1");
                    String opt2 = rs.getString("opt2");
                    String opt3 = rs.getString("opt3");
                    String opt4 = rs.getString("opt4");
                    String correctAns = rs.getString("correct_ans");
                    String submittedAns = rs.getString("submitted_answer");
                    boolean isCorrect = rs.getBoolean("is_correct");
        %>
                    <div class="question">
                        <strong>Q:</strong> <%= question %><br>
                        A. <%= opt1 %><br>
                        B. <%= opt2 %><br>
                        C. <%= opt3 %><br>
                        D. <%= opt4 %><br>
                        <strong>Submitted Answer:</strong> <%= (submittedAns != null ? submittedAns : "Not Answered") %><br>
                        <strong>Correct Answer:</strong> <%= correctAns %><br>
                        <strong>Is Correct:</strong> <%= isCorrect ? "Yes" : "No" %>
                    </div>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                out.println("<p>You did not given this quiz</p>");
            }
        %>
        <a href="StudentDashboard.jsp">
            <button type="submit">Dashboard</button>
        </a>
    </div>
</body>
</html>
