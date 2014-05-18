<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sales Analytics</title>
</head>
<body>
<% if(Util.isOwner(session)) {%>

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
	
		String action = request.getParameter("action");
	%>
	
	
	<% if(action != null) {
		
		String age = request.getParameter("age");
		String state = request.getParameter("state");
		String category = request.getParameter("category");
		//String quarter = request.getParameter("quarter");
		
	} %>
	
	
	<%-- 2-dimensional report code --%>
	
	<%if(action != null && action.equals("Run Query")) { %>
	
	
	
	
	
	<% } else { %>
	
	
	
	<% } %>
	
	<%-- filters code --%>

	<form method="GET" action="salesAnalytics.jsp">
	
		<h3> Row Selection </h3>
		
		Row:
				<select name="rows">
		
				<option value="customers">Customers</option>
				<option value="states">States</option>
				
				</select> <p />
				
		<h3> Filters </h3>
				
		Age:
			<select name="age">
				<option value="all" selected="selected">All</option>
				<option value="0">0-9</option>
				<option value="1">10-19</option>
				<option value="2">20-29</option>
				<option value="3">30-39</option>
				<option value="4">40-49</option>
				<option value="5">50-59</option>
				<option value="6">60-69</option>
				<option value="7">70-79</option>
				<option value="8">80-89</option>
				<option value="9">90-99</option>
			</select> <p/>
		
		State: 
			<select name="state">
				<option value="al">AL</option>
				<option value="ak">AK</option>
				<option value="az">AZ</option>
				<option value="ar">AR</option>
				<option value="ca">CA</option>
				<option value="co">CO</option>
				<option value="ct">CT</option>
				<option value="de">DE</option>
				<option value="dc">DC</option>
				<option value="fl">FL</option>
				<option value="ga">GA</option>
				<option value="hi">HI</option>
				<option value="id">ID</option>
				<option value="il">IL</option>
				<option value="ia">IA</option>
				<option value="in">IN</option>
				<option value="ks">KS</option>
				<option value="ky">KY</option>
				<option value="la">LA</option>
				<option value="me">ME</option>
				<option value="md">MD</option>
				<option value="ma">MA</option>
				<option value="mi">MI</option>
				<option value="mn">MN</option>
				<option value="ms">MS</option>
				<option value="mo">MO</option>
				<option value="mt">MT</option>
				<option value="ne">NE</option>
				<option value="nv">NV</option>
				<option value="nh">NH</option>
				<option value="nm">NM</option>
				<option value="my">MY</option>
				<option value="nc">NC</option>
				<option value="nd">ND</option>
				<option value="oh">OH</option>
				<option value="ok">OK</option>
				<option value="or">OR</option>
				<option value="pa">PA</option>
				<option value="ri">RI</option>
				<option value="sc">SC</option>
				<option value="sd">SD</option>
				<option value="tn">TN</option>
				<option value="tx">TX</option>
				<option value="ut">UT</option>
				<option value="vt">VT</option>
				<option value="va">VA</option>
				<option value="wa">WA</option>
				<option value="wv">WV</option>
				<option value="wi">WI</option>
				<option value="wy">WY</option>			
			</select> <p />
			
			
		<%  //query for categories
			rs = statement.executeQuery("SELECT * FROM categories");
			ArrayList<String> categories = new ArrayList<String>();
		%>
			
		Category:
			
			<select name="category">
			<%
			while(rs.next())
			{
				categories.add(rs.getString("category"));
			%>
				<option value="<%=rs.getString("category")%>"><%=rs.getString("category")%></option>
			<% 
			} 
			%>
			</select> <p/>
		
		<%-- 	
		Quarter:
			<select name="quarter">
			
				<option value="fy">Full Year</option>
				<option value="wi">Winter</option>
				<option value="sp">Spring</option>
				<option value="su">Summer</option>
				<option value="fa">Fall</option>
				
			</select> <p/>
		--%>
			
		<input type="submit" name="action" value="Run Query"/>
			
	</form>

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

<% } else { //if for owner authentication %>
    
    <h3>You must be logged in first</h3>
   	<a href="login.html">Login</a>

<% } %>  

</body>
</html>