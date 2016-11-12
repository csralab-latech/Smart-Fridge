package com.laTechProject2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/NutritionServlet")
public class NutritionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nutritionChoice = request.getParameter("nutritionChoice");
		if(UpdateNutritionPlan(nutritionChoice, request, response))
		{
			//Provide proper response that the changes have been made successfully
			System.out.println("Updated Nutrition Plan");
			response.sendRedirect("/laTechProject2/nutritionPlan.jsp");
		}		
	}
	protected boolean UpdateNutritionPlan(String nutritionChoice,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try{
			HttpSession session = request.getSession(false);
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = Main.getConnection();
			String sql;
			sql = "UPDATE Users SET Nutrition_Choice=? Where User_Name=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
	         stmt.setString(1, nutritionChoice);
	         stmt.setString(2, (String)session.getAttribute("sessionUsername"));
	         System.out.println("In Nutrtion Plan"+session.getAttribute("sessionUsername"));
	         int count = stmt.executeUpdate();
	         stmt.close();
	         conn.close();
	         if(count==1)
	         {
	         return true;
	         }
	         else
	         {
	         return false;
	         }
			
		}catch(SQLException se){
	         //Handle errors for JDBC
	         se.printStackTrace();
	         return false;
	      }catch(Exception e){
	         //Handle errors for Class.forName
	         e.printStackTrace();
	         return false;
	      }
	}
}
