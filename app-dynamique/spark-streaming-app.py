from pyspark.sql import SparkSession
from pyspark.streaming import StreamingContext

spark = SparkSession.builder.appName("DynamicApp").getOrCreate()
ssc = StreamingContext(spark.sparkContext, 10)  # Batch interval 10s

lines = ssc.socketTextStream("localhost", 9999)  # Simule un flux via nc -lk 9999
words = lines.flatMap(lambda line: line.split(" "))
pairs = words.map(lambda word: (word, 1))
wordCounts = pairs.reduceByKey(lambda x, y: x + y)

wordCounts.pprint()

ssc.start()
ssc.awaitTermination()