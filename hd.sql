-- Banco de dados
CREATE DATABASE hd_arte;
USE hd_arte;

-- Tabela de Usuários (para controle de acesso e logs)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('administrador', 'consultor', 'financeiro', 'editor_site') NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- Tabela de Clientes (Módulo de Assessoria e Consultoria)
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo ENUM('iniciativa_privada', 'poder_publico', 'pessoa_fisica') NOT NULL,
    contato VARCHAR(255),
    objetivos_culturais TEXT,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Demandas (Assessoria/Consultoria)
CREATE TABLE demandas (
    id_demanda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_demanda ENUM('fortalecimento_marca', 'agregacao_valor', 'melhoria_imagem') NOT NULL,
    descricao TEXT NOT NULL,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

-- Tabela de Documentos (Upload de arquivos)
CREATE TABLE documentos (
    id_documento INT AUTO_INCREMENT PRIMARY KEY,
    id_demanda INT,
    id_projeto INT,
    id_evento INT,
    id_transacao INT,
    nome_arquivo VARCHAR(255) NOT NULL,
    caminho_arquivo VARCHAR(255) NOT NULL,
    tipo ENUM('briefing', 'contrato', 'relatorio', 'comprovante', 'outro') NOT NULL,
    data_upload DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_demanda) REFERENCES demandas(id_demanda) ON DELETE SET NULL,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto) ON DELETE SET NULL,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE SET NULL,
    FOREIGN KEY (id_transacao) REFERENCES transacoes_financeiras(id_transacao) ON DELETE SET NULL
);

-- Tabela de Relatórios (Recomendações estratégicas)
CREATE TABLE relatorios (
    id_relatorio INT AUTO_INCREMENT PRIMARY KEY,
    id_demanda INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    conteudo TEXT NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_demanda) REFERENCES demandas(id_demanda) ON DELETE CASCADE
);

-- Tabela de Projetos Culturais
CREATE TABLE projetos (
    id_projeto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    objetivos TEXT NOT NULL,
    publico_alvo VARCHAR(255),
    orcamento_estimado DECIMAL(10, 2),
    status ENUM('em_elaboracao', 'submetido', 'aprovado', 'em_execucao', 'concluido') NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Planejamento Estratégico
CREATE TABLE planejamento_estrategico (
    id_planejamento INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    etapa VARCHAR(100) NOT NULL,
    responsavel VARCHAR(100),
    prazo DATE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto) ON DELETE CASCADE
);

-- Tabela de Templates de Projetos (Leis de incentivo, editais, etc.)
CREATE TABLE templates_projetos (
    id_template INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    justificativa TEXT,
    metas TEXT,
    plano_recursos TEXT,
    tipo ENUM('lei_incentivo', 'fundo', 'edital', 'outro') NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Avaliação de Resultados
CREATE TABLE avaliacao_resultados (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    alcance INT,
    impacto_cultural TEXT,
    retorno_financeiro DECIMAL(10, 2),
    dados_quantitativos TEXT,
    dados_qualitativos TEXT,
    data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto) ON DELETE CASCADE
);

-- Tabela de Eventos
CREATE TABLE eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    local VARCHAR(255),
    descricao TEXT,
    orcamento DECIMAL(10, 2),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Artistas Envolvidos em Eventos
CREATE TABLE eventos_artistas (
    id_evento_artista INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    id_artista INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE CASCADE,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista) ON DELETE CASCADE
);

-- Tabela de Tarefas (Produção de eventos)
CREATE TABLE tarefas (
    id_tarefa INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    tipo ENUM('fornecedores', 'logistica', 'divulgacao', 'outro') NOT NULL,
    status ENUM('pendente', 'em_andamento', 'concluida') NOT NULL,
    data_prazo DATE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE CASCADE
);

-- Tabela de Checklist
CREATE TABLE checklist (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    concluido BOOLEAN DEFAULT FALSE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE CASCADE
);

