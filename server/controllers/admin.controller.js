const Admin = require('../models/admin.model');
const mongoose = require('mongoose');

const bcrypt = require('bcryptjs'); // bcrypt for password-hashing
const logger = require('../utils/logger');

// Get all admins
const getAdmins = async (req, res) => {
  // Fetch all admins
  const admins = await Admin.find({}, { password: 0 }).sort({
    name: 1,
  });
  return res.status(200).json(admins);
};

// Get a specific admin
const getAdmin = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid admin ID!' });
  }

  // Fetch and check if the admin exists or not
  const admin = await Admin.findById(id, { password: 0 });
  if (!admin) {
    return res.status(404).json({ error: 'No such admin!' });
  }
  // Return the admin as response
  return res.status(200).json(admin);
};

// Create a new admin
const createAdmin = async (req, res) => {
  try {
    // Hash the password
    req.body.password = await bcrypt.hash(req.body.password, 10);
    // Create the new admin
    const admin = await Admin.create(req.body);
    // Logging
    logger.adminLogger.info('Admin added', {
      name: admin.name,
      nic: admin.nicNo,
    });
    // Send new admin as response
    res.status(201).json(admin);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

// Delete a admin
const deleteAdmin = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid admin ID!' });
  }

  // Fetch and check if the admin exists or not
  const admin = await Admin.findById(id);
  if (!admin) {
    return res.status(404).json({ error: 'No such admin!' });
  }

  // Delete the admin
  await Admin.findOneAndDelete({ _id: id });
  // Logging
  logger.adminLogger.info('Admin deleted', {
    name: admin.name,
    nic: admin.nicNo,
  });
  // Return the response message
  return res.status(200).json({ message: 'Admin deleted successfully!' });
};

// Update a admin
const updateAdmin = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid admin ID!' });
  }

  // Check if the admin exists or not
  const admin = await Admin.findById(id);
  if (!admin) {
    return res.status(404).json({ error: 'No such admin!' });
  }

  // Hash the password
  if (req.body.password) {
    req.body.password = await bcrypt.hash(req.body.password, 10);
  }
  // Update admin details
  await Admin.findOneAndUpdate({ _id: id }, { ...req.body });
  // Logging
  logger.adminLogger.info('Admin modified', {
    name: admin.name,
    nic: admin.nicNo,
  });
  // Return the response message
  return res.status(200).json({ message: 'Admin updated successfullly!' });
};

module.exports = {
  getAdmins,
  getAdmin,
  createAdmin,
  deleteAdmin,
  updateAdmin,
};
