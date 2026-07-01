'use strict';

const { getDb } = require('../db/database');

// ── helpers ───────────────────────────────────────────────────────────────────

function _relations(db, placeId) {
  const categories = db.prepare(`
    SELECT c.id, c.name_ar, c.name_en, c.icon, c.updated_at
    FROM categories c
    INNER JOIN place_categories pc ON pc.category_id = c.id
    WHERE pc.place_id = ?
  `).all(placeId);

  const working_hours = db.prepare(`
    SELECT id, day_of_week, open_time, close_time, is_closed
    FROM working_hours WHERE place_id = ? ORDER BY day_of_week
  `).all(placeId).map(h => ({ ...h, is_closed: h.is_closed === 1 }));

  const images = db.prepare(`
    SELECT id, url, is_primary, sort_order
    FROM place_images WHERE place_id = ? ORDER BY is_primary DESC, sort_order ASC
  `).all(placeId).map(i => ({ ...i, is_primary: i.is_primary === 1 }));

  const social_links = db.prepare(
    'SELECT id, platform, url FROM social_links WHERE place_id = ?'
  ).all(placeId);

  return { categories, working_hours, images, social_links };
}

function _format(row, db) {
  return {
    ...row,
    is_active: row.is_active === 1,
    ..._relations(db, row.id),
  };
}

// ── Public API ─────────────────────────────────────────────────────────────────

/**
 * Paginated list of all active places.
 * @param {object} opts
 * @param {number} opts.page
 * @param {number} opts.limit
 * @param {string} [opts.updated_since]  ISO-8601 — returns only newer records
 * @returns {{ data: object[], total: number, page: number, limit: number }}
 */
function getPlaces({ page = 0, limit = 100, updated_since } = {}) {
  const db = getDb();
  const offset = page * limit;

  let rows, total;
  if (updated_since) {
    rows = db.prepare(
      'SELECT * FROM places WHERE is_active=1 AND updated_at > ? ORDER BY updated_at DESC LIMIT ? OFFSET ?'
    ).all(updated_since, limit, offset);
    total = db.prepare(
      'SELECT COUNT(*) AS n FROM places WHERE is_active=1 AND updated_at > ?'
    ).get(updated_since).n;
  } else {
    rows = db.prepare(
      'SELECT * FROM places WHERE is_active=1 ORDER BY id ASC LIMIT ? OFFSET ?'
    ).all(limit, offset);
    total = db.prepare(
      'SELECT COUNT(*) AS n FROM places WHERE is_active=1'
    ).get().n;
  }

  return {
    data: rows.map(r => _format(r, db)),
    total,
    page,
    limit,
  };
}

/**
 * Single place by ID.
 */
function getPlaceById(id) {
  const db = getDb();
  const row = db.prepare('SELECT * FROM places WHERE id = ?').get(id);
  return row ? _format(row, db) : null;
}

/**
 * FTS5 search.
 */
function searchPlaces(query, limit = 20) {
  const db = getDb();
  const q = query.trim().replace(/"/g, '').replace(/'/g, '');
  if (!q) return [];

  const rows = db.prepare(`
    SELECT p.*
    FROM places p
    INNER JOIN places_fts f ON p.id = f.rowid
    WHERE places_fts MATCH ? AND p.is_active = 1
    ORDER BY rank
    LIMIT ?
  `).all(`${q}*`, limit);

  return rows.map(r => _format(r, db));
}

/**
 * All categories.
 */
function getCategories() {
  const db = getDb();
  return db.prepare('SELECT * FROM categories ORDER BY name_en ASC').all();
}

/**
 * Upsert a place (used by admin/management endpoints).
 */
function upsertPlace(data) {
  const db = getDb();
  const { categories: cats = [], working_hours: whs = [], images = [], social_links: links = [], ...row } = data;

  const upsert = db.transaction(() => {
    db.prepare(`
      INSERT INTO places (id,name_ar,name_en,description_ar,description_en,address_ar,address_en,
        latitude,longitude,phone,website,rating,review_count,price_level,is_active,created_at,updated_at)
      VALUES (@id,@name_ar,@name_en,@description_ar,@description_en,@address_ar,@address_en,
        @latitude,@longitude,@phone,@website,@rating,@review_count,@price_level,@is_active,
        COALESCE(@created_at, strftime('%Y-%m-%dT%H:%M:%SZ','now')),
        strftime('%Y-%m-%dT%H:%M:%SZ','now'))
      ON CONFLICT(id) DO UPDATE SET
        name_ar=excluded.name_ar, name_en=excluded.name_en,
        description_ar=excluded.description_ar, description_en=excluded.description_en,
        address_ar=excluded.address_ar, address_en=excluded.address_en,
        latitude=excluded.latitude, longitude=excluded.longitude,
        phone=excluded.phone, website=excluded.website,
        rating=excluded.rating, review_count=excluded.review_count,
        price_level=excluded.price_level, is_active=excluded.is_active,
        updated_at=strftime('%Y-%m-%dT%H:%M:%SZ','now')
    `).run(row);

    // relations
    db.prepare('DELETE FROM place_categories WHERE place_id=?').run(row.id);
    db.prepare('DELETE FROM working_hours WHERE place_id=?').run(row.id);
    db.prepare('DELETE FROM place_images WHERE place_id=?').run(row.id);
    db.prepare('DELETE FROM social_links WHERE place_id=?').run(row.id);

    for (const catId of cats)
      db.prepare('INSERT OR IGNORE INTO place_categories(place_id,category_id) VALUES(?,?)').run(row.id, catId);
    for (const wh of whs)
      db.prepare('INSERT INTO working_hours(place_id,day_of_week,open_time,close_time,is_closed) VALUES(@place_id,@day_of_week,@open_time,@close_time,@is_closed)')
        .run({ place_id: row.id, ...wh });
    for (const img of images)
      db.prepare('INSERT INTO place_images(place_id,url,is_primary,sort_order) VALUES(@place_id,@url,@is_primary,@sort_order)')
        .run({ place_id: row.id, ...img });
    for (const sl of links)
      db.prepare('INSERT INTO social_links(place_id,platform,url) VALUES(@place_id,@platform,@url)')
        .run({ place_id: row.id, ...sl });
  });

  upsert();
  return getPlaceById(row.id);
}

module.exports = { getPlaces, getPlaceById, searchPlaces, getCategories, upsertPlace };
