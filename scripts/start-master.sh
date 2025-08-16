#!/bin/bash

# Format NameNode (run only once, manually before starting cluster)
# hdfs namenode -format

# Start Hadoop daemons
hdfs --daemon start namenode
yarn --daemon start resourcemanager

# Start Spark master
$SPARK_HOME/sbin/start-master.sh

tail -f $HADOOP_HOME/logs/*.log