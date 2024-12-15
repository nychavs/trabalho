<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gerenciamento de Reservas</title>
  <!-- Link para Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card-reserva {
      max-width: 100%;
    }

    .input-group {
      flex-direction: column;
    }

    @media (min-width: 576px) {
      .input-group {
        flex-direction: row;
      }
    }
  </style>
</head>
<body class="bg-light">

  <div class="container my-5">
    <!-- Título -->
    <h1 class="text-center mb-4">Agendamentos</h1>

    <!-- Barra Superior -->
    <div class="row g-3 align-items-center mb-4">
      <div class="col-12 col-sm-6 col-md-4">
        <input type="text" class="form-control" placeholder="Pesquisar sala" />
      </div>
      <div class="col-6 col-md-3">
        <input type="date" class="form-control" />
      </div>
      <div class="col-6 col-md-3">
        <input type="date" class="form-control" />
      </div>
      <div class="col-12 col-md-2">
        <button class="btn btn-primary w-100">Filtrar</button>
      </div>
    </div>

    <!-- Lista de Reservas -->
    <div class="bg-white p-3 rounded shadow">
      <% 
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
          PreparedStatement statement = conexao.prepareStatement(
            "SELECT agendamentos.id, locais.nome AS nome_local, users.nome AS nome_cliente, agendamentos.data, agendamentos.hora, agendamentos.status " +
            "FROM agendamentos " +
            "JOIN locais ON agendamentos.espaco_id = locais.id " +
            "JOIN users ON agendamentos.cliente_id = users.id"
          );
          ResultSet resultSet = statement.executeQuery();
          while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String nomeLocal = resultSet.getString("nome_local");
            String nomeCliente = resultSet.getString("nome_cliente");
            java.sql.Date data = resultSet.getDate("data");
            java.sql.Time hora = resultSet.getTime("hora");
            String status = resultSet.getString("status");
      %>
        <div class="d-flex align-items-center mb-3">

          <!-- Card de Reserva -->
          <div class="flex-grow-1 mx-3 p-3 bg-light rounded d-flex flex-column flex-md-row align-items-md-start card-reserva">
            <!-- Indicador -->
            <div class="me-md-3 mb-3 mb-md-0">
              <div class="rounded-circle <%= "bg-" + (status.equals("aprovado") ? "success" : status.equals("aprovacao pendente") ? "warning" : "secondary") %>" style="width: 20px; height: 20px;"></div>
            </div>

            <!-- Informações da Reserva -->
            <div class="flex-grow-1">
              <p class="fw-bold mb-1"><%= nomeLocal %> - <%= nomeCliente %></p>
              <p class="small text-muted mb-3">
                Data: <%= data %> <br>
                Hora: <%= hora %> <br>
                Status: <%= status %>
              </p>
            </div>

            <!-- Botões de Ação -->
            <div class="d-flex flex-md-column gap-2 mt-3 mt-md-0 text-center">
              <button class="btn btn-danger w-100">Recusar</button>
              <button class="btn btn-success w-100">Aceitar</button>
            </div>
          </div>
        </div>
      <% 
          }
          resultSet.close();
          statement.close();
          conexao.close();
        } catch (SQLException e) {
          out.println("Erro na conexão ao banco de dados. erro = " + e);
        }
      %>
    </div>
  </div>

  <!-- Link para Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Link para Ícones Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</body>
</html>
