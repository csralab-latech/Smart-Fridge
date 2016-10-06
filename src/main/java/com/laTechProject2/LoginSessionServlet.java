package com.laTechProject2;



import java.io.IOException;
//import java.io.PrintWriter;
//import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
//import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 * Servlet implementation class LoginSessionServle
 */
@WebServlet("/LoginSessionServlet")
public class LoginSessionServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginSessionServlet() 
    {
        super();
        // TODO Auto-generated constructor stu
         
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{	    
		//Get the Username and Password<hashed> from the Login page
		String username= request.getParameter("username");
		String password= hash(request.getParameter("password"));
		//Validation Step <future Hash and DB>
		//Validate check:
		if(validateUsernamePassword(username, password))
		{
			//if username and password are valid
			//Create Session
		    HttpSession session = request.getSession(true);
		    //set timeout (30 * 60 seconds =30 minutes)
		    session.setMaxInactiveInterval(30*60);
		    //Add username to the session; needed to validate session in JSP include
		    session.setAttribute("sessionUsername",username);
			
		     // Set response content type
		     response.setContentType("text/html");
		      // New location to be redirected
		      String site = new String("Inventory.jsp");

		      response.setStatus(response.SC_MOVED_TEMPORARILY);
		      response.setHeader("Location", site);    
		    //RequestDispatcher rd = request.getRequestDispatcher("Inventory.jsp");//Change url to Inventory
		    //rd.forward(request,response);
		}
		else
		{
			//else username and password are invalid!
			//check if the user has been rejected before

			String invalidCredentials=null;
			if(request.getParameter("invalidLogin")!=null)//check incoming *forms*
			{
				//form value is not null; has value; increment by 1
				int invalidCount= Integer.parseInt(request.getParameter("invalidLogin").toString());
				invalidCount++;
				invalidCredentials= Integer.toString(invalidCount);
			}
			else
			{
				//Doesn't exists yet (1st whoops)
				invalidCredentials = Integer.toString(1);
			}
			//set the value of invalid logins to above logic value, pass it on to login page
			request.setAttribute("invalidLogin", invalidCredentials);
			//redirect to Login Page
			RequestDispatcher rd = request.getRequestDispatcher("loginPage.jsp");//Change url to Inventory
			rd.forward(request,response);
		}
				
		//RequestDispatcher rd = request.getRequestDispatcher("Inventory.jsp");//Change url to Inventory
		//rd.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	//Validation of username and password in the database
	//Input(s): A Username and Password both of type String
	//Output: Boolean: True if it exists, False if it doesn't
	private boolean validateUsernamePassword(String Username, String Password)
	{
	  //open Connection and test variable
	  // JDBC driver name and database URL
      //String JDBC_DRIVER="com.mysql.jdbc.Driver";  
      String DB_URL = Main.URL;
      //  Database credentials (JD)
      String USER = "jdo028";
      String PASS = "Z98S";
      //try to make a connection
      try{
         // Register JDBC driver (need the class from JAR package)
         Class.forName("com.mysql.jdbc.Driver");
         // Open a connection with credentials
         Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
         //Initialize a new Statement for SQL
         Statement stmt = conn.createStatement();
         // Create SQL query to return a username if provided the correct username and password combo
         String sql;
         sql = "SELECT User_Name FROM Users WHERE User_Name='"+Username+"'"+ " AND " + "User_Password='"+Password+"'";
         //Execute SQL
         ResultSet rs = stmt.executeQuery(sql);
         // Extract data from result set (create a username string: a value if returned, else null if not)
         String usernameDB=null;
         if(rs.next())//grab the first row if one exists
         {
        	 usernameDB = rs.getString("User_Name");
    	 }
         // Clean-up environment (close every connection)
         rs.close();
         stmt.close();
         //stmt.close();
         conn.close();
         //Test if username and password match
         if(usernameDB != null)
        	 return true;//if the username is not null, then valid login
         else
        	 return false;//else not a valid login
         
      }catch(SQLException se){
         //Handle errors for JDBC
         se.printStackTrace();
      }catch(Exception e){
         //Handle errors for Class.forName
         e.printStackTrace();
      }
		
      return false;//return value if try's fail!
	}//end validateUsernamePassword
	
	//Hash function for a SHA-256 type hash
	//Input: Input String
	//Output: Sha-256 hash of string for comparison
	private String hash(String StringName)
	{
		
	 try{
	        MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        byte[] hash = digest.digest(StringName.getBytes("UTF-8"));
	        StringBuffer hexString = new StringBuffer();

	        for (int i = 0; i < hash.length; i++) {
	            String hex = Integer.toHexString(0xff & hash[i]);
	            if(hex.length() == 1) hexString.append('0');
	            hexString.append(hex);
	        }

	        return hexString.toString();
	    } catch(Exception ex){
	       throw new RuntimeException(ex);
	    }
	}//end hash

}//end class
