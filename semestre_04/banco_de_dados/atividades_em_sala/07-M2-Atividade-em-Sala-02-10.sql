/* M2 - Atividade em Sala 03 - Aula 02-10-2024 */
-- Efetue as seguintes atividades:

-- 1. Execute os seguintes scripts da aula 08:
-- AULA08_EsquemaClinicaVet_CriacaoEsquema.sql
-- AULA08_EsquemaClinicaVet_InsercaoDados.sql

-- 2. Efetue a criação de código SQL para os itens abaixo, efetua a crição do código abaixo do respectivo item:

USE clinica_vet;

-- a. Atualize todas as ocorrências de animais com a espécie 'cachorro' para 'canina' e com a espécie 'gato' para 'felina'.
UPDATE animal SET especie = "Canina" WHERE especie = "Cachorro" LIMIT 1000;
UPDATE animal SET especie = "Felina" WHERE especie = "Gato" LIMIT 1000;

-- b. Liste os animais da espécie 'felina', mostrando apenas os campos `nome`, `raca` e `data_nasc`.
SELECT nome, raca, data_nasc FROM animal
	WHERE especie = "Felina";
  
-- c. Liste os animais da espécie 'canina' que possuem peso entre 5 e 10, mostrando apenas os campos `nome`, `peso` e `raca`.
SELECT nome, peso, raca FROM animal
	WHERE especie = "canina" AND peso >= 5 AND peso <= 10 ;
   
-- d. Apresente os endereços dos veterinários que não possuem complemento, mostrando apenas os campos `cep`, `rua`, e `cidade`.
SELECT cep, rua, cidade FROM veterinario_endereco
	WHERE complemento is null ;
    
-- e. Liste os veterinários e seus respectivos endereços, mostrando os campos `nome`, `fone`, `cep`, e `cidade`.
SELECT t.nome, t.fone, a.cep, a.cidade 	
	FROM veterinario t    
	LEFT JOIN veterinario_endereco a ON (t.id = a.id_vet);

-- f. Liste os tutores, seus respectivos endereços e animais, mostrando os campos `nome` do tutor, `cidade`, `cep` e `nome` do animal.
SELECT t.nome AS Tutor, a.cep, a.cidade, c.nome AS Animal
	FROM tutor t    
	JOIN tutor_endereco a ON (t.id = a.id_tutor)
    JOIN animal c on (t.id = c.id_tutor);
   
-- g. Liste as consultas de um determinado mês, mostrando o nome do animal, o nome do veterinário e a data da consulta.
SELECT a.nome, v.nome, c.dt
FROM animal a, veterinario v, consulta c
WHERE dt LIKE '%-05-%';

-- h. Liste os tutores que não possuem animais, mostrando apenas o `nome` e o `cpf` dos tutores.
SELECT t.nome AS Tutor, t.cpf, c.nome AS Animal
FROM tutor t    
LEFT JOIN animal c on (t.id = c.id_tutor)
WHERE t.nome is null
LIMIT 0, 1000;


-- i. Liste os animais que não possuem tutores associados, mostrando todos os seus atributos.
SELECT *
FROM animal
WHERE id_tutor is null;

-- j. Apresente a contagem de animais agrupada por sexo.
	SELECT sexo, COUNT(sexo) FROM Animal GROUP BY sexo;

-- k. Liste as consultas de um determinado veterinário, mostrando o nome do animal, a data e o horário da consulta.
SELECT  v.nome AS Veterinario ,a.nome AS Animal,c.dt, c.horario
FROM consulta c
JOIN animal a on (a.id = c.id_animal)
JOIN veterinario v on (v.id = c.id_vet)
WHERE c.id_vet = 1;

-- l. Apresentar o número de consultas agendadas por veterinário:
SELECT COUNT(id_vet) AS Quantidade_Consultas, v.nome AS Veterinario
FROM consulta c
JOIN veterinario v on (v.id = c.id_vet) 
GROUP BY id_vet;

-- m. Apresente o número de consultas agrupadas pela especialidade.
SELECT COUNT(id_vet) AS Quantidade_Consultas, v.especialidade AS Especialidade
FROM consulta c
JOIN veterinario v on (v.id = c.id_vet) 
GROUP BY id_vet;

-- n. Apresente o animal que tem o maior número de consultas agendadas, mostrando o nome e a quantidade de consultas.
SELECT COUNT(id_animal) AS Quantidade_Consultas, v.nome AS Animal
FROM consulta c
jOIN animal v on (v.id = c.id_animal) 
GROUP BY id_animal;