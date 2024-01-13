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
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>View Reservations</h1>

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
 
<!-- Sort by dropdown menu -->
Filter by Customer
<br>
	<form method="get" action="viewreservations.jsp">
		<table>
			<tr>    
				<td>Customer Name</td><td><input type="text" name="customer"></td>
			</tr>
		</table>
		<input type="submit" value="Filter">
	</form>
<br>
Filter by Transit
<br>
	<form method="get" action="viewreservations.jsp">
		<table>
			<tr>    
				<td>Transit Line</td><td><input type="text" name="transit"></td>
			</tr>
		</table>
		<input type="submit" value="Filter">
	</form>
<br>
<% 		

		String customer = request.getParameter("customer");
		String transit_line = request.getParameter("transit");
		String qry = "";
		if(transit_line == null && customer == null){		
			qry = "select r.res_id,r.reserve_date,r.username,r.trainid,r.transit_name,r.originstop, "+
					" r.deststop,r.deptime,r.arrtime,r.ticket_date,r.triptype,r.total_fare "+
					" from Reserves2 r"+
					" order by r.username;";
		}
		else if(customer != null){
			qry = "select r.res_id,r.reserve_date,r.username,r.trainid,r.transit_name,r.originstop, "+ 
					"r.deststop,r.deptime,r.arrtime,r.ticket_date,r.triptype,r.total_fare "+
					" from Reserves2 r"+
					" where r.username='"+customer+"'"+
					 " order by r.username;";
		}
		else if(transit_line != null){
			qry = "select r.res_id,r.reserve_date,r.username,r.trainid,r.transit_name,r.originstop, "+ 
					"r.deststop,r.deptime,r.arrtime,r.ticket_date,r.triptype,r.total_fare "+
					" from Reserves2 r"+
					" where r.transit_name='"+transit_line+"'"+
					" order by r.username;";
		}
		
		
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
		//make a column
		out.print("<td>");
		out.print("<strong>Reservation ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reservation Date</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Username</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>trainid</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>transit_name</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Start Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>End Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Departure Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Arrival Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Ticket Date</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Trip Type</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Fee</strong>");
		out.print("</td>");
		out.print("</tr>");

		
		//r.res_id,r.fee,r.sched_num,r.origin_station_id,r.dest_station_id,r.ticket_date,r.reserve_date,r.triptype
		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("r.res_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.reserve_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.username"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.trainid"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.transit_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.originstop"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.deststop"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.deptime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.arrtime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.ticket_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.triptype"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.total_fare"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");
		
		
		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>

