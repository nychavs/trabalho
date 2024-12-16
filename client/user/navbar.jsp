<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<nav class="navbar">
    <div class="navbar-container">
        <ul class="navbar-menu">
            <li><a href="home.jsp" class="navbar-link">Home</a></li>
            <li><a href="historico.jsp" class="navbar-link">Histórico</a></li>
            
            <% 
                String role = (String) session.getAttribute("role");
                if (role != null && role.equals("admin")) {
            %>
                <li><a href="espacos.jsp" class="navbar-link">Espaços</a></li>
                <li><a href="agendamentos.jsp" class="navbar-link">Agendamentos</a></li>
            <% } %>
        </ul>
    </div>
</nav>

<style>
    body, h1, h2, h3, h4, h5, h6, p, ul, li, a {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }

    .navbar {
        background-color: #333;
        padding: 10px 20px;
        color: white;
        position: fixed;
        width: 100%;
        top: 0;
        left: 0;
        z-index: 1000;
    }

    .navbar-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
    }

    .navbar-menu {
        list-style-type: none;
        display: flex;
    }

    .navbar-menu li {
        margin: 0 15px;
    }

    .navbar-link {
        color: white;
        text-decoration: none;
        font-size: 16px;
        transition: color 0.3s;
    }

    .navbar-link:hover {
        color: #f39c12;
    }

    .navbar-auth {
        display: flex;
    }

    .login-button, .logout-button {
        background-color: #f39c12;
        padding: 8px 16px;
        border: none;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 16px;
        margin-left: 10px;
    }

    @media (max-width: 768px) {
        .navbar-container {
            flex-direction: column;
            align-items: flex-start;
        }

        .navbar-menu {
            flex-direction: column;
            align-items: flex-start;
            margin-top: 10px;
        }

        .navbar-menu li {
            margin-bottom: 10px;
        }

        .navbar-auth {
            margin-top: 10px;
        }
    }
</style>
