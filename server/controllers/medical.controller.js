const User = require('../models/user.model');
const mongoose = require('mongoose');

// Get all medicals
const getMedicals = async (req, res) => {
  // Get ID from the request param
  const { id } = req.params;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid user ID!' });
  }

  // Fetch and check if the user exists or not
  const medicals = await User.findById(id, { medicalDetails: 1 });
  if (!medicals) {
    return res.status(404).json({ error: 'No such user!' });
  }
  // Return the medicals as response
  return res.status(200).json(medicals);
};

// Create a new medical
const createMedical = async (req, res) => {
  try {
    // Get ID from the request param
    const { id } = req.params;

    // Create the new medical
    const medical = await User.update(
      { _id: id },
      { $push: { medicalDetails: req.body } }
    );
    // Send all medicals as response
    return res.status(201).json(medical);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }
};

// Delete a station
const deleteMedical = async (req, res) => {
  // Get IDs from the request
  const { id } = req.params;
  const { medicalId } = req.body;

  // Check if the id is valid or not
  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: 'Invalid user ID!' });
  }

  // Check if the medical Id is valid or not
  if (!mongoose.Types.ObjectId.isValid(medicalId)) {
    return res.status(400).json({ error: 'Invalid medical ID!' });
  }

  // Fetch and check if the user exists or not
  const user = await User.findById(id);
  if (!user) {
    return res.status(404).json({ error: 'No such user!' });
  }

  // Fetch and check if the medical exists or not
  const medical = await User.find({
    _id: id,
    medicalDetails: { $elemMatch: { _id: medicalId } },
  });
  if (medical.length == 0) {
    return res.status(404).json({ error: 'No such medical!' });
  }

  // Delete the medical
  await User.update(
    { _id: id },
    {
      $pull: {
        medicalDetails: { _id: medicalId },
      },
    }
  );
  // Return the response message
  return res.status(200).json({ message: 'Medical deleted successfully!' });
};

module.exports = {
  getMedicals,
  createMedical,
  deleteMedical,
};
