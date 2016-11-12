<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
 
<HTML>
    <HEAD>
        <TITLE>Fetching Data From a Database</TITLE>
    </HEAD>
 
    <BODY>
         <% 
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");
 
            Statement statement = connection.createStatement();  
 
            ResultSet resultset = 
                statement.executeQuery("SELECT SUM(cc)/400 from Inventory"); 
 
            if(!resultset.next()) {
                out.println("SORRY, WE COULD NOT GET YOUR INFORMATIONS. ");
            } else {
            
        %>
        <center> Capacity of Fridge Occupied: <%= resultset.getFloat(1) %>% </center>
       <% 
           } 
       %>
    </BODY>
</HTML>