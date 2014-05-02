	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<% if(Util.isCustomer(session)) {%>

	<title>Product Order</title>
	</head>
	<body>
	
	<%-- Import the java.sql package --%>
	            <%@ page import="java.sql.*"%>
	            <%@ page import="java.util.*"%>
	            <%@ page import="cse135.Util" %>
    <%-- -------- Open Connection Code -------- --%>
	<%
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
	    // Registering Postgresql JDBC driver with the DriverManager
	    Class.forName("org.postgresql.Driver");
	
	    // Open a connection to the database using DriverManager
	    conn = DriverManager.getConnection(
	        "jdbc:postgresql://" +
	    	Util.SERVERNAME + ":" +
	    	Util.PORTNUMBER + "/" +
	    	Util.DATABASE,
	    	Util.USERNAME,
	        Util.PASSWORD);
	%>
	<%-- ---- Getting the database------ --%>
	<%
        // Create the statement
        Statement statement = conn.createStatement();
    %>
	
	<h1>Product Order Page</h1>
	
	You have selected <%=request.getParameter("name")%>.
	
	<form method="POST" action="AddToCart.jsp">
		<input type="hidden" name="productsku" value="<%=request.getParameter("sku")%>"/>
		<input type="hidden" name="username" value="<%=session.getAttribute("username")%>"/>
		
		How many do you want to add to cart?
		<input type="number" min="1" value="1" name="quantity"/>
		
		<input type="submit" value="Add to Cart"/> 
	</form>
	
	
	<% rs = statement.executeQuery(
			"SELECT products.category, products.name, products.sku, products.price, orders.quantity " +
			"FROM products " +
			"INNER JOIN orders " +
			"ON products.sku = orders.productsku " +
			"WHERE orders.username = '" + session.getAttribute("username") +"'");		
	%>
	
	<h3>Current contents of cart</h3>
	
	<table border="1">
	
	<th>Category</th>
	<th>Product</th>
	<th>SKU</th>
	<th>Price</th>
	<th>Quantity</th>
	
	<%	while (rs.next()) { %>

	<tr>
			<td> <%=rs.getString("category")%>  </td>
			<td> <%=rs.getString("name") %> </td>
			<td> <%=rs.getString("sku")%> </td>
			<td> <%=rs.getString("price")%> </td>
			<td> <%=rs.getString("quantity")%> </td>

	</tr>
	
	<% } %>
	
	</table>
	
	<%-- -------- Close Connection Code -------- --%>
    <%
            // Close the ResultSet
            //rs.close();

            // Close the Statement
            statement.close();

            // Close the Connection
            conn.close();
        } catch (SQLException e) {

            // Wrap the SQL exception in a runtime exception to propagate
            // it upwards
            throw new RuntimeException(e);
        }
        finally {
            // Release resources in a finally block in reverse-order of
            // their creation

            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) { } // Ignore
                rs = null;
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) { } // Ignore
                pstmt = null;
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) { } // Ignore
                conn = null;
            }
        }
	%>
	

	
<% }else{%>
   
   <h3>You must be logged in first</h3>
   <a href="login.html">Login</a>

<% } %> 

</body>
</html>