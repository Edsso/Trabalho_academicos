-- Com base no esquema clinica_vet:
-- EFETUE A CRIAÇÃO DE FUNÇÕES/PROCEDIMENTOS PARA CADA UM DOS EXERCICIOS ABAIXO:
use clinica_vet;
			
-- EXERCÍCIOS:	

-- 1 Crie uma Stored Procedure que insira um novo registro na tabela Endereco e 
--   retorne o código do endereço inserido.
	DELIMITER //

	CREATE PROCEDURE InserirEnderecoTutor(
		IN p_id_tutor INT,
		IN p_cep VARCHAR(12),
		IN p_rua VARCHAR(100),
		IN p_numero INT,
		IN p_complemento VARCHAR(50),
		IN p_cidade VARCHAR(50),
		IN p_uf CHAR(2),
		OUT p_id_endereco INT
	)
	BEGIN
		INSERT INTO Tutor_endereco (id_tutor, cep, rua, numero, complemento, cidade, uf)
		VALUES (p_id_tutor, p_cep, p_rua, p_numero, p_complemento, p_cidade, p_uf);
		
		SET p_id_endereco = LAST_INSERT_ID();
	END //

	DELIMITER ;
	
    CALL InserirEnderecoTutor(1, '12345-678', 'Rua Exemplo', 123, 'Apto 1', 'Cidade Exemplo', 'SP', @id_endereco);
	SELECT @id_endereco AS id_endereco_inserido;

-- 2 Crie um Stored Procedure que atualize o email de um responsável com base no seu código.

	DELIMITER //

	CREATE PROCEDURE AtualizarEmailTutor(
		IN p_id_tutor INT,
		IN p_novo_email VARCHAR(200)
	)
	BEGIN
		UPDATE Tutor
		SET email = p_novo_email
		WHERE id = p_id_tutor;
	END //

	DELIMITER ;

	CALL AtualizarEmailTutor(1, 'novoemail@example.com');

-- 3 Faça um Stored Procedure para excluir um responsável. 
--	 Excluir seus pets e endereços.

DELIMITER //

