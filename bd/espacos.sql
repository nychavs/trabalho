-- Estrutura da tabela `locais`
CREATE TABLE locais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    responsavel VARCHAR(255) NOT NULL,
    contato_responsavel VARCHAR(255) NOT NULL,
    avaliacao_geral DECIMAL(3,2), -- Média das avaliações
    descricao TEXT,
    fotos TEXT, -- URLs ou caminhos das fotos
    localizacao VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Estrutura da tabela `agendamentos`
CREATE TABLE agendamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    espaco_id INT NOT NULL,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    status ENUM('aprovacao pendente', 'aprovado', 'avaliacao pendente', 'concluido') NOT NULL,
    avaliacao INT CHECK (avaliacao BETWEEN 0 AND 10),
    FOREIGN KEY (espaco_id) REFERENCES locais(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Extraindo dados da tabela `locais`
INSERT INTO locais (nome, responsavel, contato_responsavel, avaliacao_geral, descricao, fotos, localizacao) VALUES
('Salão de Festas Central', 'Maria Silva', 'maria.silva@example.com', 8.5, 'Espaço amplo para eventos sociais e corporativos.', 'foto1.jpg,foto2.jpg', 'Rua das Flores, 123, Centro'),
('Sala de Reuniões VIP', 'João Pereira', 'joao.pereira@example.com', 9.0, 'Espaço elegante para reuniões de negócios e conferências.', 'foto3.jpg,foto4.jpg', 'Avenida dos Empresários, 456, Zona Sul');

-- Extraindo dados da tabela `agendamentos`
INSERT INTO agendamentos (espaco_id, data, hora, status, avaliacao) VALUES
(1, '2024-12-20', '18:00:00', 'aprovacao pendente', NULL),
(1, '2024-12-22', '15:00:00', 'aprovado', 9),
(2, '2025-01-05', '10:00:00', 'concluido', 8);
