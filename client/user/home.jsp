<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seleção de Salas</title>
    <!-- Link para Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-container {
            height: 100%;
        }
        .card-title {
            font-size: 1rem;
            font-weight: bold;
        }
        .card-text {
            font-size: 0.875rem;
        }
    </style>
</head>
<body class="bg-light">

<div class="container my-5">
    <!-- Título -->
    <h1 class="text-center mb-4">Seleção de Salas e Auditórios</h1>

    <!-- Barra de Filtro -->
    <div class="row mb-4">
        <div class="col-md-6">
            <form method="get" action="home.jsp">
                <input type="text" name="filtroNome" class="form-control" placeholder="Pesquisar por nome do local" value="<%= request.getParameter("filtroNome") != null ? request.getParameter("filtroNome") : "" %>">
                <div class="row mt-2">
                    <div class="col-md-6">
                        <input type="date" name="dataInicio" class="form-control" value="<%= request.getParameter("dataInicio") != null ? request.getParameter("dataInicio") : "" %>">
                    </div>
                    <div class="col-md-6">
                        <input type="date" name="dataFim" class="form-control" value="<%= request.getParameter("dataFim") != null ? request.getParameter("dataFim") : "" %>">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-2">Filtrar</button>
            </form>
        </div>
    </div>

    <!-- Grid de Salas e Auditórios -->
    <div class="row g-4">
        <%
          try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");

            String filtroNome = request.getParameter("filtroNome");
            String dataInicio = request.getParameter("dataInicio");
            String dataFim = request.getParameter("dataFim");
            
            String sql = "SELECT * FROM locais";
            boolean hasFilter = false;
            
            if ((filtroNome != null && !filtroNome.isEmpty()) || 
                (dataInicio != null && !dataInicio.isEmpty()) || 
                (dataFim != null && !dataFim.isEmpty())) {
                sql += " WHERE";
                if (filtroNome != null && !filtroNome.isEmpty()) {
                    sql += " nome LIKE ?";
                    hasFilter = true;
                }
                if (dataInicio != null && !dataInicio.isEmpty()) {
                    sql += (hasFilter ? " AND" : "") + " id IN (SELECT espaco_id FROM agendamentos WHERE data >= ?)";
                    hasFilter = true;
                }
                if (dataFim != null && !dataFim.isEmpty()) {
                    sql += (hasFilter ? " AND" : "") + " id IN (SELECT espaco_id FROM agendamentos WHERE data <= ?)";
                    hasFilter = true;
                }
            }

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

            ResultSet listar = statement.executeQuery();
            while (listar.next()) {
        %>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="card card-container shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title"><%= listar.getString("nome") %></h5>
                            <p class="card-text">
                                Responsável: <%= listar.getString("responsavel") %><br>
                                Contato: <%= listar.getString("contato_responsavel") %><br>
                                Avaliação: <%= listar.getDouble("avaliacao_geral") %>
                            </p>
                            <a href="detail.jsp?id=<%= listar.getInt("id") %>" class="btn btn-primary w-100">Selecionar</a>
                        </div>
                    </div>
                </div>
        <%
            }
            listar.close();
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
</body>
</html>
