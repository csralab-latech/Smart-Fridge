package com.laTechProject2;



import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class InvintoryServ
 */
@WebServlet("/InventoryServ")
public class InventoryServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Method to do main processing in the servlet.
	 */
    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if(request.getParameter("Item_Type") != null) { //If we get rid of type this will need a new detection parameter --Nick
			//add the item
    		//check to see if we have a session, don't give us a new one!
    		HttpSession session = request.getSession(false);
			String items[] = {request.getParameter("Item_Name"), request.getParameter("Item_Type"), request.getParameter("Item_Quantity_Have"), 
					request.getParameter("Item_Unit"),request.getParameter("Expiration_Date"), request.getParameter("Calories"), (String)session.getAttribute("sessionUsername")};
			Connection conn = Main.getConnection(); 
			boolean popup = Inventory.addItem(items, conn);
			request.setAttribute("pop", popup);
			response.sendRedirect("/laTechProject2/Inventory.jsp");
		}
		else if(request.getParameter("ItemToBeDeleted") != null){
			//delete an the item
			Connection conn = Main.getConnection();
			Inventory.deleteItem(request.getParameter("ItemToBeDeleted"), conn);
			return;
		}
		else if(request.getParameter("ItemToChangeQuantity") != null){
			//reduce the quantity of an item
			Connection conn = Main.getConnection();
			Inventory.changeQuantity(request.getParameter("ItemToChangeQuantity"), request.getParameter("value"), conn);
			return;
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
