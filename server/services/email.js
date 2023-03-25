require('dotenv').config(); // Manages the .env file

const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

let email = {
  to: '',
  from: 'RapidAid - Keep calm and trust us <no-reply@rapidaid.live>',
  replyTo: 'no-reply@rapidaid.live',
  subject: '',
  html: '',
};

// Function to send the email
let sendEmail = () =>
  sgMail
    .send(email)
    .then(() => {
      console.log('Email sent');
    })
    .catch((error) => {
      console.error(error);
    });

// Export function
module.exports = {
  email: email,
  sendEmail: sendEmail,
};
