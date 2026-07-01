'use strict';

require('dotenv').config();

const express      = require('express');
const helmet       = require('helmet');
const compression  = require('compression');
const cors         = require('cors');
const morgan       = require('morgan');
const rateLimit    = require('express-rate-limit');

const logger         = require('./services/logger');
const { errorHandler } = require('./middleware/errorHandler');

const healthRouter     = require('./routes/health');
const placesRouter     = require('./routes/places');
const categoriesRouter = require('./routes/categories');

// ── App ────────────────────────────────────────────────────────────────────────
const app  = express();
const PORT = parseInt(process.env.PORT ?? '3000', 10);

// ── Security / performance ─────────────────────────────────────────────────────
app.use(helmet());
app.use(compression());

// ── CORS ───────────────────────────────────────────────────────────────────────
const originsEnv = process.env.CORS_ORIGINS ?? '*';
const corsOrigins = originsEnv === '*' ? '*' : originsEnv.split(',').map(s => s.trim());
app.use(cors({
  origin: corsOrigins,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'X-API-Key'],
}));

// ── Rate limiting ──────────────────────────────────────────────────────────────
app.use(rateLimit({
  windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS ?? '60000', 10),
  max:      parseInt(process.env.RATE_LIMIT_MAX        ?? '120',   10),
  standardHeaders: true,
  legacyHeaders:   false,
}));

// ── Body parsing ───────────────────────────────────────────────────────────────
app.use(express.json({ limit: '2mb' }));

// ── Request logging ────────────────────────────────────────────────────────────
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));

// ── Routes ─────────────────────────────────────────────────────────────────────
app.use('/api/health',     healthRouter);
app.use('/api/places',     placesRouter);
app.use('/api/categories', categoriesRouter);

// ── 404 ───────────────────────────────────────────────────────────────────────
app.use((_req, res) => res.status(404).json({ error: 'Not found' }));

// ── Error handler ──────────────────────────────────────────────────────────────
app.use(errorHandler);

// ── Start ──────────────────────────────────────────────────────────────────────
app.listen(PORT, () => {
  logger.info(`🚀  La2eny API listening on http://localhost:${PORT}`);
  logger.info(`     GET  /api/health`);
  logger.info(`     GET  /api/categories`);
  logger.info(`     GET  /api/places?page=0&limit=100`);
  logger.info(`     GET  /api/places?updated_since=<ISO>`);
  logger.info(`     GET  /api/places?q=<search>`);
  logger.info(`     GET  /api/places/:id`);
});

module.exports = app;
