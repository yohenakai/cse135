<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- Import the java.sql package --%>
	<%@ page import="java.sql.*"%>
	<%@ page import="cse135.Util"%>
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

        // Use the created statement to SELECT
        // the student attributes FROM the Student table.
        rs = statement.executeQuery("SELECT * FROM products where SKU = " +"'" + request.getParameter("sku")+ "'");
    %>
	<%-- -------- INSERT Code -------- --%>
	<%
	    if (!rs.next()) {
	
	        // Begin transaction
	        conn.setAutoCommit(false);
	
	        // Create the prepared statement and use it to
	        // INSERT student values INTO the students table.
	        pstmt = conn
	        .prepareStatement("INSERT INTO products (name, sku, price, category) VALUES (?,?,?,?)");
	
	        pstmt.setString(1, request.getParameter("productname"));
	        pstmt.setString(2, request.getParameter("sku"));
	        pstmt.setDouble(3, Double.parseDouble(request.getParameter("price")));
	        pstmt.setString(4, request.getParameter("category"));
	        int rowCount = pstmt.executeUpdate();
	
	        // Commit transaction
	        conn.commit();
	        conn.setAutoCommit(true); %>
	        
			<h1>Product Submission Successful</h1>
			
			<h3>Submitted Product:</h3>
			Category: <%=request.getParameter("category")%> <br>
			Product: <%=request.getParameter("productname")%> <br>
			SKU: <%=request.getParameter("sku")%> <br>
			Price: <%=request.getParameter("price")%> <br>
			
	        <%
	        
	    }
	    else{

			%>
	        <h1>Failure to insert new product</h1>
			
	        <% 
	    	
	    }
	 // Close the ResultSet
        rs.close();

        // Close the Statement
        statement.close();

        // Close the Connection
        conn.close();
    }catch (SQLException e) {

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