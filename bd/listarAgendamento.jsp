<%@ page import="java.sql.*" %>

<%
  // Definindo o driver JDBC para conexão com o banco
  Class.forName("com.mysql.jdbc.Driver");
  // Criação da variável de conexão com os dados do servidor
  Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/seu_banco", "root", ""); // conectando com o banco
  // Comando SQL para selecionar todos os registros da tabela 'agendamentos'
  PreparedStatement statement = conexao.prepareStatement("SELECT * FROM agendamentos");
  ResultSet listar = statement.executeQuery();
  int reg = 1;
  while (listar.next()) {
    out.println("<b>Registro: " + reg + "</b><br>");
    out.println("Espaço ID: " + listar.getInt("espaco_id") + "<br>");
    out.println("Data: " + listar.getDate("data") + "<br>");
    out.println("Hora: " + listar.getTime("hora") + "<br>");
    out.println("Status: " + listar.getString("status") + "<br>");
    out.println("Avaliação: " + (listar.getInt("avaliacao") == 0 ? "N/A" : listar.getInt("avaliacao")) + "<p>");
    reg++;
  }
%>
<html>
<body>
  <input type='button' value='Voltar' onclick="parent.location.href='menu.jsp'">
</body>
</html>
