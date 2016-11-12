<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<HTML>
    <BODY>
     <%Connection connectionwc = DriverManager.getConnection(
               "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");
       
           Statement statementwc = connectionwc.createStatement();
           
           ResultSet resultsetwc = 
                   statementwc.executeQuery("SELECT SUM(cc) from Inventory where CURRENT_DATE>Expiration_date");
           if(!resultsetwc.next()) {
               out.println("SORRY, WE COULD NOT GET YOUR INFORMATIONS. ");
           } else {
           %>
           <center> Waste Generated : <%= (int)resultsetwc.getFloat(1) %> cc </center>
           <% }
           statementwc.close();
           connectionwc.close();           
           %>
    </BODY>
</HTML>