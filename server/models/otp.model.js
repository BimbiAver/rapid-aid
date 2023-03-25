const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// OTP schema
const otpSchema = new Schema(
  {
    user: {
      type: Schema.Types.ObjectId,
      ref: 'user',
      required: true,
    },
    emailOrMobile: {
      type: String,
      required: true,
      lowercase: true,
    },
    otp: {
      type: String,
      required: true,
      uppercase: true,
    },
  },
  { timestamps: true }
);

// Exports the data model of the OTP
module.exports = mongoose.model('otp', otpSchema);
