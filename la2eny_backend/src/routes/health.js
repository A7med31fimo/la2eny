'use strict';

const { Router } = require('express');
const { getDb }  = require('../db/database');

const router = Router();

/**
 * GET /api/health
 * Used by the Flutter app (and load balancers) to verify the backend is alive.
 */
router.get('/', (_req, res) => {
  try {
    const db   = getDb();
    const row  = db.prepare("SELECT strftime('%Y-%m-%dT%H:%M:%SZ','now') AS ts").get();
    const counts = {
      places:     db.prepare('SELECT COUNT(*) AS n FROM places WHERE is_active=1').get().n,
      categories: db.prepare('SELECT COUNT(*) AS n FROM categories').get().n,
    };

    return res.json({
      status:    'ok',
      db_time:   row.ts,
      records:   counts,
      version:   process.env.npm_package_version ?? '1.0.0',
      node:      process.version,
    });
  } catch (err) {
    return res.status(503).json({ status: 'error', message: err.message });
  }
});

module.exports = router;
