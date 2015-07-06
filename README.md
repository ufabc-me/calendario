# Calendário.ufabc.me
:warning: **ainda não funciona** - **Não-oficial** :warning:

>Sistema para gerenciamento de calendários da UFABC desenvolvido como projeto para a disciplina *MC3310 - Banco de Dados*, no segundo quadrimestre de 2015.

> Disponível em [https://calendario.ufabc.me](https://calendario.ufabc.me)

> Author: [Victor Fischer Scattone](https://victor.so) e Paulo Gabriel Massa

> Professor: Márcio Katsumi Oikawa



##Índice
 1. [Introdução](#1Introdução)
 1. [Objetivo](#2Objetivo)
 1. [Tabelas](#3Tabelas)
 1. [Stored Procedures](#4Stored-Procedures)
 1. [Dados da Prograd](#5Dados-da-PROGRAD)
 1. [Servidor](#6Servidor)
 1. [Outros](#7Outros)
 1. [Referências](#8Referências)
 1. [Anotações/Caos](#9Anotações)

##1.Introdução

>Todo quadrimestre são realizadas novas matrículas, porém essa lista é disponibilizada de uma forma pouco prática para os alunos.

> Duas listas, uma de **matrículas deferidas** (que relaciona o RA/Nome do Aluno à string completa do nome da turma), e **turmas_e_salas** (código,nome,dias da semana, horários e professores). Os alunos acabam por ter que relacionar essas duas tabelas manualmente, o que é relativamente trabalhoso e repetitivo.

> Decidimos criar uma ferramenta que permita ao aluno informar apenas o seu RA (registro de aluno) e gerar a sua grade formatada amigavelmente. Para maior comodidade, essa grade poderá ser baixada no formato **.CSV** (compatível com qualquer software de planilhas) ou então **iCal** (para ser importado em agendas como *Google Calendar*, *Apple Calendar*, *Outlook*...)


##2.Objetivo
```
SA - TEO - Banco de Dados A - Mat (Márcio Katsumi Oikawa) - S301-3
Campus - Tipo - Nome Turma - Turno (Professor) - Sala
```

##3.Tabelas
- [3.1](#3.1) <a name='3.1'></a> **alunos**: Onde serão armazenadas as informações únicas de cada aluno.

	| Nome         | Tipo                                                       | Descrição                                                                |
	|:-------------|:-----------------------------------------------------------|:-------------------------------------------------------------------------|
	| **ra**       | `INT` `UNSIGNED` `NOT NULL` `AUTO INCREMENT` `PRIMARY KEY` | **PK** Número de matrícula do aluno (definido pela PROGRAD)              |
	| nome         | `VARCHAR(120)` `NOT NULL`                                  | Nome completo (lista da prograd) - não contém caracteres especiais)      |
	| username     | `VARCHAR(30)`                                              | Parte que vem antes do email `@aluno.ufabc.edu.br`, mesmo login do Tidia |
	| email_valido | `BOOLEAN` `DEFAULT FALSE`                                  | Flag booleana para armazenar a validação por email                       |
	| ano_ingresso | `YEAR`                                                     | Ano de ingresso                                                          |

	####Exemplo:
	| ra       | nome     | username | email_valido | ano_ingresso |
	|:---------|:---------|:---------|:-------------|:-------------|
	| 11111111 | John Doe | j.doe    | 0            | 2014         |

	####Código de criação:
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

	| Nome             | Tipo                                                       | Descrição                                                                       |
	|:-----------------|:-----------------------------------------------------------|:--------------------------------------------------------------------------------|
	| **id**           | `INT` `UNSIGNED` `NOT NULL` `AUTO INCREMENT` `PRIMARY KEY` | **PK** Número único para identificação da disciplina (definido arbitrariamente) |
	| codigo           | `VARCHAR(120)` `NOT NULL`                                  | Código de identificação da disciplina usado pela PROGRAD                        |
	| nome             | `VARCHAR(30)`                                              | Nome completo da disciplina                                                     |
	| apelido          | `BOOLEAN` `DEFAULT FALSE`                                  | Abreviação ou nome comumente usado pelos alunos (FenMec, IEDO, IPE)             |
	| departamento     | `YEAR`                                                     | Departamento responsável por ofertar a disciplina                               |
	| coordenador      | `YEAR`                                                     | Coordenador da disciplina                                                       |
	| pagina_ufabchelp | `YEAR`                                                     | URL correspondente da disciplina no sistema UFABCHelp                           |
	| t                | `YEAR`                                                     | Quantidade de horas para teoria                                                 |
	| p                | `YEAR`                                                     | Quantidade de horas para prática                                                |
	| i                | `YEAR`                                                     | Quantidade de horas para estudo individual                                      |

	####Exemplo:
  | id | codigo  | nome           | apelido | departamento | coordenador | pagina_ufabchelp | t | p | i |
  |----|:--------|:---------------|---------|:------------ |:------------|:-----------------|---|---|---|
  | 1  | mc3310  | Banco de Dados | BD      | CMCC         | ZZZ AAA     | asdad            | 3 | 3 | 3 |

	####Código de criação:

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

- [3.3](#3.3) <a name='3.3'></a> **turmas**: Relaciona todas formadas, por ano/quadrimestre.


	| Nome             | Tipo                                                       | Descrição                                                                  | Foreign Key |
	|:-----------------|:-----------------------------------------------------------|:---------------------------------------------------------------------------|:------------|
	| **id**           | `INT` `UNSIGNED` `NOT NULL` `AUTO INCREMENT` `PRIMARY KEY` | **PK** Número único para identificação da turma (definido arbitrariamente) | |
	| *id_disciplina*  | `VARCHAR(120)` `NOT NULL`                                  | Número de identificação da disciplina.                                     | DISCIPLINAS.id |
	| turma            | `VARCHAR(30)`                                              | Nome completo da disciplina                                                | |
	| periodo          | `BOOLEAN` `DEFAULT FALSE`                                  | Período no qual a maioria das aulas serão realizadas                       | |
	| campus           | `YEAR`                                                     | Unidade onde essa turma terá aulas.                                        | |
	| ano              | `YEAR`                                                     | Ano em que essa matricula será cursada                                     | |
	| quadrimestre     | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |

	####Exemplo:
  | id | id_disciplina | turma | periodo  | campus | ano  | quadrimestre |
  |---:|:--------------|:----- |:---------|:-------|:-----|--------------|
  | 1  | 2014          | A     | Matutino | SA     | 2015 | 2            |

	####Código de criação:

  ```SQL
  CREATE TABLE `turmas` (
  	id INT(500) NOT NULL AUTO_INCREMENT,
    id_disciplina int(4) NOT NULL,
    turma varchar(5) NOT NULL,
    periodo varchar(20) NOT NULL,
    campus INT(1)NOT NULL,
    ano INT(4) NOT NUll,
    quadrimestre INT(1)NOT NULL,
    PRIMARY KEY (id)
  );

  LOAD DATA LOCAL INFILE '/Users/v/Desktop/turmas.csv'
  INTO TABLE turmas
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
  (@dummy,id_disciplina,turma,periodo,campus,ano,quadrimestre);
  ```

- [3.4](#3.4) <a name='3.4'></a> **matriculas**: Relaciona as matrículas por ano-quadrimestre.

	| Nome             | Tipo                                                       | Descrição                                                                  | Foreign Key |
	|:-----------------|:-----------------------------------------------------------|:---------------------------------------------------------------------------|:------------|
	| ra               | `INT` `UNSIGNED` `NOT NULL` `AUTO INCREMENT` `PRIMARY KEY` | **PK** Número único para identificação da turma (definido arbitrariamente) | |
	| *id_turma*       | `VARCHAR(120)` `NOT NULL`                                  | Número de identificação da disciplina.                                     | DISCIPLINAS.id |
	| ano              | `VARCHAR(30)`                                              | Nome completo da disciplina                                                | |
	| quadrimestre     | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |

	####Exemplo:
  | ra       | id_turma | ano  | quadrimestre |
  |----------|:---------|:-----|--------------|
  | 11111111 | 2        | 2015 | 2            |

	####Código de criação:

  ```SQL
  Codiguinho SQL para criação
  ```


  + `ra` - Foreign Key (alunos) número de matrícula do aluno.
  + `id_turma` - Foreign Key (turmas) número de identificação da turma.
  + `ano` - Ano em que essa matricula será cursada.
  + `quadrimestre` - Quadrimestre em que essa matricula será cursada.


- [3.1](#3.1) <a name='3.1'></a> **evento**: Onde serão armazenadas as informações únicas de cada aluno.

	| Nome             | Tipo                                                       | Descrição                                                                  | Foreign Key |
	|:-----------------|:-----------------------------------------------------------|:---------------------------------------------------------------------------|:------------|
	| **id**           | `INT` `UNSIGNED` `NOT NULL` `AUTO INCREMENT` `PRIMARY KEY` | **PK** Número único para identificação da turma (definido arbitrariamente) | |
	| *categoria*      | `VARCHAR(120)` `NOT NULL`                                  | Número de identificação da disciplina.                                     | DISCIPLINAS.id |
	| tipo             | `VARCHAR(30)`                                              | Nome completo da disciplina                                                | |
	| turma            | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| ano              | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
  | quadrimestre     | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| dia              | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
  | semana           | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| hora_inicio      | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
  | hora_termino     | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| dia_inicio       | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| dia_termino      | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
  | all_day          | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| repeticao        | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
	| campus           | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
  | local            | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |
  | responsavel      | `YEAR`                                                     | Quadrimestre em que essa matricula será cursada                            | |

  ####Exemplo:

  | id     | categoria | tipo | turma | ano  | quadrimestre | dia | semana | hora_inicio | hora_termino | all_day | repeticao | campus | local  | responsavel       |
  |--------|-----------|------|:-----:|:----:|:------------:|:---:|:------:|------------:|:-------------|:-------:|:---------:|--------|--------|-------------------|
  | 0      | aula      | Prat | 1     | 2015 |      2       |  1  |   1    |10:00        | 12:00        |  0      | 1         | SA     | S302-2 | Marcio Oikawa     |
  | 2      | aula      | TEO  | 1     | 2015 |      2       |  2  |   2    |10:00        | 12:00        |  0      | 1         | SA     | S501-3 | Marcio Oikawa     |
  | 4      | palestra  | pel  | 0     | 2015 |      2       |  4  |   1    |10:00        | 12:00        |  1      | 1         | SBC    | S402-2 | John "Maddog" Hal |

	####Código de criação:

  ```
  dia = 0-7, dia da semana.
  semana = 0:par;1:ímpar
  repetição (em semanas) = 0:não repete, 1: repete toda semana
  ```

###4.Stored Procedures


###5.Dados da Prograd
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


###8.Servidor


###7.Outros

* [Anotações](anotacoes.md)
* [Configuração do Servidor (Ubuntu 14.04 LTS)](configuracao_servidor.md)
* [Relatório](https://docs.google.com/document/d/1yTcExg9jd4L8NK4ZYPBjoMs3henpSFsJALr9l5_Di2E/pub) (Google Docs)
* [Virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)


###8.Referências
* [RFC2445 - iCalendar](https://www.ietf.org/rfc/rfc2445.txt)
* [Python icalendar library](https://pypi.python.org/pypi/icalendar/3.9.0)
* [Tabula](http://tabula.technology/) (Tabula is a tool for liberating data tables locked inside PDF files)

###9.Anotações
[Int Types](https://dev.mysql.com/doc/refman/5.1/en/integer-types.html)
**lembrar que unsigned armazena o dobro**
 + `TINYINT`:[1 byte] 127 até -128
 + `SMALLINT`:[2 bytes] 32.768 até -32.767
 + `MEDIUMINT`:[3 bytes] 8.388.608 até -8.388.607
 + `INT`:[4 bytes] 2.147.483.648 até -2.147.483.647
 + `BIGINT`:[8 bytes] 9.223.372.036.854.775.808 até -9.223.372.036.854.775.807


 + `ENUM`: Número limitado de strings possíveis
[DATE Types](https://dev.mysql.com/doc/refman/5.0/en/datetime.html)
 + `DATE`: YYYY-MM-DD
 + `TIME`: HH-MM-SS
 + `DATETIME`: YYYY-MM-DD HH-MM-SS
 + `TIMESTAMP`: YYYYMMDDHHMMSS
 + `YEAR`: YYYY

```SQL
create table student(
    -> first_name varchar(30) NOT NULL,
    -> last_name varchar(30) not null,
    -> email varchar(60) null,
    -> street varchar(50) not null,
    -> city varchar(40) not null,
    -> state char(2) not null default "PA",
    -> zip mediumint unsigned not null,
    -> phone varchar(20) not null,
    -> birth_date DATE not null,
    -> sex enum('M','F') NOT null,
    -> date_entered timestamp,
    -> lunch_cost FLOAT null,
    -> student_id int unsigned not null auto_increment primary key);


    create table class(
        -> name varchar(30) not null,
        -> class_id int unsigned not null auto_increment primary key);

      create table test(
          -> date DATE not null,
          -> type enum('t','q') not null,
          -> class_id INT unsigned not null,
          -> test_id INT UNSIGNED NOT Null auto_increment Primary Key);

      create table score (
          -> student_id INT unsigned not null,
          -> event_id int unsigned NOT NULL,
          -> score INT not null,
          -> PRIMARY KEY(event_id,student_id));

      create table absence(
          -> student_id int unsigned not null,
          -> date date not null,
          -> primary key(student_id, date));

```




**[⬆ voltar ao início](#calendárioufabcme)**
