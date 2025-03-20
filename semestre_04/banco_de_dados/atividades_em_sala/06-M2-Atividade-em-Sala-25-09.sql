-- 	**** M2 - ATIVIDADE EM SALA 02 ****
/* Com base no uso do banco de dados clinica_vet (código para criação do 
 esquema no final deste arquivo linha 39 a 120), efetue as seguintes atividades: */
 
 -- OBS: Estregar este arquivo com o codigo solicitado em cada tarefa em ordem cronológica.
 
 /*	1. Com o uso do comando ALTER, efetue as seguintes modificações no esquema clinica_vet: */
	-- a. Adicione um novo campo à tabela Tutor nomeado data_nascimento, para armazenar a data de nascimento dos tutores.       
       
       ALTER TABLE Tutor ADD COLUMN  data_nascimento DATE NOT NULL;
       
	-- b. Modifique o campo cpf na tabela Tutor para aceitar até 14 caracteres (para incluir a formatação de CPF com pontos e traços).
		
        ALTER TABLE Tutor MODIFY COLUMN cpf varchar(14);
        
	-- C. Modifique o nome da coluna fone da tabela Tutor para telefone, para tornar o nome mais claro.

		ALTER TABLE Tutor CHANGE COLUMN fone telefone varchar(13);

    -- D. Adicione uma restrição de unicidade ao campo telefone na tabela Veterinario para garantir que não haja duplicatas.

		ALTER TABLE Veterinario MODIFY COLUMN fone varchar(16) UNIQUE;

	-- E. Remova o campo complemento da tabela Tutor_endereco, pois ele não será mais utilizado.

		ALTER TABLE Tutor_endereco DROP COLUMN complemento;

	-- F. Renomeie a tabela Veterinario_endereco para Endereco_veterinario, tornando o nome mais claro e consistente.

		ALTER TABLE Veterinario_endereco RENAME TO Endereco_veterinario;

    -- G. Adicione uma chave estrangeira à tabela Consulta para garantir que cada consulta tenha um tutor associado, vinculando a tabela Tutor.

		ALTER TABLE consulta ADD COLUMN id_tutor INT NOT NULL;
		ALTER TABLE consulta ADD CONSTRAINT fk_cons_tut FOREIGN KEY (id_tutor) REFERENCES tutor(id);

	-- H. Modifique o campo especialidade na tabela Veterinario para torná-lo obrigatório (não aceitar NULL) e, em seguida, faça o mesmo com o campo rua na tabela Endereco_veterinario.
        
        ALTER TABLE veterinario MODIFY COLUMN especialidade VARCHAR(100) NOT NULL;
		ALTER TABLE Endereco_veterinario MODIFY COLUMN rua VARCHAR(100) NOT NULL;
        
	-- I.  Modifique os tipos de dados de duas colunas da tabela Consulta: altere o campo horario para DATETIME e o campo dt para TIMESTAMP.
	
		ALTER TABLE consulta MODIFY COLUMN horario DATETIME;
		ALTER TABLE consulta MODIFY COLUMN dt TIMESTAMP;


/* 	2. Geração e inserção de dados sintéticos. */
	/* a. Pesquisar e apresentar uma forma de inserir uma grande quantidade de 
		dados artificiais no banco de dados. */
	/* b. Com o uso da técnica apresentada no item 1, efetue a inserção da seguinte 
		quantidade de dados: 50 tutores com seus respectivos endereços; 
		30 veterinário com seus respectivos endereços; 70 animais; e 100 consultas. */

