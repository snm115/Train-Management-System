<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Login Page</title>
	</head>
<body>

Log in to existing account:
<br>
	<form method="get" action="checklogin.jsp">
		<table>
			<tr>    
				<td>Username</td><td><input type="text" name="username"></td>
			</tr>
			<tr>
				<td>Password</td><td><input type="text" name="password"></td>
			</tr>
		</table>
		<input type="submit" value="Login">
	</form>
<br>


Create a new account:
<br>
	<form method="post" action="createaccount.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="password"></td>
	</tr>
	<tr>
	<td>First Name</td><td><input type="text" name="first_name"></td>
	</tr>
	<tr>
	<td>Last Name</td><td><input type="text" name="last_name"></td>
	</tr>
	<tr>
	<td>Email</td><td><input type="text" name="email"></td>
	</tr>
	<tr>
	<td>ssn</td><td><input type="text" name="ssn"></td>
	</tr>
	</table>
	<input type="submit" value="Create Account">
	</form>
<br>


</body>
</html>