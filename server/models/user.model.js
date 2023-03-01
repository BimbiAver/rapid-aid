const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// User schema
const userSchema = new Schema(
  {
    active: {
      type: Boolean,
      required: true,
      default: true,
    },
    nicNo: {
      type: String,
      required: true,
      unique: [true, 'Sorry, the NIC number already exists!'],
    },
    firstName: {
      type: String,
      required: true,
    },
    lastName: {
      type: String,
      required: true,
    },
    gender: {
      type: String,
      required: true,
    },
    dob: {
      type: Date,
      required: true,
    },
    address: {
      type: String,
      required: true,
    },
    mobileNo: {
      type: String,
      required: true,
      unique: [true, 'Sorry, the mobile number is already in use!'],
    },
    emailAddress: {
      type: String,
      required: true,
      unique: [true, 'Sorry, the email address is already in use!'],
      lowercase: true,
    },
    bloodGroup: {
      type: String,
      required: true,
      uppercase: true,
    },
    guardian: {
      required: true,
      nicNo: String,
      fullName: String,
      address: String,
      contactNo: String,
      relationship: String,
    },
    medicalDetails: [
      {
        disease: String,
        since: Date,
        underTreatments: Boolean,
      },
    ],
  },
  { timestamps: true }
);

// Exports the data model of the user
module.exports = mongoose.model('user', userSchema);
