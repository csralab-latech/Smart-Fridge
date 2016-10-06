
<!-- Import and use Jd's Standard Header JSP code (Scripts, Nav Bar, Picture URL) -->
<%@ include file="Header.jsp"%>
<%@ include file="navBar.jsp"%>
<%@ include file="SessionValidation.jsp"%>
<script>setActiveNav('#shoppingNav');</script>
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
</script>

<!-- Function to select all checkboxes -->
<script>
function checkAll(){
	var checkboxes = document.getElementsByTagName('input'), val =null;
	for (var i=0; i<checkboxes.length; i++){
		if(checkboxes[i].type == 'checkbox'){
			if(val==null)
				val = checkboxes[i].checked;
			checkboxes[i].checked = val;
		}
	}
	
}
</script>

<!-- Function for pop-up confirmation -->
<script>
function windowConfirm(){
	var count_checked = $("[name='toInventory']:checked").length; 
	if(count_checked <= 0) 
    {
        alert("Please select an item to add to Inventory.");
        return false;
    } 
	else 
    {
		if(confirm("Do you want to add these items to your inventory?")) {
			var postData = $("#shoppingListForm").serializeArray();
	        var formURL = $("#shoppingListForm").attr("action");
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
	.amount-num {
		width: 1px;
	}
</style>

<!--Background Image (Specified in Header.jsp && **body** tag-->
<body>
<!-- Alert Pane -->
<div id="removed" class="alert alert-success fade in hidden">
	<button href="#" class="close" onClick="hideAlert()" aria-label="close">&times;</button>
	Item removed from the Shopping List!
</div>


<!--OLD CODE-->
<!-- Shopping List -->
<div class="container">
 <div class="row ">
  <div class="jumbotron" style="background: white;">
<!--**************** Shopping List Section (GUTS) ****************--> 
   <h1 class="sub-header">Shopping List</h1>
   <h2 class="page-header">Current Shopping List</h2>
     <div class="table-responsive">
       <table id="shopTab" class="table table-striped sortable">
         <thead>
           <tr>
             <th class="sortable-header" data-sort="alpha">Item Name&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
             <th class="sortable-header" data-sort="alpha">Type&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
             <th colspan='2'>Amount</th>
             <th>Remove</th>
             <th>Edit</th>
             <th><input type="checkbox" onClick ="checkAll()" name="all_to_inventory"> Select All</th>
           </tr>
         </thead>
         <tbody>
         
<!--**************** Shopping Table ****************--> 
         <!-- New Rows of information from the data base that will be dynamically to output -->
         <form id="shoppingListForm">
          <!--Iterations should start here, Value should denote the row_ID that uniquely identifies the row in MYSQL--> 
           <%@include file="shoppingListTableTabular.jsp"%>
           
         </form><!-- End Remove Form -->
         </tbody>
       </table>     
          
   
     </div><!-- End Table Container --> 
     
     <!-- Add the JavaScript for sorting the table rows -->
     <script src="sort-table.js"></script>
     
<!--**************** Input New Item Section **************** --> 
  <h2 class="page-header">Input New Item</h2>
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
        <tr>
		    <td><input type="text" name="Item_Name" class="form-control" required></td>
		    <td><input type="text" name="Item_Type" class="form-control" required></td>
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
    
    
    
</div><!-- End Jumbo --> 
</div> <!--End Row -->
</div> <!--End Container -->



<div class="container-fluid">
	<h1 align="center" style="padding-bottom: 10px;">Shopping List</h1>
		<!-- This is the tab bar -->
		<ul class="nav nav-tabs primary">
			<li class="active"><a data-toggle="tab" href="#fromInven"><b><%=(String)session.getAttribute("sessionUsername") %></b>'s Sho</a></li>
			<li><a data-toggle="tab" href="#fromWhole">Whole Refrigerator</a></li>
		</ul>
		<!-- This defines both tabs -->
		<div class="tab-content">
			<!-- This defines the "Personal inventory" tab -->
			<div id="fromInven" class="tab-pane fade in active">
				<!-- Tab content starts here -->
				<div class="row">
					<!-- This define one entire section (Your Inventory)-->
					<div class="col-sm-12">
						<div class="panel panel-default">
							<div class="panel-body">
							
							<section>
							<div class="container-fluid" style="margin-left: 5px;">
								<!--**************** Input New Item Section **************** --> 
							  <h3 class="page-header" style="margin-top: 8px;margin-bottom: 8px;">Add New Item</h3>
							  <div class="table-responsive">
							    <table class="table">
							      <thead>
							        <tr>
							          <th>Item Name</th>
							          <th>Type</th>
							          <th>Amount</th>
							          <th>Unit</th>
							          <th>Expiration Date</th>
							          <th>Calories</th>
							          <th></th>
							        </tr>
							      </thead>
							       <tbody>
							       <!-- Need URL for Servlet to post to. Likely same page.-->
							       <form action="InventoryServ" method="POST">
							        <tr>
									    <td><input type="text" name="Item_Name" class="form-control" required></td>
									    <td><input type="text" name="Item_Type" class="form-control" required></td>
									    <td><input type="text" name="Item_Quantity_Have" class="form-control" required></td>
									    <td><select name="Item_Unit" class="form-control" required>
									    	<%@ include file="unitsList.jsp"%>
									    	<option disabled selected role="separator">------</option>
									    	<option value="Other">Other</option>
									    </select></td>
									    <td><input type="date" name="Expiration_Date" class="form-control" required></td>
									    <td><input type="text" name="Calories" class="form-control" required></td>
									    <td><button class="btn btn-success" name="submit" type="submit" >Submit</button></td>
							        </tr>
							        </form><!-- End Input Form -->
							      </tbody>
							    </table> 
							    </div>
							   </div> <!-- End Contatiner -->
							</section>
							<section>
								<div id="removed" class="alert alert-success fade in hidden">
									<button href="#" class="close" onClick="hideAlert()" aria-label="close">&times;</button>
									Item removed from the inventory!
								</div>
								
								<h1 class="sub-header">Shopping List</h1>
							   <h2 class="page-header">Current Shopping List</h2>
							     <div class="table-responsive">
							       <table id="shopTab" class="table table-striped sortable">
							         <thead>
							           <tr>
							             <th class="sortable-header" data-sort="alpha">Item Name&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
							             <th class="sortable-header" data-sort="alpha">Type&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
							             <th colspan='2'>Amount</th>
							             <th>Remove</th>
							             <th>Edit</th>
							             <th><input type="checkbox" onClick ="checkAll()" name="all_to_inventory"> Select All</th>
							           </tr>
							         </thead>
							         <tbody>
							         
							<!--**************** Shopping Table ****************--> 
							         <!-- New Rows of information from the data base that will be dynamically to output -->
							         <form id="shoppingListForm">
							          <!--Iterations should start here, Value should denote the row_ID that uniquely identifies the row in MYSQL--> 
							           <%@include file="shoppingListTableTabular.jsp"%>
							           
							         </form><!-- End Remove Form -->
							         </tbody>
							       </table>     
							          
							   
							     </div><!-- End Table Container --> 
							     
							     <!-- Add the JavaScript for sorting the table rows -->
							     <script src="sort-table.js"></script>
							     
							</section>
							
						 	<c:if test="${pop}">
									<div class="modal fade" role="dialog">
						    		<div class="modal-dialog modal-lg">
						      			<div class="modal-content">
						        			<div class="modal-header">
						          				<button type="button" class="close" data-dismiss="modal">&times;</button>
						          				<h4 class="modal-title">Duplicate Item</h4>
						        			</div>
						        			<div class="modal-body">
						        				
						        			</div>
						        			<div class="modal-footer">
						          				<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						        			</div>
										</div>
									</div>
								</div>
							</c:if>
		
						</div><!-- PanelBody -->	
					</div><!--End Col-->	
				</div><!--End Row-->
			</div><!--End fromInven-->
			</div>		
			<!-- This defines the "Whole Frige" tab -->
			<div id="fromWhole" class="tab-pane fade">
				<!-- Tab content starts here -->
				<div class="row">
					<!-- This define one entire section (Whole refrigerator)-->
					<div class="col-sm-12">					
						<div class="panel panel-default">
							<div class="panel-body">
							<!-- Whole Table output -->
							<div class= "container-fluid" style="margin-left: 5px;">
							<div class="table-responsive">
								<table id="invTab" class="table table-striped sortable">
									<h3 class="page-header" style="margin-top: 8px; margin-bottom: 8px;">Entire Refrigerator Inventory</h3>										<thead>
										<tr>
											<th class="sortable-header" data-sort="alpha">Name&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
											<th class="sortable-header" data-sort="alpha">Type&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
											<th colspan='2'>Amount</th>
											<th class="sortable-header" data-sort="expire">Expiration Date&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
					          				<th>Calories</th>
											<th class="sortable-header" data-sort="alpha">Owner&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
										</tr>
									</thead>
									<tbody>
							<!-- This is where the population of the table should begin. Rows should be added in the following format: -->
							<!-- Make sure this button gets included in the last column of every row! -->
									<!-- Dynamic Table -->
									<%@ include file="inventoryWholeListTableTabular.jsp"%>
							<!-- END EXAMPLE ROWS -->
									</tbody>
								</table>
								<script src="sort-table.js"></script>
								</div>
						</div>
					 </div>		
					</div><!--End Col-->	
				</div><!--End Row-->
			</div>
			</div><!--End fromWhole-->	
	</div><!--End tabContent-->		
</div><!--End Container-->






<!--OLD CODE-->
</body><!--End **body**  -->




<!-- Include Jd's Standard Footer -->
<!-- Import and use Jd's Standard Header JSP code (Scripts, Nav Bar, Picture URL) -->
<%@ include file="Footer.jsp"%>