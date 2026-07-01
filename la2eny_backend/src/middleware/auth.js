'use strict';

/**
 * Simple API-key guard for write (POST/PUT/DELETE) endpoints.
 *
 * Clients supply the key as:
 *   Authorization: Bearer <API_SECRET>
 * or
 *   X-API-Key: <API_SECRET>
 *
 * In development (NODE_ENV !== 'production') the guard is skipped
 * unless API_SECRET is explicitly set in the environment.
 */
function requireApiKey(req, res, next) {
  const secret = process.env.API_SECRET;

  // Skip in dev when no secret is configured
  if (!secret || process.env.NODE_ENV !== 'production') {
    return next();
  }

  const authHeader = req.headers['authorization'] ?? '';
  const keyHeader  = req.headers['x-api-key'] ?? '';

  const token = authHeader.startsWith('Bearer ')
    ? authHeader.slice(7).trim()
    : keyHeader.trim();

  if (!token || token !== secret) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  return next();
}

module.exports = { requireApiKey };
