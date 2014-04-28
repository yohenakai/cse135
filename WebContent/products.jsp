<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Products</title>
</head>
<body>

<h1>Products page</h1>
<h3><%=Util.greeting(session.getAttribute("username").toString()) %></h3>


<%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
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
            
             <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT * FROM categories");
            %>

	<form method="GET" action="ViewProducts.jsp">
		Search (Enter Product Name):
		<input type="text" name="searchinput"/> <p/>
		<input type="hidden" name="intersection" value="false"/>
		<input type="hidden" name="category" value="none"/>
		<input type="submit" value="Search"/>
	</form>


	<form method="POST" action="RegisterProduct.jsp">
		Product name: 
		<input type="text" name="productname"/> <p />
		
		SKU:
		<input type="text" name="sku"/> <p />
		
		Price: 
		<input type="text" name="price"/> <p />
		
		Category: 
		<select name="category">
		<% while (rs.next()) { %>
		
		<option value="<%=rs.getString("category")%>"> <%=rs.getString("category")%> </option>
		
		<% } %>	
		</select> <p />
		
		<input type="submit" value="Submit Product"/>
	</form>
	
	<h3>View products by categories</h3>
	
	<% 
	rs = statement.executeQuery("SELECT * FROM categories");
	while (rs.next()) {
	%>
	
	<a href="ViewProducts.jsp?intersection=false&category=<%=rs.getString("category")%>"><%=rs.getString("category")%></a>
	<br>
	
	<% } %>	
	<a href="ViewProducts.jsp?intersection=false&category=viewall">All Products</a>
	
	
	            <%-- -------- Close Connection Code -------- --%>
            <%
                // Close the ResultSet
                rs.close();

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


</body>
</html>