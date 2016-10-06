<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %> 
  <!-- %@ include file="SessionValidation.jsp"%> -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="description" content="Get recipe suggestions from the IoT Refrigerator!">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Recipes</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!--JQuery Required Scripts-->
<script src="https://code.jquery.com/jquery-2.1.3.js"></script>
<script src="js/bootstrap.js"></script>

<!--<script>
$(document).on("click", "#morebutton", function() { // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
$.get("RestServ", function(responseText) {   // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
$("#loadMore").text(responseText);           // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
});
});
</script> -->

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<style>
	body {
		margin-right: 5px;
		margin-bottom: 50px;
		clear: both:
	}
	
	section {
		max-width: 1000px;
		margin-right: auto;
		margin-left: auto;
		clear: both;
	}

	footer {
		background-color: black;
		color: white;
		clear: both;
		text-align: center;
		padding: 5px;
		position: fixed;
		width: 100%;
		bottom: 0;
	}
	
	.thumbnail {
		background-size: cover;
		background-image: url('http://www.kissinosauce.com/wp-content/uploads/2014/05/Chicken-Parmesan.jpg');
	}
	
	.thumbnail a {
		text-decoration: none;
	}
	
	.thumbnail-text {
		background-color: white;
		color: black;
		opacity: 0.65;
		padding: 5%;
	}
	
	.thumbnail-title {
		position: absolute;
		min-width: 50%;
		max-width: 87%;
	}
	
	.thumbnail-status {
		margin-top: 82%;
	}
	
	.img-responsive {
		max-height: 400px;
		margin: 0 auto;
	}
	
	ul {
		list-style-type:none;
	}
	
</style>
</head>

<body>
	<!-- Tag the top of the page. Allows the footer to work. -->
	<header id="top"></header>
	
	<!-- This defines the navbar at the top of the page -->
	<%@ include file="navBar.jsp"%>
	<script>setActiveNav('#recipeNav');</script>
	<jsp:include page="/RestServ" />
	
	<!-- This defines the page's content -->
	<section>
	<div class="container-fluid">
		<h1 align="center">Recipes</h1>
		
		<!-- This is the tab bar -->
		<ul class="nav nav-tabs nav-justified">
			<li class="active"><a data-toggle="tab" href="#fromInven">Recipes Based on Your Inventory</a></li>
			<li><a data-toggle="tab" href="#suggest">Recipe Suggestions</a></li>
		</ul>
		
		<!-- This defines both tabs -->
		<div class="tab-content">
		
			<!-- This defines the "Recipes from inventory" tab -->
			<div id="fromInven" class="tab-pane fade in active">
			
				<!-- This defines the "options" section -->
				<div class="panel-group hidden">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" href="#invenOptions">Options</a>
							</h4>
						</div>
						<div id="invenOptions" class="panel-collapse collapse">
<!-- Define options within the following div tag -->
							<div class="panel-body"><i>Sorry, there are no options at this time.</i></div>
							<div class="panel-footer"></div>
						</div>
					</div>
				</div>
				
				<!-- Tab content starts here -->
			<!-- 	<div id="loadMore"> -->
			
				<c:forEach var="invRecipe" items="${invRec}" varStatus="loop1">
					<c:if test="${loop1.index % 2 == 0}"> 
						<div class="row">
						<c:forEach begin="0" end="1" varStatus="loop2">
								<div class="col-sm-6">
									<div class="thumbnail"  style="background-image: url(${invRec[loop1.index+loop2.index].imageURL})">
										<a data-toggle="modal" href="#recipeModalinv${loop1.index+loop2.index}">
											<div class="caption">
												<h3 class="thumbnail-text thumbnail-title">${invRec[loop1.index+loop2.index].title}</h3>
												<h3 class="thumbnail-text thumbnail-status">You have ${invRec[loop1.index+loop2.index].availableIngr}/${invRec[loop1.index+loop2.index].numOfIngredients} ingredients.</h3>
											</div>
										</a>
									</div>
								</div>
						<div class="modal fade" id="recipeModalinv${loop1.index+loop2.index}" role="dialog">
    					<div class="modal-dialog modal-lg">
      						<div class="modal-content">
        						<div class="modal-header">
          							<button type="button" class="close" data-dismiss="modal">&times;</button>
          							<h4 class="modal-title">${invRec[loop1.index+loop2.index].title}</h4>
        						</div>
        						<div class="modal-body">
        						<img class="img-responsive" src="${invRec[loop1.index+loop2.index].imageURL}">
          							<hr />
          								<h4>ingredients</h4>
          								<ul>
          									<c:forEach var="ingredients" items="${invRec[loop1.index+loop2.index].ingrDescriptive}" varStatus="loop3">
          									<li>${ingredients}</li> 
          									</c:forEach>
          								</ul>
          								<hr/>
          								<div style="text-align:center; width:100%;">
          									<iframe width=80% height="360" src="${invRec[loop1.index+loop2.index].youtubeLink}" frameborder="0" allowfullscreen></iframe>
          								</div>
        						</div>
        						<div class="modal-footer">
          						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        						</div>
							</div>
						</div>
					</div>
						</c:forEach>
						</div>
					</c:if>
				</c:forEach>
			<!-- 	</div>
				 <button id="morebutton">Load More</button> -->
				 <form action="RestServ" method="POST">
    				<input class= "btn btn-primary btn-block" type="submit" name="LoadMore" value="Load More" />
					</form>
			</div> 
			
