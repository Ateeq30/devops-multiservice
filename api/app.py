from flask import Flask, request, jsonify
import redis
import json

app = Flask(__name__)

r = redis.Redis(host='redis', port=6379)

@app.route('/')
def home():
    return "API is running (control)!"

@app.route('/process', methods=['POST'])
def process():
    data = request.json
    r.lpush("queue", json.dumps(data))
    return jsonify({"status": "Job added to queue"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
