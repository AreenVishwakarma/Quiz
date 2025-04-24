<%@ page import="java.sql.*" %>
<%@page import ="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Submission</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .result-container {
            background: #ffffff;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
        a{
            text-decoration: none;
            color: white;
            font-weight: bold;
        }
        button {
            background-color: #007BFF;
            color: red;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            padding: 10px;
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
            String email = (String) sess.getAttribute("StEmail");  // email taking from student.jsp
            String tableName = request.getParameter("tableName");
                out.print(email+"<br>");
                out.print(tableName);
            if (email != null && tableName != null && !tableName.isEmpty()) {
                String resultTableName = email.replaceAll("@", "_").replaceAll("\\.", "_") + "_" + tableName;
                try {
                    // Load MySQL Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");
                    String query1 = "Drop table if exists "+resultTableName;
                    // Create the results table if it doesn't exist
                    String createTableQuery = "CREATE TABLE IF NOT EXISTS " + resultTableName + " (" +
                                              "id INT AUTO_INCREMENT PRIMARY KEY, " +
                                              "question_id INT, " +
                                              "submitted_answer VARCHAR(1000), " +
                                              "correct_answer VARCHAR(1000), " +
                                              "is_correct BOOLEAN)";
                    Statement stmt = con.createStatement();
                    stmt.executeUpdate(query1);
                    stmt.executeUpdate(createTableQuery);
                    
                    sess.setAttribute("STable", resultTableName);   //  sending to

                    // Fetch the correct answers from the quiz table
                    String fetchQuestionsQuery = "SELECT * FROM " + tableName;
                    ResultSet rs = stmt.executeQuery(fetchQuestionsQuery);

                    int correctCount = 0, totalQuestions = 0;

                    while (rs.next()) {
                        int qid = rs.getInt("id");
                        String correctAnswer = rs.getString("correct_ans");
                        String submittedAnswer = request.getParameter("q" + qid);

                        // Insert the result into the results table
                        String insertResultQuery = "INSERT INTO " + resultTableName + " (question_id, submitted_answer, correct_answer, is_correct) " +
                                                   "VALUES (?, ?, ?, ?)";
                        PreparedStatement pstmt = con.prepareStatement(insertResultQuery);
                        pstmt.setInt(1, qid);
                        pstmt.setString(2, submittedAnswer);
                        pstmt.setString(3, correctAnswer);
                        pstmt.setBoolean(4, correctAnswer.equals(submittedAnswer));
                        pstmt.executeUpdate();

                        if (correctAnswer.equals(submittedAnswer)) {
                            correctCount++;
                        }
                        totalQuestions++;
                    }

                    // Close resources
                    rs.close();
                    stmt.close();
                    con.close();

                    // Display the results
                    out.println("<p>Quiz Completed!</p>");
                    out.println("<p>Your Score: " + correctCount + " out of " + totalQuestions + "</p>");
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p>Invalid session or quiz table name.</p>");
            }
        %>
        <button><a href="select-sub.jsp">Show Result</a></button>
    </div>
</body>
</html>