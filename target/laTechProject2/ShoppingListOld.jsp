

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
</body><!--End **body**  -->
