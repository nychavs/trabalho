<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autenticação</title>
</head>
<body>

<%
    String usuario = request.getParameter("usuario");
    String senha = request.getParameter("senha");
    boolean autenticado = false;
    boolean isAdmin = false;
    int clienteId = -1;
    String nomeUsuario = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
        PreparedStatement statement = conexao.prepareStatement("SELECT * FROM users WHERE email = ? AND senha = ?");
        statement.setString(1, usuario);
        statement.setString(2, senha);
        ResultSet result = statement.executeQuery();

        if (result.next()) {
            autenticado = true;
            clienteId = result.getInt("id");
            nomeUsuario = result.getString("nome");
            isAdmin = result.getString("role").equals("admin");
        }
        result.close();
        statement.close();
        conexao.close();
    } catch (SQLException e) {
        out.println("Erro na conexão ao banco de dados. erro = " + e);
    }

    if (autenticado) {
        session.setAttribute("cliente_id", clienteId);
        session.setAttribute("nome_usuario", nomeUsuario);
        session.setAttribute("is_admin", isAdmin);
        if (isAdmin) {
            response.sendRedirect("/trabalho/client/admin/listaEspacos.jsp");
        } else {
            response.sendRedirect("home.jsp");
        }
    } else {
        out.println("<div class='container my-5'>");
        out.println("<h1 class='text-center'>Erro na Autenticação</h1>");
        out.println("<p class='text-center'>Usuário ou senha incorretos. Tente novamente.</p>");
        out.println("<div class='text-center'>");
        out.println("<a href='login.jsp' class='btn btn-primary'>Voltar ao Login</a>");
        out.println("</div>");
        out.println("</div>");
    }
%>

</body>
</html>
