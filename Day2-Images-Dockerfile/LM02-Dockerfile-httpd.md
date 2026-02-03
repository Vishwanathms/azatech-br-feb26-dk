
## 🟢 Option 1: Simple Static Website using **Nginx**

Best for hosting **HTML/CSS/JS files**

**Folder structure**

```
project/
 ├─ Dockerfile
 └─ html/
     └─ index.html
```

**Dockerfile**

```dockerfile
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy your static files
COPY html/ /usr/share/nginx/html/

# Expose HTTP port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
```

**Build & Run**

```bash
docker build -t my-http-site .
docker run -p 8080:80 my-http-site
```

Open: **[http://localhost:8080](http://localhost:8080)**

---

## 🟢 Option 2: Simple HTTP Server using **Python**

Great for quick demos or lightweight file hosting.

**Dockerfile**

```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Copy files to serve
COPY . /app

EXPOSE 8000

CMD ["python", "-m", "http.server", "8000"]
```

**Build & Run**

```bash
docker build -t python-http .
docker run -p 8000:8000 python-http
```

Open: **[http://localhost:8000](http://localhost:8000)**

---

## 🟢 Option 3: Apache HTTP Server

If you prefer Apache instead of Nginx.

```dockerfile
FROM httpd:alpine

COPY ./html/ /usr/local/apache2/htdocs/

EXPOSE 80
```

Run:

```bash
docker build -t apache-http .
docker run -p 8080:80 apache-http
```

---

## 🚀 Which One Should You Use?

| Use Case                 | Best Choice |
| ------------------------ | ----------- |
| Static website           | Nginx       |
| Quick local file server  | Python      |
| Apache-based environment | Apache      |

