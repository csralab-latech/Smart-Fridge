<!--Imports for Database Connection -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<!-- Get Connection -->
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://138.47.200.54:3306/LTR_Fridgedb"
     user="emr006"  password="B89R"/>
<!-- Build the Query  -->   
<sql:query dataSource="${snapshot}" var="result">
SELECT * from Measure;
</sql:query>

<c:forEach var="row" items="${result.rows}">
	<c:if test="${not empty row.MName}">
		<option><c:out value="${row.MName}"/></option>
	</c:if>
</c:forEach>