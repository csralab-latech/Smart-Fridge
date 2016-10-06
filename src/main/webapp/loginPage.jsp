<!-- JD login page for Smart fridge (Username, Password, New User, Forgot Password?, Submit Button-->
<%@ include file="Header.jsp"%>
<body style="background:#66ACCC;">
<%for (int spacing = 0; spacing <= 4; spacing++){ %>
   <br>
<%}%>
<%
//If user is already signed in,then just give access
if(session.getAttribute("sessionUsername")!=null)
{
	  //if the session username is invalid send to Login page
	 String site = new String("Inventory.jsp");
	 response.setStatus(response.SC_MOVED_TEMPORARILY);
	 response.setHeader("Location", site); 
}
%>

<div class="container text-center"> <!-- Group Things -->
	<div class="row ">	<!-- Within a row -->
	<div class="col-xs-2 col-sm-3 col-md-4"></div>
	<div class="col-xs-7 col-sm-6 col-md-4">
		<div class="jumbotron" style="background:white;">
			<%//show user logged out
			if(request.getAttribute("Logout")!=null) 
			{
				out.print("<div id=\"removed\" class=\"alert alert-success\">You have Logged Out Successfully</div>");
			}
			//show user was created sucessfully
			if(request.getAttribute("newUser")!=null) 
			{
				out.print("<div id=\"removed\" class=\"alert alert-success\">New Account <b>"+request.getAttribute("newUser")+"</b><br> Successfully Created</div>");
			}
			%>
			<!-- Title -->
			<h2>User Login</h2>
			<!-- Username and Password Form -->
			<form action="LoginSessionServlet" method="POST">
			<input type="text" name="username" class="form-control" placeholder="Username" >
		 	<input type="password" name="password" class="form-control" placeholder="Password">
		 	<%
		 	//Grab invalid login
		 	if(request.getAttribute("invalidLogin")!=null)
 			{
 				out.println("<p style=\"color:red;font-size:110%;\">Invalid Username and Password: "+request.getAttribute("invalidLogin")+"\n</p>");
 				out.println("<input type=\"hidden\" name=\"invalidLogin\" value="+request.getAttribute("invalidLogin")+">");
 			}
		 	%>
		 	<button style="margin-top: 5px;margin-bottom: 5px;" class="btn btn-primary" name="submit" type="submit">Submit</button>
	        </form><!-- End Input Form -->
	        <!-- New User Link -->
	        <a href="newUser.jsp"><u>New User</u></a>
	        <br>
	        <!-- Forgotten Password Link -->
	        <a href="ForgotPassword.jsp"><u>Forgot Your Password?</u></a>
	        <br>
	        <!-- Forgotten Password Link -->
	        <a href="index.jsp"><u>Back to Home</u></a>
        </div>
	</div>
	</div>	
	
</div>  
</body>

<!-- Import and use Jd's Standard Header JSP code (JS Script/End HTML) -->
<%@ include file="Footer.jsp"%>
<!--
Description
Create a login webpage using HTML and CSS to match the UI design wireframe for the login page.
This page should have a title that identifies it as the “Login Page”
This page should include 2 labeled text fields that the user can put their username and password into.
The page should have a “Login” button that would submit the credentials to get verified by the system.
The page should have a forgotten password link that would take the user to the forgotPassword page that matches the UI wireframe.
The page should have a "New User" button that would take the user to the newUser page
 -->
 
 <!-- 
 Acceptance Criteria:
(check) Verify that a login page exists by opening it in a browser and ensure that its design matches that on the UI wireframe. 
(check) Verify that you can input text into the Username and Password text fields 
(check) Verify that the login button submits the information from the Username and Password text fields to the system. 
(check) Verify that the forgotten password link takes you to the forgotPassword page when clicked. 
(nope) Verify that the "New User" button takes you to the newUser page. 
  -->