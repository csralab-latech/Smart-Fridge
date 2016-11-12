<%@ page import="java.sql.*" %>
<% Class.forName("com.mysql.jdbc.Driver"); %>
 
<HTML>
    <HEAD>
    </HEAD>
 
    <BODY>
         <% int temp = 45;
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8", "smart-fridge", "password");
 
            Statement statement = connection.createStatement();
            
            Statement statement2 = connection.createStatement();
            
            Statement statement3 = connection.createStatement();
            
            Statement statement4 = connection.createStatement();   
             
            ResultSet resultset = 
                statement.executeQuery("SELECT SUM(cc)/400 from Inventory"); 
            
            ResultSet resultset2 = 
                statement2.executeQuery("SELECT * from Inventory where SName like '%ilk%'");
            
            ResultSet resultset3 = 
                statement3.executeQuery("SELECT * from Inventory where SName like '%uic%'");
            
            ResultSet resultset4 = 
                statement4.executeQuery("SELECT * from Inventory where SName in ('%heese%','%utter%')");
            
			if (resultset2.next())
			{
				temp = 27;
			}
            
            else
            {
            	
            	if (resultset3.next())
    			{
    				temp = 32;
    			}
            		else
            		{
            			if (resultset4.next())
            			{
            				temp = 40;
            			}
            		
            		}
            	
            }
			%>
			
			<center> Suggested Optimum Temperature: <%= temp %> F </center>
 <%
            if(!resultset.next()) {
                out.println("SORRY, WE COULD NOT GET YOUR INFORMATIONS. ");
            } else {
            
        %>
        <center> Capacity of Fridge Occupied: <%= (int)resultset.getFloat(1) %>% </center>
       <% 
           } 
       %>
    </BODY>
</HTML>