package com.laTechProject2;


import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Recipes from Spoonacular's ReST API
 * @author Fure
 * Team IOT :)
 */
public class Recipe {
	private String title;
	private String sourceURL;
	private String imageURL;
	private String[] ingredient; 
	private String[] ingrDescriptive;
	private int readyInMinutes;
	private Double calories;
	private int numOfIngredients;
	private int availableIngr;
	private String youtubeLink;
	
	/**
	 * Constructor for object of class Recipe
	 * @param title
	 * @param sourceURL
	 * @param imageURL
	 * @param ingredient
	 * @param ingrDescriptive: Ingredient in descriptive format.
	 * @param readyInMinutes: Time (minutes) to cook recipe. 
	 * @param calories
	 * @param numOfIngredients
	 * @param availableIngredients
	 */
	public Recipe(String title, String sourceURL, String imageURL, 
			String[] ingredient, String[] ingrDescriptive,
			int readyInMinutes, Double calories, int numOfIngredients, int availableIngr){
		this.title = title;
		this.sourceURL = sourceURL;
		this.imageURL = imageURL;
		this.ingredient = ingredient;
		this.ingrDescriptive = ingrDescriptive;
		this.readyInMinutes = readyInMinutes;
		this.calories = calories;
		this.numOfIngredients = numOfIngredients;
		this.availableIngr = availableIngr;
	}
	
	/**
	 * Constructor to create a Recipe object given a JSON String input.
	 * @param jsonString: JSON String object for a recipe retrieved using the ReST API. 
	 */
	public Recipe(String jsonString){
		JSONObject obj = new JSONObject(jsonString);
    	JSONArray ingrArr = obj.getJSONArray("extendedIngredients"); // Ingredient Array
    	JSONArray nutritionArr = obj.getJSONObject("nutrition").getJSONArray("nutrients");
		this.title = obj.getString("title").replace("?", "");
		// Start thread to get youtube link
		final String[] youtubeURL = new String[1];
		final String tempTitle = this.title;
		Thread t = new Thread(){
	    	public void run(){
	    		youtubeURL[0] = RestAPI.getYouTubeVideo(tempTitle);
	    	}
		};
		t.start();
		//********* thread Started ***********//
		this.sourceURL = obj.getString("sourceUrl").split("/")[2]; // Get only the domain name and not the entire URL.
		this.imageURL = obj.getString("image");
		this.readyInMinutes = obj.getInt("readyInMinutes");
		this.calories = nutritionArr.getJSONObject(0).getDouble("amount");
    	this.ingredient = new String[ingrArr.length()];
    	this.ingrDescriptive = new String[ingrArr.length()];
    	this.numOfIngredients = ingrArr.length();
    	for (int i = 0; i < ingrArr.length(); i++)
    	{	
    		this.ingredient[i] = ingrArr.getJSONObject(i).getString("name");
    		this.ingrDescriptive[i] = ingrArr.getJSONObject(i).getString("originalString");
    	}
    	this.availableIngr = 0;
		//********* Now Join thread and assign youtube
		try {
			t.join();
		} 
		catch (InterruptedException e) {
			e.printStackTrace();
		}
		this.youtubeLink = youtubeURL[0];
	}
	
	/**
	 * Constructor to create a Recipe object given a valid recipe ID from Spoonacular's API.
	 * @param id: Valid recipe id.
	 */
	public Recipe(int id){
		this(RestAPI.getRecipeJson(id));
	}
	
	/**
	 * Static method to assign available ingredients given a ResultSet
	 * @param inv
	 * @param invRec
	 * @return 
	 */
	public static Recipe[] setAvailableIngredients(String[] inv, Recipe[] invRec) {
		/* this is the beginning of Nicks Addition to this class */
		for(int k = 0; k < invRec.length; k++){
			int numHave = 0;
			String[] ingredient = invRec[k].getIngredient();
			for(int j = 0; j < ingredient.length; j++){ //this is where I count what is in the inventory vs. what we need
				for(int i = 0; i < inv.length; i++){
					if(ingredient[j].toLowerCase().contains(inv[i].toLowerCase())){
						numHave = numHave + 1;
						break;
					}
				}
			}
			invRec[k].setAvailableIngr(numHave); // set the availableIngr to the correct value --Nick
			/* This is the end of Nicks addition to this class */
		}
		return invRec;
	}
	
