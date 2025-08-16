REGISTER mongo-java-driver-3.12.11.jar;
REGISTER mongo-hadoop-core-2.0.2.jar;

data_from_mongo = LOAD 'mongodb://mongodb:27017/test.bank_data' USING com.mongodb.hadoop.pig.MongoLoader();
DUMP data_from_mongo;
STORE data_from_mongo INTO '/output/mongo_data' USING PigStorage(',');