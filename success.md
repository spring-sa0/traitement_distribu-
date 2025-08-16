# Documentation des Livrables - Projet : Traitement Distribué (Master 1 UCAO, 2024-2025)

## Contexte
Une entreprise fait face à une augmentation significative de ses projets et de ses données. Le centre de compétence en solutions d'infrastructure doit développer des outils, méthodes et processus pour héberger ces données brutes, qui seront ensuite traitées par un système d'exploration de données. L'environnement sera déployé sur six serveurs Linux interconnectés dans un même réseau.

## Objectifs
1. Déployer un environnement Hadoop et Spark comprenant un nœud master, un secondary-master et trois slaves.
2. Réaliser une analyse exploratoire des données avec Apache Pig.
3. Lire des données depuis MongoDB en utilisant Hadoop.
4. Sélectionner et tester une application dynamique dans cet environnement.
5. Définir et documenter le workflow de l'application.
6. Présenter les étapes du projet via une vidéo.

## Présentation du Projet
### 1. Enregistrement Vidéo
- Enregistrez une vidéo expliquant chaque étape : installation, configuration, exécution des scripts Pig, lecture des données MongoDB, test de l'application dynamique, et visualisation des résultats.
- Fournissez des explications détaillées et justifiez les choix techniques à chaque étape.

### 2. Soumission
- Soumettez les fichiers Docker, scripts Pig, scripts de configuration, et le code de l'application dynamique.
- Incluez également le diagramme du workflow et la vidéo de présentation.

## Livrables

### 1. Dockerfiles et Scripts d'Installation/Configuration
- **Description** : Fichiers Docker et scripts permettant la mise en place d'un environnement isolé et portable avec Hadoop, Spark, Pig et Tez. Inclut la configuration des services pour un cluster multi-nœuds.
- **Contenu** : Dockerfile pour construire l'image, docker-compose.yml pour orchestrer les conteneurs, fichiers de configuration Hadoop/Spark, et scripts de démarrage pour chaque rôle (master, secondary-master, slaves).
- **Objectif** : Assurer une installation reproductible et scalable sur les six serveurs.

### 2. Scripts Pig pour l'Analyse Exploratoire
- **Description** : Scripts permettant d'explorer un dataset (ex. : Bank Marketing de UCI) pour des analyses statistiques et descriptives.
- **Contenu** : Scripts Pig pour charger les données, générer des échantillons, effectuer des groupements (par job, éducation), calculer des agrégations (moyennes, max/min), et filtrer les souscripteurs.
- **Objectif** : Fournir une analyse exploratoire simplifiée et distribuée des données brutes.

### 3. Scripts de Configuration pour Hadoop-MongoDB Connector
- **Description** : Scripts et configurations pour intégrer MongoDB comme source de données avec Hadoop.
- **Contenu** : Instructions pour installer les connecteurs Mongo-Hadoop, configurer les dépendances, et un script Pig exemple pour lire des données depuis MongoDB.
- **Objectif** : Permettre l'ingestion de données NoSQL dans l'écosystème Hadoop pour un traitement distribué.

### 4. Code Source de l'Application Dynamique
- **Description** : Développement d'une application dynamique pour traiter des données en temps réel.
- **Contenu** : Code utilisant Spark Streaming (ex. : comptage de mots en temps réel via un flux socket).
- **Objectif** : Démontrer la capacité de l'environnement à gérer des flux de données dynamiques.

### 5. Diagrammes de Workflow
- **Description** : Représentation visuelle du flux de travail du projet.
- **Contenu** : Diagramme créé avec un outil comme draw.io, illustrant les étapes d'ingestion, traitement et sortie des données.
- **Objectif** : Documenter clairement le processus pour une compréhension facile et une maintenance future.

### 6. Vidéo de Présentation du Projet
- **Description** : Vidéo expliquant les différentes étapes du projet.
- **Contenu** : Démonstrations de l'installation, configuration, exécution des scripts, tests, et visualisation des résultats, avec justifications techniques.
- **Objectif** : Offrir une présentation complète et pédagogique des choix et résultats.