INSERT INTO Tutor (cpf, nome, email, telefone, data_nascimento) VALUES
('12345678901', 'João Silva', 'joao.silva@email.com', '1234-5678', '1985-01-15'),
('23456789012', 'Maria Oliveira', 'maria.oliveira@email.com', '2345-6789', '1990-02-20'),
('34567890123', 'Carlos Souza', 'carlos.souza@email.com', '3456-7890', '1988-03-25'),
('45678901234', 'Ana Paula', 'ana.paula@email.com', '4567-8901', '1992-04-30'),
('56789012345', 'Lucas Almeida', 'lucas.almeida@email.com', '5678-9012', '1987-05-05'),
('67890123456', 'Fernanda Lima', 'fernanda.lima@email.com', '6789-0123', '1993-06-10'),
('78901234567', 'Roberto Dias', 'roberto.dias@email.com', '7890-1234', '1986-07-15'),
('89012345678', 'Juliana Costa', 'juliana.costa@email.com', '8901-2345', '1991-08-20'),
('90123456789', 'Eduardo Rocha', 'eduardo.rocha@email.com', '9012-3456', '1989-09-25'),
('01234567890', 'Mariana Ferreira', 'mariana.ferreira@email.com', '0123-4567', '1994-10-30'),
('12345678912', 'Gabriel Martins', 'gabriel.martins@email.com', '1234-5678', '1988-11-10'),
('23456789023', 'Larissa Silva', 'larissa.silva@email.com', '2345-6789', '1990-12-05'),
('34567890134', 'Rafael Santos', 'rafael.santos@email.com', '3456-7890', '1987-01-18'),
('45678901245', 'Isabela Mendes', 'isabela.mendes@email.com', '4567-8901', '1993-02-22'),
('56789012356', 'Vinícius Lima', 'vinicius.lima@email.com', '5678-9012', '1986-03-28'),
('67890123467', 'Tatiane Almeida', 'tatiane.almeida@email.com', '6789-0123', '1991-04-30'),
('78901234578', 'João Pedro', 'joao.pedro@email.com', '7890-1234', '1985-05-15'),
('89012345689', 'Daniela Costa', 'daniela.costa@email.com', '8901-2345', '1992-06-20'),
('90123456790', 'Felipe Dias', 'felipe.dias@email.com', '9012-3456', '1989-07-10'),
('01234567801', 'Sofia Oliveira', 'sofia.oliveira@email.com', '0123-4567', '1994-08-15'),
('12345678923', 'André Ferreira', 'andre.ferreira@email.com', '1234-5678', '1988-09-30'),
('23456789034', 'Renata Rocha', 'renata.rocha@email.com', '2345-6789', '1990-10-05'),
('34567890145', 'Leonardo Santos', 'leonardo.santos@email.com', '3456-7890', '1987-11-18'),
('45678901256', 'Camila Martins', 'camila.martins@email.com', '4567-8901', '1993-12-22'),
('56789012367', 'Marcos Lima', 'marcos.lima@email.com', '5678-9012', '1986-01-25'),
('67890123478', 'Gisele Almeida', 'gisele.almeida@email.com', '6789-0123', '1991-02-10'),
('78901234589', 'Fernando Dias', 'fernando.dias@email.com', '7890-1234', '1989-03-15'),
('89012345690', 'Patrícia Costa', 'patricia.costa@email.com', '8901-2345', '1994-04-20'),
('90123456701', 'Robson Ferreira', 'robson.ferreira@email.com', '9012-3456', '1988-05-25'),
('01234567812', 'Aline Rocha', 'aline.rocha@email.com', '0123-4567', '1992-06-30'),
('12345678934', 'Thiago Santos', 'thiago.santos@email.com', '1234-5678', '1986-07-15'),
('23456789045', 'Eliane Martins', 'eliane.martins@email.com', '2345-6789', '1990-08-10'),
('34567890156', 'Kleber Lima', 'kleber.lima@email.com', '3456-7890', '1987-09-05'),
('45678901267', 'Viviane Almeida', 'viviane.almeida@email.com', '4567-8901', '1993-10-20'),
('56789012378', 'Samuel Dias', 'samuel.dias@email.com', '5678-9012', '1988-11-25'),
('67890123489', 'Jessica Costa', 'jessica.costa@email.com', '6789-0123', '1991-12-30'),
('78901234590', 'Gilberto Ferreira', 'gilberto.ferreira@email.com', '7890-1234', '1989-01-10'),
('89012345601', 'Marceline Rocha', 'marceline.rocha@email.com', '8901-2345', '1994-02-14'),
('90123456712', 'Rogério Santos', 'rogerio.santos@email.com', '9012-3456', '1986-03-19'),
('01234567823', 'Amanda Lima', 'amanda.lima@email.com', '0123-4567', '1991-04-24'),
('12345678945', 'Fábio Almeida', 'fabio.almeida@email.com', '1234-5678', '1988-05-29'),
('23456789056', 'Rosângela Dias', 'rosangela.dias@email.com', '2345-6789', '1990-06-04'),
('34567890167', 'Sérgio Costa', 'sergio.costa@email.com', '3456-7890', '1987-07-10'),
('45678901278', 'Célia Ferreira', 'celia.ferreira@email.com', '4567-8901', '1993-08-15'),
('56789012389', 'Nélio Rocha', 'nelio.rocha@email.com', '5678-9012', '1988-09-20'),
('67890123490', 'Isadora Santos', 'isadora.santos@email.com', '6789-0123', '1991-10-25'),
('78901234501', 'Henrique Martins', 'henrique.martins@email.com', '7890-1234', '1989-11-30'),
('89012345612', 'Evelyn Lima', 'evelyn.lima@email.com', '8901-2345', '1994-12-05'),
('90123456789', 'Henrique Martins', 'henrique@email.com', '9999-9999', '1989-11-30'),
('99239194834', 'Evelyn Lima', 'evelyn@email.com', '0000-0000', '1994-12-05');

