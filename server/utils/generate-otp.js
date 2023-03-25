const otpGenerator = require('otp-generator');

// Generate OTP and return it
module.exports.generateOTP = () => {
  return otpGenerator.generate(6, {
    upperCaseAlphabets: true,
    lowerCaseAlphabets: false,
    specialChars: false,
  });
};
