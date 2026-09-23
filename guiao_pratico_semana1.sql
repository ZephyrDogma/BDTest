-- ============================================================
-- GUIÃO DE AULA PRÁTICA - SEMANA 1: BASES DE DADOS
-- Exemplo dos Slides: CLIENTE e ENCOMENDA
-- ============================================================

-- 1. Limpeza inicial para poder reexecutar o script
DROP TABLE IF EXISTS encomenda CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;


-- Primeiro criamos tabelas que não têm referência para ninguém
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE
);


-- Depois criamos as tabelas que referenciam outras acima
CREATE TABLE encomenda (
    id_encomenda INT PRIMARY KEY,
    data         DATE NOT NULL DEFAULT CURRENT_DATE,
    valor        NUMERIC(10, 2) NOT NULL CHECK (valor > 0),
    id_cliente   INT NOT NULL,
    CONSTRAINT fk_encomenda_cliente 
        FOREIGN KEY (id_cliente) 
        REFERENCES cliente(id_cliente)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

-- Resumindo: não podemos referenciar algo que não existe


-- Primeiro inserimos os Clientes (Tabela que é referenciada por outras)
INSERT INTO cliente (id_cliente, nome, email) VALUES
    (1, 'Ana Silva', 'ana.silva@email.com'),
    (2, 'Bruno Santos', 'bruno.santos@email.com'),
    (3, 'Carla Oliveira', 'carla.oliveira@email.com');


-- Depois inserimos as Encomendas associadas aos Clientes (Tabela que refere alguém já criado acima)
INSERT INTO encomenda (id_encomenda, data, valor, id_cliente) VALUES
    (101, '2026-09-20', 150.00, 1),
    (102, '2026-09-21', 89.90, 1),
    (103, '2026-09-22', 210.50, 3);
-- Nota: O cliente 2 (Bruno Santos) fica sem encomendas para poderem testar esse caso em aula!


-- Consultas simples
SELECT * FROM cliente;

SELECT nome FROM cliente;


-- Junção (JOIN) para ver as encomendas com os dados do cliente
SELECT 
    e.id_encomenda, 
    e.data, 
    e.valor, 
    c.id_cliente, 
    c.nome AS cliente, 
    c.email
FROM encomenda e
JOIN cliente c ON e.id_cliente = c.id_cliente;


-- ============================================================
-- ERROS DE INTEGRIDADE PARA DEMONSTRAR NA AULA
-- ============================================================

-- 1. Erro de integridade referencial (Cliente 99 não existe na tabela cliente)
INSERT INTO encomenda (id_encomenda, data, valor, id_cliente) 
VALUES (104, '2026-09-22', 50.00, 99);

-- 2. Erro de integridade de unicidade (Email da Ana Silva já existe)
INSERT INTO cliente (id_cliente, nome, email) 
VALUES (4, 'Ana Rita', 'ana.silva@email.com');

-- 3. Erro de integridade por restrição CHECK (Valor da encomenda negativo)
INSERT INTO encomenda (id_encomenda, data, valor, id_cliente) 
VALUES (105, '2026-09-22', -20.00, 1);
