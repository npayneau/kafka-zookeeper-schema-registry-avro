poc-kafka
# POC Kafka-Zookeeper-SchemaRegistry

Ce POC permet de démarer un kafka avec un zookeeper et un schema registry déjà configurer en SASL_SSL.

# Utilisation

## Récupération du repository

```
git clone https://github.com/npayneau/kafka-zookeeper-schema-registry-avro.git
```

## Exécution du POC

```
docker-compose -f docker-compose.yml up
```
## Intéractions

1. Création des topics

```
sh commands.sh create
```

2. Liste des topics

```
sh commands.sh list
```

3. Producer simple et consomateur simple

ATTENTION NE FONCTIONNE QUE SOUS LA BRANCHE "basic_case_without_sasl_ssl"

```
sh commands.sh produce
sh commands.sh consume
```

4. Producer simple avro et consomateur simple avro

ATTENTION NE FONCTIONNE QUE SOUS LA BRANCHE "basic_case_without_sasl_ssl"

```
sh commands.sh produce-avro
sh commands.sh consume-avro
```

5. Producer et consomateur SASL_SSL

```
sh commands.sh produce-sasl
sh commands.sh consume-sasl
```

6. Producer avro et consomateur avro SASL_SSL

```
sh commands.sh produce-sasl-avro
sh commands.sh consume-sasl-avro
```
