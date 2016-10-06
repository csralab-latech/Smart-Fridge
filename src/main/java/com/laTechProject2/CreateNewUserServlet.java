package com.laTechProject2;


import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Servlet implementation class CreateNewUserServlet
 */
@WebServlet("/CreateNewUserServlet")
public class CreateNewUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private int NumberOfUsers;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateNewUserServlet() 
    {
        super();
        // TODO Auto-generated constructor stub
        //Initialize the number of current users
        setNumberOfUsers(0);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//Debugging purposes (out below + other out's)
		//PrintWriter out = response.getWriter();
		String username= request.getParameter("username");
		String email= request.getParameter("email");
		String password= request.getParameter("password");
		//out.println("Username: "+username);
		//out.println("Email:    "+email);
		//out.println("Password: "+password);
		if(isNameInDatabase(username))
		{
			//out.println("The name is in the Database!");
			request.setAttribute("existsUser", username);
			//redirect to Login Page
			RequestDispatcher rd = request.getRequestDispatcher("newUser.jsp");//Change url to Inventory
			rd.forward(request,response);
		}
		else
		{
			//out.println("The name is not in the Database!");
			//out.println("Number of Users Before insert: " +getNumberOfUsers());
			//add Username to User table
			if(addUserToUserTable(username, email, password))
			{
				//indicate good creation
				request.setAttribute("newUser", username);
				//redirect to login screen
				RequestDispatcher rd = request.getRequestDispatcher("loginPage.jsp");//Change url to Inventory
				rd.forward(request,response);
			}
			else
			{
				//out.println("The name was NOT properly inserted!");
				request.setAttribute("errorUser", username);
				//redirect back to Page
				RequestDispatcher rd = request.getRequestDispatcher("newUser.jsp");//Change url to Inventory
				rd.forward(request,response);
			}
		}
	}//end doGet
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	//Input: String username
	//Output: Boolean (if the name was in the database or not)
	//Creates a connection to the User table and checks to see if the username is in the table. (return true if error)
	private boolean isNameInDatabase(String username)
	{
		//try to make a connection
	      try{
		         // Register JDBC driver (need the class from JAR package)
		         Class.forName("com.mysql.jdbc.Driver");
		         // Open a connection with credentials
		         Connection conn = Main.getConnection();
		         //Initialize a new Statement for SQL (get all the usernames)
		         String sqlValidate="SELECT User_Name FROM Users";
		         Statement sqlValidateStmt = conn.createStatement();
		         //Execute SQL
		         ResultSet rsValidate = sqlValidateStmt.executeQuery(sqlValidate);
		         //build a list from the User table of names
		         ArrayList<String> UserList= new ArrayList<String>();
		         while(rsValidate.next())
		         {
		        	 UserList.add(rsValidate.getString("User_Name"));
		         }     
		         // Clean-up environment (close every connection)
		         sqlValidateStmt.close();
		         rsValidate.close();
		         conn.close();  
		         //Update the Size of the List
		         setNumberOfUsers(UserList.size());
		         //See if the Username is in the list
		         if(UserList.contains(username))
		         {
		        	 return true;// if the username is in the list
		         }
		         else
		         {
		        	 return false;// if the username is not in the list
		         }
		         
	      	}catch(SQLException se){
	         //Handle errors for JDBC
	         se.printStackTrace();
	      }catch(Exception e){
	         //Handle errors for Class.forName
	         e.printStackTrace();
	      }
		return true;//default, so we don't end up adding username if something breaks
	} //end function
	
	//Input: String username
	//Output: Boolean (if the name was added to the database or not)
	//Creates a connection to the User table and adds the username to the table.
	private boolean addUserToUserTable(String username, String email, String password)
	{
		//open Connection and test variable
	      //try to make a connection
	      try{
	         // Register JDBC driver (need the class from JAR package)
	         Class.forName("com.mysql.jdbc.Driver");
	         // Open a connection with credentials
	         Connection conn = Main.getConnection();
	         //Initialize a new Statement for SQL
	         String sql;
	         sql = "INSERT INTO Users (User_Name, User_ID, User_Email, User_Password, Color_scheme) VALUES (?,?,?,?,?)";
	         PreparedStatement stmt = conn.prepareStatement(sql);
	         stmt.setString(1, username);
	         stmt.setString(2, Integer.toString(getNumberOfUsers()));
	         stmt.setString(3, email);
	         stmt.setString(4, hash(password));
	         stmt.setString(5, "red");
	         //Execute SQL
	         int count = stmt.executeUpdate();//returns 1 (good update) or 0 (bad update)
	         // Clean-up environment (close every connection)
	         stmt.close();
	         conn.close(); 
	         
	         //Validate statment was executed by checking if the new count is greater than old number of users
	         //if count worked, rows should be 1, else count is 0
	         //System.out.println("Count: "+count);//Count output to console (DEBUG)
	         if(count==1)
	         {
	        	 return true;//more new rows
	         }
	         else
	         {
	        	 return false;//no new rows
	         }
	        
	      }catch(SQLException se){
	         //Handle errors for JDBC
	         se.printStackTrace();
	      }catch(Exception e){
	         //Handle errors for Class.forName
	         e.printStackTrace();
	      }
		return false;//no new rows (default/problem)
	}//end addUserToUserTable
	
	//Setter for Number of Users 
	private void setNumberOfUsers(int amount)
	{
		this.NumberOfUsers=amount;
	}//end setNumberOfUsers
	
	//Getter for Number of Users
	private int getNumberOfUsers()
	{
		return this.NumberOfUsers;
	}//end getNumberOfUsers
	
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
}
