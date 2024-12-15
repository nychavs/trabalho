<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Local</title>
    <!-- Link para Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-reservar {
            background-color: #343a40;
            color: white;
        }
        .btn-reservar:hover {
            background-color: #1d2124;
        }
        .image-gallery img {
            width: 100%;
            height: auto;
            border-radius: 5px;
        }
    </style>
</head>
<body class="bg-light">

<%
    int idLocal = Integer.parseInt(request.getParameter("id"));
    String nome = "";
    String responsavel = "";
    String contato_responsavel = "";
    String descricao = "";
    String fotos = "";
    double avaliacao_geral = 0.0;
    int capacidade = 50; // Exemplo de capacidade, pode ser ajustado conforme necessário
    double preco = 500.00; // Exemplo de preço, pode ser ajustado conforme necessário

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos","root","");
        PreparedStatement statement = conexao.prepareStatement("SELECT * FROM locais WHERE id = ?");
        statement.setInt(1, idLocal);
        ResultSet result = statement.executeQuery();

        if (result.next()) {
            nome = result.getString("nome");
            responsavel = result.getString("responsavel");
            contato_responsavel = result.getString("contato_responsavel");
            descricao = result.getString("descricao");
            fotos = result.getString("fotos");
            avaliacao_geral = result.getDouble("avaliacao_geral");
        }
        result.close();
        statement.close();
        conexao.close();
    } catch (SQLException e) {
        out.println("Erro na conexão ao banco de dados. erro = " + e);
    }
%>

<div class="container my-5">
    <!-- Título -->
    <h1 class="mb-4">Detalhes do Local</h1>

    <!-- Layout Principal -->
    <div class="row">
        <!-- Galeria de Imagens -->
        <div class="col-lg-8">
            <div class="row g-3 image-gallery">
                <%
                    if (fotos != null && !fotos.isEmpty()) {
                        String[] fotoArray = fotos.split(",");
                        for (int i = 0; i < fotoArray.length; i++) {
                %>
                            <div class="<%= i == 0 ? "col-12" : "col-6" %>">
                                <img src="<%= fotoArray[i] %>" alt="Imagem <%= i+1 %> do Local">
                            </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <!-- Informações e Botão Reservar -->
        <div class="col-lg-4">
            <div class="bg-white p-3 rounded shadow">
                <h5 class="fw-bold"><%= nome %></h5>
                <p>Responsável: <%= responsavel %></p>
                <p>Contato: <%= contato_responsavel %></p>
                <p>Avaliação: <%= avaliacao_geral %></p>
                <p>Capacidade: <%= capacidade %> pessoas</p>
                <p>Preço: R$ <%= preco %></p>
                <p>Descrição:</p>
                <p class="text-muted">
                    <%= descricao %>
                </p>
                <form action="reservar.jsp" method="post">
                    <input type="hidden" name="idLocal" value="<%= idLocal %>">
                    <button type="submit" class="btn btn-reservar w-100">Reservar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Link para Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
