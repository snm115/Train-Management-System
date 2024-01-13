<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style>
table, th, td {
	border: 1px solid black;
	table-layout: fixed;
	word-break: break-all;
}
</style>
<meta charset="UTF-8">
<title>Customer Support</title>
</head>
<body>

<a href="login.jsp"><button>Log out</button></a>
<a href="homepage.jsp"><button>Home</button></a>
<h1>View Question/Answers</h1>
<br>
<form method="get" action="q_a.jsp">
		<table>
			<tr>    
				<td>Search Questions by Keywords</td><td><input type="text" name="keywords"></td>
			</tr>
		</table>
		<input type="submit" value="Search">
</form>
<a href="q_a.jsp"><button>View All</button></a>
<br><br>
<%if(session.getAttribute("usertype").equals("customer")){ 
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		
		String username = (String)session.getAttribute("username");
		String keywords = request.getParameter("keywords");
		String qry;
		if(keywords == null || keywords.equals("")){
			qry = "select * from messages where customer = '"+username+"'";
		}
		else{
			qry = "select * from messages where (match(subject_line) against ('"+keywords+"') "+
				  "or match(subject_line) against ('"+keywords+"') "+
				  "or match(answer_content) against ('"+keywords+"')) "+
				  "and customer = '"+username+"'";
		}
		ResultSet result;
		result = stmt.executeQuery(qry);
		
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
		out.print("<strong>Ticket Number</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Username</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Representative</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Subject</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Content</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Answer</strong>");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("ticket_num"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("customer"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("customer_rep"));
			out.print("</td>");
			out.print("<td>");	
			out.print("<textarea id='subject_line' name='subject_line' cols='20'>"+result.getString("subject_line")+"</textarea>");
			out.print("</td>");
			out.print("<td>");
			out.print("<textarea id='ticket_content' name='ticket_content' cols='20'>"+result.getString("ticket_content")+"</textarea>");
			out.print("</td>");
			out.print("<td>");
			out.print("<textarea id='answer_content' name='answer_content' cols='20'>"+result.getString("answer_content")+"</textarea>");
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");


		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Delete Failed");
		
		out.println("<a href='homepage.jsp'>Back</a>");
		
	}

	
%>
<br>
<strong>Post a new ticket:</strong>
<br>
	<form method="get" action="postquestion.jsp">
	<div style="overflow-x: auto;">
		<table>
			<tr>    
				<td>Subject</td><td><textarea id = "subject_line" name="subject_line" cols="50"> </textarea></td>
			</tr>
			<tr>
				<td>Request</td><td><textarea id ="content" name="content" rows = "10" cols = "50"></textarea></td>
			</tr>
		</table>
		<input type="submit" value="Post">
	</div>
	</form>
<br>

<% }%>

<%if(session.getAttribute("usertype").equals("customer_rep")){ 
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		
		String username = (String)session.getAttribute("username");
		String keywords = request.getParameter("keywords");
		String qry;
		if(keywords == null || keywords.equals("")){
			qry = "select * from messages";
		}
		else{
			qry = "select * from messages where (match(subject_line) against ('"+keywords+"') "+
				  "or match(subject_line) against ('"+keywords+"') "+
				  "or match(answer_content) against ('"+keywords+"')) ";
		}
		ResultSet result;
		result = stmt.executeQuery(qry);
		
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
		out.print("<strong>Ticket Number</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Username</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Representative</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Subject</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Content</strong>");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("<strong>Answer</strong>");
		out.print("</td>");
		out.print("</tr>");

		//parse out the results
		while (result.next()) {
			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print(result.getString("ticket_num"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("customer"));
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("customer_rep"));
			out.print("</td>");
			out.print("<td>");	
			out.print("<textarea id='subject_line' name='subject_line' cols='20'>"+result.getString("subject_line")+"</textarea>");
			out.print("</td>");
			out.print("<td>");
			out.print("<textarea id='ticket_content' name='ticket_content' cols='20'>"+result.getString("ticket_content")+"</textarea>");
			out.print("</td>");
			out.print("<td>");
			out.print("<textarea id='answer_content' name='answer_content' cols='20'>"+result.getString("answer_content")+"</textarea>");
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");


		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Delete Failed");
		
		out.println("<a href='homepage.jsp'>Back</a>");
		
	}
%>
<br>
<strong>Answer a Ticket</strong>
<br>
	<form method="get" action="answerquestion.jsp">
	<div style="overflow-x: auto;">
		<table>
			<tr>    
				<td>Ticket Number</td><td><textarea id = "ticket_num" name="ticket_num" cols="50"> </textarea></td>
			</tr>
			<tr>
				<td>Answer</td><td><textarea id ="answer" name="answer" rows = "10" cols = "50"></textarea></td>
			</tr>
		</table>
		<input type="submit" value="Post">
	</div>
	</form>
<br>
<% 
} %>




</body>
</html>