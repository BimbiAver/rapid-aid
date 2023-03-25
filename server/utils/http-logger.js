const morgan = require('morgan'); // Manages data in MongoDB using queries
const json = require('morgan-json'); // Format and output as JSON

const logger = require('./logger');

// Custom logger format
const loggerFormat = json({
  method: ':method',
  url: ':url',
  status: ':status',
  contentLength: ':res[content-length]',
  responseTime: ':response-time',
});

const httpLogger = morgan(loggerFormat, {
  stream: {
    write: (message) => {
      const { method, url, status, contentLength, responseTime } =
        JSON.parse(message);

      logger.httpLogger.info('HTTP access log', {
        timestamp: new Date().toISOString(),
        method,
        url,
        status: Number(status),
        contentLength,
        responseTime: Number(responseTime),
      });
    },
  },
});

module.exports = httpLogger;
