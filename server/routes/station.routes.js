const express = require('express');
const {
  getStations,
  getStation,
  createStation,
  deleteStation,
  updateStation,
} = require('../controllers/station.controller');

const router = express.Router();

// GET all Stations
router.get('/', getStations);

// GET a specific station
router.get('/:id', getStation);

// CREATE a new station
router.post('/', createStation);

// DELETE a station
router.delete('/:id', deleteStation);

// UPDATE a station
router.patch('/:id', updateStation);

module.exports = router;
