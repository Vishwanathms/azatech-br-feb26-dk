Task4
create your own image using the below app.py
Assuming that dockerfile , requirements.txt you can reuse.

* app.py
```
import os
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis_host = os.getenv("REDIS_HOST", "redis")

redis = Redis(host=redis_host, port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return 'Hello World! I have been seen {} times.\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
```

* Dockerfile
```
FROM python:3.9-alpine
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

```

* requirements.txt
```
flask
redis
```


* move inside the app.py folder
```
docker build . -t stackdemo:configmap
```
* change the image name with docker id
```
docker tag stackdemo:configmap  dockerhubid/stackdemo:configmap
```
* push it to the docker hub 
```
docker push dockerhubid/stackdemo:configmap
```
* update your kube yaml files with your own images 
* get the similar output.