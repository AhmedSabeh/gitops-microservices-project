from flask import Flask, request, jsonify
from flask_cors import CORS
import boto3, os

app = Flask(__name__)
CORS(app)

# DynamoDB setup
dynamodb = boto3.resource(
    'dynamodb',
    region_name=os.getenv("AWS_REGION", "us-east-1")
)
table = dynamodb.Table(os.getenv("DYNAMO_TABLE", "Tasks"))

@app.route("/tasks", methods=["GET"])
def list_tasks():
    response = table.scan()
    return jsonify(response.get("Items", []))

@app.route("/tasks", methods=["POST"])
def add_task():
    data = request.json
    table.put_item(Item=data)
    return jsonify({"message": "Task added"}), 201

@app.route("/")
def home():
    return "Backend is running!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

