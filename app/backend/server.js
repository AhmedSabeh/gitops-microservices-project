const express = require('express');
const bodyParser = require('body-parser');
const AWS = require('aws-sdk');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

AWS.config.update({ region: 'us-east-1' }); // change your region
const dynamoDb = new AWS.DynamoDB.DocumentClient();
const TABLE_NAME = 'Tasks';

// Get all tasks
app.get('/tasks', async (req, res) => {
    const params = { TableName: TABLE_NAME };
    try {
        const data = await dynamoDb.scan(params).promise();
        res.json(data.Items);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Add new task
app.post('/tasks', async (req, res) => {
    const { id, title, completed } = req.body;
    const params = {
        TableName: TABLE_NAME,
        Item: { id, title, completed }
    };
    try {
        await dynamoDb.put(params).promise();
        res.json({ message: 'Task added' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Backend running on port ${PORT}`));

