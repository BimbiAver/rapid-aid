const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Admin schema
const adminSchema = new Schema(
  {
    nicNo: {
      type: String,
      required: true,
      unique: true,
      uppercase: true,
    },
    name: {
      type: String,
      required: true,
    },
    contactNo: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      required: true,
      default: 'Local Admin',
      enum: {
        values: ['Super Admin', 'Local Admin'],
        message: '{VALUE} is not supported',
      },
    },
    username: {
      type: String,
      required: true,
      unique: true,
    },
    password: {
      type: String,
      required: true,
    },
  },
  { timestamps: true }
);

// Exports the data model of the admin
module.exports = mongoose.model('admin', adminSchema);
