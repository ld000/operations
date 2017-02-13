# operations

监控工具

# depends

docker
docker-compose

mysqld_exporter
> https://github.com/prometheus/mysqld_exporter

node_exporter
> https://github.com/prometheus/node_exporter

# usage

## start prometheus

```bash
docker-compose up
```

## mysqld_exporter

```sql
CREATE USER 'prom'@'%' IDENTIFIED BY 'prom';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'prom'@'%'
  WITH MAX_USER_CONNECTIONS 3;
```

```bash
./mysqld_exporter
```

## node_exporter

```bash
./node_exporter
```
