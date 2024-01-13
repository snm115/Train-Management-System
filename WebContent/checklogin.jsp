<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CheckLogin</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		ResultSet user;
		user = stmt.executeQuery("select * from users where username = '" + username + "'");
		if(user.next()) {
			ResultSet login;
			login = stmt.executeQuery("select * from users where username = '" + username + "' and pword = '" + password +"'");
			if(login.next()){
				session.setAttribute("username", username);
				ResultSet type = stmt.executeQuery("select usertype from users where username = '"+username+ "' and pword = '" + password +"'");
				if(type.next()){
					session.setAttribute("usertype", type.getString("usertype"));
				}
				response.sendRedirect("homepage.jsp");
			}
			else{
				out.println("User and Pass do not match. <a href='login.jsp'> Retry</a>");
				
			}
		}
		else{
			out.println("User does not exist.<a href='login.jsp'>Retry</a>");
		}



		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//out.print("CheckLogin Success");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login Failed");
	}
%>
</body>
</html>