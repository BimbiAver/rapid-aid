require('dotenv').config(); // Manages the .env file

const express = require('express'); // Middleware to create CRUD endpoints
const mongoose = require('mongoose'); // Manages data in MongoDB using queries
const cors = require('cors'); // Enables CORS

const logger = require('./utils/logger');
const httpLogger = require('./utils/http-logger');

// Define routes
const authRoutes = require('./routes/auth.routes');
const userAuthRoutes = require('./routes/user-auth.routes');
const userRoutes = require('./routes/user.routes');
const adminRoutes = require('./routes/admin.routes');
const departmentRoutes = require('./routes/department.routes');
const stationRoutes = require('./routes/station.routes');
const caseRoutes = require('./routes/case.routes');
const medicalRoutes = require('./routes/medical.routes');

const { isLoggedIn } = require('./middleware/auth.middleware');

// Express app
const app = express();

// Middleware
app.use(cors()); // Add CORS headers
app.use(express.json({ limit: '20mb' })); // Parse requests (content-type - application/json)
app.use(httpLogger); // Log HTTP requests and errors

app.use((req, res, next) => {
  next();
});

// Define route handlers
app.use('/api/auth', authRoutes);
app.use('/api/user-auth', userAuthRoutes);
app.use('/api/users', isLoggedIn, userRoutes);
app.use('/api/admins', isLoggedIn, adminRoutes);
app.use('/api/departments', isLoggedIn, departmentRoutes);
app.use('/api/stations', isLoggedIn, stationRoutes);
app.use('/api/cases', isLoggedIn, caseRoutes);
app.use('/api/medicals', isLoggedIn, medicalRoutes);
app.use('/', async (req, res) => {
  try {
    return res.status(200).send("Hey I'm the homepage");
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Connect to the DB
mongoose.set('strictQuery', true); // Fix the deprecation warning
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    // Listen for requests
    app.listen(process.env.PORT || 3000, () => {
      console.log(
        'Connected to the DB & listening on port ' + process.env.PORT
      );
    });
  })
  .catch((error) => {
    console.log(error);
  });
