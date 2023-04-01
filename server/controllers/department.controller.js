const Department = require('../models/department.model');
const mongoose = require('mongoose');

const bcrypt = require('bcryptjs'); // bcrypt for password-hashing
const logger = require('../utils/logger');

// Get all departments
const getDepartments = async (req, res) => {
  // Fetch all departments
  const departments = await Department.find({}, { password: 0 }).sort({
    name: 1,
  });
  return res.status(200).json(departments);
};

// Get a specific department
const getDepartment = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid department ID!' });
  }

  // Fetch and check if the department exists or not
  const department = await Department.findById(id, { password: 0 });
  if (!department) {
    return res.status(404).json({ error: 'No such department!' });
  }
  // Return the department as response
  return res.status(200).json(department);
};

// Create a new department
const createDepartment = async (req, res) => {
  try {
    // Hash the password
    req.body.password = await bcrypt.hash(req.body.password, 10);
    // Create the new department
    const department = await Department.create(req.body);
    // Logging
    logger.departmentLogger.info('Department added', { name: department.name });
    // Send new department as response
    res.status(201).json(department);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

// Delete a department
const deleteDepartment = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid department ID!' });
  }

  // Fetch and check if the department exists or not
  const department = await Department.findById(id);
  if (!department) {
    return res.status(404).json({ error: 'No such department!' });
  }

  // Delete the department
  await Department.findOneAndDelete({ _id: id });
  // Logging
  logger.departmentLogger.info('Department deleted', { name: department.name });
  // Return the response message
  return res.status(200).json({ message: 'Department deleted successfully!' });
};

// Update a department
const updateDepartment = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid department ID!' });
  }

  // Check if the department exists or not
  const department = await Department.findById(id);
  if (!department) {
    return res.status(404).json({ error: 'No such department!' });
  }

  // Hash the password
  if (req.body.password) {
    req.body.password = await bcrypt.hash(req.body.password, 10);
  }
  // Update department details
  await Department.findOneAndUpdate({ _id: id }, { ...req.body });
  // Logging
  logger.departmentLogger.info('Department modified', {
    name: department.name,
  });
  // Return the response message
  return res.status(200).json({ message: 'Department updated successfullly!' });
};

module.exports = {
  getDepartments,
  getDepartment,
  createDepartment,
  deleteDepartment,
  updateDepartment,
};
