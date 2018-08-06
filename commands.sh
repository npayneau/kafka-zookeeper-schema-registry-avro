#!/bin/bash

if [ "$1" = "create" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm confluentinc/cp-kafka:4.1.2 \
  kafka-topics --create --topic basic --partitions 1 --replication-factor 1 \
  --if-not-exists --zookeeper zookeeper:2181
  
 docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm confluentinc/cp-kafka:4.1.2 \
  kafka-topics --create --topic basicavro --partitions 1 --replication-factor 1 \
  --if-not-exists --zookeeper zookeeper:2181
fi
if [ "$1" = "list" ]; then
  docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm \
  confluentinc/cp-kafka:4.1.2 \
  kafka-topics --describe --topic basic --zookeeper zookeeper:2181
fi

if [ "$1" = "produce" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm \
  confluentinc/cp-kafka:4.1.2 \
  bash -c "seq 42 | kafka-console-producer --request-required-acks 1 \
  --broker-list kafka:9092 --topic basic && echo 'Produced 42 messages.'"
fi

if [ "$1" = "produce-avro" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm -it\
  confluentinc/cp-schema-registry:4.1.2 \
  bash -c "/usr/bin/kafka-avro-console-producer \
  --property schema.registry.url=http://schema-registry:8081 \
  --broker-list kafka:9092 --topic basicavro \
  --property value.schema='{\"type\":\"record\",\"name\":\"myrecord\",\"fields\":[{\"name\":\"city\",\"type\":\"string\"}]}'"
fi

if [ "$1" = "produce-sasl" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm \
  -v `pwd`/config/client.properties:/etc/kafka/client.properties \
  -v `pwd`/certificates:/etc/kafka/secrets \
  confluentinc/cp-kafka:4.1.2 \
  bash -c "seq 42 | kafka-console-producer --request-required-acks 1 \
  --broker-list SASL_SSL://kafka:9093 --topic basic --producer.config /etc/kafka/client.properties && echo 'Produced 42 messages.'"
fi

if [ "$1" = "produce-sasl-avro" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm -it\
  -v `pwd`/config/client.properties:/etc/kafka/client.properties \
  -v `pwd`/certificates:/etc/kafka/secrets \
  confluentinc/cp-schema-registry:4.1.2 \
  bash -c "/usr/bin/kafka-avro-console-producer \
  --property schema.registry.url=http://schema-registry:8081 \
  --broker-list SASL_SSL://kafka:9093 --topic basicavro \
  --producer.config /etc/kafka/client.properties \
  --property value.schema='{\"type\":\"record\",\"name\":\"myrecord\",\"fields\":[{\"name\":\"city\",\"type\":\"string\"}]}'"
fi

if [ "$1" = "consume" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm \
  confluentinc/cp-kafka:4.1.2 \
  kafka-console-consumer --bootstrap-server kafka:9092 --topic basic --from-beginning --max-messages 42
fi

if [ "$1" = "consume-avro" ]; then
docker run \
  --netkafkazookeeperschemaregistryavro_default \
  --rm \
  confluentinc/cp-schema-registry:4.1.2 \
  bash -c "/usr/bin/kafka-avro-console-consumer \
	--property schema.registry.url=http://schema-registry:8081 \
	--bootstrap-server kafka:9092 --topic basicavro --from-beginning"
fi

if [ "$1" = "consume-sasl" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm \
  -v `pwd`/config/client.properties:/etc/kafka/client.properties \
  -v `pwd`/certificates:/etc/kafka/secrets \
  confluentinc/cp-kafka:4.1.2 \
  kafka-console-consumer --bootstrap-server SASL_SSL://kafka:9093 --topic basic --from-beginning --consumer.config /etc/kafka/client.properties
fi

if [ "$1" = "consume-sasl-avro" ]; then
docker run \
  --net=kafkazookeeperschemaregistryavro_default \
  --rm \
  -v `pwd`/config/client.properties:/etc/kafka/client.properties \
  -v `pwd`/certificates:/etc/kafka/secrets \
  confluentinc/cp-schema-registry:4.1.2 \
  bash -c "/usr/bin/kafka-avro-console-consumer \
	--property schema.registry.url=http://schema-registry:8081 \
	--consumer.config /etc/kafka/client.properties \
	--bootstrap-server SASL_SSL://kafka:9093 --topic basicavro --from-beginning"
fi
