const mongoose = require('mongoose');

const Schema = mongoose.Schema;

// Station schema
const stationSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
    },
    department: {
      type: Schema.Types.ObjectId,
      ref: 'department',
      required: true,
    },
    inCharge: {
      type: String,
      required: true,
    },
    address: {
      type: String,
      required: true,
    },
    location: {
      type: String,
      required: true,
    },
    contactNo: {
      type: String,
      required: true,
    },
    username: {
      type: String,
      required: true,
      unique: [true, 'Sorry, the username already exists!'],
    },
    password: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

// Exports the data model of the station
module.exports = mongoose.model('station', stationSchema);
