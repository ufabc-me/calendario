### Para configurar a instalação local:

Comandos úteis para tratar as tabelas
```
Eliminar linhas repetidas:
awk '!x[$0]++' turmas_salas.csv >> turmas_salas_sem_duplicacao.csv

Ordenar linhas em ordem alfanumérica
sort -n turmas_salas_sem_duplicacao.csv >> materias_ordenadas.csv

```


MySQL aceita apenas conexões locais, então é necessário iniciar um tunnel ssh (para conectar com o MySQLWorkbench, usar a opção Standard TCP/IP over SSH).
```bash
ssh login@server -L 3306:127.0.0.1:3306
mysql --host=127.0.0.1 --port=3306 -u u_calendario -p

```

Criar virtualenv com python3
```
mkvirtualenv -p python3 sistema_calendario
```
```
workon sistema_calendario
```
```
git clone git@github.com:ufabc-me/calendario.git
cd calendario/sistema_calendario
pip install -r requirements.txt
python wsgi.py
```
Abra o navegador em [127.0.0.1:5000](http://127.0.0.1:5000)


------------------
### anotações

```
CREATE DATABASE sistema_calendario
character set = 'latin1'
collate = 'latin1_swedish_ci';
```

```
USE sistema_calendario;
CREATE USER 'calendariouser'@'localhost' IDENTIFIED BY  '**********';
GRANT ALL ON sistema_calendario.* TO 'calendariouser'@'localhost';
```
