
<!-- Import and use Jd's Standard Header JSP code (Scripts, Nav Bar, Picture URL) -->
<%@ include file="Header.jsp"%>
<%@ include file="navBar.jsp"%>
<script>setActiveNav('#shoppingNav');</script>
<%@ include file="SessionValidation.jsp"%>
<!--JQuery Required Scripts-->
<script src="https://code.jquery.com/jquery-2.1.3.js"></script>
<script src="js/bootstrap.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<script>
function delFunc(tableRow, SID) {
  if(confirm('Are you sure you want to delete this item?')) {
    var index = tableRow.parentNode.parentNode.rowIndex;
    $.post("ShoppingListServ", {ItemToBeDeleted: SID});
    document.getElementById("shopTab").deleteRow(index);
    $("#removed").removeClass('hidden');
    return;
  }
  else{
    return false;   
  }
}
</script>
<script>
function hideAlert() {
  $("#removed").addClass('hidden');
}
</script>

<!-- Function to select all checkboxes -->
<script>
function checkAll(table) {
	var table = document.getElementById(table);
	var inputs = table.getElementsByTagName('input'), val = null;
	for (var i = 0; i < inputs.length; i++) {
		if (inputs[i].type == 'checkbox') {
			if (val == null)
				val = inputs[i].checked;
			inputs[i].checked = val;
		}
	}
}
</script>

<!-- Function for pop-up confirmation -->
<script>
function windowConfirm(table){
  var count_checked = $("[name='toInventory']:checked").length; 
  if(count_checked <= 0) 
    {
        alert("Please select an item to add to Inventory.");
        return false;
    } 
  else 
    {
    if(confirm("Do you want to add these items to your inventory?")) {
      var postData = $(table).serializeArray();
        $.ajax(
        {
            url : "ShoppingListServ",
            type: "POST",
            data : postData,
            success:function(data, textStatus, jqXHR) 
            {
              $("table input[id='toInventory']:checked").parent().parent().remove();
            },
            error: function(jqXHR, textStatus, errorThrown) 
            {
              // Do Something Super Secret
              //$("#commentFormWrap").html("<p>error: "+errorThrown+"</p>");
            }
        });
      return false;
    }
    else{
      return false;
    }
    return false;
    }
}
</script>
<!-- Add styling for the amount number column -->
<style>

	.amnt-div {
		display:table-cell;
	}
	
	.num-div {
		width:25px;
	}
	
  	footer1 {
		background-color: black;
		color: white;
		clear: both;
		text-align: center;
		padding: 5px;
		position: fixed;
		width: 100%;
		bottom: 0;
	}
	
	.btn-circle-rm {
		width: 30px;
		height: 30px;
		text-align: center;
		padding: 7px 0px 9px 0.5px;
		font-size: 12px;
		line-height: 1.42;
		border-radius: 15px;
	}
</style>

