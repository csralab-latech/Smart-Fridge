<!--Imports for Ingredients List Connection -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<!-- Get Connection -->
<%@ page import="com.laTechProject2.Main" %> 
<!-- 10.0.0.37 or 138.47.200.54 -->
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://10.0.0.37:3306/LTR_Fridgedb"
     user="jdo028"  password="Z98S"/>
<!-- Build the Query  -->   
<sql:query dataSource="${snapshot}" var="result">
SELECT * from Ingredients;
</sql:query>

		<c:forEach var="row" items="${result.rows}">
			<c:out value="${row.SName}"/>
		    <c:out value="${row.Type}"/>
		    <c:out value="${row.Calories}"/>
		</c:forEach>
