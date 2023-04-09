const Station = require('../models/station.model');
const mongoose = require('mongoose');

const bcrypt = require('bcryptjs'); // bcrypt for password-hashing
const logger = require('../utils/logger');

// Get all stations
const getStations = async (req, res) => {
  const { adminId, departmentId } = req.user; // Fetch IDs from the req.user property initialized by auth middleware

  // Fetch all stations
  if (adminId) {
    // Fetch all stations
    const stations = await Station.find({}, { password: 0 })
      .sort({
        name: 1,
      })
      .populate({
        path: 'department',
        select: { username: 0, password: 0 },
      });
    return res.status(200).json(stations);
  }

  // Fetch stations for a specific department
  if (departmentId) {
    const stations = await Station.find({ department: departmentId });
    return res.status(200).json(stations);
  }
};

// Get a specific station
const getStation = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid station ID!' });
  }

  // Fetch and check if the station exists or not
  const station = await Station.findById(id, { password: 0 }).populate({
    path: 'department',
    select: { username: 0, password: 0 },
  });
  if (!station) {
    return res.status(404).json({ error: 'No such station!' });
  }
  // Return the station as response
  return res.status(200).json(station);
};

// Create a new station
const createStation = async (req, res) => {
  try {
    // Hash the password
    req.body.password = await bcrypt.hash(req.body.password, 10);
    // Create the new station
    const station = await Station.create(req.body);
    // Logging
    logger.stationLogger.info('Station added', { name: station.name });
    // Send new station as response
    res.status(201).json(station);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

// Delete a station
const deleteStation = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid station ID!' });
  }

  // Fetch and check if the station exists or not
  const station = await Station.findById(id);
  if (!station) {
    return res.status(404).json({ error: 'No such station!' });
  }

  // Delete the station
  await Station.findOneAndDelete({ _id: id });
  // Logging
  logger.stationLogger.info('Station deleted', { name: station.name });
  // Return the response message
  return res.status(200).json({ message: 'Station deleted successfully!' });
};

// Update a station
const updateStation = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid station ID!' });
  }

  // Check if the station exists or not
  const station = await Station.findById(id);
  if (!station) {
    return res.status(404).json({ error: 'No such station!' });
  }

  // Hash the password
  if (req.body.password) {
    req.body.password = await bcrypt.hash(req.body.password, 10);
  }
  // Update station details
  await Station.findOneAndUpdate({ _id: id }, { ...req.body });
  // Logging
  logger.stationLogger.info('Station modified', {
    name: station.name,
  });
  // Return the response message
  return res.status(200).json({ message: 'Station updated successfullly!' });
};

module.exports = {
  getStations,
  getStation,
  createStation,
  deleteStation,
  updateStation,
};
