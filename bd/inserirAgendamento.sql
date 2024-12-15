<%@ page import="java.sql.*" %>
<%
  String espacoId = request.getParameter("espaco_id");
  String data = request.getParameter("data");
  String hora = request.getParameter("hora");
  String status = request.getParameter("status");
  String avaliacao = request.getParameter("avaliacao");

  try {
    // Definição do driver JDBC para conexão com o banco.
    Class.forName("com.mysql.jdbc.Driver");
    // Criação da variável de conexão com os dados do servidor.
    Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/seu_banco", "root", ""); // conectando com o banco
    // Comando SQL para inserir um novo registro na tabela 'agendamentos'.
    PreparedStatement inserir = conexao.prepareStatement("INSERT INTO agendamentos (espaco_id, data, hora, status, avaliacao) VALUES (?, ?, ?, ?, ?)");
    inserir.setString(1, espacoId); // variável associada ao primeiro ?
    inserir.setString(2, data); // variável associada ao segundo ?
    inserir.setString(3, hora); // variável associada ao terceiro ?
    inserir.setString(4, status); // variável associada ao quarto ?
    inserir.setString(5, avaliacao); // variável associada ao quinto ? (pode ser NULL)

    inserir.execute(); // execução do SQL (insert)
    out.println("Agendamento adicionado com sucesso!");
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
