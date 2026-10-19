-- =========================================================================
-- PARTE 1: SEGURANÇA - CRIAÇÃO DO USUÁRIO COM PERMISSÃO APENAS DE LEITURA
-- =========================================================================

-- 1. Criar o login de conexão no nível do servidor (Baseado no Manual 11)
USE master;
GO

CREATE LOGIN aluno 
WITH PASSWORD = '1234'; -- Senha padrão do exemplo do manual
GO

-- 2. Vincular o login a um usuário dentro do banco de dados do RPG
USE JogoRpgDB;
GO

CREATE USER aluno FOR LOGIN aluno;
GO

-- 3. Restringir o acesso para que ele possa APENAS realizar consultas (DQL)
GRANT SELECT TO aluno; -- Bloqueia automaticamente INSERT, UPDATE e DELETE
GO


-- =========================================================================
-- PARTE 2: AUDITORIA - RECURSO SQL SERVER AUDIT (LOGS DE EVENTO)
-- =========================================================================

-- 1. Criar a Auditoria a nível de Servidor (Baseado no Manual 12)
USE master;
GO

CREATE SERVER AUDIT [Audit-JogoRPG]
TO FILE ( 
    FILEPATH = 'C:\AuditoriaExemplo\', -- Pasta padrão solicitada na apostila
    MAXSIZE = 100 MB -- Limite máximo de tamanho por arquivo conforme manual
)
WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE); -- Atraso de 1000ms e continuar em caso de falha
GO

-- Habilitar a Auditoria do Servidor
ALTER SERVER AUDIT [Audit-JogoRPG] WITH (STATE = ON);
GO

-- 2. Criar a Especificação de Auditoria do Banco de Dados para a tabela PERSONAGENS
USE JogoRpgDB;
GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-RPG]
FOR SERVER AUDIT [Audit-JogoRPG]
ADD (SELECT ON OBJECT::dbo.PERSONAGENS BY aluno) -- Registra toda vez que o 'aluno' der SELECT em PERSONAGENS
WITH (STATE = ON); -- Já cria a especificação ativada/habilitada
GO
