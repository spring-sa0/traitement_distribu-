wget https://repo1.maven.org/maven2/org/mongodb/mongo-hadoop/mongo-hadoop-core/2.0.2/mongo-hadoop-core-2.0.2.jar
wget https://repo1.maven.org/maven2/org/mongodb/mongo-java-driver/3.12.11/mongo-java-driver-3.12.11.jar
cp *.jar $HADOOP_HOME/share/hadoop/common/lib/
cp *.jar $PIG_HOME/lib/