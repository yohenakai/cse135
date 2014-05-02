<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>Confirmation</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<% if(Util.isCustomer(session)) {%>


	<title>Thank you for buying</title>
	</head>
	<body>
	
	<%-- Import the java.sql package --%>
	            <%@ page import="java.sql.*"%>
	            <%@ page import="java.text.*"%>
	            <%@ page import="cse135.Util" %>
	
	<%-- -------- Open Connection Code -------- --%>
	<%
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	double total = 0.0;
	double subtotal;
	
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
	
	
	<h1>Thank you for purchasing</h1>
	
	<% rs = statement.executeQuery(
			"SELECT products.category, products.name, products.sku, products.price, orders.quantity " +
			"FROM products " +
			"INNER JOIN orders " +
			"ON products.sku = orders.productsku " +
			"WHERE orders.username = '" + session.getAttribute("username") +"'");		
	%>
	
	<h3>Purchased Products</h3>
	
	<table border="1">
	
	<th>Category</th>
	<th>Product</th>
	<th>SKU</th>
	<th>Price</th>
	<th>Quantity</th>
	
	<%	
	while (rs.next()) { %>

	<tr>
			<td> <%=rs.getString("category")%>  </td>
			<td> <%=rs.getString("name") %> </td>
			<td> <%=rs.getString("sku")%> </td>
			<td> <%=rs.getString("price")%> </td>
			<td> <%=rs.getString("quantity")%> </td>
			<% subtotal = Double.parseDouble(rs.getString("price")) * Integer.parseInt(rs.getString("quantity")); 
				total += subtotal;
			%>
	</tr>
	
	<% } %>
	
	</table>
	
	<%
	
	conn.setAutoCommit(false);
	pstmt = conn
	        .prepareStatement("DELETE from orders "+
	        				  "WHERE username = ?");
	
    pstmt.setString(1, (String)session.getAttribute("username"));
    int rowCount = pstmt.executeUpdate();

    // Commit transaction
    conn.commit();
    conn.setAutoCommit(true);
	
	%>
	
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
	
	<%DecimalFormat df = new DecimalFormat("#.##"); 
	total = Math.ceil(total*100)/100;
	%>
	
	Total Price: <%=df.format(total)%><br/><br/>
	
	
	<a href="productBrowsing.jsp">Back to browsing</a>
	

<% }else{%>
  
  <h3>You must be logged in first</h3>
  <a href="login.html">Login</a>

<% } %> 
</body>
</html>