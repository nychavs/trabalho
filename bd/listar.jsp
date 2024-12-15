<%@ page import="java.sql.*" %>

<%
  // Definindo o driver JDBC para conexão com o banco
  Class.forName("com.mysql.jdbc.Driver");
  // Criação da variável de conexão com os dados do servidor
  Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/seu_banco", "root", ""); // conectando com o banco
  // Comando SQL para selecionar todos os registros da tabela 'locais'
  PreparedStatement statement = conexao.prepareStatement("SELECT * FROM locais");
  ResultSet listar = statement.executeQuery();
  int reg = 1;
  while (listar.next()) {
    out.println("<b>Registro: " + reg + "</b><br>");
    out.println("Nome: " + listar.getString("nome") + "<br>");
    out.println("Responsável: " + listar.getString("responsavel") + "<br>");
    out.println("Contato do Responsável: " + listar.getString("contato_responsavel") + "<br>");
    out.println("Avaliação Geral: " + listar.getString("avaliacao_geral") + "<br>");
    out.println("Descrição: " + listar.getString("descricao") + "<br>");
    out.println("Fotos: " + listar.getString("fotos") + "<br>");
    out.println("Localização: " + listar.getString("localizacao") + "<p>");
    reg++;
  }
%>
<html>
<body>
  <input type='button' value='Voltar' onclick="parent.location.href='menu.jsp'">
</body>
</html>
