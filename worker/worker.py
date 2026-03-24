import redis
import time
import json

r = redis.Redis(host='redis', port=6379)

print("Worker started...")

while True:
    _, data = r.brpop("queue")
    job = json.loads(data)

    print(f"Processing job: {job}")

    time.sleep(2)  # simulate work

    print(f"Finished job: {job}")
