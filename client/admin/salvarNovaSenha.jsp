<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String novaSenha = request.getParameter("novaSenha");
    int userId = (Integer) session.getAttribute("user_id");

    Connection conexao = null;
    PreparedStatement statement = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
        
        String sql = "UPDATE users SET senha = ?, first_login = FALSE WHERE id = ?";
        statement = conexao.prepareStatement(sql);
        statement.setString(1, novaSenha);
        statement.setInt(2, userId);

        statement.executeUpdate();

        response.sendRedirect("/trabalho/client/admin/listaEspacos.jsp");

    } catch (Exception e) {
        out.println("Erro ao salvar a nova senha: " + e.getMessage());
    } finally {
        try {
            if (statement != null) statement.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            out.println("Erro ao fechar a conexão: " + e.getMessage());
        }
    }
%>
