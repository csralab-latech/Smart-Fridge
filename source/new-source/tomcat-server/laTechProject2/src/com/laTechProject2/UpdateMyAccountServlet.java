package com.laTechProject2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdateMyAccount
 */
@WebServlet("/UpdateMyAccountServlet")
public class UpdateMyAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMyAccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			HttpSession session = request.getSession(false);
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = Main.getConnection();
			
			String sql;
			sql = "UPDATE Users SET Age=?, Gender=?, Height_Feet=?, Height_Inches=?,Weight=? Where User_Name=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
	         stmt.setInt(1,Integer.parseInt(request.getParameter("age")));
	         stmt.setString(2,request.getParameter("gender"));
	         stmt.setInt(3,Integer.parseInt(request.getParameter("height_feet")));
	         stmt.setInt(4,Integer.parseInt(request.getParameter("height_inches")));
	         stmt.setInt(5,Integer.parseInt(request.getParameter("weight")));
	         stmt.setString(6, (String)session.getAttribute("sessionUsername"));
	         System.out.println("In Nutrtion Plan"+session.getAttribute("sessionUsername"));
	         stmt.executeUpdate();
	         stmt.close();
	         conn.close();
	         response.sendRedirect("/laTechProject2/myAccount.jsp");
	}catch(SQLException se){
        //Handle errors for JDBC
        se.printStackTrace();
        
     }catch(Exception e){
        //Handle errors for Class.forName
        e.printStackTrace();
        
     }
	}
}
