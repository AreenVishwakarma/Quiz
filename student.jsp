<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import ="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Login - Quiz Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #fbc2eb, #a6c1ee);
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-box {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }

        h2 {
            margin-bottom: 30px;
            color: #333;
        }

        input[type="text"],
        input[type="password"] {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #4CAF50;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Student Login</h2>
        <form action="student.jsp" method="post">
            <input type="text" name="username" placeholder="Username" required id="email"><br>
            <input type="password" name="password" placeholder="Password" required id="password"><br>
            <div id="mess"></div>
            <input type="submit" value="Login">
        </form>
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>

    <%
        if("POST".equalsIgnoreCase(request.getMethod())){
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        try{
            Class.forName("com.mysql.jdbc.Driver");  
            Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/quiz","root","");
            
            
            String check = "select * from student where email=? and password=?";
            PreparedStatement ps = con.prepareStatement(check);
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();
                if(rs.next()){
//                    out.println("<script>document.getElementById('mess').innerHTML='Logged in';</script>");
//                    HttpSession session = request.getSession();
                    HttpSession sess = request.getSession();
                    sess.setAttribute("StEmail", email);    //  sending to givequiz.jsp, SubmitPage.jsp, result.jsp
                    response.sendRedirect("StudentDashboard.jsp");
                }else{
                    out.println("<script>document.getElementById('mess').innerHTML='Incorrect LoginId or Password ';</script>");
                }
            
        }catch(Exception ex){
            response.getWriter().print("Error: "+ex.getMessage());
        }}
    %>
</body>
</html>
