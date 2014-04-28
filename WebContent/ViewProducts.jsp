<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<h1>View Products</h1>
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
                String cat = request.getParameter("category");
                String intersection = request.getParameter("intersection");
                String searchinput = request.getParameter("searchinput");
                String title;
                
                if(intersection.equals("true"))
                {
                	title = "Search Result";
                	if(cat.equals("viewall"))
                	{
                		rs = statement.executeQuery("SELECT * FROM products where name LIKE" + "'%" + searchinput + "%'");
                	}
                	else
                	{
                		rs = statement.executeQuery("SELECT * FROM products where category = " + "'" + cat + "' AND name LIKE" + "'%" + searchinput+ "%'");		
                	}
                }
                
                else
                {
	                if(cat.equals("viewall")){
	                	title = "View All Products";
	                	rs = statement.executeQuery("SELECT * FROM products");
	                }
	                else if(cat.equals("none"))
	                {
	                	title = "Search Result";
	                	rs = statement.executeQuery("SELECT * FROM products where name LIKE "+ "'%" + searchinput+ "%'");
	                }
	                else
	                {
	                	title = "Category: " + cat;
	                	rs = statement.executeQuery("SELECT * FROM products where category = " +"'" + cat+ "'");
	                }
                }
             %>
             
     <form method="GET" action="ViewProducts.jsp">
	
		Search (Enter Product Name):
		<input type="text" name="searchinput"/> <p/>
		<input type="hidden" name="intersection" value="true"/>
		<input type="hidden" name="category" value="<%=cat%>"/>
		<input type="submit" value="Search"/>
	
	</form>
	
	<h3><%=title%></h3>
	
	<table border="1">
	
	<th>Category</th>
	<th>Product</th>
	<th>SKU</th>
	<th>Price</th>
	
	<% while (rs.next()) { %>

	<tr>
		<td>  <%=rs.getString("category")%> </td>
		<td>  <%=rs.getString("name")%> </td>
		<td>  <%=rs.getString("sku")%> </td>
		<td>  <%=rs.getString("price")%> </td>
	</tr>
	
	<% } %>
	
	</table>
	
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