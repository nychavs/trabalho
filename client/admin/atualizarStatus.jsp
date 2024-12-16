<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualizar Status</title>
</head>
<body>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String status = request.getParameter("status");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
        PreparedStatement statement = conexao.prepareStatement("UPDATE agendamentos SET status = ? WHERE id = ?");
        statement.setString(1, status);
        statement.setInt(2, id);
        
        statement.executeUpdate();
        statement.close();
        conexao.close();
        
        response.sendRedirect("propostasAluguel.jsp");
    } catch (SQLException e) {
        out.println("Erro ao atualizar o status do agendamento. erro = " + e);
    }
%>

</body>
</html>
