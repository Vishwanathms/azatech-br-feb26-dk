Assume your Helm chart structure is like this:

```bash
py-redis-app/
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
helm lint ./py-redis-app
```

## Render Templates

```bash
helm template pyredis ./py-redis-app
```

## Dry Run Deployment

```bash
helm install pyredis ./py-redis-app  --dry-run --debug
```

---

# 3. Deploy Helm Chart

## Basic Install

```bash
helm install pyredis ./py-redis-app 
```

## Install with Custom Values

```bash
helm install pyredis ./py-redis-app  -f values-prod.yaml
```

## Install with Inline Variables

```bash
helm install pyredis ./py-redis-app \
 \
--set image.tag=v1 \
--set replicaCount=2
```

---

# 4. Verify Deployment

## List Helm Releases

```bash
helm list 
```

## Get All Kubernetes Resources

```bash
kubectl get all 
```

## Get Pods

```bash
kubectl get pods 
```

## Watch Pods

```bash
kubectl get pods  -w
```

## Describe Pod

```bash
kubectl describe pod <pod-name> 
```

## Check Logs

### Python App Logs

```bash
kubectl logs -f deployment/python-app 
```

### Redis Logs

```bash
kubectl logs -f deployment/redis 
```

---

# 5. Show Helm Details

## Show Release Status

```bash
helm status pyredis 
```

## Show Values

```bash
helm get values pyredis 
```

## Show Manifest

```bash
helm get manifest pyredis 
```

## Show Hooks

```bash
helm get hooks pyredis 
```

## Show History

```bash
helm history pyredis 
```

---

# 6. Test Connectivity

## Port Forward Python App

```bash
kubectl port-forward svc/python-app 8080:80 
```

Access:

```bash
http://localhost:8080
```

---

## Redis Connectivity Test

### Open Redis Pod

```bash
kubectl exec -it deployment/redis  -- sh
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
helm upgrade pyredis ./py-redis-app 
```

## Upgrade with New Image

```bash
helm upgrade pyredis ./py-redis-app \
 \
--set image.tag=v2
```

## Upgrade with Values File

```bash
helm upgrade pyredis ./py-redis-app \
 \
-f values-prod.yaml
```

## Dry Run Upgrade

```bash
helm upgrade pyredis ./py-redis-app \
 \
--dry-run --debug
```

---

# 8. Rollout Commands

## Check Rollout Status

```bash
kubectl rollout status deployment/py-deploy
```

```bash
kubectl rollout status deployment/redis-deploy 
```

---

## Restart Deployment

```bash
kubectl rollout restart deployment/python-app 
```

```bash
kubectl rollout restart deployment/redis 
```

---

## View Rollout History

```bash
kubectl rollout history deployment/python-app 
```

---

## Undo Rollout

```bash
kubectl rollout undo deployment/python-app 
```

---

# 9. Rollback Helm Release

## View Revision History

```bash
helm history pyredis 
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
helm rollback pyredis 2 
```

---

## Verify Rollback

```bash
helm status pyredis 
```

```bash
kubectl get pods 
```

---

# 10. Uninstall Helm Chart

```bash
helm uninstall pyredis 
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
kubectl get events  --sort-by=.metadata.creationTimestamp
```

## Check YAML Applied

```bash
kubectl get deployment python-app  -o yaml
```

## Shell into Python Pod

```bash
kubectl exec -it deployment/python-app  -- sh
```

---

# 13. Production Recommended Install

```bash
helm upgrade --install pyredis ./py-redis-app \
 \
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
helm dependency update ./py-redis-app
```

## Build Dependencies

```bash
helm dependency build ./py-redis-app
```

---

# 15. Common Troubleshooting

## Pending Pods

```bash
kubectl describe pod <pod>
```

## CrashLoopBackOff

```bash
kubectl logs <pod>  --previous
```

## Image Pull Errors

```bash
kubectl describe pod <pod> 
```

## Validate Rendered YAML

```bash
helm template pyredis ./py-redis-app > output.yaml
```

Validate:

```bash
kubectl apply --dry-run=client -f output.yaml
```
