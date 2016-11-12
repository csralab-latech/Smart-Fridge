<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="SessionValidation.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Details</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body style="background:#66ACCC;">
<body>
<%@ include file="navBar.jsp"%>
	<script>setActiveNav('#inventoryNav');</script>
	<!-- Required spacing from navbar -->
	<br>

<%for (int spacing = 0; spacing <= 4; spacing++){ %>
   <br>
<%}%>

<div class="container-fluid text-center"> <!-- Group Things -->
	<div class="row ">	<!-- Within a row -->
	<div class="col-xs-2 col-sm-3 col-md-4"></div>
	<div class="col-xs-7 col-sm-6 col-md-4">
		<div class="jumbotron" style="background:white;">
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
Enter Details
<% Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");
	Statement statement = connection.createStatement();
	String sql;
	ResultSet details;
	sql = "SELECT Age, Gender, Height_Feet, Height_Inches, Weight from users where User_name=?";
	PreparedStatement stmt = connection.prepareStatement(sql);
	System.out.println("In myAccount :"+session.getAttribute("sessionUsername"));
	stmt.setString(1, (String)session.getAttribute("sessionUsername"));
	details = stmt.executeQuery();
    
%>
  <h2>User Details</h2>
  <% if (details.next()) { %>
  <form name="UpdateMyAccountForm" action="UpdateMyAccountServlet" method="POST">
		      <div id="inputUsername" class="form-group">
  Age : <input type="number" name="age" class="form-control" value=<%= details.getInt(1) %>>
  <br />
  Sex :	
  <% if(details.getString(2).equals("male")){%>
  <input type="radio" name="gender" value="male" class="form-control" checked> Male <input type="radio" name="gender" value="female" class="form-control"> Female
  <% }  else { %>
  <input type="radio" name="gender" value="male" class="form-control"> Male <input type="radio" name="gender" value="female" class="form-control" checked> Female
  <% } %>
  <br />
  Height : <input type="number" name="height_feet" class="form-control" value=<%= details.getInt(3) %>>'  <input type="number" name="height_inches" class="form-control" value=<%= details.getInt(4) %>>''
  <br />
  Weight : <input type="number" name="weight" class="form-control" value=<%= details.getInt(5) %>>
    <br />
    <button  class="btn btn-primary btn-lg" name="submit" type="submit">Update</button>
    </div>
    </form>
    <%}
  connection.close();
  statement.close();%>
 
 
 </div>
    </div>
    </div>
</body>
</html>