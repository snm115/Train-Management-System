<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make a Reservation (Customer)</title>
</head>
<body>

<%
out.println("User "+session.getAttribute("username") +" is logged in.");
%>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String username =(String) session.getAttribute("username");
		
		int trainid = Integer.parseInt(request.getParameter("trainid"));
		int origin_station_id = Integer.parseInt(request.getParameter("originstop"));
		int dest_station_id = Integer.parseInt(request.getParameter("deststop"));
		int deptime = Integer.parseInt(request.getParameter("deptime"));
		int arrtime = Integer.parseInt(request.getParameter("arrtime"));
		
		String ticket_date = request.getParameter("ticket_date");
		String t = request.getParameter("triptype");
		String discount = request.getParameter("discount");
		java.util.Date current_date = new java.util.Date();
		java.sql.Date sdate = new java.sql.Date(current_date.getTime());
		
		String transitname="select t1.transit_name from tempsched t1"+
		" where t1.trainid="+trainid+" "+
		"group by trainid;";
		ResultSet transitres=stmt.executeQuery(transitname);
		String transit_name="";
		while(transitres.next()){
			
			transit_name=transitres.getString("t1.transit_name");
		}
		
		
		
		/* START OF PART TO CALCULATE THE FARE TOTAL BASED ON TRIPTYPE AND DISCOUNT */
		//String stringfare;
		float intfare=0;
		float fare_total=0;
		String qry="";
		if (origin_station_id<dest_station_id){
			qry="select sum(t1.total_fare) as 'total_fare' "+
				" from tempsched t1 "+
				" where trainid= "+ trainid+ " "+
				" and date_time= '"+ ticket_date+ "' "+
				" and originstop>= "+ origin_station_id+ " "+
				" and originstop< "+ dest_station_id+ " "+
				" and deststop> "+ origin_station_id +" "+
				" and deststop<= "+ dest_station_id+ " "+
				" and deptime>= "+ deptime+ " "+
				" and deptime< "+ arrtime+ " "+
				" and arrtime> "+ deptime+ " "+
				" and arrtime<= "+ arrtime+ ";";
		}
		else if (origin_station_id>dest_station_id){
			qry="select sum(t1.total_fare) as 'total_fare' "+
					" from tempsched t1 "+
					" where trainid= "+ trainid+ " "+
					" and date_time= '"+ ticket_date+ "' "+
					" and originstop<= "+ origin_station_id+ " "+
					" and originstop> "+ dest_station_id+ " "+
					" and deststop< "+ origin_station_id +" "+
					" and deststop>= "+ dest_station_id+ " "+
					" and deptime>= "+ deptime+ " "+
					" and deptime< "+ arrtime+ " "+
					" and arrtime> "+ deptime+ " "+
					" and arrtime<= "+ arrtime+ ";";
		}
		ResultSet res=stmt.executeQuery(qry);
		while(res.next()){
			
			intfare=res.getFloat("total_fare");
			//out.println(intfare);
		}
		if(t.equals("roundtrip")){
			intfare=2*intfare;
			//out.println("this is a round trip total: "+intfare);
		}
		else if(t.equals("oneway")){
			//out.println("this is a one way trip");
		}
		if(discount==null||discount.isEmpty()||discount.equals("none")){
			fare_total=intfare;
		}
		else if (discount.equals("senior")){
			fare_total=(float)0.65*intfare;
			//out.println("this is the total fare: "+fare_total);
		}
		else if(discount.equals("student")){
			intfare=3*intfare;
			fare_total=intfare/4;
			//out.println("this is the total fare: "+fare_total);
		}
		else if(discount.equals("disabled")){
			fare_total=intfare/2;
			//out.println("this is the total fare: "+fare_total);//
		}
		
		
		int res_num = 1 + (int) (Math.random() * 10000);
		//int new_fee//
		/* ENDING OF PART TO CALCULATE THE FARE TOTAL BASED ON TRIPTYPE AND DISCOUNT */
	
		//out.println("this is intfare:"+ intfare);
		
		
		
		/* START OF PART CHECKING IF USERNAME EXISTS */
		//Check if username exists in the database
		String query = "SELECT * FROM users WHERE username = '" +username + "'";
		ResultSet rs = stmt.executeQuery(query);
		
		if(!rs.next()){
			//redirect to failure.jsp
			response.sendRedirect("failure.jsp");
		} 
		/* END OF PART CHECKING IF USERNAME EXISTS */
		
		/* START OF PART CHECKING IF ORIGINSTOP,DESTSTOP, DEPTIME, ARRTIME, 
		DATE_TIME, TRANSIT_NAME, AND TRAINID ARE MATCHING AND IN TEMPSCHED*/
		String schedcheck="select t1.trainid,t1.transit_name, "+
		"t1.originstop,t2.deststop,t1.deptime,t2.arrtime,t1.date_time "+
				"from tempsched t1,tempsched t2 "+
				"where t1.trainid=t2.trainid "+
				"and t1.transit_name=t2.transit_name "+
				"and t1.date_time=t2.date_time "+
				"and t1.schednum=t2.schednum "+
				"and t1.originstop=101 "+
				"and t1.deptime=060000 "+
				"and t2.deststop=103 "+
				"and t2.arrtime=070000 "+
				"and t1.date_time='2021-07-05';";
		ResultSet schedres=stmt.executeQuery(schedcheck);
		if(!schedres.next()){
			System.out.print("does not exist in schedule try again.");
			response.sendRedirect("failure.jsp");
		}
		/* END OF PART CHECKING IF ORIGINSTOP,DESTSTOP, DEPTIME, ARRTIME, 
		DATE_TIME, TRANSIT_NAME, AND TRAINID ARE MATCHING AND IN TEMPSCHED*/
		
		//Make an insert statement for the customer table:
			if(discount.equals("none")||discount.isEmpty()){
				String insert = "INSERT INTO Reserves2"+
			"(res_id,reserve_date,username,trainid,transit_name,originstop,"+
			"deststop, deptime,arrtime,ticket_date,triptype,discount, total_fare)"
			+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);

				
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setInt(1,res_num);
				ps.setDate(2, sdate);
				ps.setString(3, username);
				//test fare inserted, will fix later//
				ps.setInt(4,trainid);
				
				ps.setString(5,transit_name);
				
				
				ps.setInt(6, origin_station_id);
				ps.setInt(7, dest_station_id);
				ps.setInt(8,deptime);
				ps.setInt(9,arrtime);
				
				ps.setString(10,ticket_date);
				ps.setString(11,t);
				ps.setNull(12,Types.NULL);
				ps.setFloat(13,fare_total);
				ps.executeUpdate();
		
			}
			else{
				
				String insert = "INSERT INTO Reserves2"+
						"(res_id,reserve_date,username,trainid,transit_name,originstop,"+
						"deststop, deptime,arrtime,ticket_date,triptype,discount, total_fare)"
						+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);

				
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.setInt(1,res_num);
				ps.setDate(2, sdate);
				ps.setString(3, username);
				//test fare inserted, will fix later//
				ps.setInt(4,trainid);
				
				ps.setString(5,transit_name);
				
				
				ps.setInt(6, origin_station_id);
				ps.setInt(7, dest_station_id);
				
				ps.setInt(8,deptime);
				ps.setInt(9,arrtime);
				
				ps.setString(10,ticket_date);
				ps.setString(11,t);
				
				ps.setString(12,discount);
				ps.setFloat(13,fare_total);
				ps.executeUpdate();
				
				
				
			}
		
		
		

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded <a href='homepage.jsp'>Homepage</a>");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
		%>
		<a href="makereservation.jsp">Back</a>
		<%
	}
%>
</body>
</html>