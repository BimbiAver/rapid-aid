const express = require('express');
const {
  register,
  login,
  verify,
} = require('../controllers/user-auth.controller');

const router = express.Router();

// User registration route
router.post('/register', register);

// User login route
router.post('/login', login);

// User login verify route
router.post('/verify', verify);

module.exports = router;
