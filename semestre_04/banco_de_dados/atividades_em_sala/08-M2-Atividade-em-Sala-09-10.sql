-- QUESTAO 1
CREATE SCHEMA consultorio;
use consultorio;
SET SQL_SAFE_UPDATES = 0;
DROP SCHEMA consultorio;

CREATE TABLE Especialidade(
	id INT PRIMARY KEY auto_increment,
    nome VARCHAR(50)
);

CREATE TABLE Paciente(
	id INT PRIMARY KEY auto_increment,
    nome VARCHAR(100),
    celular VARCHAR(50)
);

CREATE TABLE Medico(
	id INT PRIMARY KEY auto_increment,
    id_especialidade INT NOT NULL,
    nome VARCHAR(100),
    celular VARCHAR(15),
    FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id)
);

CREATE TABLE Consulta(
	id INT PRIMARY KEY auto_increment,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    data_hora_inicio DATETIME,
    data_hora_fim DATETIME,
    FOREIGN KEY (id_medico) REFERENCES Medico(id),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id)
);

-- Questão 2

-- 1 -
INSERT INTO Especialidade (nome)
VALUES 
('Cardiologia'),
('Oftalmologia'),
('Pediatria');

-- 2-
INSERT INTO Medico (nome, id_especialidade, celular)
VALUES 
('Beatriz', 1 , ' (47) 99999-9999'),
('Jose', 3 , ' (47) 99999-9999'),
('Ana', 1 , ' (47) 99999-9999'),
('Gustavo', 2 , ' (47) 99999-9999'),
('Paulo', 1 , ' (47) 99999-9999'),
('Carlos', 3 , ' (47) 99999-9999');

-- 3-
INSERT INTO Paciente (nome,celular)
VALUES 
('Marina',	'(47) 99999-9999'),
('Marcos',	'(47) 99999-9999'),
('Maicon',	'(47) 99999-9999'),
('Roberta',	'(47) 99999-9999'),
('Joaquim',	'(47) 99999-9999'),
('Bianca','(47) 99999-9999'),
('Pedro','(47) 99999-9999');

-- 4-
INSERT INTO Consulta (id_medico,id_paciente, data_hora_inicio, data_hora_fim)
VALUES 
(1,4,'2024-12-08 10:00:00','2024-12-08 11:30:00' ),
(1,5,'2024-12-08 11:30:00','2024-12-08 12:00:00' ),
(1,6,'2024-12-08 13:30:00','2024-12-08 14:30:00' ),
(2,2,'2024-12-08 08:00:00','2024-12-08 10:00:00' ),
(2,3,'2024-12-08 10:00:00','2024-12-08 11:00:00' ),
(2,1,'2024-12-08 11:30:00','2024-12-08 12:00:00' ),
(5,7,'2024-12-09 08:30:00','2024-12-09 09:00:00'),
(4,7,'2024-12-09 09:00:00','2024-12-09 10:00:00'),
(4,5,'2024-12-09 11:00:00','2024-12-09 12:00:00'),
(4,6,'2024-12-09 13:30:00','2024-12-09 14:30:00'),
(4,2,'2024-12-09 14:30:00','2024-12-09 15:00:00');


-- QUESTAO 3

UPDATE Paciente SET celular = '(47) 11111-1111' WHERE nome = 'Bianca';
UPDATE Paciente SET celular = '(47) 11111-1111' WHERE nome = 'Marcos';

-- QUESTAO 4

DELETE FROM Consulta WHERE data_hora_inicio = '2024-12-08 13:30:00' AND id_medico = 1 AND id_paciente = 6;

-- QUESTAO 6

-- 1
SELECT m.nome AS Medico, c.id_medico, COUNT(*) AS quantidade_consultas
FROM Consulta c
JOIN Medico m ON (m.id = c.id_medico)
GROUP BY id_medico
ORDER BY id_medico ASC;

-- 2
SELECT e.nome ,v.id_especialidade AS Especialidade, COUNT(id_medico) AS Quantidade_Consultas
FROM consulta c
JOIN medico v on (v.id = c.id_medico) 
JOIN especialidade e ON (e.id = v.id_especialidade)
GROUP BY e.nome;

-- 3
SELECT DATE_FORMAT(data_hora_inicio, '%d/%m') AS dia_mes, MAX(TIMESTAMPDIFF(MINUTE, data_hora_inicio, data_hora_fim)) AS maior_duracao 
FROM 
    consulta
GROUP BY 
    DATE(data_hora_inicio);

-- 4
SELECT e.nome , v.id_especialidade AS Especialidade, MAX(id_medico) AS Quantidade_Consultas
FROM consulta c
JOIN medico v on (v.id = c.id_medico) 
JOIN especialidade e ON (e.id = v.id_especialidade)
GROUP BY e.nome;


-- 5
CREATE VIEW todas_consultas AS
SELECT 
    p.nome AS paciente,
    m.nome AS medico,
    e.nome AS especialidade,
    c.data_hora_inicio AS data
FROM 
    consulta c
JOIN 
    paciente p ON p.id = c.id_paciente
JOIN 
    medico m ON m.id = c.id_medico
JOIN 
    especialidade e ON e.id = m.id_especialidade
ORDER BY 
    c.data_hora_inicio;