INSERT INTO Veterinario (nome, crmv, email, fone, especialidade) VALUES
('Carlos Ferreira', 1234567890, 'carlos.f@vetmail.com', '1111-1111', 'Canina'),
('Lucia Carvalho', 2345678901, 'lucia.c@vetmail.com', '2222-2222', 'Felina'),
('Fernando Gomes', 3456789012, 'fernando.g@vetmail.com', '3333-3333', 'Exótica'),
('Ana Beatriz', 4567890123, 'ana.b@vetmail.com', '4444-4444', 'Canina'),
('Roberto Silva', 5678901234, 'roberto.s@vetmail.com', '5555-5555', 'Felina'),
('Mariana Almeida', 6789012345, 'mariana.a@vetmail.com', '6666-6666', 'Canina'),
('Tatiane Lima', 7890123456, 'tatiane.l@vetmail.com', '7777-7777', 'Exótica'),
('Lucas Santos', 8901234567, 'lucas.s@vetmail.com', '8888-8888', 'Felina'),
('Juliana Costa', 9012345678, 'juliana.c@vetmail.com', '9999-9999', 'Canina'),
('Eduardo Martins', 0123456789, 'eduardo.m@vetmail.com', '1010-1010', 'Felina'),
('Ana Paula', 1234567801, 'ana.paula@vetmail.com', '2020-2020', 'Exótica'),
('Ricardo Mendes', 2345678902, 'ricardo.m@vetmail.com', '3030-3030', 'Canina'),
('Fernanda Rocha', 3456789013, 'fernanda.r@vetmail.com', '4040-4040', 'Felina'),
('Gabriel Pereira', 4567890124, 'gabriel.p@vetmail.com', '5050-5050', 'Exótica'),
('Isabela Nunes', 5678901235, 'isabela.n@vetmail.com', '6060-6060', 'Canina'),
('Robson Dias', 6789012346, 'robson.d@vetmail.com', '7070-7070', 'Felina'),
('Sofia Almeida', 7890123457, 'sofia.a@vetmail.com', '8080-8080', 'Exótica'),
('Marcos Oliveira', 8901234568, 'marcos.o@vetmail.com', '9090-9090', 'Canina'),
('Tatiane Mendes', 9012345679, 'tatiane.m@vetmail.com', '0101-0101', 'Felina'),
('Fábio Costa', 0123456790, 'fabio.c@vetmail.com', '1112-1112', 'Exótica'),
('Luana Silva', 1234567810, 'luana.s@vetmail.com', '1213-1213', 'Canina'),
('Rafael Lima', 2345678920, 'rafael.l@vetmail.com', '1314-1314', 'Felina'),
('Camila Martins', 3456789030, 'camila.m@vetmail.com', '1415-1415', 'Exótica'),
('João Pedro', 4567890140, 'joao.p@vetmail.com', '1516-1516', 'Canina'),
('Eliane Gomes', 5678901250, 'eliane.g@vetmail.com', '1617-1617', 'Felina'),
('Vitor Hugo', 6789012360, 'vitor.h@vetmail.com', '1718-1718', 'Exótica'),
('Larissa Almeida', 7890123470, 'larissa.a@vetmail.com', '1819-1819', 'Canina'),
('Felipe Santos', 8901234580, 'felipe.s@vetmail.com', '1920-1920', 'Felina'),
('Nathalia Lima', 9012345690, 'nathalia.l@vetmail.com', '2021-2021', 'Exótica'),
('André Ferreira', 0123456701, 'andre.f@vetmail.com', '2122-2122', 'Canina'),
('Joana Costa', 1234567811, 'joana.c@vetmail.com', '2223-2223', 'Felina');

