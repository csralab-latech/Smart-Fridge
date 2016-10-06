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

<%for (int spacing = 0; spacing <= 4; spacing++){ %>
   <br>
<%}%>

<div class="container-fluid text-center"> <!-- Group Things -->
	<div class="row ">	<!-- Within a row -->
	<div class="col-xs-2 col-sm-3 col-md-4"></div>
	<div class="col-xs-7 col-sm-6 col-md-4">
		<div class="jumbotron" style="background:white;">

  <h2>Create New User</h2>
		  	
		  <%
		  	//JSP logic that injects HTML to tell the user they are having issues (db error or user already exists)
		  	//show error user creation
			if(request.getAttribute("errorUser")!=null) 
			{
				//inject error message
				out.print("<div id=\"removed\" class=\"alert alert-danger\">There was a problem creating <b>"+ request.getAttribute("errorUser") +"</b></div>");
			}
		  	//Show user already exists
			if(request.getAttribute("existsUser")!=null)
			{
				//inject Username exists message
				out.print("<div id=\"removed\" class=\"alert alert-danger\">The Username <b>"+request.getAttribute("existsUser")+"</b> already exists in system. <br> Please use a different Username!</div>");
			}
			%>
			
		  <!-- Form for the new user information
		  	   The script at the bottom of the page checks to make sure the information is all there before submission.
		   -->
		  <form name="CreateNewUserForm" action="CreateNewUserServlet" onsubmit="return validateForm()" method="POST">
		      <div id="inputUsername" class="form-group">
		     	 <input type="text" name="username" class="form-control" placeholder="Enter Username" >
		      </div>   
		         <br>
		      <div id="inputEmail" class="form-group">   
		      	<input type="email" name="email" class="form-control" placeholder="Enter Email Address">
		      </div>
		        <br>
		      <div id="inputPassword" class="form-group">    
		      	<input type="password" name="password" class="form-control" placeholder="Enter Password">
		     </div>
		      <br>
		
		      <div class = "row">
	        	<div class = "col-sm-6"><center>
		    	  <button  class="btn btn-primary btn-lg" name="submit" type="submit">Sign Up!</button>
		      	</div></center>
		      
		     	<div class = "col-sm-6"><left>
		          	<div class="aboutButton"><a href="loginPage.jsp"><button type = "button" class = "btn btn-danger btn-lg">Cancel</button></a>
		        	</div></left>
		      	</div>
		      
		      </div>
		   </form>
		
		        
</div>
</div>
</div>
</div>

</body>
</html>


<script>
//When the form tries to get submitted, this checks all the fields to make sure there is something in them
//if the fields are good, it submits them as normal
//else it makes the fields red <has-error>, stops the form, and alerts the user of the problem (popup)
function validateForm() 
{
    var x = document.forms["CreateNewUserForm"]["username"].value;
    var y = document.forms["CreateNewUserForm"]["email"].value;
    var z = document.forms["CreateNewUserForm"]["password"].value;
    if(x!=null && y!=null && z!=null && x!="" && y!="" && z!="")
    {
    	return true;
    }
    else
    {
    	var alertMessage=new String();
    	if (x == null || x == "") 
        {
            alertMessage+="The \"Username\" box  must be filled out\n";
            $("#inputUsername").addClass('has-error');
        }
    	else
    	{	
    		$("#inputUsername").removeClass('has-error');
    	}
        if (y == null || y == "") 
        {
            alertMessage+="The \"Email\" box must be filled out\n";
            $("#inputEmail").addClass('has-error');
        }
        else
        {
        	$("#inputEmail").removeClass('has-error');
        }
        if (z == null || z == "") 
        {
        	alertMessage+="The \"Password\" box must be filled out\n";
        	$("#inputPassword").addClass('has-error');
        }
        else
        {
        	$("#inputPassword").removeClass('has-error');
        }
        alert(alertMessage);
        return false;
    }
}
</script>