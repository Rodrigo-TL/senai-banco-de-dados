-- SELECIONA O BANCO DE DADOS DO RPG
USE JogoRpgDB;
GO

-- =========================================================================
-- ETAPA 1: INSERÇÃO DE DADOS (INSERT)
-- Inserindo registros respeitando a hierarquia das chaves estrangeiras
-- =========================================================================

-- 1. Inserindo Usuários
INSERT INTO USUARIOS (Email, Senha) 
VALUES 
('rodrigo.player@email.com', 'senha123'),
('marcos.rpg@email.com', 'crypto456'),
('aline.games@email.com', 'rpgmaster789');
GO

-- 2. Inserindo Classes
INSERT INTO CLASSES (Nome, Descricao) 
VALUES 
('Guerreiro', 'Especialista em combate corpo a corpo com alta defesa.'),
('Mago', 'Manipulador de artes arcanas com alto dano mágico.'),
('Arqueiro', 'Atirador de elite ágil focado em ataques de longa distância.');
GO

-- 3. Inserindo Habilidades
INSERT INTO HABILIDADES (Nome) 
VALUES 
('Ataque Furioso'),
('Bola de Fogo'),
('Tiro Certeiro'),
('Escudo Divino');
GO

-- 4. Inserindo Personagens (Relacionando com UsuarioId e ClasseId)
-- Rodrigo (Id 1) cria o personagem 'Aragorn' que é Guerreiro (Id 1)
-- Marcos (Id 2) cria o personagem 'Gandalf' que é Mago (Id 2)
-- Aline (Id 3) cria o personagem 'Legolas' que é Arqueiro (Id 3)
INSERT INTO PERSONAGENS (NomePersonagem, UsuarioId, ClasseId) 
VALUES 
('Aragorn', 1, 1),
('Gandalf', 2, 2),
('Legolas', 3, 3);
GO

-- 5. Associando Habilidades às Classes (Tabela N:N - CLASSES_HABILIDADES)
INSERT INTO CLASSES_HABILIDADES (ClasseId, HabilidadeId) 
VALUES 
(1, 1), -- Guerreiro tem Ataque Furioso
(1, 4), -- Guerreiro tem Escudo Divino
(2, 2), -- Mago tem Bola de Fogo
(3, 3); -- Arqueiro tem Tiro Certeiro
GO

-- =========================================================================
-- ETAPA 2: CONSULTA DE DADOS (SELECT)
-- Demonstração de busca e filtragem no banco de dados
-- =========================================================================

-- Consultar todos os personagens cadastrados
SELECT * FROM PERSONAGENS;

-- Consultar a classe onde o Id é igual a 2 (Mago)
SELECT Nome, Descricao FROM CLASSES WHERE ClasseId = 2;
GO

-- =========================================================================
-- ETAPA 3: ATUALIZAÇÃO DE DADOS (UPDATE)
-- Atualizando um registro utilizando a cláusula WHERE para segurança
-- =========================================================================

-- Modificando o nome do personagem 'Aragorn' para 'Aragorn Rei' (Id 1)
UPDATE PERSONAGENS 
SET NomePersonagem = 'Aragorn Rei' 
WHERE PersonagemId = 1;
GO

-- =========================================================================
-- ETAPA 4: EXCLUSÃO DE DADOS (DELETE)
-- Removendo um registro específico utilizando a cláusula WHERE
-- =========================================================================

-- Deletando a associação da habilidade 'Escudo Divino' (Id 4) da classe 'Guerreiro' (Id 1)
DELETE FROM CLASSES_HABILIDADES 
WHERE ClasseId = 1 AND HabilidadeId = 4;
GO

-- =========================================================================
-- ETAPA 5: CONFERÊNCIA FINAL
-- =========================================================================
SELECT * FROM PERSONAGENS;
SELECT * FROM CLASSES_HABILIDADES;
GO
