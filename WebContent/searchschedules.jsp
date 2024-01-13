<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Search Train Schedules</title>
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>Search Train Schedules</h1>
<%if(session.getAttribute("usertype").equals("admin")){ %>
	<% response.sendRedirect("homepage.jsp");%>
	
<%}else if(session.getAttribute("usertype").equals("customer")){ %>
<% 
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String qry="";
		%>
	<br>
		<form method="get" action="searchschedules.jsp">
			<table>
				<tr>    
					<td>Start Station</td><td><input type="text" name="origin_input"></td>
					<td>End Station</td><td><input type="text" name="destination_input"></td>
					<td>Date</td><td><input type="text" name="date_travel"></td>
				</tr>
			</table>
			<input type="submit" value="Search">
		</form>
	<br>
		<% 
		
		
		
		String testorigin="Suffern";
		String testdestination="Passaic";
		String testdate="2021-07-05"; 
		String origin = request.getParameter("origin_input");
		String destination = request.getParameter("destination_input");
		String date = request.getParameter("date_travel");
		String originval=" select traindepart.stop_id "+
				" from tempsched t1, trainstops traindepart "+
				" where traindepart.stop_id=t1.originstop "+
				" and traindepart.stop_name ='"+origin+"'"+
				" and t1.date_time='"+date+"' "+
				" group by stop_id;";
		ResultSet originres=stmt.executeQuery(originval);
		int departval=0;
		while(originres.next()){
			departval=originres.getInt("traindepart.stop_id");
		}
		//got the stopid for the departing train
		
		String destval=" select trainarrive.stop_id "+
				" from tempsched t1, trainstops trainarrive "+
				" where trainarrive.stop_id=t1.deststop "+
				" and trainarrive.stop_name ='"+destination+"'"+
				" and t1.date_time='"+date+"' "+
				" group by stop_id;";
		ResultSet destres=stmt.executeQuery(destval);
		int arriveval=0;
		while(destres.next()){
			arriveval=destres.getInt("trainarrive.stop_id");
		}
				
		//selected the stopid of the arriving destination where the name matches destination
		
		if(departval<arriveval){
		
		qry = "select t1.trainid, t1.transit_name,traindepart.stop_name , trainarrive.stop_name, "+
		"t1.deptime,t1.arrtime,t1.date_time, t1.total_fare "+
		"from trainstops traindepart,trainstops trainarrive,tempsched t1 "+
		"where t1.originstop=traindepart.stop_id "+
		"and t1.deststop=trainarrive.stop_id "+
		"and t1.date_time='"+date+"'"+
		
		"and traindepart.stop_id<trainarrive.stop_id "+
		
		"and traindepart.stop_id>= all("+
		" select traindepart.stop_id"+
		" from tempsched t1, trainstops traindepart"+
		" where traindepart.stop_id=t1.originstop"+
		" and traindepart.stop_name ='"+origin+"'"+
		" and t1.date_time='"+date+"'"+
		" group by stop_id)"+
		" and traindepart.stop_id< all("+
		" select trainarrive.stop_id"+
		" from tempsched t1, trainstops trainarrive"+
		" where trainarrive.stop_id=t1.deststop"+
		" and trainarrive.stop_name ='"+destination+"'"+
		" and t1.date_time='"+date+"'"+
		" group by stop_id)"+

		" and trainarrive.stop_id> all("+
		" select traindepart.stop_id"+
		" from tempsched t1, trainstops traindepart"+
		" where traindepart.stop_id=t1.originstop"+
		" and traindepart.stop_name ='"+origin+"'"+
		" and t1.date_time='"+date+"')"+
		" and trainarrive.stop_id<= all("+
		" select trainarrive.stop_id"+
		" from tempsched t1, trainstops trainarrive"+
		" where trainarrive.stop_id=t1.deststop"+
		" and trainarrive.stop_name ='"+destination+"'"+
		" and t1.date_time='"+date+"')"+
		" order by t1.trainid;";
		}
		
		else if(departval>arriveval){
			qry = "select t1.trainid, t1.transit_name,traindepart.stop_name , trainarrive.stop_name, "+
					"t1.deptime,t1.arrtime,t1.date_time, t1.total_fare "+
					"from trainstops traindepart,trainstops trainarrive,tempsched t1 "+
					"where t1.originstop=traindepart.stop_id "+
					"and t1.deststop=trainarrive.stop_id "+
					"and t1.date_time='"+date+"'"+
					
					"and traindepart.stop_id>trainarrive.stop_id "+
					
					"and traindepart.stop_id<= all("+
					" select traindepart.stop_id"+
					" from tempsched t1, trainstops traindepart"+
					" where traindepart.stop_id=t1.originstop"+
					" and traindepart.stop_name ='"+origin+"'"+
					" and t1.date_time='"+date+"'"+
					" group by stop_id)"+
					" and traindepart.stop_id> all("+
					" select trainarrive.stop_id"+
					" from tempsched t1, trainstops trainarrive"+
					" where trainarrive.stop_id=t1.deststop"+
					" and trainarrive.stop_name ='"+destination+"'"+
					" and t1.date_time='"+date+"'"+
					" group by stop_id)"+

					" and trainarrive.stop_id< all("+
					" select traindepart.stop_id"+
					" from tempsched t1, trainstops traindepart"+
					" where traindepart.stop_id=t1.originstop"+
					" and traindepart.stop_name ='"+origin+"'"+
					" and t1.date_time='"+date+"')"+
					" and trainarrive.stop_id>= all("+
					" select trainarrive.stop_id"+
					" from tempsched t1, trainstops trainarrive"+
					" where trainarrive.stop_id=t1.deststop"+
					" and trainarrive.stop_name ='"+destination+"'"+
					" and t1.date_time='"+date+"')"+
					" order by t1.trainid;";
		}
		
		
		
		
		/* String qry = "select t1.trainid, t1.transit_name, t2.stop_name, t3.stop_name,t1.deptime,t1.arrtime,t1.date_time "+
		
				"from tempsched t1, trainstops t2,trainstops t3 "+
				"where t1.originstop=t2.stop_id "+
				"and t1.deststop=t3.stop_id "+
				"and t2.stop_name = '"+ origin +"'"+
				" and t3.stop_name = '"+ destination +"'"+
				" and t1.date_time = '"+ date +"'"; */
		
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
	<br>
		<form method="get" action="searchschedules.jsp">
			<table>
				<tr>    
					<td>Station Name</td><td><input type="text" name="station"></td>
				</tr>
			</table>
			<input type="submit" value="Search By Station">
		</form>
	<br>
		<% 
		String station = request.getParameter("station");
		String qry = "select t1.trainid, t1.transit_name,traindepart.stop_name , trainarrive.stop_name, "+
				"t1.deptime,t1.arrtime,t1.date_time, t1.total_fare "+
				"from trainstops traindepart,trainstops trainarrive,tempsched t1 "+
				"where t1.originstop=traindepart.stop_id "+
				"and t1.deststop=trainarrive.stop_id "+
				"and (traindepart.stop_name = '"+station+"' or trainarrive.stop_name = '"+station+"');";
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(qry);

		//Make an HTML table to show the results in:
		out.print("<style>");
		out.print("table, tr, td{");
		out.print("border: 1px solid black;");
		out.print("</style>");
		out.print("<table>");
		
		//make a row
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
<%} %>

</body>
</html>