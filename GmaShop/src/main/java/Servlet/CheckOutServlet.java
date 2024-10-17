package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.OrderDao;
import gmashopconnection.DBcon;
import gmashopmodel.Cart;
import gmashopmodel.Order;
import gmashopmodel.*;


@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (PrintWriter outPrintWriter= response.getWriter()) {
			 SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	            Date date = new Date();
                //retrive all cart products
	            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
	            //user autentication
	            UserModel auth = (UserModel) request.getSession().getAttribute("auth");
	            //check auth and cart list
	            if (cart_list !=null && auth!=null) {
	            	for(Cart c:cart_list) {
	            		Order order=new Order();
	            		order.setId(c.getId());
	            		order.setUid(auth.getId());
	            		order.setQuantity(c.getQuantity());
	            		order.setDate(formatter.format(date));
	            		//Instantiate the dao class
	            		OrderDao oDao =new OrderDao(DBcon.getConnection());
	            		//calling the insert method
	            		boolean result=oDao.insertOrder(order);
	            		if(!result) {
	            			System.out.println("Ordine non inserito");;
	            		}
	            		
	            		cart_list.clear();
	            		response.sendRedirect("orders.jsp");
	            				
	            	}
	            } else {
	            	if (auth==null) {
	            		response.sendRedirect("login.jsp");
	            		response.sendRedirect("cart_list.jsp");
	            	}
	            }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
