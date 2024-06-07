package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import org.apache.catalina.valves.rewrite.InternalRewriteMap.Escape;

import gmashopmodel.*;
public class ProductDao {
	    private Connection con;
		private String query;
		private PreparedStatement pst;
		private ResultSet rs;
		public ProductDao (Connection con) {
			super();
			this.con=con;
			}
		
		public List <Product> getAllProducts() {
			List <Product> products=new ArrayList<Product>();
			try {
				query = "select * from products";
				pst=this.con.prepareStatement(query);
				rs=pst.executeQuery();
				while(rs.next()) {
					Product row=new Product();
					row.setId(rs.getInt("id"));
					row.setName(rs.getString("name"));
					row.setCategory(rs.getString("category"));
					row.setPrice(rs.getDouble("price"));
					row.setImage(rs.getString("image"));
					
					products.add(row);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return products;
			
		}
		
		public Product getSingleProduct(int id) {
			Product row = null;
			
			try {
				query = "select * from products where id=?";
				pst = this.con.prepareStatement(query);
				pst.setInt(1, id);
				rs = pst.executeQuery();
				
				while(rs.next()) {
					row = new Product();
					row.setId(rs.getInt("id"));
					row.setName(rs.getString("name"));
					row.setCategory(rs.getString("category"));
					row.setPrice(rs.getDouble("price"));
					row.setImage(rs.getString("image"));
				}
			}catch (Exception e) {
				e.printStackTrace();
					
				}
			return row;
			}
		
		
		
		public List <Cart> getCartProducts(ArrayList<Cart> cartList){
		List<Cart> products=new ArrayList<Cart>();
		try {
			if (cartList.size()>0) {
				for (Cart item:cartList) {
					query="select * from products where id=?";
					pst=this.con.prepareStatement(query);
					pst.setInt(1,  item.getId());
					rs=pst.executeQuery();
					while(rs.next()) {
						Cart row=new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setCategory(rs.getString("category"));
						row.setPrice(rs.getDouble("price")*item.getQuantity());
						row.setQuantity(item.getQuantity());
						products.add(row);

					}
				}
			}
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return products;

		}
		
		public double getTotalCartPrice(ArrayList<Cart> carttList) {
			double sum=0;
			
			try {
				if(carttList.size()>0) {
					for(Cart item:carttList) {
						query = "select price from products where id=?";
						pst = this.con.prepareStatement(query);
						pst.setInt(1, item.getId());
						rs = pst.executeQuery();
						
						while(rs.next()) {
							sum+=rs.getDouble("price")*item.getQuantity();
						}
					}
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return sum;
		}
		 public boolean removeProduct(int id) throws SQLException {
		        String query = "DELETE FROM products WHERE id=?";
		        boolean rowDeleted;
		        try (PreparedStatement statement = con.prepareStatement(query)) {
		            statement.setInt(1, id);
		            rowDeleted = statement.executeUpdate() > 0;
		        }
		        return rowDeleted;
		    }
		 public boolean insertProduct(Product product) throws SQLException {
		        String query = "INSERT INTO products (name, category, price, image) VALUES (?, ?, ?, ?)";
		        boolean rowInserted;
		        try (PreparedStatement statement = con.prepareStatement(query)) {
		            statement.setString(1, product.getName());
		            statement.setString(2, product.getCategory());
		            statement.setDouble(3, product.getPrice());
		            statement.setString(4, product.getImage());
		            rowInserted = statement.executeUpdate() > 0;
		        }
		        return rowInserted;
		    }
		 
		  public void updateProduct(Product product) throws SQLException {
		        String query = "UPDATE products SET name = ?, category = ?, price = ?, image = ? WHERE id = ?";
		        PreparedStatement ps = con.prepareStatement(query);
		        ps.setString(1, product.getName());
		        ps.setString(2, product.getCategory());
		        ps.setDouble(3, product.getPrice());
		        ps.setString(4, product.getImage());
		        ps.setInt(5, product.getId());
		        ps.executeUpdate();
		    }
}

