const express = require('express');
const {
  getCases,
  getCase,
  createCase,
  deleteCase,
  updateCase,
} = require('../controllers/case.controller');

const router = express.Router();

// GET all cases
router.get('/', getCases);

// GET a specific case
router.get('/:id', getCase);

// CREATE a new case
router.post('/', createCase);

// DELETE a case
router.delete('/:id', deleteCase);

// UPDATE a case
router.patch('/:id', updateCase);

module.exports = router;
