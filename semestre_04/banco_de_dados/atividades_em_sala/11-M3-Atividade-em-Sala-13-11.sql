-- ATIVIDADE EM SALA 13/11/2024 – CONTROLE DE ACESSO DISCRICIONÁRIO
	-- Este exercício tem como objetivo a criação de usuários no MySQL, além de
	-- gerenciar seus privilégios de acesso e controle sobre objetos específicos no banco
	-- de dados.
-- A. Crie três usuários no banco de dados, com as respectivas senhas:
	-- Usuários: usuario_leitura Pass: 654321
	-- usuario_escrita Pass: 456123
	-- usuario_admin Pass: 123456
	
    -- Criação do usuário 'usuario_leitura' com permissões de leitura (SELECT)
	CREATE USER 'usuario_leitura'@'localhost' IDENTIFIED BY '654321';

	-- Criação do usuário 'usuario_escrita' com permissões de leitura e escrita (SELECT, INSERT, UPDATE, DELETE)
	CREATE USER 'usuario_escrita'@'localhost' IDENTIFIED BY '456123';

	-- Criação do usuário 'usuario_admin' com permissões totais (ALL PRIVILEGES)
	CREATE USER 'usuario_admin'@'localhost' IDENTIFIED BY '123456';

	-- Aplica as permissões
	FLUSH PRIVILEGES;

-- B. Execute o script no final deste arquivo para a criação do esquema biblioteca.

-- C. Atribuição de Privilégios:
	-- a. Conceda ao usuario_leitura privilégios de seleção sobre a view Emprestimos_livros.
	GRANT SELECT ON biblioteca2.Emprestimos_livros TO 'usuario_leitura'@'localhost';
    
	-- b. Conceda ao usuario_escrita privilégios de seleção, inserção, atualização e deleção sobre o banco de dados biblioteca.
	GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca2.* TO 'usuario_escrita'@'localhost';
    
    -- c. Conceda ao usuario_admin privilégios completos sobre o banco de dados, criação de usuários e concessão de privilégios.
	GRANT ALL PRIVILEGES ON biblioteca2.* TO 'usuario_admin'@'localhost';
    
-- D. Teste de Privilégios:
	-- a. Crie uma conexão com usuario_leitura e realize as seguintes operações:
		-- i. Crie uma instrução para visualizar a view Emprestimos_livros.
			SELECT * FROM biblioteca2.Emprestimos_livros;

		-- ii. Tente efetuar uma seleção sobre a tabela livros e registre o resultado.
			SELECT * FROM biblioteca2.Livros;
            
	-- b. Crie uma conexão com o usuario_escrita e realize as seguintes operações:
		-- i. Crie uma seleção apresentando os empréstimos sem data de devolução, mostrando os dados do membro e do livro.
			SELECT 
				e.id_emprestimo, 
				e.data_emprestimo, 
				e.data_devolucao, 
				m.nome AS nome_membro, 
				m.email, 
				l.titulo AS titulo_livro, 
				l.autor
			FROM 
				biblioteca2.Emprestimos e
			JOIN 
				biblioteca2.Membros m ON e.id_membro = m.id_membro
			JOIN 
				biblioteca2.Livros l ON e.id_livro = l.id_livro
			WHERE 
				e.data_devolucao IS NULL;

		-- ii. Crie uma instrução para atualizar o nome do livro com título “Hamlet” para “Hamlet de Shakespeare”.
			UPDATE biblioteca2.Livros
			SET titulo = 'Hamlet de Shakespeare'
			WHERE titulo = 'Hamlet';
            
		-- iii. Crie uma instrução para deletar um empréstimo qualquer, registre o resultado.
			DELETE FROM biblioteca2.Emprestimos
			WHERE id_emprestimo = 1;

		-- iv. Efetue a inserção de 4 novos livros.
			INSERT INTO biblioteca2.Livros (titulo, autor, ano_publicacao)
			VALUES
				('Jurassic Park - O Parque dos Dinossauros', 'Michael Crichton', 1993),
				('O Mundo Perdido - Jurassic Park', 'Michael Crichton', 1997),
				('Jurassic Park 3', 'Michael Crichton', 2001),
				('Jurassic World: O Mundo dos Dinossauros', 'Michael Crichton', 2015);
                
			SELECT * FROM biblioteca2.Livros;
    
	-- c. Crie uma conexão com o usuário_admin e realize as seguintes operações:
		-- i. Efetue a criação de código para realizar as atividades de seleção, atualização, inserção e remoção nas tabelas do esquema.
			SELECT * FROM biblioteca2.Livros;

			UPDATE biblioteca2.Livros
			SET titulo = 'Novo Título'
			WHERE id_livro = 1;

			INSERT INTO biblioteca2.Livros (titulo, autor, ano_publicacao)
			VALUES ('Livro Exemplo', 'Autor Exemplo', 2024);

			DELETE FROM biblioteca2.Livros
			WHERE id_livro = 13;
        
		-- ii. Efetua a criação de uma tabela Funcionário com os atributos id e nome. Posteriormente adicione 4 funcionários a tabela.
			CREATE TABLE biblioteca2.Funcionarios (
				id INT PRIMARY KEY AUTO_INCREMENT,
				nome VARCHAR(255) NOT NULL
			);

			INSERT INTO biblioteca2.Funcionarios (nome)
			VALUES
				('João Silva'),
				('Maria Oliveira'),
				('Carlos Santos'),
				('Ana Pereira');

		-- iii. Efetue a criação do usuário funcionário. Efetue a conceção dos privilégios de seleção para todas as tabelas do esquema biblioteca para este usuário.
			CREATE USER 'funcionario'@'localhost' IDENTIFIED BY '123';

			GRANT SELECT ON biblioteca2.* TO 'funcionario'@'localhost';

		-- iv. Efetue a deleção do usuario_leitura, posteriormente tente se conectar com este usuário e registre o resultado.
			DROP USER 'usuario_leitura'@'localhost';

		-- v. Remova o privilégio de deleção do usuario_escrita, e teste o efeito desta modificação na conectado a este usuário.
			REVOKE DELETE ON biblioteca2.* FROM 'usuario_escrita'@'localhost';
    
