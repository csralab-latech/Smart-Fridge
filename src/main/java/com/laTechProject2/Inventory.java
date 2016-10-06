package com.laTechProject2;



import java.sql.*;
public class Inventory {
	protected static ResultSet getInventory(Connection conn){
		ResultSet result = null;
		Statement statement = null;
		try{
			statement = conn.createStatement();
			try{
				result = statement.executeQuery("SELECT * FROM Inventory");
			} catch (SQLException e1) {
				System.out.println("problem getting result from statement");
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			System.out.println("problem getting statement from connection");
			e1.printStackTrace();
		}
		return result; 
	}
	
	static boolean deleteItem(String SID, Connection conn){
		try{
			Statement statement = conn.createStatement();
			try{
				statement.executeUpdate("DELETE FROM Inventory WHERE SID =" + SID);
				return true;
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return false;
	}
	
	static boolean addItem(String items[], Connection conn){
		try{
			Statement statement = conn.createStatement();
			try{
				String sid = Integer.toString(0);
				String query = "INSERT INTO Inventory (SID, SName, Type, Quant_curr, Quant_threshold, MName, Expiration_date, Calories, Owner) VALUES ("
					  	+sid+",'"+items[0]+"','"+items[1]+"',"+items[2]+","+items[2]+",'"+ items[3]+"','" +items[4]+"',"+items[5]+",'"+items[6]+"') "
					  			+ "on duplicate key update Quant_curr = (Inventory.Quant_curr + " + items[2] + ")";
				statement.executeUpdate(query);
				return true;
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
			return false;
		}
		return true;
	}
	
	static boolean addItemFromShoppingList(String id, Connection conn){
		//check by SID to make sure that the Item is not already on the list
		try{
			ResultSet item = ShoppingList.getItemByID(id, conn);
			item.first();
			Statement statement = conn.createStatement();
			try{
				statement.executeUpdate("INSERT INTO Inventory (SID, SName, Type, Quant_curr, Quant_threshold, MName, Expiration_date, Calories, Owner) VALUES ("
						+ item.getString(1) +",'"
						+ item.getString(2) +"','"
						+ item.getString(3) +"',"
						+ item.getString(4) +","
						+ item.getString(5) +",'"
						+ item.getString(6) +"','"
						+ (item.getString(7)== null? "0000-00-00": item.getString(7)) +"',"
						+ item.getString(8) +",'"
						+ item.getString(9) +"')" + 
						"on duplicate key update Quant_curr = (Inventory.Quant_curr + " + item.getString(4) + ")");
				return true;
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return false;
	}

	static boolean changeQuantity(String SID, String newQuantity, Connection conn){
		try{
			Statement statement = conn.createStatement();
			statement.executeUpdate("UPDATE Inventory SET Quant_Curr="+newQuantity+" WHERE SID="+SID);
			return true;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
	
	
}
