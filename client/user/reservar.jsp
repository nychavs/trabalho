<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    int clienteId = (Integer) session.getAttribute("user_id");
    int idLocal = Integer.parseInt(request.getParameter("idLocal"));
    java.sql.Date dataEntrada = java.sql.Date.valueOf(request.getParameter("data_entrada"));
    java.sql.Date dataSaida = java.sql.Date.valueOf(request.getParameter("data_saida"));
    
    String status = "aprovacao pendente";

    Calendar calendar = new GregorianCalendar();
    java.sql.Date dataAtual = new java.sql.Date(calendar.getTimeInMillis()); 
    java.sql.Time horaAtual = new java.sql.Time(calendar.getTimeInMillis()); 

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conexao = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/espacos", "root", "");
        PreparedStatement statement = conexao.prepareStatement("INSERT INTO agendamentos (espaco_id, cliente_id, data_entrada, data_saida, hora, status, data) VALUES (?, ?, ?, ?, ?, ?, ?)");
        statement.setInt(1, idLocal);
        statement.setInt(2, clienteId);
        statement.setDate(3, dataEntrada);
        statement.setDate(4, dataSaida);
        statement.setTime(5, horaAtual);  
        statement.setString(6, status);
        statement.setDate(7, dataAtual);  

        statement.executeUpdate();
        statement.close();
        conexao.close();

        response.sendRedirect("confirmacao.jsp");
    } catch (SQLException e) {
        out.println("Erro ao realizar a reserva. erro = " + e);
    }
%>
