<%-- 
    Document   : A-DeleteStudent
    Created on : 22 Apr 2025, 5:31:10 am
    Author     : hp
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Remove Student</h1>
<%--<%@ page import="java.sql.*" %>--%>
<%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

            String query = "SELECT * FROM student";
            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String id = rs.getString("student_id");
                String studentName = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String rollno = rs.getString("roll_no");
%>
                <div>
                    <p>ID: <%= id %></p>
                    <p>Name: <%= studentName %></p>
                    <p>Email: <%= email %></p>
                    <p>Password: <%= password %></p>
                    <p>Roll No: <%= rollno %></p>
                    <form action="A-Delete.jsp" method="post">
                        <input type="hidden" name="rollno" value="<%= rollno %>">
                        <input type="submit" value="Delete">
                    </form>
                    <hr>
                </div>
<%
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
%>
    </body>
</html>
