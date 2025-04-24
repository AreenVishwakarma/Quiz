<%@ page import="java.sql.*" %>
<%
    String rollno = request.getParameter("rollno");
    
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "");

            String query = "DELETE FROM student WHERE roll_no = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, rollno);

            int rowsAffected = ps.executeUpdate();

            ps.close();
            con.close();

            // Redirect back to the main page (adjust if necessary)
            response.sendRedirect("A-DeleteStudent.jsp");
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
%>
