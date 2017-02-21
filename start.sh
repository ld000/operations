#!/bin/bash

# mysql setting
export DATA_SOURCE_NAME='login:password@(hostname:port)/database'

usage() {
cat <<-EOF
   usage:

    First change DATA_SOURCE_NAME in start.sh.
    Then change prometheus/prometheus.yml line 8 node-exporter, mysqld-exporter to your IP address.

    start     ./start.sh start
    stop      ./start.sh stop

EOF
}

[[ -z "$1" ]] && { usage; }

set -u

which docker-compose &> /dev/null

if [ $? -gt 0 ]; then
  echo "Can not find docker-compose! Please install docker and docker-compose first."
  exit 1
fi

if [ "$(whoami)" != "root" ]; then
  if [ -f `which sudo` ]; then
    sudo $0 "$@"
    exit $?
  else
    usage
  fi
fi

start_func() {
#  ./exporter/mysqld_exporter -collect.binlog_size=true -collect.info_schema.processlist=true &

  ./exporter/node_exporter -collectors.enabled="diskstats,filefd,filesystem,loadavg,meminfo,netdev,stat,time,uname,vmstat" &

  docker-compose up
}

stop_func() {
  node_pid=$(pidof node_exporter)
  mysqld_pid=$(pidof mysqld_exporter)

  if [ -n "$node_pid" ]; then
    echo "stop node_exporter..."
    kill -9 $node_pid
  fi

  if [ -n "$mysqld_pid" ]; then
    echo "stop mysqld_exporter..."
    kill -9 $mysqld_pid
  fi

  echo "stop docker-compose..."
  docker-compose stop
}

if [ "$1" == "start" ]; then
  start_func
elif [ "$1" == "stop" ]; then
  stop_func
else
  usage
fi
