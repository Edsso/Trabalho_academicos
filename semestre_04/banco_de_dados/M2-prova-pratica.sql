-- 1

CREATE SCHEMA hospedaro_db;
USE hospedaro_db;

-- 2

CREATE TABLE Hotel(
id INT PRIMARY KEY UNIQUE,
nome VARCHAR(100) NOT NULL,
cidade VARCHAR(100) NOT NULL,
ratting INT NOT NULL
);

CREATE TABLE Quarto(
id INT PRIMARY KEY UNIQUE,
hotel_id INT NOT NULL,
numero INT NOT NULL,
tipo VARCHAR(100) NOT NULL,
preco_diaria DECIMAL NOT NULL,
FOREIGN KEY (hotel_id) REFERENCES Hotel(id)
);

CREATE TABLE Cliente(
id INT PRIMARY KEY UNIQUE,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
telefone VARCHAR(100) NOT NULL,
cpf VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Hospedagem(
id INT PRIMARY KEY UNIQUE,
client_id INT NOT NULL,
quarto_id INT NOT NULL,
data_checking DATE NOT NULL,
data_checkout DATE NOT NULL,
valor_total FLOAT NOT NULL,
status_hosp VARCHAR(100) NOT NULL,
FOREIGN KEY (client_id) REFERENCES Cliente(id),
FOREIGN KEY (quarto_id) REFERENCES Quarto(id)
);

-- 3

INSERT INTO Hotel (id, nome, cidade, ratting) VALUES
(1, 'Hotel A', 'Cidade1', 5),
(2, 'Hotel B', 'Cidade1', 4),
(3, 'Hotel C', 'Cidade2', 3),
(4, 'Hotel D', 'Cidade2', 4),
(5, 'Hotel E', 'Cidade3', 5);

INSERT INTO Quarto (id, hotel_id, numero, tipo, preco_diaria) VALUES
(1, 1, 101, 'Simples', 100.00),
(2, 1, 102, 'Duplo', 150.00),
(3, 1, 103, 'Suite', 250.00),
(4, 1, 104, 'Luxo', 300.00),
(5, 1, 105, 'Presidencial', 500.00),
(6, 2, 201, 'Simples', 90.00),
(7, 2, 202, 'Duplo', 140.00),
(8, 2, 203, 'Suite', 240.00),
(9, 2, 204, 'Luxo', 280.00),
(10, 2, 205, 'Presidencial', 480.00),
(11, 3, 301, 'Simples', 80.00),
(12, 3, 302, 'Duplo', 130.00),
(13, 3, 303, 'Suite', 220.00),
(14, 3, 304, 'Luxo', 270.00),
(15, 3, 305, 'Presidencial', 450.00),
(16, 4, 401, 'Simples', 85.00),
(17, 4, 402, 'Duplo', 135.00),
(18, 4, 403, 'Suite', 225.00),
(19, 4, 404, 'Luxo', 275.00),
(20, 4, 405, 'Presidencial', 460.00),
(21, 5, 501, 'Simples', 110.00),
(22, 5, 502, 'Duplo', 160.00),
(23, 5, 503, 'Suite', 260.00),
(24, 5, 504, 'Luxo', 310.00),
(25, 5, 505, 'Presidencial', 510.00);

INSERT INTO Cliente (id, nome, email, telefone, cpf) VALUES
(1, 'Alice', 'alice@example.com', '1234567890', '12345678901'),
(2, 'Bob', 'bob@example.com', '0987654321', '23456789012'),
(3, 'Carlos', 'carlos@example.com', '1122334455', '34567890123'),
(4, 'Diana', 'diana@example.com', '2233445566', '45678901234'),
(5, 'Eduardo', 'eduardo@example.com', '3344556677', '56789012345');

INSERT INTO Hospedagem (id, client_id, quarto_id, data_checking, data_checkout, valor_total, status_hosp) VALUES
(1, 1, 1, '2024-01-01', '2024-01-05', 500.00, 'Hospedado'),
(2, 1, 2, '2024-01-10', '2024-01-15', 750.00, 'Hospedado'),
(3, 2, 3, '2024-01-02', '2024-01-07', 1000.00, 'Reserva'),
(4, 2, 4, '2024-01-12', '2024-01-17', 1350.00, 'Finalizado'),
(5, 3, 5, '2024-01-03', '2024-01-08', 1500.00, 'Cancelada'),
(6, 3, 6, '2024-01-13', '2024-01-18', 720.00, 'Hospedado'),
(7, 4, 7, '2024-01-04', '2024-01-09', 850.00, 'Finalizado'),
(8, 4, 8, '2024-01-14', '2024-01-19', 1200.00, 'Finalizado'),
(9, 5, 9, '2024-01-05', '2024-01-10', 1100.00, 'Cancelada'),
(10, 5, 10, '2024-01-15', '2024-01-20', 1400.00, 'Hospedado'),
(11, 1, 11, '2024-01-06', '2024-01-11', 800.00, 'Finalizado'),
(12, 1, 12, '2024-01-16', '2024-01-21', 960.00, 'Cancelada'),
(13, 2, 13, '2024-01-07', '2024-01-12', 1260.00, 'Hospedado'),
(14, 2, 14, '2024-01-17', '2024-01-22', 1050.00, 'Reserva'),
(15, 3, 15, '2024-01-08', '2024-01-13', 1360.00, 'Finalizado'),
(16, 3, 16, '2024-01-18', '2024-01-23', 900.00, 'Cancelada'),
(17, 4, 17, '2024-01-09', '2024-01-14', 1000.00, 'Cancelada'),
(18, 4, 18, '2024-01-19', '2024-01-24', 1200.00, 'Reserva'),
(19, 5, 19, '2024-01-10', '2024-01-15', 800.00, 'Reserva'),
(20, 5, 20, '2024-10-16', '2024-10-25', 900.00, 'Reserva');

-- 4

-- a 
SELECT 
    h.nome AS hotel_nome, 
    h.cidade AS hotel_cidade, 
    q.tipo AS quarto_tipo, 
    q.preco_diaria AS quarto_preco_diaria
FROM 
    Hotel h
JOIN 
    Quarto q ON h.id = q.hotel_id;

-- b
SELECT 
    c.nome AS cliente_nome,
    c.email AS cliente_email,
    h.nome AS hotel_nome,
    h.cidade AS hotel_cidade,
    q.tipo AS quarto_tipo,
    q.preco_diaria AS quarto_preco_diaria,
    ho.data_checking,
    ho.data_checkout
FROM 
    Cliente c
JOIN 
    Hospedagem ho ON c.id = ho.client_id
JOIN 
    Quarto q ON ho.quarto_id = q.id
JOIN 
    Hotel h ON q.hotel_id = h.id
WHERE 
    ho.status_hosp = 'Finalizado';

-- c
SELECT 
    ho.id AS hospedagem_id,
    c.nome AS cliente_nome,
    h.nome AS hotel_nome,
    h.cidade AS hotel_cidade,
    q.tipo AS quarto_tipo,
    ho.data_checking,
    ho.data_checkout,
    ho.status_hosp
FROM 
    Hospedagem ho
JOIN 
    Cliente c ON ho.client_id = c.id
JOIN 
    Quarto q ON ho.quarto_id = q.id
JOIN 
    Hotel h ON q.hotel_id = h.id
WHERE 
    ho.status_hosp = 'Finalizado'
ORDER BY 
    ho.data_checkout DESC; 

-- d
SELECT 
    c.nome AS cliente_nome,
    c.email AS cliente_email,
    COUNT(ho.id) AS numero_hospedagens
FROM 
    Cliente c
JOIN 
    Hospedagem ho ON c.id = ho.client_id
GROUP BY 
    c.id
ORDER BY 
    numero_hospedagens DESC
LIMIT 1;

-- e
SELECT 
    c.nome AS cliente_nome,
    h.nome AS hotel_nome,
    q.tipo AS quarto_tipo
FROM 
    Cliente c
JOIN 
    Hospedagem ho ON c.id = ho.client_id
JOIN 
    Quarto q ON ho.quarto_id = q.id
JOIN 
    Hotel h ON q.hotel_id = h.id
WHERE 
    ho.status_hosp = 'Cancelada';

-- f
SELECT 
	h.nome AS hotel_nome,
	h.cidade AS hotel_cidade,
	SUM(q.preco_diaria * DATEDIFF(ho.data_checkout, ho.data_checking)) AS receita_total
FROM 
	Cliente c
JOIN 
	Hospedagem ho ON c.id = ho.client_id
JOIN 
	Quarto q ON ho.quarto_id = q.id
JOIN 
	Hotel h ON q.hotel_id = h.id
WHERE 
	ho.status_hosp = 'Finalizado'
GROUP BY 
	h.id, h.nome, h.cidade
ORDER BY 
	receita_total DESC;
    
-- g
SELECT 
    c.nome AS cliente_nome,
    c.email AS cliente_email
FROM 
    Cliente c
JOIN 
    Hospedagem ho ON c.id = ho.client_id
JOIN 
    Quarto q ON ho.quarto_id = q.id
JOIN 
    Hotel h ON q.hotel_id = h.id
WHERE 
    h.nome = 'Hotel A';    

-- h
SELECT 
    c.nome AS cliente_nome,
    c.email AS cliente_email,
    SUM(q.preco_diaria * DATEDIFF(ho.data_checkout, ho.data_checking)) AS total_gasto
FROM 
    Cliente c
JOIN 
    Hospedagem ho ON c.id = ho.client_id
JOIN 
    Quarto q ON ho.quarto_id = q.id
WHERE 
    ho.status_hosp = 'Finalizado'
GROUP BY 
    c.id, c.nome, c.email
ORDER BY 
    total_gasto DESC;
    
-- i
SELECT 
    q.id AS quarto_id,
    q.tipo AS quarto_tipo,
    q.preco_diaria AS quarto_preco_diaria,
    h.nome AS hotel_nome,
    h.cidade AS hotel_cidade
FROM 
    Quarto q
JOIN 
    Hotel h ON q.hotel_id = h.id
LEFT JOIN 
    Hospedagem ho ON q.id = ho.quarto_id
WHERE 
    ho.id IS NULL;
    
-- j
SELECT 
    q.tipo AS quarto_tipo,
    AVG(q.preco_diaria) AS media_preco_diaria,
    h.nome AS hotel_nome,
    h.cidade AS hotel_cidade
FROM 
    Quarto q
JOIN 
    Hotel h ON q.hotel_id = h.id
GROUP BY 
    q.tipo, h.id, h.nome, h.cidade
ORDER BY 
    quarto_tipo, h.nome;
    
-- k 
DELETE FROM Hospedagem WHERE status_hosp = 'Cancelada';     
    
-- l
ALTER TABLE Hospedagem
ADD COLUMN checkin_realizado BOOLEAN;

UPDATE Hospedagem
SET checkin_realizado = 
    CASE 
        WHEN status_hosp IN ('Finalizado', 'Hospedado') THEN TRUE
        WHEN status_hosp IN ('Reserva', 'Cancelada') THEN FALSE
    END;   
    
-- m 
ALTER TABLE Hotel
CHANGE COLUMN ratting classificacao VARCHAR(100);

-- n
CREATE VIEW reservas_futuras AS
SELECT 
    c.nome AS cliente_nome,
    c.email AS cliente_email,
    q.tipo AS quarto_tipo,
    q.preco_diaria AS quarto_preco_diaria,
    h.nome AS hotel_nome,
    h.cidade AS hotel_cidade,
    ho.data_checking
FROM 
    Hospedagem ho
JOIN 
    Cliente c ON ho.client_id = c.id
JOIN 
    Quarto q ON ho.quarto_id = q.id
JOIN 
    Hotel h ON q.hotel_id = h.id
WHERE 
    ho.status_hosp = 'Reserva' AND
    ho.data_checking >= DATE(NOW())
ORDER BY 
    ho.data_checking;