-- Tabela de Artistas
CREATE TABLE artistas (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    genero_artistico VARCHAR(100),
    portfolio TEXT,
    cache DECIMAL(10, 2),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Contratos de Agenciamento
CREATE TABLE contratos (
    id_contrato INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    duracao_meses INT,
    clausulas TEXT,
    assinatura_digital VARCHAR(255),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista) ON DELETE CASCADE
);

-- Tabela de Agenda
CREATE TABLE agenda (
    id_agenda INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT NOT NULL,
    id_evento INT NOT NULL,
    data DATE NOT NULL,
    hora TIME,
    status ENUM('confirmado', 'pendente', 'cancelado') NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE CASCADE
);

-- Tabela de Histórico de Apresentações
CREATE TABLE historico_apresentacoes (
    id_apresentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT NOT NULL,
    id_evento INT NOT NULL,
    publico INT,
    feedback TEXT,
    data_apresentacao DATETIME,
    FOREIGN KEY (id_artista) REFERENCES artistas(id_artista) ON DELETE CASCADE,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE CASCADE
);

-- Tabela de Transações Financeiras
CREATE TABLE transacoes_financeiras (
    id_transacao INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT,
    id_evento INT,
    tipo ENUM('receita', 'despesa') NOT NULL,
    categoria ENUM('consultoria', 'eventos', 'agenciamento', 'outro') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    descricao VARCHAR(255),
    data_transacao DATE NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto) ON DELETE SET NULL,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE SET NULL
);

-- Tabela de Incentivos Fiscais
CREATE TABLE incentivos_fiscais (
    id_incentivo INT AUTO_INCREMENT PRIMARY KEY,
    id_projeto INT NOT NULL,
    origem VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    aplicacao TEXT,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto) ON DELETE CASCADE
);

-- Tabela de Configurações do Site
CREATE TABLE configuracoes_site (
    id_configuracao INT AUTO_INCREMENT PRIMARY KEY,
    imagens_destaque JSON, -- Armazena lista de URLs ou IDs de imagens
    limite_depoimentos INT DEFAULT 5,
    parceiros JSON, -- Armazena lista de parceiros (nome, logo, link)
    eventos_ativos BOOLEAN DEFAULT TRUE,
    depoimentos_ativos BOOLEAN DEFAULT TRUE,
    data_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Depoimentos
CREATE TABLE depoimentos (
    id_depoimento INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT, 
    autor VARCHAR(100) NOT NULL,
    profissao VARCHAR(100),
    texto TEXT NOT NULL,
    data DATE NOT NULL,
    foto VARCHAR(255),
    video VARCHAR(255),
    status ENUM('aprovado', 'pendente', 'rejeitado') NOT NULL,
    link VARCHAR(255),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento) ON DELETE SET NULL
);

-- Tabela de Artigos
CREATE TABLE artigos (
    id_artigo INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    conteudo TEXT NOT NULL,
    categoria ENUM('cultura', 'eventos', 'consultoria', 'outro') NOT NULL,
    tags JSON,
    imagens JSON,
    pdf VARCHAR(255),
    status ENUM('rascunho', 'publicado', 'agendado') NOT NULL,
    data_publicacao DATETIME,
    visualizacoes INT DEFAULT 0,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_autor) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabela de Logs
CREATE TABLE logs (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    acao VARCHAR(255) NOT NULL,
    tipo_acao ENUM('login', 'criacao', 'edicao', 'exclusao', 'outro') NOT NULL,
    data_acao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    INDEX idx_data_acao (data_acao)
);

-- Trigger para registrar ações de exclusão (exemplo)
DELIMITER //
CREATE TRIGGER log_exclusao_projeto
BEFORE DELETE ON projetos
FOR EACH ROW
BEGIN
    INSERT INTO logs (id_usuario, acao, tipo_acao, data_acao)
    VALUES (1, CONCAT('Projeto excluído: ', OLD.nome), 'exclusao', NOW());
END //
DELIMITER ;

-- Índices adicionais para desempenho
CREATE INDEX idx_projeto_status ON projetos(status);
CREATE INDEX idx_evento_data ON eventos(data);
CREATE INDEX idx_transacao_data ON transacoes_financeiras(data_transacao);