<%-- 
    Document   : AddStudent
    Created on : 22 Apr 2025, 4:45:37 am
    Author     : hp
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .addstudent{
                border-radius: 10px;
                box-shadow: 0px 0px 15px black;
                width: fit-content;
                padding: 10px;
                margin-top: 20px;
                font-family: Arial, sans-serif;
            }
            input{
                border-color: #4f46e5;
                outline: none;
                box-shadow: 0 0 5px rgba(79, 70, 229, 0.5);
                width: 300px;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }
            button{
            width: 100px;
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
        button:hover {
            background-color: #3b31c4;
        }
        </style>    
    </head>
    <body>
        <center>
            <form class="addstudent" action="A-AddStudent.jsp" method="post">
                <h3>Add Student</h3>
                Name: <input type="text" name="name"><br>
                Email: <input type="email" name="email"><br>
                Password: <input type="password" name="password"><br>
                Roll No.: <input type="num" name="rollno"><br>
                <button type="submit">Submit</button>
            </form>
            <a href="AdminDashboard.jsp">
                <button type="submit">Dashboard</button>
            </a>
        </center>
    <%
        try {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String rollno = request.getParameter("rollno");
                if("POST".equalsIgnoreCase(request.getMethod())){
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");
                    String add = "insert into student(name, email, password, roll_no) values(?, ?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(add);
                    ps.setString(1, name);
                    ps.setString(2, email);
                    ps.setString(3, password);
                    ps.setString(4, rollno);
                    int rows = ps.executeUpdate();
                    if(rows>0){
                        out.println("<script>alert('Student Added successfully!');</script>");
                    }
                    else{
                        out.println("<script>alert('error');</script>");
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error:</p>"+ e.getMessage());
            }
    %>
    </body>
</html>
