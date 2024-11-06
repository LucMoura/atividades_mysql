create database db_rh_at09;

use db_rh_at09;

CREATE TABLE tb_funcionario (
	id_funcionario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	matricula INT NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	dt_nascimento DATE NOT NULL,
	salario NUMERIC(9,2) NOT NULL,
    nome_mae VARCHAR(100) NULL,
	id_setor INT NOT NULL,
	id_cargo INT NOT NULL,
	id_funcionario_chefe INT NULL
	);

CREATE TABLE tb_setor (
	id_setor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	sigla VARCHAR(10) NOT NULL,
	setor VARCHAR(30) NOT NULL
	);

CREATE TABLE tb_cargo (
	id_cargo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	sigla VARCHAR(10) NOT NULL,
	cargo VARCHAR(30) NOT NULL
	);

ALTER TABLE tb_funcionario 
	ADD CONSTRAINT fk_setor FOREIGN KEY (id_setor) 
		REFERENCES tb_setor (id_setor);

ALTER TABLE tb_funcionario 
	ADD CONSTRAINT fk_cargo FOREIGN KEY (id_cargo) 
	    REFERENCES tb_cargo (id_cargo);

ALTER TABLE tb_funcionario 
	ADD CONSTRAINT fk_chefe FOREIGN KEY (id_funcionario_chefe) 
	    REFERENCES tb_funcionario (id_funcionario);

CREATE UNIQUE INDEX uk_funcionario_matricula ON tb_funcionario (matricula);
CREATE UNIQUE INDEX uk_funcionario_cpf ON tb_funcionario (cpf);
CREATE UNIQUE INDEX uk_setor ON tb_setor (sigla);
CREATE UNIQUE INDEX uk_cargo ON tb_cargo (sigla);

INSERT INTO tb_setor (sigla, setor) VALUES ('DENF','Enfermaria');
INSERT INTO tb_setor (sigla, setor) VALUES ('DADM','Administração');
INSERT INTO tb_setor (sigla, setor) VALUES ('DINF','Informática');
INSERT INTO tb_setor (sigla, setor) VALUES ('DENG','Engenharia');
INSERT INTO tb_setor (sigla, setor) VALUES ('DJUR','Jurídico');
INSERT INTO tb_setor (sigla, setor) VALUES ('DLOG','Logística');
INSERT INTO tb_setor (sigla, setor) VALUES ('DPRE','Presidência');

SELECT * FROM tb_setor;

INSERT INTO tb_cargo (sigla, cargo) VALUES ('ENF','Enfermeiro(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ADM','Administrador(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ANA','Analista');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ENG','Engenheiro(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('ADV','Advogado(a)');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('GER','Gerente');
INSERT INTO tb_cargo (sigla, cargo) VALUES ('EXE','Executivo(a)');

SELECT * FROM tb_cargo;

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (1, 'Ana Clara', '11111111111', '1977-07-05', 5, 1, 3000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (2, 'Patrícia Azevedo','22222222222', '1944-07-04', 1, 1, 4000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (3, 'José Maria',      '33333333333','1971-05-10', 3, 1, 6000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (4, 'Sônia Abrantes',  '44444444444','1979-05-29', 4, 1, 7000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (5, 'Valdir Reinaldo', '55555555555','1960-09-22', 2, 2, 16000, null);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (7, 'José Alberto',    '77777777777','1955-01-13', 2, 2, 15000, NULL);

SELECT * FROM tb_funcionario;

UPDATE tb_funcionario SET id_funcionario_chefe = 5 
WHERE MATRICULA NOT IN (5,8);

INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (8, 'Jorge Duboc',    '88888888888','1967-01-10', 2, 2, 20000, NULL);

UPDATE tb_funcionario SET id_funcionario_chefe = (select F.id_funcionario from (SELECT * FROM tb_funcionario) AS F where F.matricula = 8)
WHERE matricula = 5;

SELECT F.id_funcionario, F.matricula, F.nome, F.SALARIO, C.cargo, S.setor, FC.nome AS CHEFE FROM tb_funcionario F
	INNER JOIN tb_cargo C
		ON C.id_cargo = f.id_cargo
	INNER JOIN tb_setor S
		ON S.id_setor = F.id_setor
	LEFT JOIN tb_funcionario FC
		ON FC.id_funcionario = F.id_funcionario_chefe;
        
#Questão 1
select * from tb_funcionario
order by nome desc;

#Questão 2
select * from tb_funcionario
limit 2;

#Questão 3
select * from tb_funcionario
where nome like '%an%';

#Questão 4
select matricula as Código, nome
from tb_funcionario
limit 3;

#Questão 5	
select distinct id_cargo
from tb_funcionario; 

#Questão 6
select concat('Matricula =', matricula, ' nome = ', nome) as detalhes_funcionario
from tb_funcionario;

#Questão 7
select * from tb_setor
order by setor desc;

#Questão 8
select * from tb_setor
where setor like '%aria%';

#Questão 9
select * from tb_setor
where setor like 'e';

#Questão 10
SELECT s.setor, f.salario
FROM tb_setor s
JOIN tb_funcionario f ON s.id_setor = f.id_setor
ORDER BY f.salario DESC
LIMIT 1;

#Questão 11
select *
from tb_funcionario
where id_setor <> 1 or salario > 5000.00
order by nome asc;

#Questão 12
select f.*
from tb_funcionario f
join tb_setor s ON f.idSetor = s.id_setor
where s.nome_setor = 'Administração' and f.salario >= 16000.00
order by f.nome desc;

#Questão 13
select nome, salario, (salario * 1.2) as salario_aumentado
from tb_funcionario
order by salario_aumentado desc;

#Questão 14
select f.*
from tb_funcionario f
join tb_setor s ON f.id_setor = s.id_setor
order by salario
limit 1;

select * from tb_funcionario;
select * from tb_setor;
select * from tb_cargo;


#Questão 15
select f.matricula, f.nome, f.salario, c.cargo, s.nome_setor
from tb_funcionario f
join tb_cargo c on f.id_cargo = c.id_cargo
join tb_setor s on f.idSetor = s.id_setor
order by s.nome_setor asc, c.nome_cargo asc, f.nome asc;

#Questão 16

SELECT chefe.matricula AS matricula_chefe,
       chefe.nome AS nome_chefe,
       func.nome AS nome_funcionario,
       func.salario,
       cargo.cargo AS cargo_funcionario,
       setor.setor AS setor_funcionario
FROM tb_funcionario func
JOIN tb_funcionario chefe ON func.id_funcionario_chefe = chefe.id_funcionario
JOIN tb_cargo cargo ON func.id_cargo = cargo.id_cargo
JOIN tb_setor setor ON func.id_setor = setor.id_setor
ORDER BY setor.setor, cargo.cargo, func.nome;

#Questão 17/#Questão 18
INSERT INTO tb_funcionario 
(matricula, nome, cpf, dt_nascimento, id_setor, id_cargo, salario, id_funcionario_chefe) 
VALUES (9, 'seu nome', '01010101010', '2000-02-02', 1, 1, 2500.00, 1);
#não era possivel incluir por conta de ja existir um funcionário com o ID = 8
#agr é possível incluir por conta do ID = 9 estar livre

#Questão 19

alter table tb_funcionario
modify column matricula varchar(6) not null;

#Questão 20
alter table tb_funcionario
add column valor_vale_refeicao numeric (9,2) null;

#Questão 21
alter table tb_funcionario
drop column nome_mae;

