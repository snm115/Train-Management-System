<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>View Reservations</title>
<style>
table,tr,td{
border:1px solid black]}</style>
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>Produce a Listing of Revenue</h1>

<%if(session.getAttribute("usertype").equals("admin")){ %>
<% 
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		java.util.Date current_date = new java.util.Date();
		java.sql.Date sdate = new java.sql.Date(current_date.getTime());
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
 %>

Filter by Customer
<br>
	<form method="get" action="revenuelisting.jsp">
		<table>
			<tr>    
				<td>By Customer Name:</td><td><input type="text" name="customer"></td>
			</tr>
		</table>
		<input type="submit" value="Filter">
	</form>
<br>
Filter by Transit
<br>
	<form method="get" action="revenuelisting.jsp">
		<table>
			<tr>    
				<td>Transit Line: </td><td><input type="text" name="transit"></td>
			</tr>
		</table>
		<input type="submit" value="Filter">
	</form>
<br>
<% 		

		String customer = request.getParameter("customer");
		String transit_line = request.getParameter("transit");
		String qry = "";
		
		if(customer != null){
			qry = "select sum(r.total_fare) totalsum,r.username "+ 
					"from Reserves2 r "+
					"where r.username = '"+customer+"' "+
					"group by r.username;";
			ResultSet result = stmt.executeQuery(qry);
			out.print("<style>");
			out.print("table, tr, td{");
			out.print("border: 1px solid black;");
			out.print("</style>");
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("<strong>Username</strong>");
			out.print("</td>");
			out.print("<td>");
			out.print("<strong>Fee</strong>");
			out.print("</td>");
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("r.username"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("totalsum"));
				out.print("</td>");
			}
			out.print("</table>");
		}
		else if(transit_line != null){
			qry = "select sum(r.total_fare) totalsum,r.transit_name "+ 
					"from Reserves2 r "+
					"where r.transit_name = '"+transit_line+"' ";
			ResultSet result = stmt.executeQuery(qry);
			out.print("<style>");
			out.print("table, tr, td{");
			out.print("border: 1px solid black;");
			out.print("</style>");
			out.print("<table>");
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("<strong>Transit Line</strong>");
			out.print("</td>");
			out.print("<td>");
			out.print("<strong>Fee</strong>");
			out.print("</td>");
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("r.transit_name"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("totalsum"));
				out.print("</td>");
			}
			out.print("</table>");
		}
		
		out.print("<style>");
		out.print("table, tr, td{");
		out.print("border: 1px solid black;");
		out.print("</style>");
		out.print("<table>");
		
		
		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>	<%}%>