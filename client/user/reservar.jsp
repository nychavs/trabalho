<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserva Confirmada</title>
    <!-- Link para Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
    int idLocal = Integer.parseInt(request.getParameter("idLocal"));
    int clienteId = (Integer) session.getAttribute("cliente_id");

    try {
        // Configurações de agendamento
        String status = "aprovacao pendente";
        int avaliacao = 0; // Avaliação inicial

        // Inserir o agendamento na tabela `agendamentos`
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
        PreparedStatement statement = conexao.prepareStatement("INSERT INTO agendamentos (espaco_id, cliente_id, data, hora, status, avaliacao) VALUES (?, ?, CURDATE(), CURTIME(), ?, ?)");
        statement.setInt(1, idLocal);
        statement.setInt(2, clienteId);
        statement.setString(3, status);
        statement.setInt(4, avaliacao);
        
        statement.execute();
        statement.close();
        conexao.close();

        out.println("<div class='container my-5'>");
        out.println("<h1 class='text-center'>Reserva Confirmada!</h1>");
        out.println("<p class='text-center'>Sua reserva foi realizada com sucesso e está aguardando aprovação.</p>");
        out.println("<div class='text-center'>");
        out.println("<a href='home.jsp' class='btn btn-primary'>Voltar para a Home</a>");
        out.println("</div>");
        out.println("</div>");
    } catch (SQLException e) {
        out.println("Erro ao realizar a reserva. erro = " + e);
    }
%>

<!-- Link para Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
