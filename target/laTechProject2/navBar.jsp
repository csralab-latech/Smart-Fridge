<!--**************** NavBar Section ****************--> 
<!--URL Mapping for NavBar and picture declaration-->
<% 
String urlHome = "index.jsp";
String urlInventory = "Inventory.jsp";
String urlShoppingList= "shoppingList.jsp";
String urlAbout= "about.jsp";
String urlRecipes = "recipe.jsp";
String urlLogout = "LogoutSessionServlet";

String urlBackground="http://www.goodwp.com/images/201201/goodwp.com_20978.jpg";
%>
<!-- Black Title Bar Start -->
	<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <!-- If the screen gets small, make the triple menu bar-->
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" style="color:white;"  >Smart Refrigerator</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
			<!-- Add New URL's here-->           
			<li><a style="font-weight: bold;" href=<%=urlHome%>>Home</a></li>
            <li id="inventoryNav"><a style="font-weight: bold;" href=<%=urlInventory%> >Inventory</a></li>
            <li id="shoppingNav"><a style="font-weight: bold;" href=<%=urlShoppingList%>>Shopping List</a></li>
            <li id="recipeNav"><a style="font-weight: bold;" href=<%=urlRecipes%> >Recipes</a></li>
            <li id="aboutNav"><a style="font-weight: bold;" href=<%=urlAbout%>>About</a></li>
           	<li><a style="color:red;font-weight: bold;" onclick="confirmation()">Logout</a></li> 
          	 <script type="text/javascript">
			 function confirmation() 
			 {
			   var answer = confirm("Are you sure you want to Logout?")
			   if (answer)
			   {
			     window.location = "LogoutSessionServlet";
			   }
			   else
			   {}
			 }
			 function setActiveNav(id)
			 {
				 $(id).addClass('active');
				 
			 }
 			</script>
          </ul>
        </div>
      </div>
    </nav>
<!-- Black Title Bar End-->
<!-- Spacing -->      
 	<br>
 	<br>