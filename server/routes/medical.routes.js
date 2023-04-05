const express = require('express');
const {
  getMedicals,
  createMedical,
  deleteMedical,
} = require('../controllers/medical.controller');

const router = express.Router();

// GET all medical
router.get('/:id', getMedicals);

// CREATE a new medical
router.post('/:id', createMedical);

// DELETE a medical
router.delete('/:id', deleteMedical);

module.exports = router;
