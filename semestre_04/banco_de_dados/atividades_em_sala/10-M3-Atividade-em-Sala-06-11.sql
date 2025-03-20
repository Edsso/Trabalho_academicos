-- M3 Atividade em Sala 02

-- EFETUE AS SEGUINTES ATIVIDADES (ESQUEMA E DADOS NO FINAL DO DESTE ARQUIVO)
-- A. Trigger de Atualização de Disponibilidade: Após um empréstimo ser efetivado, 
--	atualizar a disponibilidade do livro para false.

	DELIMITER $$

	-- DROP TRIGGER atualiza_disponibilidade_apos_emprestimo;

	CREATE TRIGGER atualiza_disponibilidade_apos_emprestimo
	AFTER INSERT ON Emprestimos
	FOR EACH ROW
	BEGIN
	  UPDATE Livros
	  SET disponivel = FALSE
	  WHERE id = NEW.id_livro;
	END $$

	DELIMITER ;


-- B. Trigger de Devolução de Livro: Quando um livro é devolvido, 
--    atualizar a disponibilidade do livro para true.

	DELIMITER $$

	CREATE TRIGGER atualiza_disponibilidade_devolucao
	AFTER UPDATE ON Emprestimos
	FOR EACH ROW
	BEGIN
	  IF NEW.data_devolucao IS NOT NULL AND OLD.data_devolucao IS NULL THEN
		UPDATE Livros
		SET disponivel = TRUE
		WHERE id_livro = NEW.id_livro;
	  END IF;
	END $$

	DELIMITER ;


-- C. Trigger de Auditoria de Empréstimos: Criar um trigger que 
-- 	registre em uma tabela de auditoria cada vez que um empréstimo for realizado.
-- 	esta tabela deve armazenar id da auditoria (serial), timestamp, usuário(logado que esta executando a operação), 
--	id_emprestimo, data do emprestimo e ação ("Emprestimo Realizado")

-- Tabela de auditoria para Empréstimos
-- criar 

	CREATE TABLE Auditoria_Emprestimos (
		id_auditoria INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único da auditoria
		timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da operação
		usuario VARCHAR(255),                         -- Nome do usuário que executou a ação
		id_emprestimo INT,                            -- ID do empréstimo
		data_emprestimo DATE,                         -- Data do empréstimo
		acao VARCHAR(255) DEFAULT 'Emprestimo Realizado' -- Ação realizada
	);

	DELIMITER $$

	CREATE TRIGGER auditoria_emprestimo
	AFTER INSERT ON Emprestimos
	FOR EACH ROW
	BEGIN
	  -- Insere um novo registro na tabela de auditoria após o empréstimo ser realizado
	  INSERT INTO Auditoria_Emprestimos (usuario, id_emprestimo, data_emprestimo)
	  VALUES (USER(), NEW.id_emprestimo, NEW.data_emprestimo);
	END $$

	DELIMITER ;


-- D. Trigger de Verificação de Disponibilidade: Antes de um empréstimo ser efetivado, 
--	verificar se o livro está disponível. Caso o livro esteja indisponpível larçar uma exceção
--	com a informação 'O livro % esta indisponível para emprestimo.'

	DELIMITER $$
    
	CREATE TRIGGER VerificarDisponibilidadeAntesEmprestimo
	BEFORE INSERT ON Emprestimos
	FOR EACH ROW
	BEGIN
		DECLARE livro_disponivel BOOLEAN;

		SELECT disponivel INTO livro_disponivel
		FROM Livros
		WHERE id_livro = NEW.id_livro; 

		IF livro_disponivel = FALSE THEN

			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O livro está indisponível para empréstimo.';
		END IF;
	END $$

	DELIMITER ;

-- E. Trigger de Limite de Empréstimos: Impedir que um membro faça mais de 5 empréstimos simultâneos.
--	Deve verificar a quantidade de empréstimos do membro. 
--	Considere empréstimos sem data de devolução como emprestimos em aberto.

	DELIMITER $$

	CREATE TRIGGER LimiteDeEmprestimos
	BEFORE INSERT ON Emprestimos
	FOR EACH ROW
	BEGIN
		DECLARE total_emprestimos INT;

		SELECT COUNT(*) INTO total_emprestimos
		FROM Emprestimos
		WHERE id_membro = NEW.id_membro
		AND data_devolucao IS NULL;

		IF total_emprestimos >= 5 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O membro já possui 5 empréstimos em aberto e não pode realizar mais um empréstimo.';
		END IF;
	END $$

	DELIMITER ;

