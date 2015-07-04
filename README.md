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

* [Anotações](anotacoes.md)
* [Configuração do Servidor (Ubuntu 14.04 LTS)](configuracao_servidor.md)
* [Relatório](https://docs.google.com/document/d/1yTcExg9jd4L8NK4ZYPBjoMs3henpSFsJALr9l5_Di2E/pub) (Google Docs)
* [Virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)


```
SA - TEO - Banco de Dados A - Mat (Márcio Katsumi Oikawa) - S301-3

Campus - Tipo - Nome Turma - Turno (Professor) - Sala
```

##Tables

###aluno (preencher a partir dos pdfs):

| **RA**   | nome        | username   | email_valido | ano_ingresso |
|:---------|:------------|:-----------|:-------------|:-------------|
| 11111111 | A Sobrenome | a.sobrn    | 0            | 2014         |

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

###Matrículas:
| **RA** | id_turma |
|--------|----------|
|11111111| 1        |

###disciplina:
| **id** | codigo  | nome           | abreviatura | t | p | i | departamento | coordenador |
|--------|:--------|:---------------|-------------|---|---|---|:------------ |:------------|
| 1      | mc3310  | Banco de Dados | BD          | 3 | 3 | 3 | CMCC         | ZZZ AAA     |

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

### Tabelas com os dados extraídos dos PDFs da prograd:
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

### Referências
* [RFC2445 - iCalendar](https://www.ietf.org/rfc/rfc2445.txt)
* [Python icalendar library](https://pypi.python.org/pypi/icalendar/3.9.0)
* [Tabula](http://tabula.technology/) (Tabula is a tool for liberating data tables locked inside PDF files)
