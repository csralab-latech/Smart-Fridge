<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="SessionValidation.jsp"%>
<html lang="en">
<head>
  <title>Create New User</title>

  <!-- Bootstrap header-->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

</head>
<body style="background:#66ACCC;">
<body>
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<% Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");
	Statement statement = connection.createStatement();
	String sql;
	ResultSet details;
	sql = "SELECT bmi from Users where User_name=?";
	PreparedStatement stmt = connection.prepareStatement(sql);
	System.out.println("In myAccount :"+session.getAttribute("sessionUsername"));
	stmt.setString(1, (String)session.getAttribute("sessionUsername"));
	details = stmt.executeQuery();
    
%>
<%@ include file="navBar.jsp"%>
	<script>setActiveNav('#nutritionPlan');</script>
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
	<%if (details.next())
		{%>
	<h4>Your BMI Index is <%=(int) details.getFloat(1) %></h4>
		<%} %>
<%@ include file="customNutrition.jsp"%> <!-- This includes calculation of calories etc., -->
<%@ include file="dietPlan.jsp"%> <!-- This includes diet plan generation -->
 <h4>Choose Nutrition Plan</h4>
<form name="NutritionPlan" action="NutritionServlet" method="POST">
<select name="nutritionChoice">
  <option value="weightLoss">Lose Weight</option>
  <option value="balancedDiet">Regular Diet</option>
  <option value="weightGain">Weight Gain</option>
</select>
<input type="submit" value="Submit">
	        		         
</form>
</div></div></div></div>
</body>
</html>