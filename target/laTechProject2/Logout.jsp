<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Logout</h1>
	<br>
	
	<p>You have logged out:</p><br> 
	<% 
	
	if(session.getAttribute("sessionUsername")!=null)//if session username is not null
	{
		out.println("Session not destroyed!");
	}
	%>	
	<br>
	<br>
	<h1><% out.println("SessionUsername: "+ session.getAttribute("sessionUsername")); %></h1>
	<a href="loginPage.jsp">Log Back in</a>
</body>
</html>