<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page session="true" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Histórico de Agendamentos</title>
    <!-- Link para Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-cancelar {
            background-color: #dc3545;
            color: white;
            border: none;
        }
        .btn-cancelar:hover {
            background-color: #b02a37;
        }
    </style>
</head>
<body class="bg-light">

<div class="container my-5">
    <h1 class="mb-4 text-center">Histórico de Agendamentos</h1>

    <div class="row mb-4">
        <form method="get" action="historico.jsp" class="d-flex flex-column flex-md-row gap-3">
            <input type="text" name="filtroNome" class="form-control" placeholder="Pesquisar por nome do local" value="<%= request.getParameter("filtroNome") != null ? request.getParameter("filtroNome") : "" %>">
            <input type="date" name="dataInicio" class="form-control" value="<%= request.getParameter("dataInicio") != null ? request.getParameter("dataInicio") : "" %>">
            <input type="date" name="dataFim" class="form-control" value="<%= request.getParameter("dataFim") != null ? request.getParameter("dataFim") : "" %>">
            <button type="submit" class="btn btn-primary">Filtrar</button>
        </form>
    </div>

    <div class="row g-3">
        <% 
            int clienteId = (Integer) session.getAttribute("user_id");
            String filtroNome = request.getParameter("filtroNome");
            String dataInicio = request.getParameter("dataInicio");
            String dataFim = request.getParameter("dataFim");

            try {
                String sql = "SELECT agendamentos.id, locais.nome AS nome_local, agendamentos.data_entrada, agendamentos.data_saida, agendamentos.hora, agendamentos.status " +
                             "FROM agendamentos " +
                             "JOIN locais ON agendamentos.espaco_id = locais.id " +
                             "WHERE agendamentos.cliente_id = ?";

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
                statement.setInt(1, clienteId);

                int paramIndex = 2;
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
                    java.sql.Date dataEntrada = resultSet.getDate("data_entrada");
                    java.sql.Date dataSaida = resultSet.getDate("data_saida");
                    String status = resultSet.getString("status");
        %>
        <div class="col-12 col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Local: <%= nomeLocal %></h5>
                    <p class="card-text">
                        Data de Entrada: <%= dataEntrada %><br>
                        Data de Saída: <%= dataSaida %><br>
                        Status: <%= status %>
                    </p>
                    <% if (status.equals("aprovacao pendente")) { %> 
                        <form action="cancelarAgendamento.jsp" method="post">
                            <input type="hidden" name="idAgendamento" value="<%= id %>">
                            <button class="btn btn-cancelar w-100">Cancelar</button>
                        </form>
                     <% } %>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
