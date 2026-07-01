'use strict';

const { Router } = require('express');
const { getPlaces, getPlaceById, searchPlaces } = require('../models/placeModel');
const { requireApiKey } = require('../middleware/auth');

const router = Router();

/**
 * GET /api/places
 *
 * Query parameters (all optional):
 *   page          integer  default 0
 *   limit         integer  default 100  (max 500)
 *   updated_since ISO-8601 string  → delta-sync (returns only places updated after this date)
 *   q             string   → full-text search (overrides pagination)
 */
router.get('/', (req, res, next) => {
  try {
    const { page, limit, updated_since, q } = req.query;

    // Full-text search path
    if (q && q.trim()) {
      const results = searchPlaces(q.trim(), parseInt(limit ?? 20, 10));
      return res.json({ data: results, total: results.length, page: 0, limit: results.length });
    }

    const pageNum  = Math.max(0, parseInt(page  ?? 0,   10));
    const limitNum = Math.min(500, Math.max(1, parseInt(limit ?? 100, 10)));

    const result = getPlaces({
      page: pageNum,
      limit: limitNum,
      updated_since: updated_since || undefined,
    });

    return res.json(result);
  } catch (err) {
    next(err);
  }
});

/**
 * GET /api/places/:id
 */
router.get('/:id', (req, res, next) => {
  try {
    const id = parseInt(req.params.id, 10);
    if (isNaN(id)) return res.status(400).json({ error: 'Invalid place id' });

    const place = getPlaceById(id);
    if (!place) return res.status(404).json({ error: 'Place not found' });

    return res.json(place);
  } catch (err) {
    next(err);
  }
});

/**
 * POST /api/places  (admin — protected by API key)
 * Body: same shape as a place object from the Flutter PlaceDto
 */
router.post('/', requireApiKey, (req, res, next) => {
  try {
    const { upsertPlace } = require('../models/placeModel');
    if (!req.body || !req.body.id) {
      return res.status(400).json({ error: 'Body must include id' });
    }
    const saved = upsertPlace(req.body);
    return res.status(201).json(saved);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
