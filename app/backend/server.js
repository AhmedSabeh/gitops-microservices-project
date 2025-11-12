import express from "express";
import AWS from "aws-sdk";
import cors from "cors";
import { v4 as uuidv4 } from "uuid";

const app = express();
app.use(express.json());
app.use(cors());

AWS.config.update({ region: process.env.AWS_REGION || "us-east-1" });
const dynamodb = new AWS.DynamoDB.DocumentClient();
const TABLE_NAME = process.env.DYNAMODB_TABLE || "sabeh-app-db";

// Get all tasks
app.get("/tasks", async (req, res) => {
  try {
    const data = await dynamodb.scan({ TableName: TABLE_NAME }).promise();
    res.json(data.Items);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Add new task
app.post("/tasks", async (req, res) => {
  const { title } = req.body;
  const newTask = { id: uuidv4(), title, completed: false };
  await dynamodb.put({ TableName: TABLE_NAME, Item: newTask }).promise();
  res.json(newTask);
});

// Update task status
app.put("/tasks/:id", async (req, res) => {
  const { id } = req.params;
  const { completed } = req.body;
  await dynamodb
    .update({
      TableName: TABLE_NAME,
      Key: { id },
      UpdateExpression: "set completed = :c",
      ExpressionAttributeValues: { ":c": completed },
      ReturnValues: "ALL_NEW",
    })
    .promise();
  res.json({ message: "Task updated" });
});

// Delete task
app.delete("/tasks/:id", async (req, res) => {
  const { id } = req.params;
  await dynamodb.delete({ TableName: TABLE_NAME, Key: { id } }).promise();
  res.json({ message: "Task deleted" });
});

const PORT = process.env.PORT || 8080;
app.listen(PORT, () => console.log(`Taskify backend running on port ${PORT}`));

