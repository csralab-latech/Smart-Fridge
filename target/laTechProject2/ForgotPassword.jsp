<!-- Include Jd's Standard Header file -->
<%@ include file="Header.jsp"%>

<!-- Password Recovery Section -->
<div class="container">
	<div class="row ">
		<div class="jumbotron" style="background: white;">
			<h1 class="sub-header">Password Recovery</h1>

<!--**************** Password Recovery Section **************** --> 
			<h3 class="page-header">Having trouble signing in?</h3>
		       	<!--<!-- Need URL for Servlet to post to. Likely same page.-->
		       	<form class="form-horizontal" role="form" action="testservlet" method="post" >
					<div class="form-group">
						<label class="control-label col-sm-1" for="username">Username:</label>
						<div class="col-sm-offset-1 col-sm-5">
					  		<input type="username" class="form-control" name="username" placeholder="Enter username">
						</div>
					</div>
					<div class="form-group"> 
						<div class="col-sm-offset-2 col-sm-5">
							<button class="btn btn-success" name="pwd_recovery_bttn" type="submit">Submit</button>
						</div>
					</div>
				</form>
				<h4 class="page-header"></h4>
				<a href="index.jsp">Cancel</a><br>
		</div><!-- End Jumbo --> 
		
	</div><!-- End Row -->
</div><!-- End Container -->
<!-- Include Jd's Standard Footer -->
<%@ include file="Footer.jsp"%>