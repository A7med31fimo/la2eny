'use strict';

const path = require('path');
const Database = require('better-sqlite3');

const DB_PATH = process.env.DB_PATH
  ? path.resolve(process.env.DB_PATH)
  : path.resolve(__dirname, '../../data/la2eny.db');

let _db;

/**
 * Returns the singleton SQLite connection.
 * Creates all tables on first call.
 */
function getDb() {
  if (_db) return _db;

  _db = new Database(DB_PATH);
  _db.pragma('journal_mode = WAL');
  _db.pragma('foreign_keys = ON');
  _db.pragma('synchronous = NORMAL');

  _createSchema(_db);
  return _db;
}

function _createSchema(db) {
  db.exec(/* sql */ `
    -- ── Categories ────────────────────────────────────────────────────────────
    CREATE TABLE IF NOT EXISTS categories (
      id          INTEGER PRIMARY KEY,
      name_ar     TEXT    NOT NULL,
      name_en     TEXT    NOT NULL,
      icon        TEXT,
      updated_at  TEXT    NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ', 'now'))
    );

    -- ── Places ────────────────────────────────────────────────────────────────
    CREATE TABLE IF NOT EXISTS places (
      id              INTEGER PRIMARY KEY,
      name_ar         TEXT    NOT NULL,
      name_en         TEXT    NOT NULL,
      description_ar  TEXT    NOT NULL DEFAULT '',
      description_en  TEXT    NOT NULL DEFAULT '',
      address_ar      TEXT    NOT NULL DEFAULT '',
      address_en      TEXT    NOT NULL DEFAULT '',
      latitude        REAL    NOT NULL,
      longitude       REAL    NOT NULL,
      phone           TEXT,
      website         TEXT,
      rating          REAL    NOT NULL DEFAULT 0.0,
      review_count    INTEGER NOT NULL DEFAULT 0,
      price_level     INTEGER NOT NULL DEFAULT 1 CHECK (price_level BETWEEN 1 AND 4),
      is_active       INTEGER NOT NULL DEFAULT 1,
      created_at      TEXT    NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ', 'now')),
      updated_at      TEXT    NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%SZ', 'now'))
    );

    CREATE INDEX IF NOT EXISTS idx_places_active     ON places(is_active);
    CREATE INDEX IF NOT EXISTS idx_places_updated_at ON places(updated_at);
    CREATE INDEX IF NOT EXISTS idx_places_rating     ON places(rating);

    -- ── Place ↔ Category (many-to-many) ──────────────────────────────────────
    CREATE TABLE IF NOT EXISTS place_categories (
      place_id    INTEGER NOT NULL REFERENCES places(id)     ON DELETE CASCADE,
      category_id INTEGER NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
      PRIMARY KEY (place_id, category_id)
    );

    CREATE INDEX IF NOT EXISTS idx_pc_place    ON place_categories(place_id);
    CREATE INDEX IF NOT EXISTS idx_pc_category ON place_categories(category_id);

    -- ── Working Hours ─────────────────────────────────────────────────────────
    CREATE TABLE IF NOT EXISTS working_hours (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      place_id    INTEGER NOT NULL REFERENCES places(id) ON DELETE CASCADE,
      day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
      open_time   TEXT    NOT NULL DEFAULT '00:00',
      close_time  TEXT    NOT NULL DEFAULT '00:00',
      is_closed   INTEGER NOT NULL DEFAULT 0,
      UNIQUE (place_id, day_of_week)
    );

    CREATE INDEX IF NOT EXISTS idx_wh_place ON working_hours(place_id);

    -- ── Place Images ──────────────────────────────────────────────────────────
    CREATE TABLE IF NOT EXISTS place_images (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      place_id    INTEGER NOT NULL REFERENCES places(id) ON DELETE CASCADE,
      url         TEXT    NOT NULL,
      is_primary  INTEGER NOT NULL DEFAULT 0,
      sort_order  INTEGER NOT NULL DEFAULT 0
    );

    CREATE INDEX IF NOT EXISTS idx_img_place ON place_images(place_id);

    -- ── Social Links ──────────────────────────────────────────────────────────
    CREATE TABLE IF NOT EXISTS social_links (
      id          INTEGER PRIMARY KEY AUTOINCREMENT,
      place_id    INTEGER NOT NULL REFERENCES places(id) ON DELETE CASCADE,
      platform    TEXT    NOT NULL,
      url         TEXT    NOT NULL
    );

    -- ── Full-text Search ──────────────────────────────────────────────────────
    CREATE VIRTUAL TABLE IF NOT EXISTS places_fts USING fts5(
      name_en, name_ar, description_en, description_ar, address_en, address_ar,
      content='places',
      content_rowid='id'
    );

    -- Keep FTS in sync with places table
    CREATE TRIGGER IF NOT EXISTS places_ai AFTER INSERT ON places BEGIN
      INSERT INTO places_fts(rowid, name_en, name_ar, description_en, description_ar, address_en, address_ar)
      VALUES (new.id, new.name_en, new.name_ar, new.description_en, new.description_ar, new.address_en, new.address_ar);
    END;

    CREATE TRIGGER IF NOT EXISTS places_ad AFTER DELETE ON places BEGIN
      INSERT INTO places_fts(places_fts, rowid, name_en, name_ar, description_en, description_ar, address_en, address_ar)
      VALUES ('delete', old.id, old.name_en, old.name_ar, old.description_en, old.description_ar, old.address_en, old.address_ar);
    END;

    CREATE TRIGGER IF NOT EXISTS places_au AFTER UPDATE ON places BEGIN
      INSERT INTO places_fts(places_fts, rowid, name_en, name_ar, description_en, description_ar, address_en, address_ar)
      VALUES ('delete', old.id, old.name_en, old.name_ar, old.description_en, old.description_ar, old.address_en, old.address_ar);
      INSERT INTO places_fts(rowid, name_en, name_ar, description_en, description_ar, address_en, address_ar)
      VALUES (new.id, new.name_en, new.name_ar, new.description_en, new.description_ar, new.address_en, new.address_ar);
    END;
  `);
}

module.exports = { getDb };
