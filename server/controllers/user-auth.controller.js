require('dotenv').config();

const jwt = require('jsonwebtoken'); // JWT

const User = require('../models/user.model');
const OTP = require('../models/otp.model');

const welcomeEmail = require('../services/welcome-email');
const otpEmail = require('../services/otp-email');
const { sendSMS } = require('../services/send-sms');

const logger = require('../utils/logger');
const { generateOTP } = require('../utils/generate-otp');

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
    // Send welcome email
    welcomeEmail.sendEmail(user.emailAddress, user.firstName);
    // Send new user as response
    res.status(201).json(user);
    // Logging
    logger.authLogger.info('User registered', { nicNo: user.nicNo });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// User login
const login = async (req, res) => {
  try {
    // Login with email address
    if (req.body.emailAddress) {
      // Check if the user is exist
      const user = await User.findOne({ emailAddress: req.body.emailAddress });
      if (user) {
        // Generate OTP
        const otpCode = generateOTP();
        // Save OTP in the DB
        const otp = new OTP({
          user: user._id,
          emailOrMobile: user.emailAddress,
          otp: otpCode,
        });
        await OTP.create(otp);
        // Send OTP email
        otpEmail.sendEmail(user.emailAddress, user.firstName, otpCode);
        // Logging
        logger.authLogger.info('The OTP sent to the email address', {
          nicNo: user.nicNo,
          emailAddress: user.emailAddress,
        });
        // Return response
        return res
          .status(200)
          .json({ message: 'The OTP has been sent to your email address' });
      } else {
        return res.status(400).json({ error: 'No account found!' });
      }
    }
    // Login with mobile no
    if (req.body.mobileNo) {
      // Check if the user is exist
      const user = await User.findOne({ mobileNo: req.body.mobileNo });
      if (user) {
        // Generate OTP
        const otpCode = generateOTP();
        // Save OTP in the DB
        const otp = new OTP({
          user: user._id,
          emailOrMobile: user.mobileNo,
          otp: otpCode,
        });
        await OTP.create(otp);
        // Send OTP SMS
        sendSMS(
          user.mobileNo,
          `Hi ${user.firstName}, ${otpCode} is your OTP for login verification. - RapidAid`
        );
        // Logging
        logger.authLogger.info('The OTP sent to the mobile number', {
          nicNo: user.nicNo,
          mobileNo: user.mobileNo,
        });
        // Return response
        return res
          .status(200)
          .json({ message: 'The OTP has been sent to your mobile number' });
      } else {
        return res.status(400).json({ error: 'No account found!' });
      }
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Login verification
const verify = async (req, res) => {
  try {
    const { emailOrMobile, otp } = req.body;
    // Check if the user is exist
    const user = await User.findOne({
      $or: [{ emailAddress: emailOrMobile }, { mobileNo: emailOrMobile }],
    });
    if (user) {
      // Get the last saved OTP
      const lastOTP = await OTP.findOne({ emailOrMobile: emailOrMobile }).sort({
        createdAt: -1,
      });
      // Check if the OTP is correct
      if (otp == lastOTP.otp) {
        // Sign the token and send it in response
        const token = await jwt.sign(
          {
            userId: lastOTP.user,
          },
          process.env.JWT_SECRET,
          { expiresIn: '12h' }
        );
        // Logging
        logger.authLogger.info('OTP verified successfully', {
          nicNo: user.nicNo,
        });
        // Return response
        return res
          .status(202)
          .json({
            message: 'OTP verified successfully!',
            token: token,
            userId: lastOTP.user,
          });
      } else {
        return res.status(401).json({ error: 'Incorrect authentication!' });
      }
    } else {
      return res.status(400).json({ error: 'No account found!' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Export functions
module.exports = { register, login, verify };
