<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Edit Account</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String first_name = request.getParameter("first_name");
		String last_name = request.getParameter("last_name");
		String email = request.getParameter("email");
		String ssn=request.getParameter("ssn");
		String usertype=request.getParameter("usertype");
		
		//Check if username exists in the database
		String query = "SELECT * FROM users WHERE username = '" + username + "'";
		ResultSet rs = stmt.executeQuery(query);
		
		if(!rs.next()){
			//redirect to failure.jsp
			response.sendRedirect("usernotfound.jsp");
		}

		//Make an delete statement for the customer table:
			String update = "update users set pword=?, first_name=?, last_name=?, email=?, ssn=?, usertype=? where username = ?";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(update);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, password);
		ps.setString(2, first_name);
		ps.setString(3, last_name);
		ps.setString(4, email);
		ps.setString(5, ssn);
		ps.setString(6, usertype);
		ps.setString(7, username);
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("edit succeeded <a href='viewusers.jsp'>Back</a>");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("edit failed");
	}
%>
</body>
</html>