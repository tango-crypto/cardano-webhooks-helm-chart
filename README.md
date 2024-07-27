Cardano events helm chart

### Install the Helm chart in the default namespace
`helm install cardano-webhooks .`

### Uninstall any previous failed release
`helm uninstall cardano-webhooks`

Create `secrets.yaml`with the values
```
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