<%}else if(session.getAttribute("usertype").equals("customer")){ %>
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
 
<!-- Sort by dropdown menu -->
Cancel an Existing Reservation:
<br>
	<form method="get" action="cancelexistingreservation.jsp">
		<table>
			<tr>    
				<td>Reservation ID: </td><td><input type="text" name="res_id"></td>
			</tr>			
		</table>
		<input type="submit" value="Cancel Reservation">
	</form>
<br>
<% 		
//out.println("this is the current date: "+sdate);
		//String sortfilter = request.getParameter("sort");
		String username =(String) session.getAttribute("username");
		String qry = "select r.res_id,r.reserve_date,r.trainid,r.transit_name,r.originstop,r.deststop,r.deptime,r.arrtime,r.ticket_date,r.triptype,r.total_fare "+
				"from Reserves2 r "+
				"where  r.username= '"+ username +"'"+
				" and r.ticket_date >= '"+ sdate +"'";
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(qry);

		//Make an HTML table to show the results in:
		out.print("<h3>");
		out.print("Current Reservations"); //HERE IS WHERE CURRENT RESERVATIONS ARE DISPLAYED
		out.print("</h3>");
		out.print("<style>");
		out.print("table, tr, td{");
		out.print("border: 1px solid black;");
		out.print("</style>");
		out.print("<table>");
		
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reservation ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reserve Date</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Train ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Transit Name</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Departure Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Arrival Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Departure Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Arrival Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Ticket Date</strong>");
		out.print("</td>");
		out.print("<td>");
		//make a column
		out.print("<strong>Trip Type</strong>");
		out.print("</td>");
		out.print("<td>");
		//make a column
		out.print("<strong>Total Fare</strong>");
		out.print("</td>");
		out.print("</tr>");

		
		//r.res_id,r.fee,r.sched_num,r.origin_station_id,r.dest_station_id,r.ticket_date,r.reserve_date,r.triptype
		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("r.res_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.reserve_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.trainid"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.transit_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.originstop"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.deststop"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.deptime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.arrtime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.ticket_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.triptype"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.total_fare"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");
		
		
		
		String q = "select r.res_id,r.reserve_date,r.trainid,r.transit_name,r.originstop,r.deststop,r.deptime,r.arrtime,r.ticket_date,r.triptype,r.total_fare "+
				"from reservations r2 "+
				"where  r2.username= '"+ username +"'"+
				" and r2.ticket_date < '"+ sdate +"'";
		
		//Run the query against the database.
		ResultSet res = stmt.executeQuery(q);
		out.print("<h3>");
		out.print("Past Reservations"); //HERE IS PAST RESERVATIONS DISPLAYED//
		out.print("</h3>");
		out.print("<style>");
		out.print("table, tr, td{");
		out.print("border: 1px solid black;");
		out.print("</style>");
		out.print("<table>");
		
		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reservation ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reserve Date</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Train ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Departure Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Arrival Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Departure Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Arrival Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Ticket Date</strong>");
		out.print("</td>");
		out.print("<td>");
		//make a column
		out.print("<strong>Trip Type</strong>");
		out.print("</td>");
		out.print("<td>");
		//make a column
		out.print("<strong>Total Fare</strong>");
		out.print("</td>");
		out.print("</tr>");
		
		//r.res_id,r.fee,r.sched_num,r.origin_station_id,r.dest_station_id,r.ticket_date,r.reserve_date,r.triptype
		//parse out the results
		while (res.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("r2.res_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.reserve_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.trainid"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.transit_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.originstop"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.tdeststop"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.rdeptime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.arrtime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.ticket_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.triptype"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r2.total_fare"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");
		
		
		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>	



<%}else if(session.getAttribute("usertype").equals("customer_rep")){ %>
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
 
<!-- Sort by dropdown menu -->
Find Reservations on Given Transit and Date
<br>
	<form method="get" action="viewreservations.jsp">
		<table>
			<tr>    
				<td>Date</td><td><input type="text" name="date"></td>
				<td>Transit Line</td><td><input type="text" name="transit"></td>
			</tr>
		</table>
		<input type="submit" value="Produce List">
	</form>
<br>

<% 		

		String date = request.getParameter("date");
		String transit_line = request.getParameter("transit");
		String qry = "";
		if(transit_line == null && date == null){		
			qry = "select tr.name, r.res_id, r.username, r.fee, r.sched_num, "+ 
					"s1.name, s2.name, r.reserve_date, r.ticket_date, "+
					"tst.depart_time, tst.arrival_time, r.triptype "+
					"from reservations r, stations s1, stations s2, train_schedule_times tst, transits tr, train_schedule ts "+
					"where r.origin_station_id = s1.station_id "+
					"and r.dest_station_id = s2.station_id "+
					"and r.sched_num = tst.sched_num "+
					"and r.sched_num = ts.sched_num "+
					"and tr.line_id = ts.line_id "+
					"group by r.res_id order by r.username";
		}
		else if(date != null){
			qry = "select tr.name, r.res_id, r.username, r.fee, r.sched_num, "+ 
					"s1.name, s2.name, r.reserve_date, r.ticket_date, "+
					"tst.depart_time, tst.arrival_time, r.triptype "+
					"from reservations r, stations s1, stations s2, train_schedule_times tst, transits tr, train_schedule ts "+
					"where r.origin_station_id = s1.station_id "+
					"and r.dest_station_id = s2.station_id "+
					"and r.sched_num = tst.sched_num "+
					"and r.sched_num = ts.sched_num "+
					"and tr.line_id = ts.line_id "+
					"and r.ticket_date = '"+date+"' "+
					"group by r.res_id";
		}
		else if(transit_line != null){
			qry = "select tr.name, r.res_id, r.username, r.fee, r.sched_num, "+ 
					"s1.name, s2.name, r.reserve_date, r.ticket_date, "+
					"tst.depart_time, tst.arrival_time, r.triptype "+
					"from reservations r, stations s1, stations s2, train_schedule_times tst, transits tr, train_schedule ts "+
					"where r.origin_station_id = s1.station_id "+
					"and r.dest_station_id = s2.station_id "+
					"and r.sched_num = tst.sched_num "+
					"and r.sched_num = ts.sched_num "+
					"and tr.line_id = ts.line_id "+
					"and tr.name = '"+transit_line+"' "+
					"group by r.res_id";
		}
		else{
			qry = "select tr.name, r.res_id, r.username, r.fee, r.sched_num, "+ 
					"s1.name, s2.name, r.reserve_date, r.ticket_date, "+
					"tst.depart_time, tst.arrival_time, r.triptype "+
					"from reservations r, stations s1, stations s2, train_schedule_times tst, transits tr, train_schedule ts "+
					"where r.origin_station_id = s1.station_id "+
					"and r.dest_station_id = s2.station_id "+
					"and r.sched_num = tst.sched_num "+
					"and r.sched_num = ts.sched_num "+
					"and tr.line_id = ts.line_id "+
					"and r.ticket_date = '"+date+"' "+
					"and tr.name = '"+transit_line+"' "+
					"group by r.res_id";
		}
		
		
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
		out.print("<strong>Transit Line</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reservation ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Username</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Fee</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Schedule Number</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Start Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>End Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Reservation Date</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Date of Travel</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Departure Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Arrival Time</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Trip Type</strong>");
		out.print("</td>");
		out.print("</tr>");

		
		//r.res_id,r.fee,r.sched_num,r.origin_station_id,r.dest_station_id,r.ticket_date,r.reserve_date,r.triptype
		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("tr.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.res_id"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.username"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.fee"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.sched_num"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("s1.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("s2.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.reserve_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.ticket_date"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tst.depart_time"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tst.arrival_time"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("r.triptype"));
			out.print("</td>");
			out.print("</tr>");

		}
		out.print("</table>");
		
		
		//close the connection.
		con.close();

	} catch (Exception e) {
	}
%>	

<%} %>

</body>
</html>