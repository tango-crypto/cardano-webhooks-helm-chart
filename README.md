## Cardano-webhooks Helm chart

## Build docker images

Here we are going to build the Docker image for Cardano-webhooks (https://github.com/tango-crypto/cardano-webhooks)

### Build the Docker image
```bash 
$ cd cardano-api
$ docker build -t javiertc86/cardano-webhooks:latest .
```
### Push the Docker image to the repository
```bash
$ docker push javiertc86/cardano-webhooks:latest
```

The nest step is to install Helm. Helm is a package manager for Kubernetes that simplifies the deployment and management of applications on Kubernetes clusters.

To Install Helm on Mac and Linux follow the instructions below:

**MacOS:**

Install using Homebrew:
```bash
brew install helm
```
**Linux:**

Download the Helm binary:
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```
For more details, refer to the official <a href="https://helm.sh/docs/intro/install/" target="_blank" rel="noopener noreferrer">Helm Installation Guide</a>.

## Secrets encoding
Kubernetes requires secret data to be base64 encoded to ensure that it can handle arbitrary binary data in a text-based format. This encoding ensures data integrity during transport and storage.

```bash
echo -n 'your-secret-value' | base64
```

Example:
```bash
echo -n 'v8hlDV0yMAHHlIurYupj' | base64
# Output: djhoblRWMHlNQUhIbEl1cll1cGo=
```

Create `secrets.yaml`with the encoded values:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: cardano-events-secret
  annotations:
    meta.helm.sh/release-name: cardano-events
    meta.helm.sh/release-namespace: default
  labels:
    app.kubernetes.io/managed-by: Helm
type: Opaque
data:
  DB_USER: XXX
  DB_PWD: XXX
  REDIS_HOST: XXX
  DB_HOST: XXX
  DB_HOST_TESTNET: XXX
  DB_USER_TESTNET: XXX
  DB_PWD_TESTNET: XXX
  SCYLLA_CONTACT_POINTS: XXX
  KAFKA_HOST: XXX
```
To view secrets:   
```bash
$ kubectl get secrets
```
    
To describe secret:
```bash
$ kubectl describe secret
```
    
To view the values of the secret:
``` 
$ kubectl get secret cardano-webhooks-secret -o yaml
```
## Installing Helm Chart

### Install the Helm chart in the default namespace
```bash
git clone https://github.com/tango-crypto/cardano-webhooks-helm-chart.git
$ cd cardano-webhooks-helm-chart
$ helm install cardano-webhooks .
``````

### Uninstall any previous failed release
```bash
$ helm uninstall cardano-webhooks
```

List running pods:
```bash
$ kubectl get pods
NAME                                                  READY   STATUS    RESTARTS   AGE
cardano-webhooks-cardano-webhooks-helm-chart-86b57d59d-m6ngt     1/1     Running   0          9m47s
``````

Get logs:
```bash
$ kubectl logs -f cardano-webhooks-cardano-webhooks-helm-chart-86b57d59d-m6ngt  
```
Should show the following: 
```
[4:06:03 AM] Starting compilation in watch mode...

[4:06:06 AM] Found 0 errors. Watching for file changes.

[Nest] 30  - 07/27/2024, 4:06:07 AM     LOG [NestFactory] Starting Nest application...
[Nest] 30  - 07/27/2024, 4:06:07 AM     LOG [InstanceLoader] ConfigHostModule dependencies initialized +8ms
[Nest] 30  - 07/27/2024, 4:06:07 AM     LOG [InstanceLoader] ConfigModule dependencies initialized +1ms
[Nest] 30  - 07/27/2024, 4:06:07 AM     LOG [InstanceLoader] ConfigModule dependencies initialized +0ms
[Nest] 30  - 07/27/2024, 4:06:07 AM     LOG [InstanceLoader] ClientsModule dependencies initialized +56ms
[Nest] 30  - 07/27/2024, 4:06:07 AM     LOG [InstanceLoader] AppModule dependencies initialized +20ms
[Nest] 30  - 07/27/2024, 4:06:07 AM    WARN [ServerKafka] WARN [undefined] KafkaJS v2.0.0 switched default partitioner. To retain the same partitioning behavior as in previous versions, create the producer with the option "createPartitioner: Partitioners.LegacyPartitioner". See the migration guide at https://kafka.js.org/docs/migration-guide-v2.0.0#producer-new-default-partitioner for details. Silence this warning by setting the environment variable "KAFKAJS_NO_PARTITIONER_WARNING=1" {"timestamp":"2024-07-27T04:06:07.617Z","logger":"kafkajs"}
Redis: connect
Redis: ready
[Nest] 30  - 07/27/2024, 4:06:09 AM     LOG [ServerKafka] INFO [Consumer] Starting {"timestamp":"2024-07-27T04:06:09.537Z","logger":"kafkajs","groupId":"webhook-consumer-server"}
[Nest] 30  - 07/27/2024, 4:06:13 AM     LOG [ServerKafka] INFO [ConsumerGroup] Consumer has joined the group {"timestamp":"2024-07-27T04:06:13.397Z","logger":"kafkajs","groupId":"webhook-consumer-server","memberId":"webhook-server-c380ec92-f2aa-4a7b-bb22-856293e17638","leaderId":"webhook-server-c380ec92-f2aa-4a7b-bb22-856293e17638","isLeader":true,"memberAssignment":{"new_epoch":[0],"new_block":[0],"new_delegation":[0],"new_payment":[0],"new_transaction":[0],"wbh_event":[0]},"groupProtocol":"RoundRobinAssigner","duration":3856}
[Nest] 30  - 07/27/2024, 4:06:13 AM     LOG [NestMicroservice] Nest microservice successfully started +6ms
Process new stream event (payment) --------------------------------------------------
PAYMENT {"transaction":{"hash":"246c1af5fb4bdbbe6a0c72ffabc474b3670723a708848503d2cb98fa799ca2b3","out_sum":1385333536,"fee":453099,"size":3754,"block":{"network":"testnet","hash":"847ddf2ee00aabb27646e4a8e048ffa88e1b25fce16001aea4ffe28087a791e6","epoch_no":157,"slot_no":66276633,"epoch_slot_no":94233,"block_no":2512471,"previous_block":2512470,"next_block":2512472,"slot_leader":"pool1pmvsu5kmy9nt82qwqugcsku5772sls8r3x99ww5tnzcwjzpvy4n","out_sum":6758790930,"fees":668496,"confirmations":1,"size":5015,"time":"2024-07-26T02:10:33.000Z","tx_count":2,"proto_major":8,"proto_minor":0,"vrf_key":"41f9655d52f4ca4791ad08bbedc61511aa7ba6a620661e7f19da0822cc0a2c6d"}},"inputs":[{"hash":"078dc0c01e5f5f14f0ef6c0770ae1383113d322979e633eead8696530d5be029","index":1},{"hash":"59e900697f2d0dae02d146c724d737f1276042cf214060d3a3ba54c93e678218","index":0}],"outputs":[{"hash":"246c1af5fb4bdbbe6a0c72ffabc474b3670723a708848503d2cb98fa799ca2b3","index":0,"address":"addr_test1wz7uytdxstxe4nhdtl2gj9rcnlyce99tc707mz6qewxyx9qac0urr","value":2000000,"assets":[{"policy_id":"1939392018c01f9b0e77e192382092bdb1581a0d4c06e7ebb443f91c","asset_name":"PREPROD_ORACLE","fingerprint":"asset1e4zjqm0z7harlq9aqxc8nks9hw5pkdjw25vlfd","quantity":1,"owner":"addr_test1wz7uytdxstxe4nhdtl2gj9rcnlyce99tc707mz6qewxyx9qac0urr","address":"addr_test1wz7uytdxstxe4nhdtl2gj9rcnlyce99tc707mz6qewxyx9qac0urr"}],"datum":{"hash":"6ecc2063fa3fa25858ec7d1379046359e7f7f823adaca5629731f637a061dc9b","value_raw":"d8799fd8799f1a002609cdff1b00000190ee16e038ff","value":{"constructor":0,"fields":[{"constructor":0,"fields":[2492877]},1721981395000]}}},{"hash":"246c1af5fb4bdbbe6a0c72ffabc474b3670723a708848503d2cb98fa799ca2b3","index":1,"address":"addr_test1vrqrt84m05rg34usvj73rryeezu8kkznuwh4jfzmh9lgf5swrdhze","value":1383333536,"assets":[{"policy_id":"2b172b4b0141058c3a5ee855cfa0f52f85808e3d3aba47f5a44cbd5e","asset_name":"iETH","fingerprint":"asset1qmy9h4vyq3k45jxryt9qksutmnkg8ktwk6v3vs","quantity":1,"owner":"addr_test1vrqrt84m05rg34usvj73rryeezu8kkznuwh4jfzmh9lgf5swrdhze","address":"addr_test1vrqrt84m05rg34usvj73rryeezu8kkznuwh4jfzmh9lgf5swrdhze"},{"policy_id":"d088875616229b83868ac5596e77288d8b5c9dffc2f748d8df6332b6","asset_name":"tINDY","fingerprint":"asset16rvrlalvu0aw8q7qz9r438ttfxexklx7vczltr","quantity":9997000000,"owner":"addr_test1vrqrt84m05rg34usvj73rryeezu8kkznuwh4jfzmh9lgf5swrdhze","address":"addr_test1vrqrt84m05rg34usvj73rryeezu8kkznuwh4jfzmh9lgf5swrdhze"}]}]}
```
