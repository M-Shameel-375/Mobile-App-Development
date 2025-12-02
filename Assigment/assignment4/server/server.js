const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// In-memory storage (replace with database in production)
let activities = [];

// Routes
app.get('/api/activities', (req, res) => {
  res.json(activities);
});

app.post('/api/activities', (req, res) => {
  const activity = {
    id: uuidv4(),
    ...req.body,
    timestamp: new Date().toISOString(),
    isSynced: true
  };
  
  activities.unshift(activity);
  res.status(201).json(activity);
});

app.delete('/api/activities/:id', (req, res) => {
  const index = activities.findIndex(a => a.id === req.params.id);
  
  if (index !== -1) {
    activities.splice(index, 1);
    res.status(200).json({ message: 'Activity deleted' });
  } else {
    res.status(404).json({ error: 'Activity not found' });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
