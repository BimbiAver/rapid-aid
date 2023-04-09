const express = require('express');
const { login } = require('../controllers/auth.controller');

const router = express.Router();

// Department/Station/Admin login route
router.post('/login', login);

module.exports = router;
