<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quiz App - Welcome</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #6dd5ed, #2193b0);
            color: white;
            text-align: center;
        }

        .container {
            margin-top: 10%;
        }

        h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        p {
            font-size: 20px;
            margin-bottom: 40px;
        }

        .btn {
            padding: 15px 30px;
            font-size: 18px;
            border: none;
            border-radius: 10px;
            margin: 15px;
            cursor: pointer;
            background-color: #ffffff;
            color: #2193b0;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #2193b0;
            color: white;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Welcome to the Quiz Portal</h1>
        <p>Select your login type to continue</p>
        <button class="btn" onclick="location.href='student.jsp'">Student Login</button>
        <button class="btn" onclick="location.href='admin.jsp'">Admin Login</button>
    </div>

</body>
</html>
