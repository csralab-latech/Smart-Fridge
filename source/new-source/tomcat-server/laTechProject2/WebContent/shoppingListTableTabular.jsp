<!--Imports for Database Connection -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<!-- Get Connection -->
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8"
     user="smart-fridge"  password="password"/>
<!-- Build the Query  -->   
<sql:query dataSource="${snapshot}" var="result">
SELECT * from ShoppingList WHERE Owner='<%=(String)session.getAttribute("sessionUsername")%>';
</sql:query>

	<c:forEach var="row" items="${result.rows}">
		<tr>
		   <td><c:out value="${row.SName}"/></td>
		   <td><c:out value="${row.Type}"/></td>
		   <td>
		   	<div class="amnt-div num-div"><c:out value="${row.Quant_curr}"/></div>
		   	<div class="amnt-div"><c:out value="${row.MName}"/></div>
		   </td>
		   <td><button class="btn btn-danger btn-circle-rm" name="row_remove" onclick="return delFunc(this, ${row.SID})" type="submit">
		   				<span class="glyphicon glyphicon-remove"></span>
		   				</button></td>
		   <td class= "hidden"><button class="btn btn-warning btn-block" name="row_edit" value=<c:out value="${row.SID}"/> type="submit">Edit</button></td>
		   <td><input type="checkbox" name="toInventory" id="toInventory" value=<c:out value="${row.SID}"/>></td>
		</tr>
	</c:forEach>
	<button  class="btn btn-success" name="add_to_inventory" onClick="return windowConfirm('#shoppingListForm')" type="submit"> Add to Inventory</button>
	