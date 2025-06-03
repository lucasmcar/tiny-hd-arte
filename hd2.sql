-- Banco de dados
CREATE DATABASE IF NOT EXISTS hdarte_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hdarte_db;

-- Tabela para usuários (administradores)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    foto VARCHAR(255) DEFAULT '/assets/imgs/default.jpg',
    funcao ENUM('admin', 'editor') DEFAULT 'admin',
    ultimo_login TIMESTAMP NULL,
    INDEX idx_usuario (usuario),
    INDEX idx_email (email)
);

-- Tabela para posts
CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    texto TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('rascunho', 'publicado', 'arquivado') DEFAULT 'rascunho',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_slug (slug),
    INDEX idx_data_criacao (data_criacao)
);

-- Tabela para projetos/eventos
CREATE TABLE projetos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    descricao TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('em_andamento', 'aprovado', 'reprovado', 'finalizado') DEFAULT 'em_andamento',
    link_depoimento VARCHAR(255) UNIQUE DEFAULT NULL,
    link_expiracao TIMESTAMP NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_data_criacao (data_criacao),
    INDEX idx_link_expiracao (link_expiracao)
);

-- Tabela para depoimentos
CREATE TABLE depoimentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    projeto_id INT,
    usuario_id INT,
    titulo VARCHAR(255) NOT NULL,
    foto VARCHAR(255) DEFAULT NULL,
    depoimento TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('em_analise', 'aprovado', 'reprovado') DEFAULT 'em_analise',
    FOREIGN KEY (projeto_id) REFERENCES projetos(id) ON DELETE SET NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_data_criacao (data_criacao)
);

-- Tabela para parceiros
CREATE TABLE parceiros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tipo ENUM('empresa', 'pessoa') NOT NULL,
    descricao TEXT DEFAULT NULL,
    telefone VARCHAR(20) DEFAULT NULL,
    redes_sociais JSON DEFAULT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nome (nome)
);

-- Tabela para serviços
CREATE TABLE servicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_nome (nome)
);

-- Tabela para configuração do site
CREATE TABLE configuracao_site (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chave VARCHAR(100) UNIQUE NOT NULL,
    valor TEXT NOT NULL,
    descricao VARCHAR(255) DEFAULT NULL,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela para e-mails da empresa
CREATE TABLE empresa_emails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    descricao VARCHAR(255) DEFAULT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- Tabela para logs de atividades (já existente, mantida como está)
CREATE TABLE logs_atividades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    acao VARCHAR(100) NOT NULL,
    tabela_afetada VARCHAR(50) NOT NULL,
    id_registro INT NOT NULL,
    detalhes JSON DEFAULT NULL,
    data_acao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_usuario_id (usuario_id),
    INDEX idx_data_acao (data_acao)
);

-- Tabela para editais (nova)
CREATE TABLE editais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    name VARCHAR(255) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    status ENUM('Em Análise', 'Aprovado', 'Reprovado') DEFAULT 'Em Análise',
    data_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_data_upload (data_upload)
);

-- Triggers para regras e logs
DELIMITER //

-- Trigger para depoimento em análise
CREATE TRIGGER depoimento_em_analise 
BEFORE INSERT ON depoimentos 
FOR EACH ROW 
BEGIN
    IF NEW.usuario_id IS NULL THEN
        SET NEW.status = 'em_analise';
    END IF;
END;//

-- Trigger para log de criação de depoimento
CREATE TRIGGER log_criacao_depoimento 
AFTER INSERT ON depoimentos 
FOR EACH ROW 
BEGIN
    INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
    VALUES (NEW.usuario_id, 'criacao_depoimento', 'depoimentos', NEW.id, JSON_OBJECT('titulo', NEW.titulo, 'projeto_id', NEW.projeto_id));
END;//

-- Trigger para gerar link de depoimento quando projeto é finalizado
CREATE TRIGGER gerar_link_projeto_finalizado 
BEFORE UPDATE ON projetos 
FOR EACH ROW 
BEGIN
    IF NEW.status = 'finalizado' AND OLD.status != 'finalizado' THEN
        SET NEW.link_depoimento = CONCAT('dep-', UUID());
        SET NEW.link_expiracao = DATE_ADD(NOW(), INTERVAL (SELECT CAST(valor AS UNSIGNED) FROM configuracao_site WHERE chave = 'link_expiracao_dias') DAY);
    END IF;
