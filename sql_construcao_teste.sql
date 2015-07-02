use sistema_calendario;

/*CREATE TABLE `aluno` (
	ra INT(8) NOT NULL,
	nome VARCHAR(100) NOT NULL,
	username VARCHAR(50),
	email_valido boolean default false,
	ano_ingresso INT(4),
    primary key (ra)
);*/

/*
LOAD DATA LOCAL INFILE '/Users/v/Desktop/alunos.csv'
INTO TABLE aluno
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/
#Select * from aluno;

/*
LOAD DATA LOCAL INFILE '/Users/v/Desktop/ingressantes_sbc.csv'
INTO TABLE aluno
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/
#Select * from aluno;

/*
LOAD DATA LOCAL INFILE '/Users/v/Desktop/ingressantes_sa.csv'
INTO TABLE aluno
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
*/
#Select * from aluno;

/*
CREATE TABLE `disciplina` (
	id MEDIUMINT NOT NULL AUTO_INCREMENT,
    codigo varchar(10)NOT NULL,
    nome varchar(100)NOT NULL,
	departamento varchar(20),
    coordenador varchar(50),
	primary key (id)
);
*/
/*
LOAD DATA LOCAL INFILE '/Users/v/Desktop/materias_ordenadas.csv'
INTO TABLE disciplina
FIELDS TERMINATED BY ','
ENCLOSED by '"'
LINES TERMINATED BY '\n'
(codigo,nome);
*/
/*
select * from disciplina;
*/

#select nome from disciplina where codigo = 'mc3310';


/*CREATE TABLE `campus`(
	id SMALLINT NOT NULL AUTO_INCREMENT,
	nome varchar(50) NOT NULL,
	abreviacao varchar(10) NOT NULL,
    primary key (id)
)*/

/*
insert into campus values (@dummy,'Santo André','SA');
insert into campus values (@dummy,'São Bernardo do Campo','SBC');
insert into campus values (@dummy,'Santo André - Semi Presencial','SA-SEMI');
select * from campus;
*/





/*
CREATE TABLE `turmas` (
	id MEDIUMINT NOT NULL AUTO_INCREMENT,
    ano int(4) NOT NUll,
    quadrimestre int(1)NOT NULL,
	campus int(1)NOT NULL,
    id_disciplina int(4),
    codigo_disciplina varchar(10) NOT NULL,
    turma varchar(5) NOT NULL,
    periodo varchar(20) NOT NULL,
	primary key (id)
);
*/

/*
select * from turmas;

LOAD DATA LOCAL INFILE '/Users/v/Desktop/turmas.csv'
INTO TABLE turmas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(ano,quadrimestre,campus,codigo_disciplina,turma,periodo);
select * from turmas;
*/

/*
update turmas
set turmas.id_disciplina = disciplina.id
from
turmas
    JOIN turmas on disciplina.codigo=turmas.codigo_disciplina;
*/


UPDATE turmas dest, (SELECT id,codigo FROM turmas LEFT JOIN turmas on disciplina.codigo=turmas.codigo_disciplina) src 
  SET dest.id_disciplina = src.id where dest.codigo_disciplina=src.codigo;


/*

UPDATE
    t
SET
    t.col1 = other_table.col1,
    t.col2 = other_table.col2
FROM
    Table t
INNER JOIN
    OtherTable other_table
ON
    t.id = other_table.id
*/

/*
update turmas, disciplina set turmas.id_disciplina =
(select disciplina.id
from turmas, disciplina
where disciplina.codigo=turma.codigo_disciplina)
where turmas.codigo_disciplina=disciplina.codigo
*/



