#!/bin/bash

usage() {
  echo usage
}

[[ -z "$1" ]] && { usage; }

set -u

start_func() {
  export DATA_SOURCE_NAME='login:password@(hostname:port)/'

#  ./exporter/mysqld_exporter -collect.binlog_size=true -collect.info_schema.processlist=true &

  ./exporter/node_exporter -collectors.enabled="diskstats,filefd,filesystem,loadavg,meminfo,netdev,stat,time,uname,vmstat" &

  docker-compose up
}

stop_func() {
  node_pid=$(pidof node_exporter)
  mysqld_pid=$(pidof mysqld_exporter)

  if [ -n "$node_pid" ]; then
    kill -9 $node_pid
  fi

  if [ -n "$mysqld_pid" ]; then
    kill -9 $mysqld_pid
  fi
  docker-compose stop
}

echo $1

if [ "$1" == "art" ]; then
  start_func
elif [ "$1" == "stop" ]; then
  stop_func
else
  usage
fi
