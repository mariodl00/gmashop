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

@WebServlet("/user-register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            // Crea un nuovo oggetto UserModel
            UserModel user = new UserModel();
            
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setUsersType(2);
            
            
            // Usa Userdao per salvare l'utente nel database
            try {
                Userdao udao = new Userdao(DBcon.getConnection());
                boolean userRegistered = udao.registerUser(user);
                
                if (userRegistered) {
                    response.sendRedirect("login.jsp"); // Reindirizza alla pagina di login dopo la registrazione
                } else {
                    out.println("Registrazione fallita!");
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                out.println("Errore nella classe del database: " + e.getMessage());
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Errore SQL: " + e.getMessage());
            }
        } 
    }
}

