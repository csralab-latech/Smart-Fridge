package com.laTechProject2;

import java.sql.*;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RestServ
 */
@WebServlet("/RestServ")
public class RestServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private static final String VIEW = "/recipe.jsp";
	private static int loads = 1;
    /**
     * Default constructor. 
     */
    public RestServ() {
        // TODO Auto-generated constructor stub
    }
    //private static Recipe[] invRec;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response) 
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//RequestDispatcher dispatcher = request.getRequestDispatcher(VIEW);
		long start = System.currentTimeMillis();
		final Recipe[] recipes = new Recipe[4];
		final Recipe[] invRec = new Recipe[10*loads];
    	final String[] strInv =  getInventoryAsArray();
    	System.out.println("Get String from Inv: " + (System.currentTimeMillis() - start));
    	if(strInv != null){
    		Thread invThread = new Thread(){
    	    	public void run(){
    	    		Recipe[] temp = SortIng(Recipe.setAvailableIngredients(strInv, RestAPI.getRecipesFromInv(10*loads, strInv)));
    	    		for (int i = 0; i < temp.length; i++){
    	    			invRec[i] = temp[i];
    	    		}
    	    	}
    		};
    		invThread.start();
    		Thread suggestionsThread = new Thread(){
    	    	public void run(){
    	    		Recipe[] temp = Sort(Recipe.setAvailableIngredients(strInv, RestAPI.getRandRecipes(4, RestAPI.recipeType.mainCourse)));
    	    		for (int i = 0; i < temp.length; i++){
    	    			recipes[i] = temp[i];
    	    		}
    	    	}
    		};
    		suggestionsThread.start();
    		try {
    			invThread.join();
    			suggestionsThread.join();
    		} 
    		catch (InterruptedException e) {
    			setDefaultAttributes(request);
    			e.printStackTrace(); return; 
    		}
    		System.out.println("All Done: " + (System.currentTimeMillis() - start)); 
    	}
    	else{
    		setDefaultAttributes(request);
    	}
		request.setAttribute("invRec", invRec);
		request.setAttribute("recipes", recipes);
		if(request.getParameter("LoadMore") != null){
			loads = loads + 1;
			response.sendRedirect("/laTechProject2/recipe.jsp");  	 
		}
		else {
			loads = 1;
		}
        //dispatcher.forward(request, response);
	}
	
	private void setDefaultAttributes(HttpServletRequest request) {
		request.setAttribute("invRec", Sort(RestAPI.getRandRecipes(4, RestAPI.recipeType.mainCourse)));
		request.setAttribute("recipes", Sort(RestAPI.getRandRecipes(4, RestAPI.recipeType.mainCourse)));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public static String[] getInventoryAsArray(){
		Connection conn = Main.getConnection();
    	ResultSet inv = Inventory.getInventory(conn);
    	try{
    		inv.last();
    		int last = inv.getRow();
    		String [] strInv = new String[last];
    		int i = 0;
    		if(inv.first())
    		{
    			strInv[i] = inv.getString(2).toLowerCase();
    			i += 1;
    			while(inv.next() != false){
    				strInv[i] = inv.getString(2).toLowerCase();
    				i += 1;
    			}
    		}
    		return strInv;
    	}catch(SQLException e){
    		e.printStackTrace();
    		return null;
    	}
	}


	/*sorting methods*/
	public Recipe[] swap(Recipe array[], int index1, int index2) 
	// pre: array is full and index1, index2 < array.length
	// post: the values at indices 1 and 2 have been swapped
	{
		Recipe temp = array[index1];          // store the first value in a temp
		array[index1] = array[index2];      // copy the value of the second into the first
		array[index2] = temp;               // copy the value of the temp into the second
		return array;
	}
	
	public Recipe[] Sort(Recipe[] arr) {
	      boolean swapped = true;
	      int j = 0;
	      //int tmp;
	      while (swapped) {
	            swapped = false;
	            j++;
	            for (int i = 0; i < arr.length - j; i++) {                                       
	                  if (arr[i].getCalories() > arr[i+1].getCalories()) {                          
	                        swap(arr,i,i+1);
	                        swapped = true;
	                  }
	            }                
	      }
	      return arr;
	}

	public Recipe[] SortIng(Recipe[] arr) {
	      boolean swapped = true;
	      int j = 0;
	      //int tmp;
	      while (swapped) {
	            swapped = false;
	            j++;
	            for (int i = 0; i < arr.length - j; i++) {                                       
	                  if ((arr[i].getNumOfIngredients()-arr[i].getAvailableIngr()) > (arr[i+1].getNumOfIngredients()-arr[i+1].getAvailableIngr())) {                          
	                        swap(arr,i,i+1);
	                        swapped = true;
	                  }
	            }                
	      }
	      return arr;
	}
}
