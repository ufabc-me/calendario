# Calendário.ufabc.me
Sistema para gerenciamento de calendários - ainda não funciona

* [Anotações](anotacoes.md)
* [Configuração do Servidor (Ubuntu 14.04 LTS)](configuracao_servidor.md)
* [Relatório](https://docs.google.com/document/d/1yTcExg9jd4L8NK4ZYPBjoMs3henpSFsJALr9l5_Di2E/pub) (Google Docs)
*  [Virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)


```
SA - TEO - Banco de Dados A - Mat (Márcio Katsumi Oikawa) - S301-3
```

##Tables

###aluno (preencher a partir dos pdfs):

| RA       | nome        |   username | email_valido | ano_ingresso |
|:---------|:------------|:-----------|:-------------|:-------------|
| 11111111 | A Sobrenome | a.sobrn    | 0            | 2014         |


###Matrículas:
| RA  | id_turma |
|-----|----------|
|11100| 1        |


###disciplina:

| cod_disciplina | nome           | t | p | i | departamento | coordenador |
|:---------------|:---------------|---|---|---|:------------ |:------------|
|  mc3310        | Banco de Dados | 3 | 3 | 3 | CMCC         | ZZZ AAA     |



###turma:

| id_turma  | ano  | quadrimestre | Campus | cod_disciplina | turma | Periodo |
|----------:|:-----|:------------ |:------ |:---------------|:------|---------|
|         1 | 2014 | 2            | SA     |  mc3310        | A1    | Mat     |





###evento:



| id | categoria | tipo | turma | ano | quadrimestre | dia | semana | hora_inicio | hora_termino | all_day | repeticao | campus | responsavel |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0| aula      | Prat | 1     | 2015| 2   | 1  | 1     |10:00        | 12:00        |  0      | 1         | S301-3 | Marcio Oikawa     |
| 2| aula      | TEO  | 1     | 2015| 2   | 2  | 2     |10:00        | 12:00        |  0      | 1         | S501-3 | Marcio Oikawa     |
| 4| palestra  | pel  | 0     | 2015| 2   | 4  | 1     |10:00        | 12:00        |  1      | 1         | S402-2 | John "Maddog" Hal |



####Código para geração
```
CREATE
```




|id| categoria | tipo | Turma | ano | quad| dia| semana| hora_início | hora_término | all_day | repetição | local  | responsável       |
|--|-----------|------|-------|-----|-----|----|-------|-------------|--------------|---------|-----------|--------|-------------------|
| 0| aula      | Prat | 1     | 2015| 2   | 1  | 1     |10:00        | 12:00        |  0      | 1         | S301-3 | Marcio Oikawa     |
| 2| aula      | TEO  | 1     | 2015| 2   | 2  | 2     |10:00        | 12:00        |  0      | 1         | S501-3 | Marcio Oikawa     |
| 4| palestra  | pel  | 0     | 2015| 2   | 4  | 1     |10:00        | 12:00        |  1      | 1         | S402-2 | John "Maddog" Hal |

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
