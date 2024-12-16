<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Obtendo os dados do formulário
    String email = request.getParameter("usuario"); // Alterado para receber o email
    String senha = request.getParameter("senha");

    // Validação básica
    if (email == null || senha == null || email.isEmpty() || senha.isEmpty()) {
        response.sendRedirect("login.jsp?erro=preenchimento");
        return;
    }

    // Conexão com o banco de dados
    Connection conexao = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
        
        String sql = "SELECT id, role, first_login FROM users WHERE email = ? AND senha = ?";
        statement = conexao.prepareStatement(sql);
        statement.setString(1, email);
        statement.setString(2, senha);

        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            int userId = resultSet.getInt("id");
            String role = resultSet.getString("role");
            boolean firstLogin = resultSet.getBoolean("first_login");

            session.setAttribute("user_id", userId);
            session.setAttribute("role", role);

            if (firstLogin && email.equals("admin@example.com")) {
                response.sendRedirect("/trabalho/client/admin/alterarSenha.jsp");
            } else if (role.equals("admin")) {
                response.sendRedirect("/trabalho/client/admin/listaEspacos.jsp");
            } else {
                response.sendRedirect("/trabalho/client/user/home.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?erro=invalid");
        }
    } catch (Exception e) {
        out.println("Erro ao autenticar o usuário: " + e.getMessage());
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (conexao != null) conexao.close();
        } catch (SQLException e) {
            out.println("Erro ao fechar a conexão: " + e.getMessage());
        }
    }
%>
