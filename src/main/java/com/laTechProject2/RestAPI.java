package com.laTechProject2;

import java.util.concurrent.ThreadLocalRandom;

import javax.ws.rs.core.Response;
import org.json.JSONArray;
import org.json.JSONObject;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

public class RestAPI {
	private static final String MASHAPE_KEY = "yHf6hwGbWNmshL7IFrRzR4cW7YBlp1QllrdjsnRjzg3xPacmjC";
	public static enum recipeType{mainCourse, sideDish, dessert, 
		appetizer, salad, bread, breakfast, soup, beverage, sauce, drink};
	
	/* See Here for a brief example on how to use the API */	
    public static void example()
    {
    	int numOfRandRecipes = 4;
    	int[] randInt = getRandRecipesId(numOfRandRecipes, recipeType.mainCourse);
    	// Also see getRandRecipes(numOfRandRecipes, recipeType.mainCourse)
    	String result;
    	for (int i = 0; i < randInt.length; i++){
    		result = getRecipeInfoStr(randInt[i]);
    	    System.out.println( result != null? 
    	    		"Status: " + 200 + "\n\n" + result + "\n\n":
    	    			"null");
    	}
    	/*ThreadLocalRandom.current().nextInt(1, 50);
    	int[] temp = searchForRecipes(5, 2, recipeType.mainCourse);
    	String result;
    	for (int i = 0; i < temp.length; i++){
    		System.out.println(temp[i]);
    		result = getRecipeInfoStr(temp[i]);
    	    System.out.println( result != null? 
    	    		"Status: " + 200 + "\n\n" + result + "\n\n":
    	    			"null");
    	}*/
        //System.out.println( "Status: " + statusCode + "\n\n" + output );
    }
    
    /**
     * Method to get an array of recipes that use the ingredients given.
     * @param numOfRecipes: Number of recipes wanted
     * @param ingredients: Array of the ingredients in the inventory to be used in search
     * @return Recipe[]: array of Recipes. See Recipes class for more details on the object.
     */
    public static Recipe[] getRecipesFromInv(int numOfRecipes, String[] ingredients){
    	final int[] recipeIds = getRecipesIdsByIngr(numOfRecipes, ingredients);
    	return getRecipesById(recipeIds);
    }
    
    /**
     * Method to get a randomly generated array of recipes of a specific type.
     * @param numOfRecipes: Number of recipes wanted
     * @param type: Type of recipes needed. Type is specified with the recipeType ENUM.
     * @return Recipe[]: array of Recipes. See Recipes class for more details on the object.
     */
    public static Recipe[] getRandRecipes(int numOfRecipes, recipeType type){
    	final int[] randIds = getRandRecipesId(numOfRecipes, type);
    	return getRecipesById(randIds);
    }

