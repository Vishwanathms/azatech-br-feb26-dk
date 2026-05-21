Assume your Helm chart structure is like this:

```bash
mychart/
├── Chart.yaml
├── values.yaml
├── templates/
```

Example:

* Python app deployment
* Redis deployment/service
* Namespace: `dev`
* Release name: `pyredis`

---

# 1. Create Namespace

```bash
kubectl create namespace dev
```

---

# 2. Validate Helm Chart

## Lint Chart

```bash
helm lint ./mychart
```

## Render Templates

```bash
helm template pyredis ./mychart
```

## Dry Run Deployment

```bash
helm install pyredis ./mychart -n dev --dry-run --debug
```

---

# 3. Deploy Helm Chart

## Basic Install

```bash
helm install pyredis ./mychart -n dev
```

## Install with Custom Values

```bash
helm install pyredis ./mychart -n dev -f values-prod.yaml
```

## Install with Inline Variables

```bash
helm install pyredis ./mychart \
-n dev \
--set image.tag=v1 \
--set replicaCount=2
```

---

# 4. Verify Deployment

## List Helm Releases

```bash
helm list -n dev
```

## Get All Kubernetes Resources

```bash
kubectl get all -n dev
```

## Get Pods

```bash
kubectl get pods -n dev
```

## Watch Pods

```bash
kubectl get pods -n dev -w
```

## Describe Pod

```bash
kubectl describe pod <pod-name> -n dev
```

## Check Logs

### Python App Logs

```bash
kubectl logs -f deployment/python-app -n dev
```

### Redis Logs

```bash
kubectl logs -f deployment/redis -n dev
```

---

# 5. Show Helm Details

## Show Release Status

```bash
helm status pyredis -n dev
```

## Show Values

```bash
helm get values pyredis -n dev
```

## Show Manifest

```bash
helm get manifest pyredis -n dev
```

## Show Hooks

```bash
helm get hooks pyredis -n dev
```

## Show History

```bash
helm history pyredis -n dev
```

---

# 6. Test Connectivity

## Port Forward Python App

```bash
kubectl port-forward svc/python-app 8080:80 -n dev
```

Access:

```bash
http://localhost:8080
```

---

## Redis Connectivity Test

### Open Redis Pod

```bash
kubectl exec -it deployment/redis -n dev -- sh
```

### Run Redis CLI

```bash
redis-cli
```

### Test Redis

```bash
PING
```

Expected:

```bash
PONG
```

---

# 7. Upgrade Helm Release

## Upgrade Using Same Values

```bash
helm upgrade pyredis ./mychart -n dev
```

## Upgrade with New Image

```bash
helm upgrade pyredis ./mychart \
-n dev \
--set image.tag=v2
```

## Upgrade with Values File

```bash
helm upgrade pyredis ./mychart \
-n dev \
-f values-prod.yaml
```

## Dry Run Upgrade

```bash
helm upgrade pyredis ./mychart \
-n dev \
--dry-run --debug
```

---

# 8. Rollout Commands

## Check Rollout Status

```bash
kubectl rollout status deployment/python-app -n dev
```

```bash
kubectl rollout status deployment/redis -n dev
```

---

## Restart Deployment

```bash
kubectl rollout restart deployment/python-app -n dev
```

```bash
kubectl rollout restart deployment/redis -n dev
```

---

## View Rollout History

```bash
kubectl rollout history deployment/python-app -n dev
```

---

## Undo Rollout

```bash
kubectl rollout undo deployment/python-app -n dev
```

---

# 9. Rollback Helm Release

## View Revision History

```bash
helm history pyredis -n dev
```

Example:

```text
REVISION    STATUS
1           deployed
2           deployed
3           failed
```

---

## Rollback to Previous Version

```bash
helm rollback pyredis 2 -n dev
```

---

## Verify Rollback

```bash
helm status pyredis -n dev
```

```bash
kubectl get pods -n dev
```

---

# 10. Uninstall Helm Chart

```bash
helm uninstall pyredis -n dev
```

---

# 11. Cleanup Namespace

```bash
kubectl delete namespace dev
```

---

# 12. Useful Debug Commands

## Find Events

```bash
kubectl get events -n dev --sort-by=.metadata.creationTimestamp
```

## Check YAML Applied

```bash
kubectl get deployment python-app -n dev -o yaml
```

## Shell into Python Pod

```bash
kubectl exec -it deployment/python-app -n dev -- sh
```

---

# 13. Production Recommended Install

```bash
helm upgrade --install pyredis ./mychart \
-n dev \
--create-namespace \
-f values-prod.yaml
```

This command:

* Installs if not present
* Upgrades if present
* Creates namespace automatically
* Uses production values

---

# 14. Helm Dependency Commands (If Redis is dependency)

## Download Dependencies

```bash
helm dependency update ./mychart
```

## Build Dependencies

```bash
helm dependency build ./mychart
```

---

# 15. Common Troubleshooting

## Pending Pods

```bash
kubectl describe pod <pod>
```

## CrashLoopBackOff

```bash
kubectl logs <pod> -n dev --previous
```

## Image Pull Errors

```bash
kubectl describe pod <pod> -n dev
```

## Validate Rendered YAML

```bash
helm template pyredis ./mychart > output.yaml
```

Validate:

```bash
kubectl apply --dry-run=client -f output.yaml
```