	public static Recipe nullRecipe(){
		String[] temp = {"ingredient"};
		return new Recipe("Title", "Source", "Image", temp, temp, 0, 0.0, 0,0);
	}
	
	/**
	 * Getter for title field of a Recipe object.
	 * @return String: Containing the title/name of the recipe.
	 */
	public String getTitle(){
		return this.title;
	}
	
	/**
	 * Getter for source URL field of a Recipe object.
	 * @return String: Containing the source i.e. Where the recipe was gotten from.
	 */
	public String getSourceUrl(){
		return this.sourceURL;
	}
	
	/**
	 * Getter for image URL field of a Recipe object.
	 * @return String: Containing the URL to an image of the recipe.
	 */
	public String getImageURL(){
		return this.imageURL;
	}
	
	/**
	 * Getter for list of ingredients in a Recipe object.
	 * @return ArrayList<String>: Containing the list of ingredients of the recipe.
	 */
	public String[] getIngredient(){
		return this.ingredient;
	}
	
	/**
	 * Getter for list of ingredients given with descriptions.
	 * @return ArrayList<String>
	 */
	public String[] getIngrDescriptive(){
		return this.ingrDescriptive;
	}
	
	/**
	 * Getter for a String representation of the list of ingredients with descriptions.
	 * @return String
	 */
	public String getIngrDescStr(){
		StringBuffer strBuf = new StringBuffer("Ingredients:\n\t" );
		for(int i = 0; i < this.ingrDescriptive.length; i++){
			strBuf.append(ingrDescriptive[i] + "\n\t");
		}
		return strBuf.toString();
	}

	/**
	 * Getter to retrieve the calories field of a Recipe object.
	 * @return Double
	 */
	public Double getCalories(){
		return this.calories;
	}
	
	/**
	 * Getter to retrieve the time to cook field of a Recipe object.
	 * @return int: Integer value for the time to cook the recipe in minutes.
	 */
	public int getCookingTime(){
		return this.readyInMinutes;
	}
	
	public String toString(){
		return "Name: " + this.getTitle() + "\n" + 
     			"Source: " + this.getSourceUrl() + "\n" + 
 				"Image: " + this.getImageURL() + "\n" + 
 				"Calories: " + this.getCalories() + "\n" + 
     			"Cooking Time (min): " + this.getCookingTime() + "\n\n" + 
 				"Ingredients:\n\t" + this.getIngrDescStr();
	}
	
	/**
	 * Getter to retrieve the number of ingredients needed for a Recipe.
	 * @return int: Integer value for the number of ingredients.
	 */
	public int getNumOfIngredients() {
		return numOfIngredients;
	}

	/**
	 * Setter method to set the number of ingredients needed for a Recipe.
	 * @return int: Integer value for the number of ingredients.
	 */
	public void setNumOfIngredients(int numOfIngredients) {
		this.numOfIngredients = numOfIngredients;
	}

	/**
	 * Getter to retrieve the number of ingredients that are available in the Refrigerator.
	 * @return int: Integer value for the number of ingredients already in the Refrigerator.
	 */
	public int getAvailableIngr() {
		return availableIngr;
	}

	/**
	 * Setter method to set the number of available ingredients already in the Refrigerator.
	 * @return int: Integer value for the number of available ingredients.
	 */
	public void setAvailableIngr(int availableIngr) {
		this.availableIngr = availableIngr;
	}

	public String getYoutubeLink() {
		return youtubeLink;
	}

	public void setYoutubeLink(String youtubeLink) {
		this.youtubeLink = youtubeLink;
	}
}
