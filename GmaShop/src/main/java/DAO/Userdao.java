package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import gmashopmodel.UserModel;


public class Userdao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	public Userdao(Connection con) {
		this.con = con;
	}
	public UserModel userLogin (String email, String password) {
		UserModel user=null;
		try {
			query="select* from users where email=? and password=?";
			pst=this.con.prepareStatement(query);
			pst.setString(1,email);
			pst.setString(2, password);
			rs=pst.executeQuery();
			
			if(rs.next()) {
				user=new UserModel();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
	}
	return user;
}
}

	
	
   

