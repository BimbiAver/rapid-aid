require('dotenv').config();

const bcrypt = require('bcryptjs'); // bcrypt for password-hashing
const jwt = require('jsonwebtoken'); // JWT

const User = require('../models/user.model');

let result = '';

// User registration
const register = async (req, res) => {
  try {
    // Check if the user is already exist
    result = await User.findOne({ nicNo: req.body.nicNo });
    if (result) {
      return res
        .status(409)
        .json({ message: 'A user with this NIC number already exists!' });
    }
    // Check if the mobile number is already in use
    result = await User.findOne({ mobileNo: req.body.mobileNo });
    if (result) {
      return res
        .status(409)
        .json({ message: 'The mobile number is already in use!' });
    }
    // Check if the email address is already in use
    result = await User.findOne({ emailAddress: req.body.emailAddress });
    if (result) {
      return res
        .status(409)
        .json({ message: 'The email address is already in use!' });
    }
    // If everything is fine register the new user
    const user = await User.create(req.body);
    // send new user as response
    res.status(201).json(user);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// User login
const login = async (req, res) => {
  try {
    // Check if the user is exist
    const user = await User.findOne({ emailAddress: req.body.emailAddress });
    if (user) {
      // Check if password matches
      const result = await bcrypt.compare(req.body.password, user.password);
      if (result) {
        // Sign the token and send it in response
        const token = await jwt.sign(
          {
            userId: user._id,
            firstName: user.firstName,
            emailAddress: user.emailAddress,
            role: user.role,
          },
          process.env.JWT_SECRET
        );
        res.json({ token });
      } else {
        res.status(400).json({ error: 'Your password is invalid' });
      }
    } else {
      res.status(400).json({ error: 'No account found' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

module.exports = { register, login };
