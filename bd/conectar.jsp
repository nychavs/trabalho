<%@ page import="java.sql.*" %>
<%
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conexao = DriverManager.getConnection("jdbc:mysql://localhost/espacos", "root", "");
  } catch (ClassNotFoundException erroClass) {
    out.println("Class Driver não foi localizado, erro = " + erroClass);
  } catch (SQLException e) {
    out.println("Erro na conexão ao banco de dados. erro = " + e);
  }
%>
