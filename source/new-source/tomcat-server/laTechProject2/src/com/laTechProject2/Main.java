package com.laTechProject2;

import java.sql.*; //Java library for sql stuff --Nick
public class Main {//138.47.200.54		10.0.0.37
	public static final String URL = "jdbc:mysql://localhost:3306/ltr_fridgedb?zeroDateTimeBehavior=convertToNull&autoReconnect=true&characterEncoding=UTF-8&characterSetResults=UTF-8";// I have copied the url from the google hangout --Nick
	static final String USERNAME = "smart-fridge"; //This is my username and password please don't hack
	static final String PASSWORD = "password"; //my Jira to find all of that sensitive data. --Nick
	
	/*public static void main(String[] args){ 
		//This block is needed to set the mysql driver --Nick
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(ClassNotFoundException e){
			throw new IllegalStateException("the class forname thing did not work", e);
		}
		//End of driver selection block --Nick
		Connection connection = getConnection(); //get a connection to the remote database --Nick
	}*/
	
	// Copied database accessing code from hospital source code given to me by Furay --Nick 
	static Connection getConnection(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(ClassNotFoundException e){
			throw new IllegalStateException("the class forname thing did not work", e);
		}
		//End of driver selection block --Nick
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(Main.URL, Main.USERNAME, Main.PASSWORD);
		} catch (SQLException e) {
		    throw new IllegalStateException("Cannot connect the database!", e);
		}
		return connection;
	}
	
	static void printResultSet(ResultSet result){
		try {

			if(result.first()){
				int numOfColumns = result.getMetaData().getColumnCount();
				String temp;
				do{
					for(int i = 1; i <= numOfColumns; i++){
						temp = result.getString(i)+"";
						System.out.print((temp.length() >= 10? padStr(temp): temp) + "\t");
					}
					System.out.println();
				}while(result.next());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	static String padStr(String str){
		if (str.length() <= 30){
			for(int i = 0; i < 30 -str.length(); i++){
				str += " ";
			}
		}else{
			str = str.substring(0,29);
		}
		return str;
	}
	
	public static String getURL() {
		return URL;
	}

	public static String getUsername() {
		return USERNAME;
	}

	public static String getPassword() {
		return PASSWORD;
	}

}