END;//

-- Trigger para log de finalização de projeto
CREATE TRIGGER log_finalizacao_projeto 
AFTER UPDATE ON projetos 
FOR EACH ROW 
BEGIN
    IF NEW.status = 'finalizado' AND OLD.status != 'finalizado' THEN
        INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
        VALUES (NEW.usuario_id, 'finalizacao_projeto', 'projetos', NEW.id, JSON_OBJECT('titulo', NEW.titulo, 'link_depoimento', NEW.link_depoimento));
    END IF;
END;//

-- Trigger para invalidar link de depoimento antes de atualização
CREATE TRIGGER invalidar_link_depoimento 
BEFORE UPDATE ON projetos 
FOR EACH ROW 
BEGIN
    IF NEW.link_expiracao IS NOT NULL AND NEW.link_expiracao < NOW() THEN
        SET NEW.link_depoimento = NULL;
        SET NEW.link_expiracao = NULL;
    END IF;
END;//

-- Trigger para log de expiração de link
CREATE TRIGGER log_expiracao_link 
AFTER UPDATE ON projetos 
FOR EACH ROW 
BEGIN
    IF OLD.link_expiracao IS NOT NULL AND NEW.link_expiracao IS NULL AND OLD.link_depoimento IS NOT NULL AND NEW.link_depoimento IS NULL THEN
        INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
        VALUES (NULL, 'expiracao_link_depoimento', 'projetos', NEW.id, JSON_OBJECT('titulo', NEW.titulo));
    END IF;
END;//

-- Trigger para log de criação de post
CREATE TRIGGER log_criacao_post 
AFTER INSERT ON posts 
FOR EACH ROW 
BEGIN
    INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
    VALUES (NEW.usuario_id, 'criacao_post', 'posts', NEW.id, JSON_OBJECT('titulo', NEW.titulo));
END;//

-- Trigger para log de aprovação/reprovação de depoimento
CREATE TRIGGER log_status_depoimento 
AFTER UPDATE ON depoimentos 
FOR EACH ROW 
BEGIN
    IF NEW.status != OLD.status THEN
        INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
        VALUES (NEW.usuario_id, CONCAT('alteracao_status_depoimento_', NEW.status), 'depoimentos', NEW.id, JSON_OBJECT('titulo', NEW.titulo, 'status_antigo', OLD.status));
    END IF;
END;//

-- Trigger para log de upload de edital
CREATE TRIGGER log_upload_edital 
AFTER INSERT ON editais 
FOR EACH ROW 
BEGIN
    INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
    VALUES (NEW.usuario_id, 'upload_edital', 'editais', NEW.id, JSON_OBJECT('name', NEW.name, 'filename', NEW.filename));
END;//

-- Trigger para log de alteração de status de edital
CREATE TRIGGER log_status_edital 
AFTER UPDATE ON editais 
FOR EACH ROW 
BEGIN
    IF NEW.status != OLD.status THEN
        INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
        VALUES (NEW.usuario_id, CONCAT('alteracao_status_edital_', NEW.status), 'editais', NEW.id, JSON_OBJECT('name', NEW.name, 'status_antigo', OLD.status));
    END IF;
END;//

DELIMITER ;

-- Evento para invalidar links expirados periodicamente
DELIMITER //
CREATE EVENT invalidar_links_expirados 
ON SCHEDULE EVERY 1 DAY 
DO 
BEGIN
    UPDATE projetos 
    SET link_depoimento = NULL, link_expiracao = NULL
    WHERE link_expiracao IS NOT NULL AND link_expiracao < NOW();

    INSERT INTO logs_atividades (usuario_id, acao, tabela_afetada, id_registro, detalhes)
    SELECT NULL, 'expiracao_link_depoimento', 'projetos', id, JSON_OBJECT('titulo', titulo)
    FROM projetos 
    WHERE link_expiracao IS NULL AND link_depoimento IS NULL AND data_atualizacao >= DATE_SUB(NOW(), INTERVAL 1 DAY);
END;//

-- Evento para limpar logs antigos
CREATE EVENT limpar_logs_antigos 
ON SCHEDULE EVERY 1 MONTH 
DO 
BEGIN
    DELETE FROM logs_atividades WHERE data_acao < DATE_SUB(NOW(), INTERVAL 6 MONTH);
END;//

DELIMITER ;