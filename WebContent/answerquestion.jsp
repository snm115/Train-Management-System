<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
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

<%if(session.getAttribute("usertype").equals("customer_rep")){ 
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		
		String username = (String)session.getAttribute("username");
		String ticket_num = request.getParameter("ticket_num");
		String answer_content = request.getParameter("answer");
		String qry = "update messages set answer_content = ?, customer_rep = ? where ticket_num = ?";
		
		PreparedStatement ps = con.prepareStatement(qry);
		ps.setString(1, answer_content);
		ps.setString(2, username);
		ps.setString(3, ticket_num);
		ps.executeUpdate();			 
		response.sendRedirect("q_a.jsp");
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Question Failed To Answer");
		
		out.println("<a href='homepage.jsp'>Back</a>");
		
	}

	
}
else{
	response.sendRedirect("homepage.jsp");
}%>


</body>
</html>