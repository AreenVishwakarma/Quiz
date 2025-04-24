<%-- 
    Document   : logout
    Created on : 11 Mar 2025, 5:13:19 pm
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Invalidate the session to log the user out
            session.invalidate();

            // Redirect to login page or home page
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
