# Calendário.ufabc.me

*Sistema para gerenciamento de calendários - ainda não funciona*

Disponível em [https://calendario.ufabc.me](https://calendario.ufabc.me)

##Índice
 1. [Introdução](#introducao)
 1. [Tabelas](#tabelas)
 1. [Dados da Prograd](#dados-da-prograd)
 1. [Servidor](#servidor)
 1. [Outros](#outros)
 1. [Referências](#referências)




```
SA - TEO - Banco de Dados A - Mat (Márcio Katsumi Oikawa) - S301-3

Campus - Tipo - Nome Turma - Turno (Professor) - Sala
```

##Tabelas
- [3.1](#3.1) <a name='3.1'></a> **alunos**: Onde serão armazenadas as informações únicas de cada aluno.
	+ `ra` - Primary Key, número de matrícula do aluno.
	+ `nome` - Nome completo (tão completo quanto estiver na lista da prograd - não contém caracteres especiais).
	+ `username` - Parte que vem antes do email @aluno.ufabc.edu.br, mesmo login do Tidia.
	+ `email_valido` - Flag booleana para armazenar a validação por email.
	+ `ano_ingresso` - Ano de ingresso.

	| RA       | nome     | username | email_valido | ano_ingresso |
	|:---------|:---------|:---------|:-------------|:-------------|
	| 11111111 | John Doe | j.doe    | 0            | 2014         |

	```SQL
	CREATE TABLE `aluno` (
		ra INT(8) NOT NULL,
		nome VARCHAR(100) NOT NULL,
		username VARCHAR(50),
		email_valido boolean default false,
		ano_ingresso INT(4),
	  primary key (ra)
	);

	LOAD DATA LOCAL INFILE 'tabelas_tratadas_para_importacao/alunos.csv'
	INTO TABLE aluno
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;
	```

- [3.2](#3.2) <a name='3.2'></a> **disciplinas**: Relaciona todas as disciplinas ofertáveis pela universidade.
  + `id` - Primary Key, número único para identificação da disciplina (definido arbitrariamente).
  + `codigo` - Código de identificação da disciplina usado pela prograd.
  + `nome` - Nome completo da disciplina.
  + `apelido` - Abreviação ou nome comumente usado pelos alunos para se referir à disciplina (Ex. FenMec, para Fenômenos Mecânicos).
  + `departamento` - Departamento responsável por ofertar a disciplina.
  + `coordenador` - Coordenador da disciplina.
  + `pagina_ufabchelp` - URL correspondente da disciplina no sistema UFABCHelp.
  + `t` - Quantidade de horas para teoria.
  + `p` - Quantidade de horas para prática.
  + `i` - Quantidade de horas para estudo individual.


  | id | codigo  | nome           | apelido | departamento | coordenador | pagina_ufabchelp | t | p | i |
  |----|:--------|:---------------|---------|:------------ |:------------|:-----------------|---|---|---|
  | 1  | mc3310  | Banco de Dados | BD      | CMCC         | ZZZ AAA     | asdad            | 3 | 3 | 3 |

  ```SQL
  CREATE TABLE `disciplina` (
  	id MEDIUMINT NOT NULL AUTO_INCREMENT,
  	codigo varchar(10)NOT NULL,
  	nome varchar(100)NOT NULL,
  	abreviatura varchar(10),
  	departamento varchar(20),
  	coordenador varchar(50),
  	primary key (id)
  );

	LOAD DATA LOCAL INFILE '/Users/v/Desktop/materias_ordenadas.csv'
	INTO TABLE disciplina
	FIELDS TERMINATED BY ','
	ENCLOSED by '"'
	LINES TERMINATED BY '\n'
	(codigo,nome);
	```

- [3.3](#3.3) <a name='3.3'></a> **matriculas**: Relaciona as matrículas por ano-quadrimestre.
  + `ra` - Foreign Key (alunos) número de matrícula do aluno.
  + `id_turma` - Foreign Key (turmas) número de identificação da turma.
  + `ano` - Ano em que essa matricula será cursada.
  + `quadrimestre` - Quadrimestre em que essa matricula será cursada.

	| ra       | id_turma | ano  | quadrimestre |
	|----------|:---------|:-----|--------------|
	| 11111111 | 2        | 2015 | 2            |

	```SQL
	Codiguinho SQL para criação
	```


###Matrículas:
| **RA** | id_turma |
|--------|----------|
|11111111| 1        |



###turma:
| **id** | ano  | quadrimestre | campus | id_disciplina | turma | periodo |
|-------:|:-----|:------------ |:------ |:--------------|:------|---------|
| 1      | 2014 | 2            | SA     |  mc3310       | A1    | Mat     |

```SQL
CREATE TABLE `turmas` (
	id MEDIUMINT NOT NULL AUTO_INCREMENT,
  ano int(4) NOT NUll,
  quadrimestre int(1)NOT NULL,
	campus int(1)NOT NULL,
  id_disciplina int(4),
  turma varchar(5) NOT NULL,
  periodo varchar(20) NOT NULL,
	primary key (id)
);

LOAD DATA LOCAL INFILE '/Users/v/Desktop/turmas.csv'
INTO TABLE turmas
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(ano,quadrimestre,campus,codigo_disciplina,turma,periodo);
```

###evento:
| **id** | categoria | tipo | turma | ano  | quadrimestre | dia | semana | hora_inicio | hora_termino | all_day | repeticao | campus | local  | responsavel       |
|--------|-----------|------|:-----:|:----:|:------------:|:---:|:------:|------------:|:-------------|:-------:|:---------:|--------|--------|-------------------|
| 0      | aula      | Prat | 1     | 2015 |      2       |  1  |   1    |10:00        | 12:00        |  0      | 1         | SA     | S302-2 | Marcio Oikawa     |
| 2      | aula      | TEO  | 1     | 2015 |      2       |  2  |   2    |10:00        | 12:00        |  0      | 1         | SA     | S501-3 | Marcio Oikawa     |
| 4      | palestra  | pel  | 0     | 2015 |      2       |  4  |   1    |10:00        | 12:00        |  1      | 1         | SBC    | S402-2 | John "Maddog" Hal |

dia = 0-7, dia da semana.
semana = 0:par;1:ímpar
repetição (em semanas) = 0:não repete, 1: repete toda semana


### Dados da Prograd
* 2015
  * 2015.2
    * Alunos Ingressantes - Campus SA [[PDF](original_data/2015.2/turmas_ingressantes_sa_2015.2.pdf)] [[CSV](original_data/2015.2/turmas_ingressantes_sa_2015.2.csv)]
    * Alunos Ingressantes - Campus SBC [[PDF](original_data/2015.2/turmas_ingressantes_sbc_2015.2.pdf)] [[CSV](original_data/2015.2/turmas_ingressantes_sbc_2015.2.csv)]
    * Alunos Veteranos - Pós ajuste [[PDF](original_data/2015.2/matriculas_deferidas_pos_ajuste_2015.2.pdf)] [[CSV](original_data/2015.2/matriculas_deferidas_pos_ajuste_2015.2.csv)]
    * Disciplinas, Turmas, Salas, Docentes - Campus SA [[PDF](original_data/2015.2/turmas_salas_docentes_sa_2015.2.pdf)][[CSV](original_data/2015.2/turmas_salas_docentes_sa_2015.2.csv)]
    * Disciplinas, Turmas, Salas, Docentes - Campus SBC [[PDF](original_data/2015.2/turmas_salas_docentes_sbc_2015.2.pdf)][[CSV](original_data/2015.2/turmas_salas_docentes_sbc_2015.2.csv)]
  * 2015.3
    * ???
    * ???
    * ???

### Outros

* [Anotações](anotacoes.md)
* [Configuração do Servidor (Ubuntu 14.04 LTS)](configuracao_servidor.md)
* [Relatório](https://docs.google.com/document/d/1yTcExg9jd4L8NK4ZYPBjoMs3henpSFsJALr9l5_Di2E/pub) (Google Docs)
* [Virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)


### Referências
* [RFC2445 - iCalendar](https://www.ietf.org/rfc/rfc2445.txt)
* [Python icalendar library](https://pypi.python.org/pypi/icalendar/3.9.0)
* [Tabula](http://tabula.technology/) (Tabula is a tool for liberating data tables locked inside PDF files)
