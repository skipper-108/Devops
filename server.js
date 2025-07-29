const express = require('express');
const path = require('path');
const fs = require('fs');
const cors = require('cors');
const MongoClient = require('mongodb').MongoClient;
const bodyParser = require('body-parser');

const app = express();

// Enable CORS to allow requests from frontend (e.g., localhost:5500)
app.use(cors());

// Parse application/x-www-form-urlencoded and application/json
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Serve the main page
app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Serve profile picture
app.get('/profile-picture', function (req, res) {
  const img = fs.readFileSync(path.join(__dirname, 'profile_picture.png'));
  res.writeHead(200, { 'Content-Type': 'image/png' }); // changed to png
  res.end(img, 'binary');
});

// MongoDB connection
const isDocker = process.env.DOCKER_ENV === 'true';
const mongoUrl = isDocker
  ? 'mongodb://admin:password@mongodb2'
  : 'mongodb://admin:password@localhost:27018';

const mongoClientOptions = {
  useNewUrlParser: true,
  useUnifiedTopology: true,
};

const databaseName = 'my-db';

// Update user profile
app.post('/update-profile', function (req, res) {
  const userObj = req.body;
  userObj.userid = 1;

  MongoClient.connect(mongoUrl, mongoClientOptions, function (err, client) {
    if (err) {
      console.error('❌ MongoDB connection error:', err);
      return res.status(500).send({ error: 'Database connection failed' });
    }

    const db = client.db(databaseName);
    const myquery = { userid: 1 };
    const newvalues = { $set: userObj };

    db.collection('users').updateOne(myquery, newvalues, { upsert: true }, function (err) {
      client.close();

      if (err) {
        console.error('❌ MongoDB update error:', err);
        return res.status(500).send({ error: 'Failed to update profile' });
      }

      res.send(userObj);
    });
  });
});

// Fetch user profile
app.get('/get-profile', function (req, res) {
  MongoClient.connect(mongoUrl, mongoClientOptions, function (err, client) {
    if (err) {
      console.error('❌ MongoDB connection error:', err);
      return res.status(500).send({ error: 'Database connection failed' });
    }

    const db = client.db(databaseName);
    const myquery = { userid: 1 };

    db.collection('users').findOne(myquery, function (err, result) {
      client.close();

      if (err) {
        console.error('❌ MongoDB fetch error:', err);
        return res.status(500).send({ error: 'Failed to fetch profile' });
      }

      res.send(result || {});
    });
  });
});

// Start the server
app.listen(3000, function () {
  console.log('✅ Express app running on http://localhost:3000');
});
