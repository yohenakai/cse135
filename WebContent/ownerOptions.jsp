<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Options</title>
</head>
<body>
<h1>Options</h1>
<h3><%=Util.greeting(session.getAttribute("username").toString()) %></h3>

<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%@ page import="cse135.Util" %>
            <%-- -------- Open Connection Code -------- --%>
<li><a href="categories.jsp">Product Categories</a></li>
<li><a href="products.jsp">Add/View Products</a></li>
</body>
</html>