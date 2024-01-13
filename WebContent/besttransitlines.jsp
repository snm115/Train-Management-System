<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Best Transit Lines</title>
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>Best Transit Lines</h1>

<%if(session.getAttribute("usertype").equals("admin")){ %>
<% 
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		%>
<form method="post" action="besttransitlines.jsp">
	<select name = "month">
		<option value="1">January</option>
		<option value="2">February</option>
		<option value="3">March</option>
		<option value="4">April</option>
		<option value="5">May</option>
		<option value="6">June</option>
		<option value="7">July</option>
		<option value="8">August</option>
		<option value="9">September</option>
		<option value="10">October</option>
		<option value="11">November</option>
		<option value="12">December</option>
	</select>
	<input type="submit" value="Get Best 5 Transit Lines">
</form> 
<% 
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String month = request.getParameter("month");
		String qry = "select count(r.transit_name), r.transit_name,  "+
				"MONTH(r.reserve_date) from Reserves2 r "+
				"where MONTH(r.reserve_date)="+month+"  order by count(r.transit_name) DESC limit 5;";
		
		//out.print(qry);
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(qry);
		
		//Make an HTML table to show the results in:
		out.print("<style>");
		out.print("table, tr, td{");
		out.print("border: 1px solid black;");
		out.print("</style>");
		out.print("<table>");
		
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		out.print("<strong># Reservations</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Transit Name</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Month</strong>");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("count(r.transit_name)"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.transit_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("MONTH(r.reserve_date)"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");

		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>	


<%}else { 
	response.sendRedirect("homepage.jsp");
} %>

</body>
</html>