INSERT INTO Animal (id_tutor, nome, peso, raca, especie, cor, sexo, data_nasc) VALUES
(1, 'Rex', 30.5, 'Labrador', 'Cão', 'Amarelo', 'Macho', '2018-05-10'),
(1, 'Mia', 5.2, 'Siames', 'Gato', 'Branco', 'Fêmea', '2020-07-15'),
(2, 'Max', 25.0, 'Bulldog', 'Cão', 'Branco', 'Macho', '2019-03-20'),
(2, 'Luna', 6.5, 'Persa', 'Gato', 'Cinza', 'Fêmea', '2021-08-22'),
(3, 'Fido', 40.0, 'Pit Bull', 'Cão', 'Preto', 'Macho', '2017-01-30'),
(3, 'Nina', 4.8, 'Ragdoll', 'Gato', 'Bege', 'Fêmea', '2022-06-10'),
(4, 'Bobby', 10.0, 'Beagle', 'Cão', 'Marrom', 'Macho', '2020-05-01'),
(4, 'Bella', 7.5, 'Sphynx', 'Gato', 'Branco', 'Fêmea', '2023-02-15'),
(5, 'Rocky', 35.0, 'Rottweiler', 'Cão', 'Preto', 'Macho', '2016-09-12'),
(5, 'Chloe', 3.5, 'Maine Coon', 'Gato', 'Cinza', 'Fêmea', '2021-11-05'),
(6, 'Buddy', 22.0, 'Golden Retriever', 'Cão', 'Dourado', 'Macho', '2018-12-01'),
(6, 'Daisy', 4.0, 'Bengal', 'Gato', 'Malhado', 'Fêmea', '2022-01-25'),
(7, 'Oscar', 29.0, 'Cocker Spaniel', 'Cão', 'Caramelo', 'Macho', '2019-04-17'),
(7, 'Lily', 5.0, 'Siamês', 'Gato', 'Branco', 'Fêmea', '2021-07-14'),
(8, 'Simba', 28.0, 'Husky', 'Cão', 'Cinza', 'Macho', '2017-10-05'),
(8, 'Nala', 6.0, 'Persa', 'Gato', 'Branco', 'Fêmea', '2020-03-30'),
(9, 'Jake', 33.0, 'Doberman', 'Cão', 'Preto', 'Macho', '2018-06-20'),
(9, 'Coco', 4.5, 'Scottish Fold', 'Gato', 'Branco', 'Fêmea', '2021-09-10'),
(10, 'Charlie', 26.0, 'Shih Tzu', 'Cão', 'Branco', 'Macho', '2019-05-15'),
(10, 'Sophie', 3.0, 'Bichon Frise', 'Gato', 'Bege', 'Fêmea', '2022-02-18'),
(11, 'Toby', 34.0, 'Boxer', 'Cão', 'Marron', 'Macho', '2017-08-30'),
(11, 'Molly', 5.5, 'Ragdoll', 'Gato', 'Cinza', 'Fêmea', '2021-01-10'),
(12, 'Leo', 38.0, 'Pit Bull', 'Cão', 'Preto', 'Macho', '2016-11-21'),
(12, 'Ella', 6.2, 'Sphynx', 'Gato', 'Branco', 'Fêmea', '2020-04-17'),
(13, 'Marley', 27.0, 'Beagle', 'Cão', 'Tricolor', 'Macho', '2018-03-15'),
(13, 'Zoe', 4.8, 'Maine Coon', 'Gato', 'Cinza', 'Fêmea', '2021-12-12'),
(14, 'Rusty', 31.0, 'Rottweiler', 'Cão', 'Preto', 'Macho', '2017-05-25'),
(14, 'Ruby', 3.7, 'Siamês', 'Gato', 'Caramelo', 'Fêmea', '2020-08-01'),
(15, 'Ginger', 19.0, 'Cocker Spaniel', 'Cão', 'Dourado', 'Fêmea', '2019-07-14'),
(15, 'Shadow', 5.3, 'Siamês', 'Gato', 'Cinza', 'Macho', '2022-11-30'),
(16, 'Duke', 24.0, 'Golden Retriever', 'Cão', 'Dourado', 'Macho', '2016-02-17'),
(16, 'Princess', 4.9, 'Bengal', 'Gato', 'Malhado', 'Fêmea', '2021-03-22'),
(17, 'Hunter', 29.0, 'Labrador', 'Cão', 'Preto', 'Macho', '2018-09-01'),
(17, 'Lola', 5.7, 'Persa', 'Gato', 'Bege', 'Fêmea', '2022-01-11'),
(18, 'Rocky', 26.0, 'Husky', 'Cão', 'Branco', 'Macho', '2019-06-06'),
(18, 'Mimi', 3.2, 'Siamês', 'Gato', 'Cinza', 'Fêmea', '2021-10-25'),
(19, 'Spike', 32.0, 'Pit Bull', 'Cão', 'Preto', 'Macho', '2017-04-14'),
(19, 'Lily', 4.1, 'Maine Coon', 'Gato', 'Malhado', 'Fêmea', '2020-12-30'),
(20, 'Bear', 28.0, 'Rottweiler', 'Cão', 'Marrom', 'Macho', '2018-08-05'),
(20, 'Chloe', 3.9, 'Persa', 'Gato', 'Branco', 'Fêmea', '2021-09-15'),
(21, 'Apollo', 35.0, 'Boxer', 'Cão', 'Preto', 'Macho', '2016-03-22'),
(21, 'Lola', 5.1, 'Bengal', 'Gato', 'Tricolor', 'Fêmea', '2021-05-05'),
(22, 'Bruno', 30.0, 'Labrador', 'Cão', 'Amarelo', 'Macho', '2017-10-10'),
(22, 'Bella', 4.3, 'Ragdoll', 'Gato', 'Cinza', 'Fêmea', '2020-11-01'),
(23, 'Maximus', 27.0, 'Pit Bull', 'Cão', 'Preto', 'Macho', '2018-07-18'),
(23, 'Luna', 6.2, 'Persa', 'Gato', 'Bege', 'Fêmea', '2022-04-09'),
(24, 'Diesel', 29.0, 'Husky', 'Cão', 'Cinza', 'Macho', '2016-05-21'),
(24, 'Ginger', 4.5, 'Maine Coon', 'Gato', 'Malhado', 'Fêmea', '2021-08-14'),
(25, 'Thor', 33.0, 'Golden Retriever', 'Cão', 'Dourado', 'Macho', '2017-12-15'),
(25, 'Misty', 4.4, 'Sphynx', 'Gato', 'Branco', 'Fêmea', '2020-01-19'),
(26, 'Oreo', 22.0, 'Beagle', 'Cão', 'Preto e Branco', 'Macho', '2018-02-20'),
(26, 'Nala', 3.6, 'Siamês', 'Gato', 'Branco', 'Fêmea', '2021-06-16'),
(27, 'Zorro', 28.0, 'Doberman', 'Cão', 'Preto', 'Macho', '2016-09-30'),
(27, 'Cleo', 5.4, 'Siamês', 'Gato', 'Cinza', 'Fêmea', '2022-02-12'),
(28, 'Coco', 34.0, 'Cocker Spaniel', 'Cão', 'Caramelo', 'Macho', '2017-03-05'),
(28, 'Whiskers', 4.7, 'Bengal', 'Gato', 'Malhado', 'Fêmea', '2021-11-04'),
(29, 'Bailey', 31.0, 'Rottweiler', 'Cão', 'Preto', 'Macho', '2018-08-18'),
(29, 'Sasha', 5.8, 'Sphynx', 'Gato', 'Branco', 'Fêmea', '2020-07-07'),
(30, 'Rudy', 36.0, 'Labrador', 'Cão', 'Amarelo', 'Macho', '2016-11-11'),
(30, 'Daisy', 3.4, 'Maine Coon', 'Gato', 'Cinza', 'Fêmea', '2021-03-30'),
(31, 'Gizmo', 25.0, 'Beagle', 'Cão', 'Tricolor', 'Macho', '2018-05-14'),
(31, 'Mochi', 4.0, 'Ragdoll', 'Gato', 'Bege', 'Fêmea', '2022-06-19'),
(32, 'Simba', 29.0, 'Pit Bull', 'Cão', 'Preto', 'Macho', '2017-10-22'),
(32, 'Lola', 5.9, 'Siamês', 'Gato', 'Branco', 'Fêmea', '2021-01-15'),
(33, 'Rex', 28.0, 'Husky', 'Cão', 'Cinza', 'Macho', '2016-02-28'),
(33, 'Cleo', 3.5, 'Persa', 'Gato', 'Cinza', 'Fêmea', '2020-12-10'),
(34, 'Ziggy', 32.0, 'Golden Retriever', 'Cão', 'Dourado', 'Macho', '2018-09-08'),
(34, 'Chloe', 5.2, 'Sphynx', 'Gato', 'Branco', 'Fêmea', '2021-07-22'),
(35, 'Max', 30.0, 'Boxer', 'Cão', 'Preto', 'Macho', '2017-06-18'),
(35, 'Sophie', 4.8, 'Maine Coon', 'Gato', 'Malhado', 'Fêmea', '2021-04-05');

