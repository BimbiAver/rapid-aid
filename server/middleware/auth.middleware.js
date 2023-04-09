require('dotenv').config();

const jwt = require('jsonwebtoken'); // JWT

// Authorization
const isLoggedIn = async (req, res, next) => {
  try {
    // Check whether the auth header exists or not
    if (req.headers.authorization) {
      // If yes, parse the token from header
      const token = req.headers.authorization.split(' ')[1]; //  Get the token by splitting the header
      if (token) {
        const payload = await jwt.verify(token, process.env.JWT_SECRET);
        if (payload) {
          // Stores the data in request object - user
          req.user = payload;
          next();
        } else {
          res.status(401).json({ error: 'Token verification failed!' });
        }
      } else {
        res.status(400).json({ error: 'Malformed authorization header!' });
      }
    } else {
      res.status(400).json({ error: 'No authorization header!' });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

module.exports = { isLoggedIn };
