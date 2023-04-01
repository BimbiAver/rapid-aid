const express = require('express');
const {
  getDepartments,
  getDepartment,
  createDepartment,
  deleteDepartment,
  updateDepartment,
} = require('../controllers/department.controller');

const router = express.Router();

// GET all departments
router.get('/', getDepartments);

// GET a specific department
router.get('/:id', getDepartment);

// CREATE a new department
router.post('/', createDepartment);

// DELETE a department
router.delete('/:id', deleteDepartment);

// UPDATE a department
router.patch('/:id', updateDepartment);

module.exports = router;
