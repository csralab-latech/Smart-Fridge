<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!-- Put session validate back!!!!-->
<%@ include file="SessionValidation.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="description" content="Inventory page for the IoT Refrigerator.">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Inventory</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!--JQuery Required Scripts-->
<script src="https://code.jquery.com/jquery-2.1.3.js"></script>
<script src="js/bootstrap.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<style type="text/css">

	.amount-num {
		width: 1px;
	}
	
	.btn-circle {
		width: 30px;
		height: 30px;
		text-align: center;
		padding: 7px 3.5px 8px 3px;
		font-size: 12px;
		line-height: 1.42;
		border-radius: 15px;
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
	body{
		margin-bottom: 51px;
	}
	
</style>
<script>
function delFunc(r, SID) {
	if(confirm('Are you sure you want to delete this item?')) {
		var i = r.parentNode.parentNode.rowIndex;
		$.post("InventoryServ", {ItemToBeDeleted: SID});
		document.getElementById("invTab").deleteRow(i);
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
</head>

<body>
	<header id="top"></header>

	<%@ include file="navBar.jsp"%>
	<script>setActiveNav('#inventoryNav');</script>
	<!-- Required spacing from navbar -->
	<br>
	<div class="container-fluid">
	<h1 align="center" style="padding-bottom: 10px;">Inventory</h1>
		<!-- This is the tab bar -->
		<ul class="nav nav-tabs primary">
			<li class="active"><a data-toggle="tab" href="#fromInven"><b><%=(String)session.getAttribute("sessionUsername") %></b>'s Inventory</a></li>
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
								
								<div class="container-fluid" style="margin-left: 5px;">
								<div class="table-responsive">
									<table id="invTab" class="table table-striped sortable">
										<h3 class="page-header" style="margin-top: 8px; margin-bottom: 8px;">Current Inventory</h3>										
										<thead>
											<tr>
												<th class="sortable-header" data-sort="alpha">Name&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
												<th class="sortable-header" data-sort="alpha">Type&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
												<th colspan='2'>Amount</th>
												<th class="sortable-header" data-sort="expire">Expiration Date&nbsp;<span class="glyphicon glyphicon-sort"></span></th>
						          				<th>Calories</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
						<!-- This is where the population of the table should begin. Rows should be added in the following format: -->
						<!-- Make sure this button gets included in the last column of every row! -->
										<!-- Dynamic Table -->
										<%@ include file="inventoryListTableTabular.jsp"%>
						<!-- END EXAMPLE ROWS -->
										</tbody>
									</table>
									<!-- Add the JavaScript for sorting the table rows.   -->
									<script src="sort-table.js"></script>
									</div>
								</div>
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
	<footer class="footer">
		<div class="container">
			<a href="#top" style="text-decoration:none;color:white;"><span class="glyphicon glyphicon-arrow-up"></span> Back to top</a>
		</div>
	</footer>
</body>
</html>
