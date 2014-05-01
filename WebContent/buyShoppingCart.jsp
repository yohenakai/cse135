<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Buy Cart</title>
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

<h1>Confirm order and pay.</h1>

<p3>These are the items in your cart:</p3>
<p>~~~~~items here~~~~</p>
<br>

<p3>
<form method="GET" action="confirmation.jsp">
		Enter credit card:<input type="number" name="cardNum"/><br></p3>
		<input type="submit" value="Confirm Order"/> 
</form>
</body>
</html>