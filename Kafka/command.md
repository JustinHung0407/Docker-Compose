helm repo add strimzi https://strimzi.io/charts/

helm search repo strimzi/ --versions

helm install kafka strimzi/strimzi-kafka-operator --version 0.21.1 -f values.yaml -n kafka

k apply -f deploy/kafka-cluster-cr.yaml


quay.io/strimzi/kafka:0.21.1-kafka-2.7.0

# Producer
```
kubectl run kafka-producer -ti --image=quay.io/strimzi/kafka:0.21.1-kafka-2.7.0 --rm=true --restart=Never -n kafka -- bin/kafka-console-producer.sh --broker-list kafka-cluster-kafka-bootstrap:9092 --topic my-topic 
```

# Consumer
```
kubectl run kafka-consumer -ti --image=quay.io/strimzi/kafka:0.21.1-kafka-2.7.0 --rm=true --restart=Never -n kafka -- bin/kafka-console-consumer.sh --bootstrap-server kafka-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning
```