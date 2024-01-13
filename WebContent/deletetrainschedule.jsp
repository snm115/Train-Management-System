<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Edit/Delete a Train Schedule</title>
</head>
<body>
<h1>Edit Train Schedule Handler</h1>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		
		String sched_num = request.getParameter("sched_num");
		String qry = "delete from tempsched where sched_num = "+sched_num;
	
		stmt.executeUpdate(qry);
		out.println(qry);
		response.sendRedirect("edittrainschedule.jsp");
		



		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Delete Failed");
		%>
		<a href="edittrainschedule.jsp">Back</a>
		<%
	}
%>
</body>
</html>