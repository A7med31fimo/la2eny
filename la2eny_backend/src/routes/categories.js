'use strict';

const { Router } = require('express');
const { getCategories } = require('../models/placeModel');
const { getDb } = require('../db/database');
const { requireApiKey } = require('../middleware/auth');

const router = Router();

/**
 * GET /api/categories
 */
router.get('/', (req, res, next) => {
  try {
    const data = getCategories();
    return res.json({ data });
  } catch (err) {
    next(err);
  }
});

/**
 * POST /api/categories  (admin — protected)
 */
router.post('/', requireApiKey, (req, res, next) => {
  try {
    const { id, name_ar, name_en, icon } = req.body ?? {};
    if (!name_ar || !name_en) {
      return res.status(400).json({ error: 'name_ar and name_en are required' });
    }
    const db = getDb();
    const stmt = db.prepare(`
      INSERT INTO categories (id, name_ar, name_en, icon)
      VALUES (@id, @name_ar, @name_en, @icon)
      ON CONFLICT(id) DO UPDATE SET
        name_ar=excluded.name_ar,
        name_en=excluded.name_en,
        icon=excluded.icon,
        updated_at=strftime('%Y-%m-%dT%H:%M:%SZ','now')
    `);
    const result = stmt.run({ id: id ?? null, name_ar, name_en, icon: icon ?? null });
    const saved  = db.prepare('SELECT * FROM categories WHERE id = ?').get(result.lastInsertRowid ?? id);
    return res.status(201).json(saved);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
