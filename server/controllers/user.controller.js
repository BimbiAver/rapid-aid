const User = require('../models/user.model');
const mongoose = require('mongoose');

const logger = require('../utils/logger');

// Get all users
const getUsers = async (req, res) => {
  // Fetch all users
  const users = await User.find({}).sort({ createdAt: 1 });
  return res.status(200).json(users);
};

// Get a specific user
const getUser = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid user ID!' });
  }

  // Fetch and check if the user exists or not
  const user = await User.findById(id);
  if (!user) {
    return res.status(404).json({ error: 'No such user!' });
  }
  // Return the user as response
  return res.status(200).json(user);
};

// Delete a user
const deleteUser = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid user ID!' });
  }

  // Fetch and check if the user exists or not
  const user = await User.findById(id);
  if (!user) {
    return res.status(404).json({ error: 'No such user!' });
  }
  // Delete the user
  await User.findOneAndDelete({ _id: id });
  // Logging
  logger.userLogger.info('User deleted', { nicNo: user.nicNo });
  // Return the response message
  return res.status(200).json({ message: 'User deleted successfully!' });
};

// Update a user
const updateUser = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid user ID!' });
  }

  // Check if the user exists or not
  const user = await User.findById(id);
  if (!user) {
    return res.status(404).json({ error: 'No such user!' });
  }

  // Update user details
  await User.findOneAndUpdate({ _id: id }, { ...req.body });
  // Logging
  logger.userLogger.info('User modified', { nicNo: user.nicNo });
  // Return the response message
  return res.status(200).json({ message: 'User updated successfullly!' });
};

module.exports = {
  getUsers,
  getUser,
  deleteUser,
  updateUser,
};
