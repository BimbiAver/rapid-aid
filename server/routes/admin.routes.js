const express = require('express');
const {
  getAdmins,
  getAdmin,
  createAdmin,
  deleteAdmin,
  updateAdmin,
} = require('../controllers/admin.controller');

const router = express.Router();

// GET all admins
router.get('/', getAdmins);

// GET a specific admin
router.get('/:id', getAdmin);

// CREATE a new admin
router.post('/', createAdmin);

// DELETE a admin
router.delete('/:id', deleteAdmin);

// UPDATE a admin
router.patch('/:id', updateAdmin);

module.exports = router;
