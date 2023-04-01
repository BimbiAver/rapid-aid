const express = require('express');
const {
  getUsers,
  getUser,
  deleteUser,
  updateUser,
} = require('../controllers/user.controller');

const router = express.Router();

// GET all users
router.get('/', getUsers);

// GET a specific user
router.get('/:id', getUser);

// DELETE a user
router.delete('/:id', deleteUser);

// UPDATE a user
router.patch('/:id', updateUser);

module.exports = router;
