<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script type="module">
    import { setup } from 'https://cdn.skypack.dev/twind/shim';
    setup({});
  </script>
  <title>Formulário de Reserva</title>
</head>
<body class="bg-gray-200 flex justify-center items-center min-h-screen">

  <div class="bg-gray-300 p-8 rounded-lg shadow-lg w-96">
    <!-- Nome do Lugar -->
    <label for="nomeLugar" class="block text-sm font-semibold text-gray-700 mb-2">Nome do Lugar</label>
    <input
      type="text"
      id="nomeLugar"
      name="nomeLugar"
      class="w-full p-2 border border-gray-400 rounded focus:outline-none focus:ring focus:ring-blue-300 mb-4"
    />

    <!-- Descrição do Lugar -->
    <label for="descricaoLugar" class="block text-sm font-semibold text-gray-700 mb-2">Descrição do Lugar</label>
    <textarea
      id="descricaoLugar"
      name="descricaoLugar"
      rows="4"
      class="w-full p-2 border border-gray-400 rounded focus:outline-none focus:ring focus:ring-blue-300 mb-4"
    ></textarea>

    <!-- Datas de Reserva -->
    <div class="flex gap-4 mb-4">
      <div>
        <label for="dataInicial" class="block text-sm font-semibold text-gray-700 mb-2">Data Inicial</label>
        <input
          type="date"
          id="dataInicial"
          name="dataInicial"
          class="w-full p-2 border border-gray-400 rounded focus:outline-none focus:ring focus:ring-blue-300"
        />
      </div>
      <div>
        <label for="dataFinal" class="block text-sm font-semibold text-gray-700 mb-2">Data Final</label>
        <input
          type="date"
          id="dataFinal"
          name="dataFinal"
          class="w-full p-2 border border-gray-400 rounded focus:outline-none focus:ring focus:ring-blue-300"
        />
      </div>
    </div>

    <!-- Botão de Cadastro -->
    <button
      type="button"
      class="bg-blue-500 text-white w-full p-2 rounded font-semibold hover:bg-blue-600 focus:outline-none focus:ring focus:ring-blue-300"
    >
      Cadastrar
    </button>
  </div>

</body>
</html>
