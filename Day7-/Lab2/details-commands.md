## Scenario lab 
Moving the env variables to configmap

Adding "configmap file"
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: py-config
data:
  REDIS_HOST: "redis-service"
  APP_PORT: "8000"
```

Updating the pyt-deploy.yaml file
replace the below 
```
          env:
            - name: REDIS_HOST
              value: "redis-service"

```
with 
```
          envFrom:
            - configMapRef:
                name: py-config
```