	/** Method to get a list of recipes given an array of recipe IDs (Multithreded).
	 * @param ids: int array containing the ids of recipes to be returned.
	 * @return Recipe[]: array of Recipes. See Recipes class for more details on the object.
	 */
	private static Recipe[] getRecipesById(final int[] ids) {
    	final Recipe[] recipesArr = new Recipe[ids.length];
		Thread [] t = new Thread[ids.length];
    	for(int i = 0; i < ids.length; i++){
    		final int index = i;
    		t[i] = new Thread(){
    	    	public void run(){
    	    		recipesArr[index] = new Recipe(ids[index]);
    	    	}
    		};
    	}
    	for(int i =0; i < t.length; i++){
			t[i].start();
		}
		for(int i =0; i < t.length; i++){
			try {
				t[i].join();
			} 
			catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
    	return recipesArr;
	}
	
	/**
	 * Method to get an array of valid Recipe IDs that meet an ingredient search.
	 * @param numOfRecipes: int for number of recipes expected.
	 * @param ingredients: String array containing ingredients.
	 * @return int[] containing the numOfRecipes Recipe IDs.
	 */
	public static int[] getRecipesIdsByIngr(int numOfRecipes, String [] ingredients){
    	return searchForRecipes(getRecipesUrlByIngredients(numOfRecipes, ingredients));
    }
    
    /**
     * Method to get random recipe id's of a specific type.
     * @param numOfRecipes: Number of recipes wanted
     * @param type: Type of recipes needed. Type is specified with the recipeType ENUM.
     * @return int[]: int array containing the recipe id's.
     */
    public static int[] getRandRecipesId(int numOfRecipes, recipeType type){
    	int totalNumOfRecipes = 1000;
    	int randOffset = ThreadLocalRandom.current().nextInt(1, totalNumOfRecipes - numOfRecipes);
    	return searchForRecipes(getRecipesSearchUrl(numOfRecipes, randOffset, type));
    }

    /**
     * Method to get recipe based on recipe ID.
     * @param id
     * @return Recipe: A single recipe that has the specified ID.
     */
    public static Recipe getRecipeFromId(int id){
    	String recipeJson = getRecipeJson(id);
    	if(recipeJson != null){
    		return new Recipe(recipeJson);
    	}
	    return Recipe.nullRecipe();
    }
    
    /**
     * Method to get recipe based on recipe ID
     * @param id
     * @return String: JSON string received from the Rest Server
     */    
    public static String getRecipeJson(int id){
    	Client client = Client.create();
		WebResource webResource = client.resource(getRecipeUrl(id));
		ClientResponse response = webResource.header("X-Mashape-Key", MASHAPE_KEY)
				.accept("application/json").get(ClientResponse.class); 
 	    int statusCode = response.getStatus();
 	    if(statusCode == 200){
	    	return response.getEntity(String.class);
	    }
	    return null;
    }
     
     /**
      * Method to format recipe JSON to a readable String
      * @param jsonString
      * @return String with recipe name, ingredient details etc.
      */
     public static String getRecipeInfoStr(int id){
     	Recipe temp = getRecipeFromId(id);
 		return temp.toString();
     }
     
     /**
      * Method to search for recipes based on type. 
      * This method returns "numOfRecipes" recipes starting from the "offset" result.
      * @param numOfRecipes: (0 - 100) Number of recipes to be returned back. -1 defaults to 10.
      * @param offset: (0 - 900) Number of results to skip. -1 defaults to 0.
      * @param type: Enum for possible types. Use "recipeType.mainCourse" if you're not sure.
      * @return int[]: int array, numOfRecipes long, contains recipe id's that meet search criteria.
      */
     public static int[] searchForRecipes(String url){
    	 Client client = Client.create();
    	 WebResource webResource = client.resource(url);
    	 ClientResponse response = webResource.header("X-Mashape-Key", MASHAPE_KEY)
 				.accept("application/json").get(ClientResponse.class); 
    	 int statusCode = response.getStatus();
    	 if(statusCode == 200){
    		 return recipeSearchJson2Arr(response.getEntity(String.class));
		 }
    	 return null;
     }
     
     // Youtube functions start here: Everything is hardcoded :(
     /**
      * Method to return a youtube video link given a search term (recipe name)
      * @param searchStr: A sting parameter which specifies a term to search for (e.g. the name of a recipe)
      * @return String: String containing https link to "most relevant" youtube video
      */
     public static String getYouTubeVideo(String searchStr){
    	 Client client = Client.create();
         String url = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDUDoK1vzyOobR22nkDGZ1jrNYl1yhSjKc&part=snippet&maxResults=1&q=";
         url = url + searchStr.trim().replace("w/", " ").replaceAll("[^A-Za-z0-9 ]", " ").replaceAll("\\s+", "%2C"); // replace stupid stuff.
    	 WebResource webResource = client.resource(url);
    	 ClientResponse response = webResource
  				.accept("application/json").get(ClientResponse.class); 
         int statusCode = response.getStatus(); 
         if(statusCode == 200){
        	 String temp = response.getEntity(String.class);
             JSONObject obj = new JSONObject(temp);
             JSONArray result = obj.getJSONArray("items");
             try{
             return "https://www.youtube.com/embed/" + result.getJSONObject(0).getJSONObject("id").getString("videoId");
             }catch(Exception e){
            	 return "";
             }
         }
         return null;
     }
     
    
     /********************************** BEGINNING OF PRIVATE METHODS ********************************/
    
    /**
     * Method to parse JSON string received from Recipe search query
     * @param jsonString
     * @return int[]: int array containing a list of recipe id's that meet the search criteria.
     */
    private static int[] recipeSearchJson2Arr(String jsonString){
    	JSONArray resultsArr;
    	try{
    		resultsArr = new JSONArray(jsonString); // Works for search by ingredients. 
    	}catch(Exception e){
        	JSONObject obj = new JSONObject(jsonString);
    		resultsArr = obj.getJSONArray("results"); // Works for general search (used for random recipes).
    	}
    	int[] results = new int[resultsArr.length()];
    	for (int i = 0; i < resultsArr.length(); i++)
    	{	
    		results[i] = resultsArr.getJSONObject(i).getInt("id");
    	}
    	return results;
    }
  
	private static String getRecipeUrl(int id){
		return "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/" + id + "/information?includeNutrition=true";
	}
	
	private static String getRecipesSearchUrl(int numOfResults, int offset, recipeType type){
		StringBuffer url = new StringBuffer("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?limitLicense=false");
		if(numOfResults >= 0){
			url.append("&number=" + numOfResults);
		}
		if(offset >= 0){
			url.append("&offset=" + offset);
		}
		switch (type){
		case appetizer:
			url.append("&type=appetizer");
			break;
		case beverage:
			url.append("&type=beverage");
			break;
		case breakfast:
			url.append("&type=breakfast");
			break;
		case dessert:
			url.append("&type=dessert");
			break;
		case drink:
			url.append("&type=drink");
			break;
		default:
			url.append("&type=main+course");
			break;
		}
		return url.toString();
	}
	
	private static String getRecipesUrlByIngredients(int numOfResults, String [] ingredients){
		StringBuffer url = new StringBuffer("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com"
				+ "/recipes/findByIngredients?fillIngredients=false&ranking=2&limitLicense=false");
		if(numOfResults >= 0){
			url.append("&number=" + numOfResults);
		}
		if(ingredients.length > 0 && ingredients != null){
			url.append("&ingredients=" + ingredients[0].trim().replaceAll("\\s+", "%2C")); // Replace whitespace
			for(int i = 1; i < ingredients.length; i++){
				if(ingredients[i] != null && !ingredients[i].isEmpty()){
					url.append("%2C" + ingredients[i].trim().replaceAll("\\s+", "%2C"));
				}
			}
		}
		return url.toString();
	}
}