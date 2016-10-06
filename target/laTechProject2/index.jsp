<!DOCTYPE html>

<html>	<head>
		<title>
			Welcome!
		</title>

		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	  	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

		<link href="welcomeStylesheet.css" type="text/css" rel="stylesheet" />


		<style>
		  .btn-primary, .btn-success, .btn-warning {
		      box-shadow: 1px 2px 5px #000000;   
		  }
  		</style>


  		<!-- Carousel -->
				<style>
				  .carousel-inner > .item > img,
				  .carousel-inner > .item > a > img {
				      height: 345px;				      
				      margin: auto;
				  }
				  .carousel{
				  		float: center;
				  		background-color: white;
       					}
				  </style>

	</head>


	<body>
		<!-- Jumbotron heading -->
		<div class="container">
		  <div class="jumbotron">
		    <h1>Welcome to LTR's Smart Refrigerator!</h1>      
		    			
							<p>
							<script type="text/javascript">
						   	datetoday = new Date();
							timenow=datetoday.getTime();
							datetoday.setTime(timenow);
							thehour = datetoday.getHours();
							if (thehour > 18) display = "Evening";
							else if (thehour >12) display = "Afternoon";
							else display = "Morning";
							var greeting = ("Good " + display + "!");
							document.write(greeting);						    
						    </script></p>

					</p>
					</div>
		<!-- End of Jumbotron heading -->


		<div class = "buttons">
			<br>
			<div class = "row">

				<div class = "col-sm-4"><center>
					<div class="loginButton"><a href="loginPage.jsp"><button type = "button" class = "btn btn-primary btn-lg"><span class="glyphicon glyphicon-user"></span></button></a>
					<p align="middle"><br>  Log In Here!  </p>
					</div></center>
				</div>

				<div class = "col-sm-4"><center>
					<div class="newAccountButton"><a href="newUser.jsp"><button type = "button" class = "btn btn-success btn-lg"><span class="glyphicon glyphicon-plus-sign"></span></button></a>
					<p align="middle"><br>Create New Account</p>
					</div></center>
				</div>

				<div class = "col-sm-4"><center>
					<div class="aboutButton"><a href="about.jsp"><button type = "button" class = "btn btn-warning btn-lg"><span class="glyphicon glyphicon-question-sign"></span></button></a>
					<p align="middle"><br>About</p>
					</div></center>
				</div>

			</div>
		</div>




<div class="container2">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
      <li data-target="#myCarousel" data-slide-to="3"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
<jsp:include page="/RestServ" />

      <div class="item active">
        <img src="${recipes[0].imageURL}">
        <div class="carousel-caption">
        <h3>${recipes[0].title}</h3>
        </div>
      </div>
 
      <div class="item">
        <img src="${recipes[1].imageURL}" >
         <div class="carousel-caption">
        <h3>${recipes[1].title}</h3>
        </div>
      </div>

       <div class="item">
        <img src="${recipes[2].imageURL}"  >
         <div class="carousel-caption">
        <h3>${recipes[2].title}</h3>
        </div>
      </div>

      <div class="item">
        <img src="${recipes[3].imageURL}"   >
         <div class="carousel-caption">
        <h3>${recipes[3].title}</h3>
        </div>
      </div>
    
     
  
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>





<!--
		<div class="fridgeImage">	
			<img src="http://www.loghome.com/images/Articles/refrigerator-with-internet.jpg" alt="LG Smart Refrigerator" title="Image of an LG Smart Refrigerator from www.loghome.com." width="20%" height="" align="middle" >
		</div>	
		
-->
		


			<!-- Links to other pages -->
			<br>
				<div class = "row">
					<div class = "col-md-12">
					<center>
						<h4><a href=testservelet>Servelet</a></h4>
						<a href="shoppingList.jsp">Shopping List</a><br>
						<a href="newItems.jsp">Enter New Items</a><br>
						<a href="Inventory.jsp">Inventory</a><br />	
						<a href="ForgotPassword.jsp">Forgot Password?</a><br />	
						<a href="recipe.jsp">Recipes</a><br />
						<br><br>
					</center>
					</div>
				</div>



		<!-- Date and time display -->
		<div class = "row">
			<div class = "col-sm-12">
				<!--<p><p id="date" align="middle"></p>-->
				<p id="time" align="middle"></p>

				<script>
				var d = new Date();
				document.getElementById("date").innerHTML = d.toDateString();
				</script> 

				<script>
				var t = new Date();
				document.getElementById("time").innerHTML = t.toUTCString();
				</script>
			</div>
		</div>



	</body>

</html>
