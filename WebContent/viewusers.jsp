<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>View all users</title>
</head>
<body>
<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>

<article>
<header>
<h1>Users</h1>
</header>
</article>
<% 
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Run the query against the database.
			ResultSet result = stmt.executeQuery("select * from users");

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
			out.print("<strong>username</strong>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("<strong>password</strong>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("<strong>first name</strong>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("<strong>last name</strong>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("<strong>email</strong>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("<strong>ssn</strong>");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("<strong>usertype</strong>");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("username"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("pword"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("first_name"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("last_name"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("email"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("ssn"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("usertype"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
%>
<br/>
Edit User:
<br>
	<form method="post" action="admineditaccount.jsp">
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
	<tr>
	<select name = "usertype">
		<option value="customer">customer</option>
		<option value="customer_rep">customer_rep</option>
	</select>
	</tr>
	</table>
	<input type="submit" value="Edit Account">
	</form>
<br>
Delete User:
<br>
	<form method="post" action="admindeleteaccount.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	</table>
	<input type="submit" value="Delete Account">
	</form>
<br>
<br/>
<!-- Adding new user form -->
Create a new account:
<br>
	<form method="post" action="admincreateaccount.jsp">
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
	<tr>
	<select name = "usertype">
		<option value="customer">customer</option>
		<option value="customer_rep">customer_rep</option>
	</select>
	</tr>
	</table>
	<input type="submit" value="Create Account">
	</form>
<br>
</body>
</html>