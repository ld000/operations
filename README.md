# operations

监控工具

# depends

docker

docker-compose

grafana

mysqld_exporter
> https://github.com/prometheus/mysqld_exporter

node_exporter
> https://github.com/prometheus/node_exporter

# Setup instructions

##

```bash
chmod +x mysqld_exporter
chmod +x node_exporter
```

## up docker-compose

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
export DATA_SOURCE_NAME='login:password@(hostname:port)/'

./mysqld_exporter -collect.binlog_size=true -collect.info_schema.processlist=true
```

## node_exporter

```bash
./node_exporter -collectors.enabled="diskstats,filefd,filesystem,loadavg,meminfo,netdev,stat,time,uname,vmstat"
```

## Add datasource in Grafana
![grafana datasource](https://github.com/percona/grafana-dashboards/blob/master/assets/datasource.png)

## telegraf

```bash
# ubuntu
cd /tmp
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.3.2-1_amd64.deb
sudo dpkg -i telegraf_1.3.2-1_amd64.deb
```

`/etc/telegraf/telegraf.conf`

```
service telegraf start|stop|restart|status
```
