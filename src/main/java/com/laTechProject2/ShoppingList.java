package com.laTechProject2;

import java.sql.*;

public class ShoppingList {
	
	protected static ResultSet getShoppingList(Connection conn){
		ResultSet result = null;
		Statement statement = null;
		try{
			statement = conn.createStatement();
			try{
				result = statement.executeQuery("SELECT * FROM ShoppingList");
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
	
	public static ResultSet getItemByID(String id, Connection conn){
		ResultSet result = null;
		Statement statement = null;
		try{
			statement = conn.createStatement();
			result = statement.executeQuery("SELECT * FROM ShoppingList WHERE SID=" + id);
		} catch (SQLException e1) {
			System.out.println("problem getting statement from connection");
		}
		return result;
	}
	
	static boolean deleteItem(String SID, Connection conn){
		try{
			Statement statement = conn.createStatement();
			try{
				statement.executeUpdate("DELETE FROM ShoppingList WHERE SID ='" + SID + "'");
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
				String query = "INSERT INTO ShoppingList (SID, SName, Type, Quant_curr, Quant_threshold, MName, Expiration_date, Calories, Owner) VALUES ("
						+sid+",'"+items[0]+"','"+items[1]+"',"+items[2]+","+items[3]+ ",'"+ items[4]+"'," +items[5]+","+items[6]+",'"+items[7]+"') "
						+ "on duplicate key update Quant_curr = (ShoppingList.Quant_curr + " + items[2] + ")";
				statement.executeUpdate(query);
				return true;
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return false;
	}

	static boolean changeDesiredQuantity(String SID, int newQuantity, Connection conn){
		try{
			Statement statement = conn.createStatement();
			statement.executeUpdate("UPDATE 'ShoppingList' SET Quant_threshold="+newQuantity+" WHERE SID="+"'"+SID+"'");
			return true;
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
}
