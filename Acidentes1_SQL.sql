
#---------------- Tabela de Localidades ----------------------------------------#
CREATE TABLE Localidades (
    id_localidade INT PRIMARY KEY,
    cidade VARCHAR(100),
    estado VARCHAR(2)
);
#-------------------------------------------------------------------------------#


#---------------- Tabela de Condutores -----------------------------------------#
CREATE TABLE Condutores (
    id_condutor INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    habilitado BOOLEAN
);
#-------------------------------------------------------------------------------#


#---------------- Tabela de Veículos -------------------------------------------#
CREATE TABLE Veiculos (
    id_veiculo INT PRIMARY KEY,
    tipo VARCHAR(50),
    placa VARCHAR(10),
    id_condutor INT,
    FOREIGN KEY (id_condutor) REFERENCES Condutores(id_condutor)
);
#-------------------------------------------------------------------------------#

-- Tabela de acidentes
CREATE TABLE Acidentes (
    id_acidente INT PRIMARY KEY,
    data DATE,
    id_localidade INT,
    tipo_acidente VARCHAR(50),
    qtd_feridos INT,
    qtd_mortos INT,
    id_veiculo INT,
    FOREIGN KEY (id_localidade) REFERENCES Localidades(id_localidade),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo)
);
#-------------------------------------------------------------------------------#

#-------------------------------------------------------------------------------#
-- Localidades
INSERT INTO Localidades VALUES 
(1, 'Belém', 'PA'),
(2, 'Ananindeua', 'PA'),
(3, 'Santarém', 'PA');

-- Condutores
INSERT INTO Condutores VALUES 
(1, 'Mario Diego', 40, TRUE),
(2, 'Maria Souza', 29, TRUE),
(3, 'Carlos Lima', 21, FALSE);

-- Veículos
INSERT INTO Veiculos VALUES 
(1, 'Carro', 'ABC1234', 1),
(2, 'Motocicleta', 'XYZ5678', 2),
(3, 'Motoneta', 'DEF8901', 3);

-- Acidentes
INSERT INTO Acidentes VALUES 
(1, '2024-07-15', 1, 'Colisão Frontal', 2, 1, 1),
(2, '2024-08-20', 2, 'Atropelamento', 1, 0, 2),
(3, '2024-09-10', 3, 'Capotamento', 0, 2, 3),
(4, '2024-09-25', 1, 'Colisão Traseira', 3, 0, 1);
#-------------------------------------------------------------------------------#




#-------------------------------------------------------------------------------#
# CONSULTAS

SELECT * FROM Acidentes WHERE qtd_mortos > 0;


SELECT tipo_acidente, COUNT(*) AS total
FROM Acidentes
GROUP BY tipo_acidente;

SELECT l.cidade, COUNT(*) AS total_acidentes
FROM Acidentes a
JOIN Localidades l ON a.id_localidade = l.id_localidade
GROUP BY l.cidade;


SELECT DISTINCT c.nome
FROM Condutores c
JOIN Veiculos v ON c.id_condutor = v.id_condutor
JOIN Acidentes a ON v.id_veiculo = a.id_veiculo;


SELECT 
    EXTRACT(MONTH FROM data) AS mes,
    COUNT(*) AS total
FROM Acidentes
GROUP BY mes
ORDER BY mes;


SELECT a.id_acidente, c.nome, c.habilitado
FROM Acidentes a
JOIN Veiculos v ON a.id_veiculo = v.id_veiculo
JOIN Condutores c ON v.id_condutor = c.id_condutor
WHERE c.habilitado = FALSE;


SELECT * FROM Acidentes
ORDER BY qtd_mortos DESC
LIMIT 1;
#-------------------------------------------------------------------------------#





