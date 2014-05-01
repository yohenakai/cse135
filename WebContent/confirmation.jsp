<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Confirmation</title>
</head>
<body>

<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%@ page import="java.util.*"%>
            <%@ page import="cse135.Util" %>

<%
	try{
	Util.greeting(session.getAttribute("username").toString());
	}catch(NullPointerException e){}
%>

<h1>Thank you for buying </h1>
<p>~~~list of bought items here~~~</p>

<br>
<br>
<a href="productBrowsing.jsp?search=&category=all">Back to Browsing</a>

</body>
</html>