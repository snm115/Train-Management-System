<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
table, th, td {
	border: 1px solid black;
}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Edit/Delete a Train Schedule</title>
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>Edit/Delete Train Schedule</h1>
Edit Train Schedule:

<br>
	<form method="get" action="edittrainhandler.jsp">
		<table>
			<tr>    
				<td>Schedule Number</td><td><input type="text" name="sched_num"></td>
			</tr>
			<td>Train ID</td><td><input type="text" name="trainid"></td>
			</tr>
			<tr>
				<td>Arrival Time</td><td><input type="text" name="arrival_time"></td>
			</tr>
			<tr>    
				<td>Departure Time</td><td><input type="text" name="depart_time"></td>
			</tr>
			<tr>    
				<td>Origin Station ID</td><td><input type="text" name="origin_station_name"></td>
			</tr>
			<tr>    
				<td>Destination Station ID</td><td><input type="text" name="dest_station_name"></td>
			</tr>
			<tr>    
				<td>Fare</td><td><input type="text" name="fare"></td>
			</tr>			
		</table>
		<input type="submit" value="Edit">
	</form>
<br>

Delete Train Schedule:
<br>
	<form method="get" action="deletetrainschedule.jsp">
		<table>
			<tr>    
				<td>Schedule Number</td><td><input type="text" name="sched_num"></td>
			</tr>			
		</table>
		<input type="submit" value="Delete">
	</form>
<br>


</body>
</html>