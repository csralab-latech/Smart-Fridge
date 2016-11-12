<%
//Validate based on User Test 
if(session.getAttribute("sessionUsername")==null)
{
	  //if the session username is invalid send to Login page
	 String site = new String("loginPage.jsp");
	 response.setStatus(response.SC_MOVED_TEMPORARILY);
	 response.setHeader("Location", site); 
}
%>