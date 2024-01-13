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

		//Get parameters from the HTML form at the HelloWorld.jsp
		String sched_num = request.getParameter("sched_num");
		String trainid = request.getParameter("trainid");
		String arrival_time = request.getParameter("arrival_time");
		String depart_time = request.getParameter("depart_time");
		String origin_station = request.getParameter("origin_station_name");
		String dest_station = request.getParameter("dest_station_name");
		String fare = request.getParameter("fare");
		
		String qry = "update tempsched "+
				"set arrtime = '"+arrival_time+"', deptime = '"+depart_time+"' , total_fare = "+fare+ ", originstop="+origin_station+",deststop="+dest_station+",trainid="+trainid+""+
				" where schednum="+sched_num+";";
		stmt.executeUpdate(qry);
		out.println(qry);
		response.sendRedirect("edittrainschedule.jsp");
		



		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Edit Failed");
		%>
		<a href="edittrainschedule.jsp">Back</a>
		<%
	}
%>
</body>
</html>