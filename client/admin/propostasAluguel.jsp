<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page session="true" %>
<%@ include file="navbar.jsp" %>
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
      flex-direction: row;
      gap: 10px;
    }

    @media (max-width: 576px) {
      .input-group {
        flex-direction: column;
      }
    }
  </style>
</head>
<body class="bg-light">

  <div class="container my-5">
    <h1 class="text-center mb-4">Agendamentos</h1>

    <div class="row g-3 align-items-center mb-4">
      <form method="get" action="propostasAluguel.jsp" class="input-group col-12 col-sm-6 col-md-4 mb-3">
        <div class="mb-3">
          <label for="dataInicio" class="form-label">Data de Entrada</label>
          <input type="date" id="dataInicio" name="dataInicio" class="form-control" value="<%= request.getParameter("dataInicio") != null ? request.getParameter("dataInicio") : "" %>">
        </div>
        <div class="mb-3">
          <label for="dataFim" class="form-label">Data de Saída</label>
          <input type="date" id="dataFim" name="dataFim" class="form-control" value="<%= request.getParameter("dataFim") != null ? request.getParameter("dataFim") : "" %>">
        </div>
        <div class="mb-3">
          <label for="filtroNome" class="form-label">Pesquisar Sala</label>
          <input type="text" id="filtroNome" name="filtroNome" class="form-control" placeholder="Pesquisar sala" value="<%= request.getParameter("filtroNome") != null ? request.getParameter("filtroNome") : "" %>">
        </div>
        <button type="submit" class="btn btn-primary align-self-end">Filtrar</button>
      </form>
    </div>

    <div class="bg-white p-3 rounded shadow">
      <% 
        String filtroNome = request.getParameter("filtroNome");
        String dataInicio = request.getParameter("dataInicio");
        String dataFim = request.getParameter("dataFim");

        try {
          String sql = "SELECT agendamentos.id, locais.nome AS nome_local, users.nome AS nome_cliente, agendamentos.data_entrada, agendamentos.data_saida, agendamentos.hora, agendamentos.status " +
                       "FROM agendamentos " +
                       "JOIN locais ON agendamentos.espaco_id = locais.id " +
                       "JOIN users ON agendamentos.cliente_id = users.id WHERE 1=1";

          if (filtroNome != null && !filtroNome.isEmpty()) {
              sql += " AND locais.nome LIKE ?";
          }
          if (dataInicio != null && !dataInicio.isEmpty()) {
              sql += " AND agendamentos.data_entrada >= ?";
          }
          if (dataFim != null && !dataFim.isEmpty()) {
              sql += " AND agendamentos.data_saida <= ?";
          }
          Class.forName("com.mysql.jdbc.Driver");
          Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
          PreparedStatement statement = conexao.prepareStatement(sql);

          int paramIndex = 1;
          if (filtroNome != null && !filtroNome.isEmpty()) {
              statement.setString(paramIndex++, "%" + filtroNome + "%");
          }
          if (dataInicio != null && !dataInicio.isEmpty()) {
              statement.setDate(paramIndex++, Date.valueOf(dataInicio));
          }
          if (dataFim != null && !dataFim.isEmpty()) {
              statement.setDate(paramIndex++, Date.valueOf(dataFim));
          }

          ResultSet resultSet = statement.executeQuery();
          while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String nomeLocal = resultSet.getString("nome_local");
            String nomeCliente = resultSet.getString("nome_cliente");
            java.sql.Date dataEntrada = resultSet.getDate("data_entrada");
            java.sql.Date dataSaida = resultSet.getDate("data_saida");
            java.sql.Time hora = resultSet.getTime("hora");
            String status = resultSet.getString("status");
      %>
        <div class="d-flex align-items-center mb-3">
          <!-- Card de Reserva -->
          <div class="flex-grow-1 mx-3 p-3 bg-light rounded d-flex flex-column flex-md-row align-items-md-start card-reserva">
            <!-- Indicador -->
            <div class="me-md-3 mb-3 mb-md-0">
              <div class="rounded-circle <%= "bg-" + (status.equals("aprovado") ? "success" : status.equals("aprovacao pendente") ? "warning" : status.equals("recusado") ? "danger" : "secondary") %>" style="width: 20px; height: 20px;"></div>
            </div>

            <div class="flex-grow-1">
              <p class="fw-bold mb-1"><%= nomeLocal %> - <%= nomeCliente %></p>
              <p class="small text-muted mb-3">
                Data de Entrada: <%= dataEntrada %> <br>
                Data de Saída: <%= dataSaida %> <br>
                Hora: <%= hora %> <br>
                Status: <%= status %>
              </p>
            </div>

            <% if (status.equals("aprovacao pendente")) { %>
            <div class="d-flex flex-md-column gap-2 mt-3 mt-md-0 text-center">
              <form action="atualizarStatus.jsp" method="post" class="d-inline-block w-100">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="hidden" name="status" value="recusado">
                <button type="submit" class="btn btn-danger w-100">Recusar</button>
              </form>
              <form action="atualizarStatus.jsp" method="post" class="d-inline-block w-100">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="hidden" name="status" value="aprovado">
                <button type="submit" class="btn btn-success w-100">Aceitar</button>
              </form>
            </div>
            <% } %>
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
