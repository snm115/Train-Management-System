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

<%if(session.getAttribute("usertype").equals("customer")){ 
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		
		String username = (String)session.getAttribute("username");
		String subject_line = request.getParameter("subject_line");
		String ticket_content = request.getParameter("content");
		String qry = "insert into messages(customer, subject_line, ticket_content, answer_content) values (?, ?, ?, ?)";
		
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, username);
		ps.setString(2, subject_line);
		ps.setString(3, ticket_content);
		ps.setString(4, "Not yet answered");
		ps.executeUpdate();			 
		response.sendRedirect("q_a.jsp");
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Question Failed To Post");
		
		out.println("<a href='homepage.jsp'>Back</a>");
		
	}

	
}%>





</body>
</html>