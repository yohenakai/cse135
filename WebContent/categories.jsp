<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Categories</title>
</head>
<body>
<h1>Categories page</h1>
<h3><%=Util.greeting(session.getAttribute("username").toString()) %></h3>

<table>
    <tr>
        <td>
            <%-- Import the java.sql package --%>
            <%@ page import="java.sql.*"%>
            <%@ page import="cse135.Util" %>
            <%-- -------- Open Connection Code -------- --%>
            <%
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            ResultSet res = null;

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
            
            <%-- -------- INSERT Code -------- --%>
            <%
                String action = request.getParameter("action");
                // Check if an insertion is requested
                if (action != null && action.equals("insert")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmt = conn
                    .prepareStatement("INSERT INTO categories (category, description) VALUES (?, ?)");
                    
                    pstmt.setString(1, request.getParameter("category"));
                    pstmt.setString(2, request.getParameter("description"));
                   
                    
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
                if (action != null && action.equals("update")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // UPDATE student values in the Students table.
                    pstmt = conn
                        .prepareStatement("UPDATE categories SET description = ? "
                            + " WHERE category = ?");
                    
                    pstmt.setString(1, request.getParameter("descript"));
                    pstmt.setString(2, request.getParameter("categor"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>
            
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Create the prepared statement and use it to
                    // DELETE students FROM the Students table.
                    pstmt = conn
                        .prepareStatement("DELETE FROM categories WHERE category = ?");

                    pstmt.setString(1, request.getParameter("categ"));
                    int rowCount = pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                // Create the statement
                Statement statement = conn.createStatement();

                // Use the created statement to SELECT
                // the student attributes FROM the Student table.
                rs = statement.executeQuery("SELECT distinct c.category, c.description FROM categories c join products p on p.category = c.category");
            %>
            
            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
                <th>Category</th>
                <th>Description</th> 
            </tr>             


            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th><input value="" name="category" size="15"/></th>
                    <th><textarea  name="description" cols="25" rows="5"></textarea></th>
                    <th><input type="submit" value="Insert"/></th>
                </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // Iterate over the ResultSet
                while (rs.next()) {

            %>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
					<input type="hidden" value="<%=rs.getString("category")%>" name="categor"/>
                <%-- Get the id --%>
                <td>
                    <%=rs.getString("category")%>
                </td>

          

                <%-- Get the last name --%>
                <td>
                    <textarea  name="descript" cols="25" rows="5"><%=rs.getString("description")%></textarea>
                </td>
                
                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                

                
                
                <td>&nbsp;</td>
                

                      
                </tr>
                <%
                }
                // Iterate over the ResultSet
                res = statement.executeQuery("SELECT a.category, a.description from categories a where a.category not in (SELECT distinct c.category FROM categories c join products p on p.category = c.category)");

                while (res.next()) {

            %>

            <tr>
                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
					<input type="hidden" value="<%=res.getString("category")%>" name="categor"/>
                <%-- Get the id --%>
                <td>
                    <%=res.getString("category")%>
                </td>

          

                <%-- Get the last name --%>
                <td>
                    <textarea  name="descript" cols="25" rows="5"><%=res.getString("description")%></textarea>
                </td>
                
                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                

                
                
                



                <form action="categories.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=res.getString("category")%>" name="categ"/>
                    <%-- Button --%>

                <td><input type="submit" value="Delete"/></td>

                </form>
                      
                </tr>
                <%
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
                //throw new RuntimeException(e);
            	%>
    	        <h1>
    	        <font color="red">The requested data modification failed.</font>
    	        </h1>
    	        <%
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
        </table>
        </td>
    </tr>
</table>


</body>
</html>