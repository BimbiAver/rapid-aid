const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Department schema
const departmentSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
    },
    category: {
      type: String,
      required: true,
      enum: {
        values: ['Police', 'Hospital', 'Fire Brigade', 'DMC', 'MWCA'],
        message: '{VALUE} is not supported',
      },
    },
    inCharge: {
      type: String,
      required: true,
    },
    address: {
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

// Exports the data model of the department
module.exports = mongoose.model('department', departmentSchema);
