<%@ page import="java.sql.*" %>
<%
  String nome = request.getParameter("nome");
  String responsavel = request.getParameter("responsavel");
  String contatoResponsavel = request.getParameter("contato_responsavel");
  String avaliacaoGeral = request.getParameter("avaliacao_geral"); // Avaliação inicial pode ser NULL ou 0
  String descricao = request.getParameter("descricao");
  String fotos = request.getParameter("fotos");
  String localizacao = request.getParameter("localizacao");

  try {
    // Definição do driver JDBC para conexão com o banco.
    Class.forName("com.mysql.jdbc.Driver");
    // Criação da variável de conexão com os dados do servidor.
    Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/seu_banco", "root", ""); // conectando com o banco
    // Comando SQL para inserir um novo registro na tabela 'locais'.
    PreparedStatement inserir = conexao.prepareStatement("INSERT INTO locais (nome, responsavel, contato_responsavel, avaliacao_geral, descricao, fotos, localizacao) VALUES (?, ?, ?, ?, ?, ?, ?)");
    inserir.setString(1, nome); 
    inserir.setString(2, responsavel); 
    inserir.setString(3, contatoResponsavel);
    inserir.setString(4, avaliacaoGeral); 
    inserir.setString(5, descricao); 
    inserir.setString(6, fotos); 
    inserir.setString(7, localizacao); 

    inserir.execute(); // execução do SQL (insert)
    out.println("Espaço adicionado com sucesso!");
    inserir.close();
  } catch (ClassNotFoundException erroClass) {
    out.println("Class Driver não foi localizado, erro = " + erroClass);
  } catch (SQLException e) {
    out.println("Erro na conexão ao banco de dados. erro = " + e);
  }
%>
<html>
  <body>
    <input type='button' value='Voltar' onclick="parent.location.href='menu.jsp'">
  </body>
</html>
