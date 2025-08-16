FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    ssh \
    rsync \
    pdsh \
    vim \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Install Hadoop
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz \
    && tar -xzf hadoop-3.3.6.tar.gz \
    && mv hadoop-3.3.6 /opt/hadoop \
    && rm hadoop-3.3.6.tar.gz

ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Install Spark (compatible with Hadoop 3)
RUN wget https://archive.apache.org/dist/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3.tgz \
    && tar -xzf spark-3.4.1-bin-hadoop3.tgz \
    && mv spark-3.4.1-bin-hadoop3 /opt/spark \
    && rm spark-3.4.1-bin-hadoop3.tgz

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Setup SSH for Hadoop (passwordless)
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys

# Install Apache Pig
RUN wget https://archive.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz \
    && tar -xzf pig-0.17.0.tar.gz \
    && mv pig-0.17.0 /opt/pig \
    && rm pig-0.17.0.tar.gz

ENV PIG_HOME=/opt/pig
ENV PATH=$PATH:$PIG_HOME/bin

# Install Apache Tez for Pig compatibility with Hadoop 3
RUN wget https://archive.apache.org/dist/tez/0.10.3/apache-tez-0.10.3-bin.tar.gz \
    && tar -xzf apache-tez-0.10.3-bin.tar.gz \
    && mv apache-tez-0.10.3-bin /opt/tez \
    && rm apache-tez-0.10.3-bin.tar.gz

ENV TEZ_HOME=/opt/tez
ENV TEZ_CONF_DIR=/opt/tez/conf
ENV TEZ_JARS=$TEZ_HOME:$TEZ_HOME/lib/*
ENV HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$TEZ_CONF_DIR:$TEZ_JARS

# Hadoop env tweaks to avoid strict host checking
RUN echo "export HADOOP_SSH_OPTS='-o StrictHostKeyChecking=no'" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

# Create directories for HDFS data (will be mounted as volumes)
RUN mkdir -p /data/hdfs/name /data/hdfs/data /data/hdfs/secondary

# Expose ports (adjust as needed)
EXPOSE 9870 8088 9000 8020 50070 50090 7077 8080

# Default command to keep container running
CMD ["tail", "-f", "/dev/null"]