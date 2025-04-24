<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Quiz Table Creator</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      /*align-items: center;*/
    }
    .top-bar {
      display: flex;
      justify-content: space-between;
      background: #4f46e5;
      color: white;
      padding: 20px;
    }
    .section {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .section input, select {
      padding: 8px;
      border-radius: 4px;
      border: none;
    }
    .section button {
      padding: 8px 12px;
      background: #10b981;
      border: none;
      border-radius: 4px;
      color: white;
      cursor: pointer;
    }
    #tablesList{
        /*justify-content: center;*/
            /*align-items: center;*/
    }
    #quiz {
        margin-top: 20px;
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            width: 400px;
            /*align-items: center;*/
            box-shadow: 0 0px 10px black;
        }

        #quiz p {
            margin: 10px 0;
            font-weight: bold;
        }

        #quiz input[type="text"],
        #quiz input[type="number"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        #quiz input[type="text"]:focus,
        #quiz input[type="number"]:focus {
            border-color: #4f46e5;
            outline: none;
            box-shadow: 0 0 5px rgba(79, 70, 229, 0.5);
        }

        #quiz button[type="submit"] {
            width: 100%;
            background-color: #4f46e5;
            color: #ffffff;
            border: none;
            padding: 10px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #quiz button[type="submit"]:hover {
            background-color: #3b31c4;
        }
  </style>
</head>
<body>
  <div class="top-bar">
    <!-- Section for creating new quiz tables -->
    <div class="section">
      <input type="text" id="quizName" placeholder="Enter Quiz Name" />
      <button onclick="createQuiz()">Create Quiz Table</button>
      <a href="AdminDashboard.jsp">
          <button type="submit">Dashboard</button>
      </a>
    </div>
    <!-- Section for selecting existing quiz tables -->
    <div class="section">
      <strong>Quiz Tables:</strong>
      <select id="quizTablesDropdown">
        <!-- Dropdown options dynamically populated -->
      </select>
    </div>
  </div>

  <div id="tablesList">
    <!-- Form for adding questions to the selected quiz table -->
    <center>
    <form id="quiz" onsubmit="return submitQuestion();">
        <p>Question</p>
        <input type="text" name="question" placeholder="Enter your question here..." required />
        <p>Options</p>
         <input type="text" name="opt1" placeholder="Option 1" required /><br />
         <input type="text" name="opt2" placeholder="Option 2" required /><br />
         <input type="text" name="opt3" placeholder="Option 3" required /><br />
         <input type="text" name="opt4" placeholder="Option 4" required /><br />
        <p>Correct Ans</p>
        <input type="text" name="answer" placeholder="Enter the correct answer" required />
        <p>Marks</p>
        <input type="number" name="marks" placeholder="Enter marks for this question" required /><br />
        <button type="submit">Submit</button>
    </form></center>
  </div>

<%-- Backend logic for dynamically fetching tables and handling form submissions --%>
<%
    // Database connection details
    String dbUrl = "jdbc:mysql://localhost:3306/quiz";
    String dbUser = "root";
    String dbPassword = "";

    // Handle table creation
    String newQuizName = request.getParameter("name");
    if (newQuizName != null && !newQuizName.isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            String tableName = newQuizName.replaceAll("\\s+", "_").toLowerCase();
            Statement stmt = con.createStatement();
            String createTableQuery = "CREATE TABLE IF NOT EXISTS quiz_" + tableName +
                " (id INT AUTO_INCREMENT PRIMARY KEY, question TEXT, opt1 TEXT, opt2 TEXT, opt3 TEXT, opt4 TEXT, correct_ans TEXT, marks INT)";
            stmt.executeUpdate(createTableQuery);
            out.println("<script>alert('Table created successfully!');</script>");
        } catch (Exception e) {
            out.println("<script>alert('Error creating table: " + e.getMessage() + "');</script>");
        }
    }

    // Handle question submission
    String selectedTable = request.getParameter("quizTablesDropdown");
    
    HttpSession sess = request.getSession(false);
    sess.setAttribute("STable", selectedTable);     //  sending to
    
    if (selectedTable != null && !selectedTable.isEmpty()) {
        try {
            String question = request.getParameter("question");
            String opt1 = request.getParameter("opt1");
            String opt2 = request.getParameter("opt2");
            String opt3 = request.getParameter("opt3");
            String opt4 = request.getParameter("opt4");
            String answer = request.getParameter("answer");
            String marks = request.getParameter("marks");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            String insertQuery = "INSERT INTO " + selectedTable + " (question, opt1, opt2, opt3, opt4, correct_ans, marks) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertQuery);
            ps.setString(1, question);
            ps.setString(2, opt1);
            ps.setString(3, opt2);
            ps.setString(4, opt3);
            ps.setString(5, opt4);
            ps.setString(6, answer);
            ps.setString(7, marks);
            ps.executeUpdate();
            out.println("<script>alert('Question submitted successfully!');</script>");
        } catch (Exception e) {
            out.println("<script>alert('Error submitting question: " + e.getMessage() + "');</script>");
        }
    }
%>
<script>
  // Function to create a new quiz table
  function createQuiz() {
    let name = $('#quizName').val().trim();
    if (!name) {
      alert("Enter quiz name");
      return;
    }
    $.ajax({
      url: 'createquiz.jsp',
      type: 'POST',
      data: { name },
      success: function (res) {
        alert("Quiz table created successfully!");
        loadTables();
      },
      error: function (err) {
        alert("Error creating quiz table: " + err.responseText);
      },
    });
  }

  // Function to load existing quiz tables into the dropdown
  function loadTables() {
    $.ajax({
      url: 'ListTablesServlet',
      type: 'POST',
      data: { action: 'loadTables' },
      success: function (data) {
        let dropdown = $('#quizTablesDropdown');
        dropdown.empty(); // Clear existing options
        dropdown.append(data); // Append new options
      },
      error: function (err) {
        alert("Error loading quiz tables: " + err.responseText);
      },
    });
  }

  // Function to submit a question to the selected quiz table
  function submitQuestion() {
  let selectedTable = $('#quizTablesDropdown').val();
  if (!selectedTable) {
    alert("Please select a quiz table");
    return false;
  }

  let formData = $('#quiz').serialize() + '&quizTablesDropdown=' + selectedTable;

  $.ajax({
    url: 'createquiz.jsp', // Ensure this matches the backend JSP file
    type: 'POST',
    data: formData,
    success: function (response) {
      alert("Question Added"); // Display the response message from the JSP
      if (response.trim() === "Question submitted successfully!") {
        $('#quiz')[0].reset(); // Reset the form on success
      }
    },
    error: function (err) {
      alert("Error submitting the question: " + err.responseText);
    },
  });
  return false; // Prevent default form submission
}

  // Load tables on page load
  $(document).ready(function () {
    loadTables();
  });
</script>
</body>
</html>