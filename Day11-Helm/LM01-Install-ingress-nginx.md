Option 1: Install NGINX Ingress Controller (most common use case)
1️⃣ Add the official NGINX Helm repo
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

2️⃣ Create namespace (recommended)
kubectl create namespace ingress-nginx

3️⃣ Install NGINX Ingress
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx

4️⃣ Verify installation
kubectl get pods -n ingress-nginx
kubectl get svc  -n ingress-nginx


You should see:

Controller pod(s)

Service of type LoadBalancer or NodePort (depending on cluster)


helm install py-redis-app py-redis-app