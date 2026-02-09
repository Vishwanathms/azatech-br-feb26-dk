## deployment Kube files

inside Lab2, there is deployment.yaml and service.yaml


Inside the folder 
```
kubectl apply -f .
kubectl get pods 
kubectl get rs
kubectl get deployment

kubectl get svc
```

* delete a pod 
```
kubectl delete pod <pod-name>
```
sample of pod name in deployment -- deploymentname-replicaset-podvalue

* observe that the service.yaml file is the same use din lab1


* scale the pods
```
kubectl scale deployment nginx-deployment --replicas=5
```

* lets add the replica in the yaml file
```
replicas: 5
```
Note: to be added below the first spec: