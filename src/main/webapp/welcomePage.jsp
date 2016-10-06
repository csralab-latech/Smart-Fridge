<!DOCTYPE html>
<html>
	<head>
		<title>
			Welcome!
		</title>
		<link href="welcomeStylesheet.css" type="text/css" rel="stylesheet" />


					<!-- Display time and date -->
							
<div>
						<p id="date" align="middle"></p>
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
							
							<p><center>
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
						    </script></center></p>
		</head>

<p class="marquee">
    <span id="dtText"></span>
</p>

	<body>
		<h1 class="welcome">
				Welcome to LTR's Smart Refrigerator!
		</h1>



		<div class="fridgeImage">	
			<img src="http://www.loghome.com/images/Articles/refrigerator-with-internet.jpg" alt="LG Smart Refrigerator" title="Image of an LG Smart Refrigerator from www.loghome.com." width="25%" height="" align="middle" >
		</div>	
		

		<div class="loginButton"><form action="loginPage.jsp"><button><img src="http://icons.iconseeker.com/png/64/longhorn-r2/forward-button.png"/></form></button>

			<p align="middle">Log In Here!</p>
		</div>

		<div class="newAccountButton"><form action="http://www.google.com"><button><img src="http://www.psdgraphics.com/wp-content/uploads/2012/04/add-button.jpg" width="76" height="55"></form></button>

			<p align="middle">Create New Account</p>
		</div>

		<div class="aboutButton"><form action="http://www.google.com"><button><img src="http://thumb10.shutterstock.com/display_pic_with_logo/859894/183940877/stock-photo-question-mark-button-isolated-183940877.jpg" width="12%" height=""></form></button>

			<p align="middle">About</p>
		</div>



	</body>

	<footer>

	</footer>
</html>