CREATE PROCEDURE ExcluirResponsavel(
    IN p_id_tutor INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM Animal WHERE id_tutor = p_id_tutor;

    DELETE FROM Tutor_endereco WHERE id_tutor = p_id_tutor;

    DELETE FROM Tutor WHERE id = p_id_tutor;

    COMMIT;
END //

DELIMITER ;

CALL ExcluirResponsavel(1);


-- 4 Faça um Stored Procedure que liste todas as consultas agendadas para uma data específica.
--   Deve retornar uma tabela com os campos data da consulta, nome do responsavel, 
--   nome do pet, telefone do responsavel e nome do veterinario 

	DELIMITER //

	CREATE PROCEDURE ListarConsultasPorData(
		IN p_data DATE
	)
	BEGIN
		SELECT 
			c.dt AS data_consulta,
			t.nome AS nome_responsavel,
			a.nome AS nome_pet,
			t.fone AS telefone_responsavel,
			v.nome AS nome_veterinario
		FROM 
			Consulta c
		JOIN 
			Animal a ON c.id_animal = a.id
		JOIN 
			Tutor t ON a.id_tutor = t.id
		JOIN 
			Veterinario v ON c.id_vet = v.id
		WHERE 
			c.dt = p_data;
	END //

	DELIMITER ;


	CALL ListarConsultasPorData('2024-05-10');

-- 5 Crie um Stored Procedure que receba os dados do veterinario por parâmetro, armazene na tabela “veterinario” e retorne todos os dados da tabela.

	DELIMITER //

	CREATE PROCEDURE AdicionarVeterinario(
		IN p_nome VARCHAR(100),
		IN p_crmv VARCHAR(20),
		IN p_email VARCHAR(200),
		IN p_fone VARCHAR(16),
		IN p_especialidade VARCHAR(100)
	)
	BEGIN
		INSERT INTO Veterinario (nome, crmv, email, fone, especialidade)
		VALUES (p_nome, p_crmv, p_email, p_fone, p_especialidade);
		
		SELECT * FROM Veterinario;
	END //

	DELIMITER ;

	CALL AdicionarVeterinario('Dr. Ana Silva', '123456', 'ana.silva@example.com', '21988887777', 'Cardiologia');


-- 6 Crie um Stored Procedure para adicionar um novo pet, associando-o a um responsável existente.

	DELIMITER //

	CREATE PROCEDURE AdicionarPet(
		IN p_id_tutor INT,
		IN p_nome VARCHAR(100),
		IN p_peso DECIMAL(5,2),
		IN p_raca VARCHAR(100),
		IN p_especie VARCHAR(100),
		IN p_cor VARCHAR(100),
		IN p_sexo VARCHAR(10),
		IN p_data_nasc DATE
	)
	BEGIN
		INSERT INTO Animal (id_tutor, nome, peso, raca, especie, cor, sexo, data_nasc)
		VALUES (p_id_tutor, p_nome, p_peso, p_raca, p_especie, p_cor, p_sexo, p_data_nasc);
		
		SELECT * FROM Animal WHERE id_tutor = p_id_tutor;
	END //

	DELIMITER ;

	CALL AdicionarPet(1, 'Buddy', 12.5, 'Golden Retriever', 'Cachorro', 'Dourado', 'Macho', '2022-03-15');

-- 7 Escreva um Stored Procedure que conte quantos pets um determinado responsável possui.

	DELIMITER //

	CREATE PROCEDURE ContarPetsPorTutor(
		IN p_id_tutor INT
	)
	BEGIN
		DECLARE pet_count INT;

		SELECT COUNT(*) INTO pet_count
		FROM Animal
		WHERE id_tutor = p_id_tutor;

		SELECT pet_count AS total_pets;
	END //

	DELIMITER ;

	CALL ContarPetsPorTutor(1);

-- 8 Desenvolva um Stored Procedure que retorne todos os veterinários com uma determinada especialidade.

	DELIMITER //

	CREATE PROCEDURE RetornarVeterinariosPorEspecialidade(
		IN p_especialidade VARCHAR(100)
	)
	BEGIN
		SELECT *
		FROM Veterinario
		WHERE especialidade = p_especialidade;
	END //

	DELIMITER ;

	CALL RetornarVeterinariosPorEspecialidade('Cardiologia');

-- 9 Crie um Stored Procedure que atualize o endereço de um veterinário.
	
	DELIMITER //

	CREATE PROCEDURE AtualizarEnderecoVeterinario(
		IN p_id_vet INT,
		IN p_cep VARCHAR(12),
		IN p_rua VARCHAR(100),
		IN p_numero INT,
		IN p_complemento VARCHAR(50),
		IN p_cidade VARCHAR(50),
		IN p_uf CHAR(2)
	)
	BEGIN
		UPDATE Veterinario_endereco
		SET cep = p_cep,
			rua = p_rua,
			numero = p_numero,
			complemento = p_complemento,
			cidade = p_cidade,
			uf = p_uf
		WHERE id_vet = p_id_vet;
	END //

	DELIMITER ;

	CALL AtualizarEnderecoVeterinario(1, '29000000', 'Rua Nova', 123, 'Apto 404', 'Vitória', 'ES');

-- 10 Faça um Stored Procedure que calcule a idade atual de um pet.

	DELIMITER //

	CREATE PROCEDURE CalcularIdadePet(
		IN p_id_pet INT,
		OUT p_idade INT
	)
	BEGIN
		SELECT FLOOR(DATEDIFF(CURDATE(), data_nasc) / 365) INTO p_idade
		FROM Animal
		WHERE id = p_id_pet;
	END //

	DELIMITER ;

	CALL CalcularIdadePet(1, @idade);
	SELECT @idade AS Idade_Pet;

-- 11 Crie um Stored Procedure que retorne todos os endereços em uma cidade específica.

	DELIMITER //

	CREATE PROCEDURE ListarEnderecosPorCidade(
		IN p_cidade VARCHAR(50)
	)
	BEGIN
		SELECT *
		FROM Tutor_endereco
		WHERE cidade = p_cidade;
	END //

	DELIMITER ;

	CALL ListarEnderecosPorCidade('Curitiba');

-- 12 Desenvolva um Stored Procedure que associe um pet existente a um novo responsável.

	DELIMITER //

	CREATE PROCEDURE AssociarPetANovoResponsavel(
		IN p_id_pet INT,
		IN p_id_novo_responsavel INT
	)
	BEGIN
		UPDATE Animal
		SET id_tutor = p_id_novo_responsavel
		WHERE id = p_id_pet;
	END //

	DELIMITER ;

	CALL AssociarPetANovoResponsavel(1, 2);

-- 13 Elabore um Stored Procedure que retorne todas as consultas agendadas de um determinado veterinário.

	DELIMITER //

	CREATE PROCEDURE ListarConsultasPorVeterinario(
		IN p_id_veterinario INT
	)
	BEGIN
		SELECT c.id AS consulta_id, 
			   c.dt AS data, 
			   c.horario AS horario, 
			   a.nome AS nome_pet, 
			   t.nome AS nome_responsavel
		FROM Consulta c
		JOIN Animal a ON c.id_animal = a.id
		JOIN Tutor t ON a.id_tutor = t.id
		WHERE c.id_vet = p_id_veterinario;
	END //

	DELIMITER ;

	CALL ListarConsultasPorVeterinario(1);

-- 14 Crie um Stored Procedure para Buscar Responsável pelo Nome do Pet: Desenvolva uma função que retorne o nome do responsável pelo nome do pet.

	DELIMITER //

	CREATE PROCEDURE BuscarResponsavelPorNomePet(
		IN p_nome_pet VARCHAR(100)
	)
	BEGIN
		SELECT t.nome AS nome_responsavel
		FROM Animal a
		JOIN Tutor t ON a.id_tutor = t.id
		WHERE a.nome = p_nome_pet;
	END //

	DELIMITER ;

	CALL BuscarResponsavelPorNomePet('Rex');

-- 15 Desenvolva um Stored Procedure que recebe o CPF de um responsável e retorna seu nome se ele existir na base de dados; caso contrário, retorna uma mensagem "Responsável não encontrado".

	DELIMITER //

	CREATE PROCEDURE BuscarResponsavelPorCPF(
		IN p_cpf VARCHAR(12)
	)
	BEGIN
		DECLARE v_nome_responsavel VARCHAR(100);

		SELECT nome INTO v_nome_responsavel
		FROM Tutor
		WHERE cpf = p_cpf;

		IF v_nome_responsavel IS NOT NULL THEN
			SELECT v_nome_responsavel AS nome_responsavel;
		ELSE
			SELECT 'Responsável não encontrado' AS mensagem;
		END IF;
	END //

	DELIMITER ;

	CALL BuscarResponsavelPorCPF('12345678901');

-- 16 Crie um Stored Procedure que receba um código de veterinário e retorne o total de consultas realizadas por ele, utilizando um loop WHILE.

	DELIMITER //

	CREATE PROCEDURE ContarConsultasVeterinario(
		IN p_id_veterinario INT
	)
	BEGIN
		DECLARE v_total_consultas INT DEFAULT 0;
		DECLARE v_contador INT DEFAULT 0;

		SELECT COUNT(*) INTO v_total_consultas
		FROM Consulta
		WHERE id_vet = p_id_veterinario;

		WHILE v_contador < v_total_consultas DO
			SET v_contador = v_contador + 1;
		END WHILE;

		SELECT v_total_consultas AS total_consultas;
	END //

	DELIMITER ;

	CALL ContarConsultasVeterinario(1);
