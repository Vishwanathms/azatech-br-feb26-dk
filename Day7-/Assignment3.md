Task3

Update the application yaml files created in Task2 with configmap 
export all the required option for your app as configmap values and pass it via the yaml file

Task4
create your own image using the below app.py
Assuming that dockerfile , requirements.txt you can reuse.

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
