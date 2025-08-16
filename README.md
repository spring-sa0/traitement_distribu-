# Projet : Traitement Distribué - Environnement Big Data avec Hadoop et Spark

## Contexte
Une entreprise fait face à une explosion de ses données due à l'augmentation de ses projets. En tant que consultant, j'ai été chargé de créer et gérer un environnement Big Data pour héberger et traiter ces données. L'entreprise dispose de six serveurs Linux connectés au même réseau. Le projet utilise Docker pour l'isolation et la portabilité.

## Objectifs
1. Mettre en place un environnement Hadoop et Spark : 1 nœud master, 1 secondary-master et 3 slaves.
2. Effectuer une analyse exploratoire des données avec Apache Pig.
3. Lire des données depuis MongoDB avec Hadoop.
4. Choisir et tester une application dynamique dans cet environnement.
5. Définir et documenter le workflow de l'application.
6. Présenter et expliquer les étapes via une vidéo.

## Architecture du Répertoire
```
project_root/
├── Dockerfile
├── docker-compose.yml
├── config/
│   ├── hadoop/
│   │   ├── core-site.xml
│   │   ├── hdfs-site.xml
│   │   ├── yarn-site.xml
│   │   ├── mapred-site.xml
│   │   ├── tez-site.xml  # Ajouté pour compatibilité Pig avec Hadoop 3
│   │   ├── workers
│   │   └── masters
│   └── spark/
│       ├── spark-env.sh
│       └── workers
├── scripts/
│   ├── start-master.sh
│   ├── start-secondary.sh
│   └── start-slave.sh
├── pig-scripts/
│   ├── load_and_describe.pig
│   └── exploratory_analysis.pig
├── mongodb-connector/
│   ├── mongo-hadoop-connector-setup.sh  # Script de configuration
│   └── read_from_mongo.pig  # Exemple de script Pig pour lire depuis MongoDB
├── app-dynamique/
│   ├── spark-streaming-app.py  # Code source de l'application dynamique (ex. : Spark Streaming)
│   
└── data/
    └── bank-full.csv  # Dataset exemple pour l'analyse Pig (téléchargé depuis UCI)
```

## Instructions d'Installation et de Configuration
1. **Construire l'image Docker** : Exécutez `docker build -t hadoop-spark-cluster .` pour créer l'image avec Hadoop 3.3.6, Spark 3.4.1, Pig 0.17.0 et Tez 0.10.3.
2. **Démarrer le cluster** : Utilisez `docker-compose up -d`. Formatez le NameNode une fois : `docker exec -it master hdfs namenode -format`.
3. **Vérification** :
   - HDFS UI : http://localhost:9870
   - YARN UI : http://localhost:8088
   - Spark Master UI : http://localhost:8080
4. **Pour un déploiement multi-serveurs** : Utilisez Docker Swarm. Initialisez sur un serveur (`docker swarm init`), joignez les autres, puis déployez avec `docker stack deploy -c docker-compose.yml hadoopstack`.

## Livrables

### 1. Dockerfiles et scripts d'installation/configuration
- **Dockerfile** : Définit l'image de base avec Ubuntu 22.04, Java 11, Hadoop, Spark, Pig et Tez. Inclut la configuration SSH pour un accès sans mot de passe.
- **docker-compose.yml** : Définit les services pour master, secondary-master et 3 slaves, avec volumes pour la persistance des données et montage des configs/scripts.
- **Dossier config/hadoop/** : Fichiers XML pour core-site, hdfs-site, yarn-site, mapred-site, tez-site ; workers et masters pour les nœuds.
- **Dossier config/spark/** : spark-env.sh et workers pour la configuration Spark.
- **Dossier scripts/** : start-master.sh (démarre NameNode, ResourceManager, Spark Master), start-secondary.sh (Secondary NameNode), start-slave.sh (DataNode, NodeManager, Spark Worker).

### 2. Scripts Pig pour l'analyse exploratoire
- Dataset utilisé : "Bank Marketing" de UCI (bank-full.csv, 45211 instances, 17 attributs). Chargé sur HDFS via `hdfs dfs -put bank-full.csv /data/bank/`.
- **pig-scripts/load_and_describe.pig** : Charge les données, décrit le schéma, affiche un échantillon et stocke les résultats.
- **pig-scripts/exploratory_analysis.pig** : Analyse avec groupements (comptage par job/éducation), agrégations (âge moyen, balance max/min/avg), filtrage (souscripteurs seulement). Exécutez avec `pig -x tez script.pig`.
- Justification : Pig simplifie l'EDA sur de grands datasets sans coder MapReduce. Résultats stockés dans /output/ sur HDFS.

### 3. Scripts de configuration pour Hadoop-MongoDB Connector
- Ajoutez un service MongoDB à docker-compose.yml :

- **mongodb-connector/mongo-hadoop-connector-setup.sh** : Script pour télécharger et configurer les JARs du connector (mongo-hadoop-core, mongo-java-driver).
- **mongodb-connector/read_from_mongo.pig** : Exemple de script Pig pour lire depuis MongoDB (assumez une collection 'bank_data' dans la DB 'test') :
- Justification : Permet l'intégration de données NoSQL avec Hadoop pour un traitement distribué.

### 4. Code source de l'application dynamique
- Choix : Une application Spark Streaming pour l'ingestion dynamique de données (ex. : flux Kafka ou socket pour simuler des données en temps réel).
- **app-dynamique/spark-streaming-app.py** : Code Python utilisant PySpark pour traiter un flux de données (ex. : compter les mots en temps réel).
- Test : Exécutez avec `spark-submit spark-streaming-app.py`. Envoyez des données via `nc -lk 9999`.
- Justification : Démonstre une application dynamique pour l'ingestion et le traitement en temps réel, alignée sur les besoins de l'entreprise.