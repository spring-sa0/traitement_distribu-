#!/bin/bash

# Start Secondary NameNode
hdfs --daemon start secondarynamenode

tail -f $HADOOP_HOME/logs/*.log