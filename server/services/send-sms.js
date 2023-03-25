require('dotenv').config(); // Manages the .env file

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);

// Function to send the SMS
let sendSMS = (to, msg) =>
  client.messages
    .create({
      body: msg,
      messagingServiceSid: 'MGba2276400d3bd183e2bfeb73282da056',
      to: to,
    })
    .then((message) => console.log(message.sid));

// Export function
module.exports = {
  sendSMS: sendSMS,
};
