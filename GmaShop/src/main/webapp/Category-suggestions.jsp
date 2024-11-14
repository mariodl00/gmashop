<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="gmashopconnection.DBcon" %>

<%
    String query = request.getParameter("query");
    if (query == null || query.trim().isEmpty()) {
        return; // Non fare nulla se la query è vuota
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DBcon.getConnection();
        String sql = "SELECT DISTINCT category FROM products WHERE category LIKE ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, query + "%");
        rs = ps.executeQuery();

        while (rs.next()) {
            out.println("<div class='suggestion-item' onclick=\"document.getElementById('category').value = '" + rs.getString("category") + "'\">" + rs.getString("category") + "</div>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Errore durante il recupero dei dati.");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>