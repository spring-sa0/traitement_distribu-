#!/bin/bash

# Start Hadoop slave daemons
hdfs --daemon start datanode
yarn --daemon start nodemanager

# Start Spark worker (connects to master)
$SPARK_HOME/sbin/start-worker.sh spark://master:7077

tail -f $HADOOP_HOME/logs/*.log