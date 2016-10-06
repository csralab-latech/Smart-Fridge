<!--Imports for Database Connection -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<!-- Get Connection -->
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://10.0.0.37:3306/LTR_Fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8"
     user="jdo028"  password="Z98S"/>
<!-- Build the Query  -->   
<sql:query dataSource="${snapshot}" var="result">
SELECT I.SID as SID, I.SName as SName, 
I.Type as Type, I.Quant_curr as Quant_curr,
I.Calories as Calories,
datediff(I.Expiration_date, CURDATE()) as Days_Left,
I.MName as MName
from Inventory I WHERE Owner='<%=(String)session.getAttribute("sessionUsername")%>' ;
</sql:query>

<style type="text/css">
td.bad{
color: red;
}
td.eh{
color: #FCD116;
}
td.good{
color: black;

}
</style>

<form>	
	<c:forEach var="row" items="${result.rows}">
	<tr>
	   <td><c:out value="${row.SName}"/></td>
	   <td><c:out value="${row.Type}"/></td>
	   <td>
		   <div class="amnt-div num-div"><c:out value="${row.Quant_curr}"/></div>
		   <div class="amnt-div unit-div" class="amount-unit"><c:out value="${row.MName}"/></div>
		   <div class="amnt-div btn-div"><button name="amnt_decrease" onclick="return changeQuantity(this, ${row.SID}, 'decrease')" class="btn btn-warning btn-circle-mn">
		   		<span class="glyphicon glyphicon-minus"></span>
	 	   </button></div>
		   <div class="amnt-div btn-div"><button name="amnt_increase" onclick="return changeQuantity(this, ${row.SID}, 'increase')" class="btn btn-warning btn-circle-pl">
	 	   		<span class="glyphicon glyphicon-plus"></span>
	 	   </button></div>
	   </td>
	   <td class = "${row.Days_Left <= 2 ? 'bad' : row.Days_Left < 6 ? 'eh' : 'good'}"><c:out value="${row.Days_Left}"/> day(s)</td>
	   <td><c:out value="${row.Calories}"/></td>
	    
	   <td><button type="submit" name="row_remove" onclick="return delFunc(this, ${row.SID})" class="btn btn-danger btn-circle-rm"> 
	   			<span class="glyphicon glyphicon-remove"></span>
   			</button></td>
   			
	</tr>
	</c:forEach>
	
</form>