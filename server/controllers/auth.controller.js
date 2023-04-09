require('dotenv').config();

const bcrypt = require('bcryptjs'); // bcrypt for password-hashing
const jwt = require('jsonwebtoken'); // JWT

const Admin = require('../models/admin.model');
const Department = require('../models/department.model');
const Station = require('../models/station.model');

const logger = require('../utils/logger');

// Login
const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    // Check if the admin is exist
    const admin = await Admin.findOne({ username: username });
    if (admin) {
      // Check if password matches
      const result = await bcrypt.compare(password, admin.password);
      if (result) {
        // Sign the token and send it in response
        const token = await jwt.sign(
          {
            adminId: admin._id,
            role: admin.type,
          },
          process.env.JWT_SECRET,
          { expiresIn: '12h' }
        );
        // Logging
        logger.authLogger.info('User logged in', {
          adminId: admin._id,
          nicNo: admin.nicNo,
        });
        // Return response
        return res.status(202).json({
          message: 'Login successful!',
          token: token,
          adminId: admin._id,
        });
      } else {
        return res.status(401).json({ error: 'Your password is invalid!' });
      }
    }

    // Check if the department is exist
    const department = await Department.findOne({ username: username });
    if (department) {
      // Check if password matches
      const result = await bcrypt.compare(password, department.password);
      if (result) {
        // Sign the token and send it in response
        const token = await jwt.sign(
          {
            departmentId: department._id,
            category: department.category,
            role: 'Department',
          },
          process.env.JWT_SECRET,
          { expiresIn: '12h' }
        );
        // Logging
        logger.authLogger.info('User logged in', {
          departmentId: department._id,
        });
        // Return response
        return res.status(202).json({
          message: 'Login successful!',
          token: token,
          departmentId: department._id,
        });
      } else {
        return res.status(401).json({ error: 'Your password is invalid!' });
      }
    }

    // Check if the station is exist
    const station = await Station.findOne({ username: username });
    if (station) {
      // Check if password matches
      const result = await bcrypt.compare(password, station.password);
      if (result) {
        // Sign the token and send it in response
        const token = await jwt.sign(
          {
            stationId: station._id,
            department: station.department,
            role: 'Station',
          },
          process.env.JWT_SECRET,
          { expiresIn: '12h' }
        );
        // Logging
        logger.authLogger.info('User logged in', {
          stationId: station._id,
        });
        // Return response
        return res.status(202).json({
          message: 'Login successful!',
          token: token,
          stationId: station._id,
        });
      } else {
        return res.status(401).json({ error: 'Your password is invalid!' });
      }
    }
    // Return no account found response
    return res.status(404).json({ error: 'No account found!' });
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

module.exports = { login };
