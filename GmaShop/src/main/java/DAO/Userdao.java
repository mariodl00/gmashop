package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import gmashopmodel.UserModel;

public class Userdao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public Userdao(Connection con) {
        this.con = con;
    }

    // Metodo per il login dell'utente
    public UserModel userLogin(String email, String password) {
        UserModel user = null;
        try {
            query = "select * from users where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setUsersType(rs.getInt("account_type"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return user;
    }

    // Metodo per ottenere tutti i clienti
    public List<UserModel> getAllCustomers() {
        List<UserModel> customers = new ArrayList<>();
        try {
            String query = "SELECT * FROM users WHERE account_type != 1"; // Filtra gli amministratori (account_type != 1)
            PreparedStatement pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setUsersType(rs.getInt("account_type"));
                customers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    public boolean registerUser(UserModel user) throws SQLException {
        boolean isRegistered = false;
        String query = "INSERT INTO users (name, email, password, account_type) VALUES (?, ?, ?, ?)";

        try {
            pst = this.con.prepareStatement(query);
           
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPassword());
            pst.setInt(4, user.getUsersType()); // account_type 0 per utenti normali, puoi modificare questo valore se necessario
            
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected > 0) {
                isRegistered = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isRegistered;
    }


}

   

