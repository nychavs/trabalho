<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Histórico de Agendamentos</title>
    <!-- Link para Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .btn-cancelar {
            background-color: #dc3545;
            color: white;
            border: none;
        }
        .btn-cancelar:hover {
            background-color: #b02a37;
        }
    </style>
</head>
<body class="bg-light">

<div class="container my-5">
    <!-- Título -->
    <h1 class="mb-4 text-center">Histórico de Agendamentos</h1>

    <!-- Filtro -->
    <div class="row mb-4">
        <div class="col-md-6">
            <input type="text" class="form-control" placeholder="Pesquisar por nome do local">
        </div>
        <div class="col-md-3">
            <input type="date" class="form-control">
        </div>
        <div class="col-md-3">
            <input type="date" class="form-control">
        </div>
    </div>

    <!-- Lista de Agendamentos -->
    <div class="row g-3">
        <!-- Card de Agendamento 1 -->
        <div class="col-12 col-md-6 col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Local: Sala de Reunião</h5>
                    <p class="card-text">
                        Data: 2024-12-20<br>
                        Status: 
                    </p>
                    <!-- Botão Cancelar -->
                    <form action="cancelarAgendamento" method="post">
                        <input type="hidden" name="idAgendamento" value="1">
                        <button class="btn btn-cancelar w-100">Cancelar</button>
                    </form>
                </div>
            </div>
        </div>        
    </div>
</div>

<!-- Link para Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>