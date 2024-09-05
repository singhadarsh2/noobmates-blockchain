const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
require('dotenv').config();  // Load environment variables from .env file

// Initialize the app
const app = express();
const port = 8000;  // Change the port to 8000

// Middleware for parsing JSON bodies
app.use(bodyParser.json());

// MongoDB connection string from environment variable
const mongoURI = process.env.MONGO_URL;

// Connect to MongoDB using Mongoose
mongoose.connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => {
    console.log('MongoDB connected successfully');
})
.catch((err) => {
    console.error('MongoDB connection error:', err);
});


// Start the Express server on port 8000
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
