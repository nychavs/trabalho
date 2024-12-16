<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Listagem de Locais</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .btn-edit {
      position: absolute;
      top: 10px;
      right: 10px;
      font-size: 0.75rem;
      padding: 5px 8px;
    }
    .card-container {
      position: relative;
      height: 100%;
    }
  </style>
</head>
<body class="bg-light">

  <div class="container my-5">
    <div class="row mb-4">
      <div class="col-md-12">
        <h1 class="fw-bold">Lista de Locais</h1>
      </div>
      <div class="col-12 col-md-6 col-lg-3">
        <input type="text" class="form-control mb-3" placeholder="Pesquisar...">
      </div>
      <div class="col-6 col-md-3 col-lg-2">
        <input type="date" class="form-control mb-3">
      </div>
      <div class="col-6 col-md-3 col-lg-2">
        <input type="date" class="form-control mb-3">
      </div>
      <div class="col-12 col-lg-2">
        <button class="btn btn-primary w-100">Filtrar</button>
      </div>
    </div>

    <div class="row g-4">
      <%
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
          PreparedStatement statement = conexao.prepareStatement("SELECT * FROM locais");
          ResultSet listar = statement.executeQuery();
          while (listar.next()) {
      %>
        <!-- Card de Local -->
        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
          <div class="card shadow-sm card-container">
            <a href="cadastroEspaco.jsp?id=<%= listar.getInt("id") %>" class="btn btn-primary btn-edit">Editar</a>
            <div class="card-body">
              <h5 class="card-title"><%= listar.getString("nome") %></h5>
              <p class="card-text text-muted">
                Responsável: <%= listar.getString("responsavel") %> <br>
                Avaliação: <%= listar.getDouble("avaliacao_geral") %> <br>
                Localização: <%= listar.getString("localizacao") %>
              </p>
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

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
