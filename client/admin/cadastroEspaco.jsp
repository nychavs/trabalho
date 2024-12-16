<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cadastro de Espaço</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
    int id = 0;
    String nomeForm = "Salão de Festas Luxo";
    String responsavelForm = "Naiury Chaves";
    String contatoForm = "naiury.silva@example.com";
    String descricaoForm = "Local bonito";
    String fotosForm = "file:///C:/Users/chave/Downloads/salao%201.jpg";
    String localizacaoForm = "Rua 4, jardim das Paineras - Hortolândia";

    if (request.getParameter("id") != null) {
        id = Integer.parseInt(request.getParameter("id"));
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos", "root", "");
            PreparedStatement statement = conexao.prepareStatement("SELECT * FROM locais WHERE id = ?");
            statement.setInt(1, id);
            ResultSet result = statement.executeQuery();

            if (result.next()) {
                nomeForm = result.getString("nome");
                responsavelForm = result.getString("responsavel");
                contatoForm = result.getString("contato_responsavel");
                descricaoForm = result.getString("descricao");
                fotosForm = result.getString("fotos");
                localizacaoForm = result.getString("localizacao");
            }
            result.close();
            statement.close();
            conexao.close();
        } catch (SQLException e) {
            out.println("Erro na conexão ao banco de dados. erro = " + e);
        } catch (ClassNotFoundException e) {
            out.println("Erro ao carregar o driver. erro = " + e);
        }
    }
%>

<div class="container my-5">
    <div class="bg-white p-5 rounded-lg shadow">
        <h2 class="mb-4">Cadastro de Espaço</h2>
        <form method="post" action="" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= id %>">
            
            <div class="mb-3">
                <label for="nome" class="form-label">Nome do Local</label>
                <input type="text" class="form-control" id="nome" name="nome" value="<%= nomeForm %>">
            </div>
            <div class="mb-3">
                <label for="responsavel" class="form-label">Responsável</label>
                <input type="text" class="form-control" id="responsavel" name="responsavel" value="<%= responsavelForm %>">
            </div>
            <div class="mb-3">
                <label for="contato" class="form-label">Contato do Responsável</label>
                <input type="text" class="form-control" id="contato" name="contato" value="<%= contatoForm %>">
            </div>
            <div class="mb-3">
                <label for="descricao" class="form-label">Descrição</label>
                <textarea class="form-control" id="descricao" name="descricao" rows="3"><%= descricaoForm %></textarea>
            </div>
            <div class="mb-3">
                <label for="fotos" class="form-label">Fotos (até 3 imagens)</label>
                <input type="file" class="form-control" id="fotos" name="fotos" accept="image/*" multiple>
            </div>
            <div class="mb-3">
                <label for="localizacao" class="form-label">Localização</label>
                <input type="text" class="form-control" id="localizacao" name="localizacao" value="<%= localizacaoForm %>">
            </div>
            <button type="submit" class="btn btn-primary w-100">Salvar</button>
        </form>
    </div>
</div>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String responsavel = request.getParameter("responsavel");
        String contato = request.getParameter("contato");
        String descricao = request.getParameter("descricao");
        String localizacao = request.getParameter("localizacao");
        double avaliacaoGeral = 0.0; 

        boolean hasError = false;
        if (nome == null || nome.isEmpty()) {
            out.println("Erro: Campo 'Nome' está vazio.<br>");
            hasError = true;
        }
        if (responsavel == null || responsavel.isEmpty()) {
            out.println("Erro: Campo 'Responsável' está vazio.<br>");
            hasError = true;
        }
        if (contato == null || contato.isEmpty()) {
            out.println("Erro: Campo 'Contato' está vazio.<br>");
            hasError = true;
        }
        if (descricao == null || descricao.isEmpty()) {
            out.println("Erro: Campo 'Descrição' está vazio.<br>");
            hasError = true;
        }
        if (localizacao == null || localizacao.isEmpty()) {
            out.println("Erro: Campo 'Localização' está vazio.<br>");
            hasError = true;
        }

        if (!hasError) {
            String fotoPaths = "";
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            for (Part part : request.getParts()) {
                if (part.getName().equals("fotos") && part.getSize() > 0) {
                    String fileName = new File(part.getSubmittedFileName()).getName();
                    part.write(uploadPath + File.separator + fileName);
                    fotoPaths += fileName + ",";
                }
            }
            if (!fotoPaths.isEmpty()) {
                fotoPaths = fotoPaths.substring(0, fotoPaths.length() - 1); 
            }

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos", "root", "");
                if (id == 0) {
                    PreparedStatement statement = conexao.prepareStatement("INSERT INTO locais (nome, responsavel, contato_responsavel, descricao, fotos, localizacao, avaliacao_geral) VALUES (?, ?, ?, ?, ?, ?, ?)");
                    statement.setString(1, nome);
                    statement.setString(2, responsavel);
                    statement.setString(3, contato);
                    statement.setString(4, descricao);
                    statement.setString(5, fotoPaths);
                    statement.setString(6, localizacao);
                    statement.setDouble(7, avaliacaoGeral);
                    statement.executeUpdate();
                    statement.close();
                } else {
                    PreparedStatement statement = conexao.prepareStatement("UPDATE locais SET nome = ?, responsavel = ?, contato_responsavel = ?, descricao = ?, fotos = ?, localizacao = ?, avaliacao_geral = ? WHERE id = ?");
                    statement.setString(1, nome);
                    statement.setString(2, responsavel);
                    statement.setString(3, contato);
                    statement.setString(4, descricao);
                    statement.setString(5, fotoPaths);
                    statement.setString(6, localizacao);
                    statement.setDouble(7, avaliacaoGeral);
                    statement.setInt(8, id);
                    statement.executeUpdate();
                    statement.close();
                }
                conexao.close();
                response.sendRedirect("listaEspacos.jsp");
            } catch (SQLException e) {
                out.println("Erro ao salvar o espaço. erro = " + e);
            } catch (ClassNotFoundException e) {
                out.println("Erro ao carregar o driver. erro = " + e);
            }
        }
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
