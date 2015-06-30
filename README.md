# Calendário.ufabc.me
Sistema para gerenciamento de calendários - ainda não funciona

* [Anotações](anotacoes.md)
* [Configuração do Servidor (Ubuntu 14.04 LTS)](configuracao_servidor.md)
* [Relatório](https://docs.google.com/document/d/1yTcExg9jd4L8NK4ZYPBjoMs3henpSFsJALr9l5_Di2E/pub) (Google Docs)
*  [Virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)



##Tables

###aluno:

| RA       |   username | email_valido | nome        | ano_ingresso | facebook_id  |
|:---------|:-----------|:-------------|:------------|:-------------|:-------------|
| 11111111 | a.sobrn    | 0            | A Sobrenome | 2014         | asdads       |

###calendario:




###disciplina:

| cod_disciplina | nome           | departamento | coordenador | t | p | i |
|:---------------|:---------------|:------------ |:------------|---|---|---|
|  mc3310        | Banco de Dados | CMCC         | ZZZ AAA     | 3 | 3 | 3 |



###turma:

| id_evento | turma | cod_disciplina | ano  | quadrimestre | ano_ingresso |
|----------:|:------|:---------------|:-----|:------------ |:-------------|
|         1 | A1    |  mc3310       | 2014 | 2            | 2014         |










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
