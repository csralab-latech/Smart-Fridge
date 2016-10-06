<!-- Include Jd's Standard Header-->
<%@ include file="Header.jsp"%>
<%@ include file="navBar.jsp"%>
<%@ include file="SessionValidation.jsp"%>
<script>setActiveNav('#newItemsNav');</script>
<body>
<!-- Formating of page-->
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2 text centered">
			<div class="jumbotron" ; style="background: white">
				<h1 class="page-header">Enter Your New Items</h1>
				<form action="InventoryServ" method="POST">
					<div style="font-size: 25px;">
						<!-- Input tables begin -->
						<table>
							<tr>
								<td>Item Name:</td>
								<td><input type="text" name="Item_Name"></td>
							</tr>

							<tr>
								<td>Type:</td>
								<td><input type="text" name="Item_Type"></td>
							</tr>

							<tr>
								<td>Quantity You Have:</td>
								<td><input type="text" name="Item_Quantity_Have"></td>
							</tr>

							<tr>
								<td>Quantity You Need:</td>
								<td><input type="text" name="Item_Quantity_Need"></td>
							</tr>

							<tr>
								<td>Expiration Date:</td>
								<td><input type="text" name="Expiration_Date"></td>
							</tr>

							<tr>
								<td>Calories:</td>
								<td><input type="text" name="Calories"></td>
							</tr>

							<tr>
								<td>Owner:</td>
								<td><select name="User">
										<option value="User 1">User 1</option>
										<option value="User 2">User 2</option>
										<option value="User 3">User 3</option>
								</select></td>
							</tr>
						</table>
					</div>
					<br>
					<div class='wrapper text-center'>
						<!-- Buttons to save entered information and cancel input and return to homepage-->
						<button type="submit" class="btn btn-success">Save</button>
						<button type="reset" class="btn btn-danger"
							onclick="location.href='http://172.31.2.245:8080/laTechProject2/Inventory.jsp'">Cancel</button>
						<br>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

</body>

<!-- Include Jd's Standard Footer -->
<%@ include file="Footer.jsp"%>