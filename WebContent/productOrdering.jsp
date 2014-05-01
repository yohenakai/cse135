<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Order</title>
</head>
<body>
<h1>Products Browsing page</h1>

<h3><%
	try{
	Util.greeting(session.getAttribute("username").toString());
	}catch(NullPointerException e){
		
	}
	
%></h3>


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
            
             <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                //rs = statement.executeQuery("SELECT * FROM categories");
            %>

	<form method="GET" action="productBrowsing.jsp">
		Search (Enter Product Name):
		<input type="text" name="search"/> <p/>
		<input type="hidden" name="category" value=<%=request.getParameter("category")%>>
		<input type="submit" value="Search"/>
	</form>

<h3>View products by categories</h3>
	
	<% 
	rs = statement.executeQuery("SELECT * FROM categories");
	ArrayList<String> categories = new ArrayList<String>();
	while(rs.next())
	{
		categories.add(rs.getString("category"));
	}
	for (int i = 0; i < categories.size(); i++) {
	%>
	
	<a href="productBrowsing.jsp?search=&category=<%=categories.get(i)%>"><%=categories.get(i)%></a>
	<br>
	
	<% } %>	
	<a href="productBrowsing.jsp?search=&category=all">All Products</a>


	<% 
	String cat = request.getParameter("category");
    String search = request.getParameter("search");
    if(cat != null && search != null)
    {
	    if(!search.equals(""))
	    {
	    	if(cat.equals("all") || cat.equals(""))
	    	{
	    		rs = statement.executeQuery("SELECT * FROM products where name LIKE" + "'%" + search + "%'");
	    	}
	    	else
	    	{
	    		rs = statement.executeQuery("SELECT * FROM products where category = " + "'" + cat + "' AND name LIKE" + "'%" + search+ "%'");		
	    	}
	    }
	    
	    else
	    {
	        if(cat.equals("all")){
	        	rs = statement.executeQuery("SELECT * FROM products");
	        }
	        else
	        {
	        	rs = statement.executeQuery("SELECT * FROM products where category = " +"'" + cat+ "'");
	        }
	    }
       
	   	if (rs.isBeforeFirst())
	   	{
	%>
	<h3>Search Result</h3>
	
	<table border="1">
	
	<th>Category</th>
	<th>Product</th>
	<th>SKU</th>
	<th>Price</th>
	
		<%	while (rs.next()) { %>

	<tr>
			<input type="hidden" name="searchinput" value=<%=search%>>
			<input type="hidden" name="cat" value=<%=cat%>>
			<input type="hidden" name="oldsku" value="<%=rs.getString("sku")%>"/>
			<td> <%=rs.getString("category")%>  </td>
			<td> <%=rs.getString("name")%> </td>
			<td> <%=rs.getString("sku")%> </td>
			<td> <%=rs.getString("price")%> </td>

	</tr>
	
		<% } %>
	
	</table>
	<% 
		} 
		else 
		{}
	}
   	%>


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