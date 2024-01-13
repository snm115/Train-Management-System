<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Browse Train Schedules</title>
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>Browse Train Schedules</h1>

<%if(session.getAttribute("usertype").equals("admin")){ %>
	<% response.sendRedirect("homepage.jsp");%>

<%}else if(session.getAttribute("usertype").equals("customer") ||session.getAttribute("usertype").equals("customer_rep")){ %>
<% 
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
 %>
 
<!-- Sort by dropdown menu -->
<form method="post" action="browseschedules.jsp">
	<select name = "sort">
		<option value="t1.arrtime">Sort By Arrival Time</option>
		<option value="t1.deptime">Sort By Departure Time</option>
		<option value="tl.total_fare">Sort By Fare</option>
	</select>
	<input type="submit" value="Sort">
	</form> 
	
	

<% 		
		String sortfilter = request.getParameter("sort");
		String qry = "select t1.trainid, t1.transit_name,traindepart.stop_name , trainarrive.stop_name, "+
				"t1.deptime,t1.arrtime,t1.date_time, t1.total_fare "+
				"from trainstops traindepart,trainstops trainarrive,tempsched t1 "+
				"where t1.originstop=traindepart.stop_id "+
				"and t1.deststop=trainarrive.stop_id "+
				"order by "+ sortfilter;
		
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
		out.print("<strong>Train ID</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Transit Line</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>From</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>To</strong>");
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
		//make a column
		out.print("<strong>Date</strong>");
		out.print("</td>");
		out.print("<td>");
		//make a column
		out.print("<strong>Fare</strong>");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("t1.trainid"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("t1.transit_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("traindepart.stop_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("trainarrive.stop_name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("t1.deptime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("t1.arrtime"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("t1.date_time"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("t1.total_fare"));
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
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
 %>
 
<!-- Sort by dropdown menu -->
<form method="post" action="browseschedules.jsp">
	<select name = "sort">
		<option value="tst.arrival_time">Sort By Arrival Time</option>
		<option value="tst.depart_time">Sort By Departure Time</option>
		<option value="tl.fare">Sort By Fare</option>
	</select>
	<input type="submit" value="Sort">
	</form> 
	
	

<% 		
		String sortfilter = request.getParameter("sort");
		String qry = "select ts.sched_num, tl.name, tst.depart_time, tst.arrival_time, s1.name, s2.name, tl.fare, tst.date "+
				"from transits tl, train_schedule ts, train_schedule_times tst, stations s1, stations s2, transit_routes tr "+
				"where tl.line_id = tr.line_id "+
				"and tr.origin_station_id = s1.station_id "+
				"and tr.dest_station_id = s2.station_id "+
				"and ts.line_id = tl.line_id "+
				"and tst.sched_num = ts.sched_num "+
				"and tst.route_id = tr.route_id " +
				"order by "+ sortfilter;
		
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
		out.print("<strong>Schedule Number</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Transit Line</strong>");
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
		out.print("<strong>Start Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>End Station</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Fare</strong>");
		out.print("</td>");
		out.print("<td>");
		//make a column
		out.print("<strong>Date</strong>");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("ts.sched_num"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tl.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tst.depart_time"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tst.arrival_time"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("s1.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("s2.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tl.fare"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("tst.date"));
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