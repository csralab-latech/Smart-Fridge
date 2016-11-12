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
</head>
<body>
<%String gender = null;
String Nutrition_Choice = null;%>
<% Connection connectiondp = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");

    Statement statementdp = connectiondp.createStatement();
    String sqldp;
	ResultSet detailsdp;
	sqldp = "SELECT Gender, Nutrition_Choice FROM Users where user_name=?";
	/* sqldp = "SELECT ? from Diet where Gender=?,Diet=?"; */
	PreparedStatement stmtdp = connectiondp.prepareStatement(sqldp);
	System.out.println("In dietPlan :"+session.getAttribute("sessionUsername"));
	stmtdp.setString(1,(String)session.getAttribute("sessionUsername"));
	detailsdp = stmtdp.executeQuery();  
%>

<%if(detailsdp.next())
	{
	gender = detailsdp.getString(1);
	Nutrition_Choice = detailsdp.getString(2);	
	}
	%>
	
<%Connection connectiondp1 = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");

    Statement statementdp1 = connectiondp1.createStatement();
    String sqldp1;
	ResultSet detailsdp1;
	sqldp1 = "SELECT U from dietplan where Gender= ? and Diet= ? and Meal=? ";
	PreparedStatement stmtdp1 = connectiondp1.prepareStatement(sqldp1);
	stmtdp1.setString(1, gender);
	System.out.println(gender);
	stmtdp1.setString(2, Nutrition_Choice);
	System.out.println(Nutrition_Choice);
	stmtdp1.setString(3, "Breakfast");
	System.out.println(sqldp1);
	detailsdp1 = stmtdp1.executeQuery(); %>
<%if (detailsdp1.next()) { %>
<br /><br /><b ALIGN="right">Suggested Diet for Today :</b> <br />
<table>
	<tr>
	<td>
Breakfast : <%=detailsdp1.getString(1)%> <br />
<% } %>
</td></tr>
<tr><td>
<%Connection connectiondp2 = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");

    Statement statementdp2 = connectiondp2.createStatement();
    String sqldp2;
	ResultSet detailsdp2;
	sqldp2= "SELECT U from dietplan where Gender= ? and Diet= ? and Meal=? ";
	PreparedStatement stmtdp2 = connectiondp2.prepareStatement(sqldp1);
	stmtdp2.setString(1, gender);
	System.out.println(gender);
	stmtdp2.setString(2, Nutrition_Choice);
	System.out.println(Nutrition_Choice);
	stmtdp2.setString(3, "Lunch");
	System.out.println(sqldp1);
	detailsdp2 = stmtdp2.executeQuery(); %>
<%if (detailsdp2.next()) { %>
 Lunch : <%=detailsdp2.getString(1)%> <br />
<% } %>
</td></tr>
<tr><td>
<%Connection connectiondp3 = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");

    Statement statementdp3 = connectiondp3.createStatement();
    String sqldp3;
	ResultSet detailsdp3;
	sqldp3= "SELECT U from dietplan where Gender= ? and Diet= ? and Meal=? ";
	PreparedStatement stmtdp3 = connectiondp3.prepareStatement(sqldp1);
	stmtdp3.setString(1, gender);
	System.out.println(gender);
	stmtdp3.setString(2, Nutrition_Choice);
	System.out.println(Nutrition_Choice);
	stmtdp3.setString(3, "Dinner");
	System.out.println(sqldp3);
	detailsdp3 = stmtdp3.executeQuery(); %>
	
<%if (detailsdp3.next()) { %>
Dinner : <%=detailsdp3.getString(1)%> <br />
<% } %>
</td></tr>
</table>
<%stmtdp.close();
connectiondp.close();
stmtdp1.close();
connectiondp1.close();
stmtdp2.close();
connectiondp2.close();
stmtdp3.close();
connectiondp3.close();%>
</body>
</html>