<!--Background Image (Specified in Header.jsp && **body** tag-->
<body>
<!-- Alert Pane -->
<div id="removed" class="alert alert-success fade in hidden">
  <button href="#" class="close" onClick="hideAlert()" aria-label="close">&times;</button>
  Item removed from the Shopping List!
</div>

<!-- Shopping List -->
<br>
<h1 align="center" style="padding-bottom: 10px;">Shopping list</h1>
<br>
<div class="container-fluid">

 <div class="row ">
 	<div class="col-sm-12">
		<div class="panel panel-default">
			<div class="panel-body">
		  <!--**************** Input New Item Section **************** --> 
		  <h2 class="page-header" style="margin-top: 8px;margin-bottom: 8px;">Input New Item</h2>
		  <!--  -->
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Item Name</th>
			          <th>Type</th>
			          <th>Amount</th>
			          <th>Unit</th>
			          <th></th>
			        </tr>
			      </thead>
			      <tbody>
			       <!-- Need URL for Servlet to post to. Likely same page.-->
			       <form action="ShoppingListServ" method="POST">
					       <datalist id="ingredients">
							    <option value="Apples">
							    <option value="Avocado">
							    <option value="Blueberries">
							    <option value="Carrots">
							    <option value="Milk">
							    <option value="Chicken">
							    <option value="Lettuce">
							    <option value="Cheese">
							    <option value="Mushrooms">
							    <option value="Bacon">
							    <option value="Bread">
							    <option value="Orange Juice">
							    <option value="Ranch Dressing">
					  		</datalist>
			        <tr>
			    <td><input type="text" name="Item_Name" list="ingredients" class="form-control" required></td>
			    <td><select type="text" name="Item_Type" class="form-control" required>
			    	 <%@ include file="typeListTableTabular.jsp"%>
			      		<option disabled selected role="separator">------</option>
			      		<option value="Other">Other</option>
			    </select></td>
			    <td><input type="text" name="Item_Quantity" class="form-control" required></td>
			    <td><select name="Item_Unit" class="form-control" required>
			      <%@ include file="unitsList.jsp"%>
			      <option disabled selected role="separator">------</option>
			      <option value="Other">Other</option>
			    </select></td>
			    <td><button class="btn btn-success" name="submit" type="submit" >Submit</button></td>
			        </tr>
			        </form><!-- End Input Form -->
			      </tbody>
			    </table>
		<!--**************** Shopping List Section (GUTS) ****************--> 
		   <h2 class="page-header">Current Shopping List</h2>
		     <div class="table-responsive">
		       <table id="shopTab" class="table table-striped sortable">
		         <thead>
		           <tr>
		             <th class="sortable-header" data-sort="alpha">Item Name&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
		             <th class="sortable-header" data-sort="alpha">Type&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
		             <th>Amount</th>
		             <th>Remove</th>
		             <th class="hidden">Edit</th>
		             <th><input type="checkbox" onClick ="checkAll('shopTab')" name="all_to_inventory"> Select All</th>
		           </tr>
		         </thead>
		         <tbody>
		         
		<!--**************** Shopping Table ****************--> 
		         <!-- New Rows of information from the data base that will be dynamically to output -->
		         <form id="shoppingListForm">
		          <!--Iterations should start here, Value should denote the row_ID that uniquely identifies the row in MYSQL--> 
		           <%@include file="shoppingListTableTabular.jsp"%>
		         </form><!-- End Remove Form -->  
		         <!--</form> End Remove Form -->
		         </tbody>
		       </table>     
		          
		   
		     </div><!-- End Table Container --> 
		     
		     
		     
		<h2 class="page-header">Everyone Else's Shopping List</h2>
		     <div class="table-responsive">
		       <table id="shopTab2" class="table table-striped sortable">
		         <thead>
		           <tr>
		             <th class="sortable-header" data-sort="alpha">Item Name&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
		             <th class="sortable-header" data-sort="alpha">Type&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
		             <th>Amount</th>
		             <th class="sortable-header" data-sort="alpha">Owner&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
		             <th><input type="checkbox" onClick ="checkAll('shopTab2')" name="all_to_inventory"> Select All</th>
		           </tr>
		         </thead>
		         <tbody>
		         
		<!--**************** Shopping Table ****************--> 
		         <!-- New Rows of information from the data base that will be dynamically to output -->
		         <!--<form id="shoppingListForm">-->
		         <form id="shoppingListFormWhole">
		          <!--Iterations should start here, Value should denote the row_ID that uniquely identifies the row in MYSQL--> 
		           <%@include file="shoppingListWholeTableTabular.jsp"%>
		           
		         </form> <!--End Remove Form -->
		         </tbody>
		       </table>     
		          
		   
		     </div><!-- End Table Container -->
			    
</div>	<!-- panel body-->	    
</div>	<!-- panel-->	    
</div><!-- End col --> 
</div> <!--End Row -->
</div> <!--End Container -->
<div class="container">
	<a href="#top" style="text-decoration:none;color:white;"><span class="glyphicon glyphicon-arrow-up"></span> Back to top</a>
</div>

<!-- Add the JavaScript for sorting the table rows -->
<script src="sort-table.js"></script>
</body><!--End **body**  -->


<!-- Include Jd's Standard Footer -->
<!-- Import and use Jd's Standard Header JSP code (Scripts, Nav Bar, Picture URL) -->
<%@ include file="Footer.jsp"%>
<footer1>
<div class="container">
	<a href="#top" style="text-decoration:none;color:white;"><span class="glyphicon glyphicon-arrow-up"></span> Back to top</a>
</div>
</footer1>