<!--**************** This defines the "Suggested recipes" tab ********************************************************************-->
			<div id="suggest" class="tab-pane fade">
				<!-- This defines the "options" section -->
				<div class="panel-group hidden">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" href="#suggestOptions">Options</a>
							</h4>
						</div>
						<div id="suggestOptions" class="panel-collapse collapse">
<!-- Define options within the following div tag -->
							<div class="panel-body">
							<i>Sorry, there are no options at this time.</i></div>
							<div class="panel-footer"></div>
						</div>
					</div>
				</div>
<!-- Iterations for the tiles on the suggested recipes tab STARTS here. See Furay for any explanations --> 				
				<!-- Tab content starts here -->
		 		<c:forEach var="recipe" items="${recipes}" varStatus="loop1">
					<c:if test="${loop1.index % 2 == 0}"> 
						<div class="row">
						<c:forEach begin="0" end="1" varStatus="loop2">
								<div class="col-sm-6">
									<div class="thumbnail"  style="background-image: url(${recipes[loop1.index+loop2.index].imageURL})">
										<a data-toggle="modal" href="#recipeModal${loop1.index+loop2.index}">
											<div class="caption">
												<h3 class="thumbnail-text thumbnail-title">${recipes[loop1.index+loop2.index].title}</h3>
												<h3 class="thumbnail-text thumbnail-status">You have ${recipes[loop1.index+loop2.index].availableIngr}/${recipes[loop1.index+loop2.index].numOfIngredients} ingredients.</h3>
											</div>
										</a>
									</div>
								</div>
					<div class="modal fade" id="recipeModal${loop1.index+loop2.index}" role="dialog">
    					<div class="modal-dialog modal-lg">
      						<div class="modal-content">
        						<div class="modal-header">
          							<button type="button" class="close" data-dismiss="modal">&times;</button>
          							<h4 class="modal-title">${recipes[loop1.index+loop2.index].title}</h4>
        						</div>
        						<div class="modal-body">
        						<img class="img-responsive" src="${recipes[loop1.index+loop2.index].imageURL}">
          							<hr />
          								<h4>ingredients</h4>
          								<ul>
          									<c:forEach var="ingredients" items="${recipes[loop1.index+loop2.index].ingrDescriptive}" varStatus="loop3">
          									<li>${ingredients}</li> 
          									</c:forEach>
          								</ul>
          								<hr/>
          								<div style="text-align:center; width:100%;">
          									<iframe width=80% height="360" src="${recipes[loop1.index+loop2.index].youtubeLink}" frameborder="0" allowfullscreen></iframe>
          								</div>
        						</div>
        						<div class="modal-footer">
          						<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        						</div>
							</div>
						</div>9
					</div>
				</c:forEach>
			</div>
          </c:if>
	</c:forEach>	   
<!-- Iterations for the tiles on the suggested recipes tab ENDS here. See Furay for any explanations --> 				

			</div>
		</div>
		<div class="modal fade" id="recipeModal" role="dialog">
    		<div class="modal-dialog modal-lg">
      			<div class="modal-content">
        			<div class="modal-header">
          				<button type="button" class="close" data-dismiss="modal">&times;</button>
          				<h4 class="modal-title">Recipe Name</h4>
        			</div>
        			<div class="modal-body">
        				<img class="img-responsive" src="http://www.kissinosauce.com/wp-content/uploads/2014/05/Chicken-Parmesan.jpg">
          				<ul>
          					<hr />
          					<li><h4>Example Set 1</h4>
          						<ul>
          							<li>Item 1</li>
          							<li>Item 2</li>
          							<li>Item 3</li>
          						</ul>
          					</li>
          					<hr />
          					<li><h4>Example Set 2</h4>
          						<ul>
          							<li>Item 1</li>
          							<li>Item 2</li>
          						</ul>
          					</li>
          				</ul>
        			</div>
        			<div class="modal-footer">
          				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        			</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	
	<!-- Evan's semi-standard footer -->
	<footer class="footer">
		<a href="#top" style="text-decoration:none;color:white;"><span class="glyphicon glyphicon-arrow-up"></span> Back to top</a>
	</footer>
</body>
</html>
