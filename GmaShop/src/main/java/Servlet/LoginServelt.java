package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.Userdao;
import gmashopconnection.DBcon;
import gmashopmodel.UserModel;

/**
 * Servlet implementation class LoginServelt
 */
@WebServlet("/user-login")
public class LoginServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("login.jsp");	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out=response.getWriter()) {
			String email=request.getParameter("login-email");
			String password=request.getParameter("login-password");
			
			try {
			Userdao udao=new Userdao(DBcon.getConnection());
			UserModel user=udao.userLogin(email, password);
			
		if(user!=null) {
			request.getSession().setAttribute("auth", user);

			if (user.getUsersType() == 1) {
				response.sendRedirect("index.jsp");	//da modificare 
            } else {
                response.sendRedirect("index.jsp");
            }
		}
		else {
			out.print("user login failed");
		}
		}
		catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		}
	}

}