-- E. Conectado ao usuário Root, realize as seguintes operações:
	-- a. Efetue a remoção do usuário criados e da tabela funcionários.
	-- Efetue a postagem do código criado em cada uma das conexões, root,
	-- usuário_leitura, usuário_escrita e usuário_admin. Assim como, mensagens de
	-- erro ou alerta apresentados na realização das operações, nos respectivos
	-- usuários.
    
    DROP USER 'usuario_leitura'@'localhost';
	DROP USER 'usuario_escrita'@'localhost';
	DROP USER 'usuario_admin'@'localhost';
	DROP USER 'funcionario'@'localhost';

    DROP TABLE IF EXISTS biblioteca2.Funcionarios;

	-- ADMIN
	-- Error Code: 1227. Access denied; you need (at least one of) the CREATE USER privilege(s) for this operation
	-- Error Code: 1227. Access denied; you need (at least one of) the CREATE USER privilege(s) for this operation
	-- Error Code: 1044. Access denied for user 'usuario_admin'@'localhost' to database 'biblioteca2'
	
    -- ROOT
    -- Error Code: 1396. Operation DROP USER failed for 'funcionario'@'localhost'

    
-- INICIO DO SCRIPT
CREATE SCHEMA biblioteca2;
USE biblioteca2;
SET SQL_SAFE_UPDATES = 0;
-- Criação da tabela Livros
CREATE TABLE Livros (
 id_livro INT PRIMARY KEY AUTO_INCREMENT,
 titulo VARCHAR(255) NOT NULL,
 autor VARCHAR(255) NOT NULL,
 ano_publicacao INT,
 disponivel BOOLEAN DEFAULT true
);
-- Criação da tabela Membros
CREATE TABLE Membros (
 id_membro INT PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(255) NOT NULL,
 email VARCHAR(255) NOT NULL UNIQUE,
 data_cadastro DATE NOT NULL
);
-- Criação da tabela Empréstimos
CREATE TABLE Emprestimos (
 id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
 id_livro INT NOT NULL,
 id_membro INT NOT NULL,
 data_emprestimo DATE NOT NULL,
 data_devolucao DATE,
 FOREIGN KEY (id_livro) REFERENCES Livros(id_livro) ON DELETE CASCADE,
 FOREIGN KEY (id_membro) REFERENCES Membros(id_membro) ON DELETE
CASCADE);
-- DADOS PARA TESTES
-- Inserção de dados na tabela Livros
INSERT INTO Livros (titulo, autor, ano_publicacao) VALUES
('Dom Quixote', 'Miguel de Cervantes', 1605),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943),
('Hamlet', 'William Shakespeare', 1603),
('Cem Anos de Solidão', 'Gabriel Garcia Márquez', 1967),
('Orgulho e Preconceito', 'Jane Austen', 1813),
('1984', 'George Orwell', 1949),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954),
('A Divina Comédia', 'Dante Alighieri', 1320);
-- Inserção de dados na tabela Membros
INSERT INTO Membros (nome, email, data_cadastro) VALUES
('Ana Silva', 'ana.silva@example.com', '2022-01-10'),
('Bruno Gomes', 'bruno.gomes@example.com', '2022-02-15'),
('Carlos Eduardo', 'carlos.eduardo@example.com', '2022-03-20'),
('Daniela Rocha', 'daniela.rocha@example.com', '2022-05-05'),
('Eduardo Lima', 'eduardo.lima@example.com', '2022-06-10'),
('Fernanda Martins', 'fernanda.martins@example.com', '2022-07-15'),
('Gustavo Henrique', 'gustavo.henrique@example.com', '2022-08-20'),
('Helena Souza', 'helena.souza@example.com', '2022-09-25');
-- Inserção de dados na tabela Empréstimos
INSERT INTO Emprestimos (id_livro, id_membro, data_emprestimo,
data_devolucao) VALUES
(1, 1, '2022-04-01', NULL),
(2, 2, '2022-04-03', '2022-04-10'),
(3, 3, '2022-04-05', NULL),
(4, 4, '2022-10-01', NULL),
(5, 5, '2022-10-03', '2022-10-17'),
(2, 3, '2022-10-06', NULL),
(1, 2, '2022-10-08', '2022-10-15'),
(3, 1, '2022-10-10', NULL),
(3, 2, '2022-11-01', NULL),
(2, 3, '2022-11-03', NULL),
(1, 4, '2022-11-05', NULL),
(5, 1, '2022-11-07', '2022-11-21'),
(4, 5, '2022-11-09', '2022-11-23'),
(2, 1, '2022-11-12', NULL),
(3, 4, '2022-11-14', '2022-11-28'),
(1, 3, '2022-11-16', NULL),
(5, 2, '2022-11-18', '2022-11-25'),
(4, 1, '2022-11-20', '2022-12-04');
CREATE OR REPLACE VIEW Emprestimos_livros AS
SELECT e.id_emprestimo idEmprestimo, e.data_emprestimo, e.data_devolucao,
m.id_membro as id_membro, m.nome nome_membro, l.id_livro id_livro, l.titulo
FROM emprestimos e
 JOIN membros m ON (e.id_membro = m.id_membro)
 JOIN livros l ON (e.id_livro = l.id_livro);
 
 -- FIM DO SCRIPT