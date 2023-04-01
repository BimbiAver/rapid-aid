const { createLogger, format, transports } = require('winston');

// Custom logger format
const loggerFormat = format.combine(
  format.timestamp(),
  // format.align(),
  // format.printf(
  //   (info) =>
  //     `${info.level}: ${[info.timestamp]}: ${[info.component]}: ${info.message}`
  // ),
  format.json()
);

// Logger for authentication
const authLogger = createLogger({
  defaultMeta: { component: 'auth-service' },
  transports: [
    new transports.File({
      level: 'info',
      filename: 'logs/authLog.log',
      format: loggerFormat,
      handleExceptions: true,
    }),
  ],
});

// Logger for users
const userLogger = createLogger({
  defaultMeta: { component: 'user-service' },
  transports: [
    new transports.File({
      level: 'info',
      filename: 'logs/userLog.log',
      format: loggerFormat,
      handleExceptions: true,
    }),
  ],
});

// Logger for departments
const departmentLogger = createLogger({
  defaultMeta: { component: 'department-service' },
  transports: [
    new transports.File({
      level: 'info',
      filename: 'logs/departmentLog.log',
      format: loggerFormat,
      handleExceptions: true,
    }),
  ],
});

// Logger for cases
const caseLogger = createLogger({
  defaultMeta: { component: 'case-service' },
  transports: [
    new transports.File({
      level: 'info',
      filename: 'logs/caseLog.log',
      format: loggerFormat,
      handleExceptions: true,
    }),
  ],
});

// Logger for HTTP req/res
const httpLogger = createLogger({
  transports: [
    new transports.File({
      level: 'info',
      filename: 'logs/httpLog.log',
      handleExceptions: true,
    }),
  ],
});

// Export loggers
module.exports = {
  authLogger: authLogger,
  userLogger: userLogger,
  departmentLogger: departmentLogger,
  caseLogger: caseLogger,
  httpLogger: httpLogger,
};
