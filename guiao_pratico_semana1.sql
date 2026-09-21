-- Primeiro criamos tabelas que não têm referencia para ninguem
CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY,
    nome            VARCHAR(50) NOT NULL UNIQUE,
    localizacao     VARCHAR(100) NOT NULL
);

-- Depois criamos as tabelas que referenciam outras acima
CREATE TABLE empregado (
    id_empregado    INT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    salario         NUMERIC(10, 2) NOT NULL CHECK (salario > 0),
    data_admissao   DATE NOT NULL DEFAULT CURRENT_DATE,
    id_departamento INT NOT NULL,
    CONSTRAINT fk_empregado_departamento 
        FOREIGN KEY (id_departamento) 
        REFERENCES departamento(id_departamento)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
);

-- Resumindo não podemos referenciar algo que não existe



-- Primeiro inserimos os Departamentos (Tabela que é referenciada por outras)
INSERT INTO departamento (id_departamento, nome, localizacao) VALUES
    (1,'Recursos Humanos', 'Edifício A - Piso 1'),
    (2,'Tecnologias de Informação', 'Edifício B - Piso 2'),
    (3,'Financeiro', 'Edifício A - Piso 3');

-- Depois inserimos os Empregados associados aos Departamentos (Tabela que refere alguem já criado acima)
INSERT INTO empregado (id_empregado, nome, email, salario, id_departamento) VALUES
    (1, 'Ana Silva', 'ana.silva@empresa.com', 1500.00, 2),
    (2, 'Bruno Santos', 'bruno.santos@empresa.com', 1800.50, 2),
    (3, 'Carla Oliveira', 'carla.oliveira@empresa.com', 1350.00, 1),
    (4, 'Diogo Costa', 'diogo.costa@empresa.com', 1600.00, 3);

select * from departamento;

select nome from departamento

select e.id_empregado, e.nome AS empregado, e.email, e.salario, d.nome AS departamento, d.localizacao
FROM empregado e
JOIN departamento d ON e.id_departamento = d.id_departamento;

-- 1. Erro de integridade
INSERT INTO empregado (id_empregado, nome, email, salario, id_departamento) VALUES (10, 'Teste FK', 'erro.fk@empresa.com', 1000.00, 99);

-- 2. Erro de integridade
INSERT INTO empregado (id_empregado, nome, email, salario, id_departamento) VALUES (20, 'Outro Nome', 'ana.silva@empresa.com', 1200.00, 1);

-- 3. erro de integridade
INSERT INTO empregado (id_empregado, nome, email, salario, id_departamento) VALUES (30, 'Erro Salario', 'erro.salario@empresa.com', -500.00, 1);
