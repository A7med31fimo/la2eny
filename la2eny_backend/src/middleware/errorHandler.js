'use strict';

const logger = require('../services/logger');

// eslint-disable-next-line no-unused-vars
function errorHandler(err, req, res, _next) {
  logger.error({ message: err.message, stack: err.stack, path: req.path });

  const status = err.status ?? 500;
  return res.status(status).json({
    error:   err.message ?? 'Internal server error',
    ...(process.env.NODE_ENV !== 'production' && { stack: err.stack }),
  });
}

module.exports = { errorHandler };
