MySQL aceita apenas conexões locais, então é necessário iniciar um tunnel ssh (para conectar com o MySQLWorkbench, usar a opção Standard TCP/IP over SSH).
```bash
ssh login@server -L 3306:127.0.0.1:3306 -N
```

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
