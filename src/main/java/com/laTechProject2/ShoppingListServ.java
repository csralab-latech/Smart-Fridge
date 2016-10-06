package com.laTechProject2;

import java.sql.*;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShoppingListServ
 */
@WebServlet("/ShoppingListServ")
public class ShoppingListServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Method to do main processing in the servlet.
	 */
    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if(request.getParameter("Item_Quantity") != null) {
			//add the item
    		//check to see if we have a session, don't give us a new one!
    		HttpSession session = request.getSession(false);
    		//DOES THIS NEED CHANGING? CURRENT QUANTITIY IN OBJECT IS ALWAYS 0, THRESHOLD IS BEING SET...
			String items[] = {request.getParameter("Item_Name"), request.getParameter("Item_Type"), request.getParameter("Item_Quantity"), request.getParameter("Item_Quantity"), 
					request.getParameter("Item_Unit"), "0", "0", (String)session.getAttribute("sessionUsername")};
			Connection conn = Main.getConnection();
			ShoppingList.addItem(items, conn);
			response.sendRedirect("/laTechProject2/shoppingList.jsp");
		}
		else if(request.getParameter("ItemToBeDeleted") != null){
			//delete an the item
			Connection conn = Main.getConnection();
			ShoppingList.deleteItem(request.getParameter("ItemToBeDeleted"), conn);
			return;
		}
		else if(request.getParameterValues("toInventory") != null){
			String ids[] = request.getParameterValues("toInventory");
			Connection conn = Main.getConnection();
			for (int i = 0; i < ids.length; i++){
				Inventory.addItemFromShoppingList(ids[i], conn);
			}
		}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

}