INSERT INTO Consulta (id_vet, id_animal, dt, horario, id_tutor) VALUES
(1, 1, '2024-05-01', '14:00', 1),
(1, 2, '2024-05-02', '15:00', 2),
(2, 3, '2024-05-03', '09:00', 3),
(2, 4, '2024-05-04', '10:00', 4),
(3, 5, '2024-05-05', '11:00', 5),
(3, 6, '2024-05-06', '16:00', 6),
(4, 7, '2024-05-07', '17:00', 7),
(4, 8, '2024-05-08', '18:00', 8),
(5, 9, '2024-05-09', '19:00', 9),
(5, 10, '2024-05-10', '20:00', 10),
(6, 11, '2024-05-11', '08:00', 11),
(6, 12, '2024-05-12', '14:00', 12),
(7, 13, '2024-05-13', '15:00', 13),
(7, 14, '2024-05-14', '09:00', 14),
(8, 15, '2024-05-15', '10:00', 15),
(8, 16, '2024-05-16', '11:00', 16),
(9, 17, '2024-05-17', '16:00', 17),
(9, 18, '2024-05-18', '17:00', 18),
(10, 19, '2024-05-19', '18:00', 19),
(10, 20, '2024-05-20', '19:00', 20),
(11, 21, '2024-05-21', '08:00', 21),
(11, 22, '2024-05-22', '14:00', 22),
(12, 23, '2024-05-23', '15:00', 23),
(12, 24, '2024-05-24', '09:00', 24),
(13, 25, '2024-05-25', '10:00', 25),
(13, 26, '2024-05-26', '11:00', 26),
(14, 27, '2024-05-27', '16:00', 27),
(14, 28, '2024-05-28', '17:00', 28),
(15, 29, '2024-05-29', '18:00', 29),
(15, 30, '2024-05-30', '19:00', 30),
(16, 31, '2024-06-01', '08:00', 31),
(16, 32, '2024-06-02', '14:00', 32),
(17, 33, '2024-06-03', '15:00', 33),
(17, 34, '2024-06-04', '09:00', 34),
(18, 35, '2024-06-05', '10:00', 35),
(18, 36, '2024-06-06', '11:00', 36),
(19, 37, '2024-06-07', '16:00', 37),
(19, 38, '2024-06-08', '17:00', 38),
(20, 39, '2024-06-09', '18:00', 39),
(20, 40, '2024-06-10', '19:00', 40),
(21, 41, '2024-06-11', '08:00', 41),
(21, 42, '2024-06-12', '14:00', 42),
(22, 43, '2024-06-13', '15:00', 43),
(22, 44, '2024-06-14', '09:00', 44),
(23, 45, '2024-06-15', '10:00', 45),
(23, 46, '2024-06-16', '11:00', 46),
(24, 47, '2024-06-17', '16:00', 47),
(24, 48, '2024-06-18', '17:00', 48),
(25, 49, '2024-06-19', '18:00', 1),
(25, 50, '2024-06-20', '19:00', 2),
(26, 51, '2024-06-21', '08:00', 3),
(26, 52, '2024-06-22', '14:00', 4),
(27, 53, '2024-06-23', '15:00', 5),
(27, 54, '2024-06-24', '09:00', 6),
(28, 55, '2024-06-25', '10:00', 7),
(28, 56, '2024-06-26', '11:00', 8),
(29, 57, '2024-06-27', '16:00', 9),
(29, 58, '2024-06-28', '17:00', 10),
(30, 59, '2024-06-29', '18:00', 11),
(30, 60, '2024-06-30', '19:00', 12),
(1, 61, '2024-07-01', '08:00', 13),
(1, 62, '2024-07-02', '14:00', 14),
(2, 63, '2024-07-03', '15:00', 15),
(2, 64, '2024-07-04', '09:00', 16),
(3, 65, '2024-07-05', '10:00', 17),
(3, 66, '2024-07-06', '11:00', 18),
(4, 67, '2024-07-07', '16:00', 19),
(4, 68, '2024-07-08', '17:00', 20),
(5, 69, '2024-07-09', '18:00', 21),
(5, 70, '2024-07-10', '19:00', 22),
(6, 71, '2024-07-11', '08:00', 23),
(6, 72, '2024-07-12', '14:00', 24),
(7, 73, '2024-07-13', '15:00', 25),
(7, 74, '2024-07-14', '09:00', 26),
(8, 75, '2024-07-15', '10:00', 27),
(8, 76, '2024-07-16', '11:00', 28),
(9, 77, '2024-07-17', '16:00', 29),
(9, 78, '2024-07-18', '17:00', 30),
(10, 79, '2024-07-19', '18:00', 31),
(10, 80, '2024-07-20', '19:00', 32),
(11, 81, '2024-07-21', '08:00', 33),
(11, 82, '2024-07-22', '14:00', 34),
(12, 83, '2024-07-23', '15:00', 35),
(12, 84, '2024-07-24', '09:00', 36),
(13, 85, '2024-07-25', '10:00', 37),
(13, 86, '2024-07-26', '11:00', 38),
(14, 87, '2024-07-27', '16:00', 39),
(14, 88, '2024-07-28', '17:00', 40),
(15, 89, '2024-07-29', '18:00', 41),
(15, 90, '2024-07-30', '19:00', 42),
(16, 91, '2024-07-31', '08:00', 43),
(16, 92, '2024-08-01', '14:00', 44),
(17, 93, '2024-08-02', '15:00', 45),
(17, 94, '2024-08-03', '09:00', 46),
(18, 95, '2024-08-04', '10:00', 47),
(18, 96, '2024-08-05', '11:00', 48),
(19, 97, '2024-08-06', '16:00', 1),
(19, 98, '2024-08-07', '17:00', 2),
(20, 99, '2024-08-08', '18:00', 3),
(20, 100, '2024-08-09', '19:00', 4);