-- F. Trigger de Atualização de Livros: Sempre que as informações
--	de um livro forem atualizadas, registrar a alteração em uma tabela de histórico.
-- 	Registrando as seguintes informações: id_historico, id_livro, titulo_antigo, autor_antigo,
--	ano_publicacao_antigo e a data de alteração (timestamp).

-- Tabela de histórico de alterações de livros
-- criar

	CREATE TABLE Historico_Livros (
		id_historico INT PRIMARY KEY AUTO_INCREMENT,
		id_livro INT NOT NULL,
		titulo_antigo VARCHAR(255) NOT NULL,
		autor_antigo VARCHAR(255) NOT NULL,
		ano_publicacao_antigo INT,
		data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
	);

	DELIMITER $$

	CREATE TRIGGER AtualizarHistoricoLivro
	AFTER UPDATE ON Livros
	FOR EACH ROW
	BEGIN
		INSERT INTO Historico_Livros (id_livro, titulo_antigo, autor_antigo, ano_publicacao_antigo, data_alteracao)
		VALUES (OLD.id_livro, OLD.titulo, OLD.autor, OLD.ano_publicacao, CURRENT_TIMESTAMP);
	END $$

	DELIMITER ;


-- G. Trigger de Exclusão de Membro: Quando um membro for excluído, 
--	verificar se todos os livros foram devolvidos antes de permitir a exclusão.
--	Caso ainda existam livros com data de devolução em aberto relacionados ao membro,
--	apresentar a mensagem: 'Não é possível excluir o membro %, pois possui empréstimos pendentes.'


	DELIMITER $$

	CREATE TRIGGER VerificarEmpréstimosPendentesAntesDeExcluirMembro
	BEFORE DELETE ON Membros
	FOR EACH ROW
	BEGIN
		DECLARE emprestimos_pendentes INT;

		SELECT COUNT(*) INTO emprestimos_pendentes
		FROM Emprestimos
		WHERE id_membro = OLD.id_membro
		AND data_devolucao IS NULL;

		IF emprestimos_pendentes > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir o membro pois possui empréstimos pendentes.';
		END IF;
	END $$

	DELIMITER ;


-- H. Trigger de Auditoria para Inserção, Atualização e Deleção de Livros: Crie um trigger que registre em uma 
--	tabela de auditoria (AuditoriaLivros) toda vez que um novo livro for inserido, modificado,
-- 	ou deletado, incluindo as seguintes informações: id_audit_livro (serial), current_user,
--	a operação ('I'inserção, 'U' update, e 'D' delete)informações como o título do livro, 
--	autor, e a data e hora da operação.

DELIMITER $$

CREATE TRIGGER AuditoriaLivrosInsert
AFTER INSERT ON Livros
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaLivros (usuario, operacao, titulo, autor, data_hora)
    VALUES (CURRENT_USER(), 'I', NEW.titulo, NEW.autor, CURRENT_TIMESTAMP);
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER AuditoriaLivrosUpdate
AFTER UPDATE ON Livros
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaLivros (usuario, operacao, titulo, autor, data_hora)
    VALUES (CURRENT_USER(), 'U', NEW.titulo, NEW.autor, CURRENT_TIMESTAMP);
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER AuditoriaLivrosDelete
AFTER DELETE ON Livros
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaLivros (usuario, operacao, titulo, autor, data_hora)
    VALUES (CURRENT_USER(), 'D', OLD.titulo, OLD.autor, CURRENT_TIMESTAMP);
END $$

DELIMITER ;


-- I. Trigger para Verificar a Exclusão de Livros: Crie um trigger que previna a exclusão de um livro da tabela 
--	Livros se ele estiver atualmente emprestado.

	DELIMITER $$

	CREATE TRIGGER VerificarEmprestimoAntesDeExcluirLivro
	BEFORE DELETE ON Livros
	FOR EACH ROW
	BEGIN
		DECLARE livro_emprestado INT;

		SELECT COUNT(*) INTO livro_emprestado
		FROM Emprestimos
		WHERE id_livro = OLD.id_livro AND data_devolucao IS NULL;

		IF livro_emprestado > 0 THEN
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Não é possível excluir o livro pois está atualmente emprestado.';
		END IF;
	END $$

	DELIMITER ;


CREATE SCHEMA biblioteca;
USE biblioteca;

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
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro),
    FOREIGN KEY (id_membro) REFERENCES Membros(id_membro)
);

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
INSERT INTO Emprestimos (id_livro, id_membro, data_emprestimo, data_devolucao) VALUES
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