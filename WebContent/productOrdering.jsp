<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Order</title>
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
<h1 align = "center">Product Order Page</h1>
<p align = "right"> <a href="buyShoppingCart.jsp">Buy Cart?</a> <p>
<p3>
<form method="GET" action="productBrowsing.jsp">
		You have selected ___________ . <br> <br>
		How many do you want to add to cart?<input type="number" name="orderNum"/>
		<input type="submit" value="Add to Cart"/> </p3>
</form>
<br>
<p3> Current contents of cart: <br>
~~~~~contents here~~~~~~
</p3>
<br>
<br>
<br>
<a href="productBrowsing.jsp?search=&category=all">Back to Browsing</a>

</body>
</html>