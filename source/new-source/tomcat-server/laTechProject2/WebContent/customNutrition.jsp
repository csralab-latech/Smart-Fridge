<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="SessionValidation.jsp"%>   
<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}</style>
</head>
<body>

<% Connection connectioncn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");

    Statement statementcn = connectioncn.createStatement();
    String sqlcn;
	ResultSet detailscn;
	sqlcn = "SELECT * from Nutrition where User_Name=?";
	PreparedStatement stmtcn = connectioncn.prepareStatement(sqlcn);
	System.out.println("In myAccount Custom Nutrition :"+session.getAttribute("sessionUsername"));
	stmtcn.setString(1, (String)session.getAttribute("sessionUsername"));
	detailscn = stmtcn.executeQuery();
    
%>
<%if (detailscn.next())
		{%>
Your suggested Daily intake of calories is <%=(int)detailscn.getDouble(2)%><!-- Show Calories --><br /><br />
Your diet should contain the following<br />
Protein: <%=(int)detailscn.getDouble(3)%> grams<!-- Show Protiens --><br />
Carbohydrates : <%=(int)detailscn.getDouble(4)%> grams<!-- Show Carbohydrates --><br />
Fat : <%=(int)detailscn.getDouble(5)%> grams<!-- Show Fats --><br />
<%} 
stmtcn.close();
connectioncn.close();
%>
</body>
</html>