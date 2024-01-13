<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Main Customer Reservation Page</title>
	</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<%
out.println("User "+session.getAttribute("username") +" is logged in.");
%>
<br>
Create a reservation:
<br>
	<form method="post" action="createreservation.jsp">
	<table>
	<tr>
	<td>Train ID</td><td><input type="text" name="trainid"></td>
	
	</tr>
	<tr>
	<td>Origin Station ID</td><td><input type="text" name="originstop"></td>
	
	</tr>
	
	<tr>
	<td>Destination Station ID</td><td><input type="text" name="deststop"></td>
	</tr>
	<tr>
	<td>Departure Time</td><td><input type="text" name="deptime"></td>
	</tr>
	<tr>
	<td>Arrival Time</td><td><input type="text" name="arrtime"></td>
	</tr>
	<tr>
	<td>Date</td><td><input type="text" name="ticket_date"></td>
	</tr>
	<tr>
	<td>Trip Type</td><td><input type="radio" name="triptype" value="oneway"/>One Way
  	
  	<input type="radio" name="triptype" value="roundtrip"/>Round Trip</td>
	</tr>
	<tr>
	<td>Discount?</td><td>
	<input type="radio" name="discount" value="student"/>Student Rider Discount
  	
  	<input type="radio" name="discount" value="senior"/>Senior Rider Discount
  	
  	<input type="radio" name="discount" value="disabled"/>Disabled Rider Discount
	<input type="radio" name="discount" value="none"/>None
	</td>
	</tr>
	
	</table>
	<input type="submit" value="Create Reservation">
	</form>
<br>


</body>
</html>