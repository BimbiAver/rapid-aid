const Case = require('../models/case.model');
const User = require('../models/user.model');
const mongoose = require('mongoose');

const logger = require('../utils/logger');
const { sendSMS } = require('../services/send-sms');

// Get all cases
const getCases = async (req, res) => {
  const { userId, adminId, departmentId, stationId, category } = req.user; // Fetch IDs & category from the req.user property initialized by auth middleware

  // Fetch cases for a specific user
  if (userId) {
    const cases = await Case.find({ user: userId }, { images: 0 })
      .sort({ updatedAt: -1 })
      .populate({
        path: 'user',
      });
    return res.status(200).json(cases);
  }

  // Fetch all cases
  if (adminId) {
    const cases = await Case.find({}, { images: 0 })
      .sort({ updatedAt: -1 })
      .populate({
        path: 'user',
      });
    return res.status(200).json(cases);
  }

  // Fetch cases for a specific department
  if (departmentId) {
    // For Police
    if (category == 'Police') {
      const cases = await Case.find(
        { 'departments.police.assign': true },
        { images: 0 }
      )
        .sort({ updatedAt: -1 })
        .populate({
          path: 'user',
        });
      return res.status(200).json(cases);
    }
    // For Hospital
    if (category == 'Hospital') {
      const cases = await Case.find(
        { 'departments.hospital.assign': true },
        { images: 0 }
      )
        .sort({ updatedAt: -1 })
        .populate({
          path: 'user',
        });
      return res.status(200).json(cases);
    }
    // For Fire Brigade
    if (category == 'Fire Brigade') {
      const cases = await Case.find(
        { 'departments.fireBrigade.assign': true },
        { images: 0 }
      )
        .sort({ updatedAt: -1 })
        .populate({
          path: 'user',
        });
      return res.status(200).json(cases);
    }
    // For DMC
    if (category == 'DMC') {
      const cases = await Case.find(
        { 'departments.dmc.assign': true },
        { images: 0 }
      )
        .sort({ updatedAt: -1 })
        .populate({
          path: 'user',
        });
      return res.status(200).json(cases);
    }
    // For MWCA
    if (category == 'MWCA') {
      const cases = await Case.find(
        { 'departments.mwca.assign': true },
        { images: 0 }
      )
        .sort({ updatedAt: -1 })
        .populate({
          path: 'user',
        });
      return res.status(200).json(cases);
    }
  }

  // Fetch cases for a specific station
  if (stationId) {
    const cases = await Case.find(
      {
        $or: [
          { 'departments.police.station': stationId },
          { 'departments.hospital.station': stationId },
          { 'departments.fireBrigade.station': stationId },
          { 'departments.dmc.station': stationId },
          { 'departments.mwca.station': stationId },
        ],
      },
      { images: 0 }
    )
      .sort({ updatedAt: -1 })
      .populate({
        path: 'user',
      });
    return res.status(200).json(cases);
  }
};

// Get a specific case
const getCase = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid case ID!' });
  }

  // Fetch and check if the case exists or not
  const cases = await Case.findById(id).populate({
    path: 'user',
  });
  if (!cases) {
    return res.status(404).json({ error: 'No such case!' });
  }
  // Return the case as response
  return res.status(200).json(cases);
};

// Create a new case
const createCase = async (req, res) => {
  try {
    // Create the new case
    const cases = await Case.create(req.body);
    // Get guardian contact no
    const user = await User.findById(
      { _id: req.body.user },
      { 'guardian.contactNo': 1, firstName: 1 }
    );
    // Send sms to guardian
    sendSMS(
      user.guardian.contactNo,
      `Emergency!!! ${user.firstName} has made an emergency case from the approx. location: https://www.google.com/maps/search/?api=1&query=${req.body.location} . You are receiving this message because ${user.firstName} has listed you as an emergency contact.\n- RapidAid -`
    );
    // Logging
    logger.caseLogger.info('Case reported', {
      caseId: cases._id,
      userId: cases.user,
    });
    // Send new case as response
    res.status(201).json(cases);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

// Delete a case
const deleteCase = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid case ID!' });
  }

  // Fetch and check if the case exists or not
  const cases = await Case.findById(id);
  if (!cases) {
    return res.status(404).json({ error: 'No such case!' });
  }

  // Delete the case
  await Case.findOneAndDelete({ _id: id });
  // Logging
  logger.caseLogger.info('Case deleted', { caseId: cases._id });
  // Return the response message
  return res.status(200).json({ message: 'Case deleted successfully!' });
};

// Update a case
const updateCase = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid case ID!' });
  }

  // Check if the case exists or not
  const cases = await Case.findById(id);
  if (!cases) {
    return res.status(404).json({ error: 'No such case!' });
  }

  // Update case details
  await Case.findOneAndUpdate({ _id: id }, { ...req.body });
  // Logging
  logger.caseLogger.info('Case modified', {
    caseId: cases._id,
  });
  // Return the response message
  return res.status(200).json({ message: 'Case updated successfullly!' });
};

module.exports = {
  getCases,
  getCase,
  createCase,
  deleteCase,
  updateCase,
};
