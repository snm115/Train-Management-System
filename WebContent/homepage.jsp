<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Homepage</title>
	</head>
	<body>
	<!-- in the future, may have to display train schedule -->
<%

	if(session.getAttribute("username") == null){		
		response.sendRedirect("login.jsp");
	}
	out.println("User "+session.getAttribute("username") +" is logged in.");%>
	<br/>
	<a href='logout.jsp'>Log out</a>
	<br/>
	<%if(session.getAttribute("usertype").equals("admin")){ %>
	Admin Homepage
	<br/>
	<a href="viewusers.jsp"><button>View Users</button></a>
	<a href="salesreports.jsp"><button>View Sales Reports</button></a>
	<a href="viewreservations.jsp"><button>View Reservations(Admin)</button></a>
	<a href="revenuelisting.jsp"><button>View Revenue Listing</button></a>
	<a href="bestcustomer.jsp"><button>View Best Customer</button></a>
	<a href="besttransitlines.jsp"><button>View Top 5 Transit Lines</button></a>
	<%} 
	else if(session.getAttribute("usertype").equals("customer")){ %>
	Customer Homepage
	<br/>
	<a href="browseschedules.jsp"><button>Browse All Train Schedules</button></a>
	<a href="searchschedules.jsp"><button>Search Train Schedules</button></a>
	<a href="makereservation.jsp"><button>Make a Reservation</button></a>
	<a href="viewreservations.jsp"><button>View Reservations</button></a>
	<a href="q_a.jsp"><button>Contact Representative Q/A</button></a>
	<%} 
	else if(session.getAttribute("usertype").equals("customer_rep")){ %>
	Customer Representative Homepage
	<br/>
	<a href="edittrainschedule.jsp"><button>Edit/Delete Train Schedule Information</button></a>
	<a href="q_a.jsp"><button>View Questions and Answers</button></a>
	<a href="searchschedules.jsp"><button>View Train Schedules</button></a>
	<a href="viewreservations.jsp"><button>View Reservations(Customer Rep)</button></a>
	<%} %>
	
	
	
	
	

	</body>
</html>