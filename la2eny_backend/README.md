# La2eny Backend

REST API for the La2eny local-discovery Flutter app.
Built with **Node.js + Express + SQLite (better-sqlite3)**.

---

## Quick start

```bash
# 1. Install dependencies
npm install

# 2. Copy env file and edit if needed
cp .env.example .env

# 3. Seed the database with the 12 GCC sample places
npm run seed

# 4. Start the dev server (auto-restarts on change)
npm run dev

# 5. Verify it's working
curl http://localhost:3000/api/health
```

---

## Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/health` | Server health + record counts |
| `GET` | `/api/categories` | All categories |
| `POST` | `/api/categories` | Create/update a category *(API key required in prod)* |
| `GET` | `/api/places` | Paginated list of active places |
| `GET` | `/api/places?page=0&limit=100` | Paged list (Flutter full sync) |
| `GET` | `/api/places?updated_since=<ISO>` | Delta sync (only changed records) |
| `GET` | `/api/places?q=<text>` | Full-text search (Arabic + English) |
| `GET` | `/api/places/:id` | Single place by ID |
| `POST` | `/api/places` | Upsert a place *(API key required in prod)* |

### Example responses

**`GET /api/places?page=0&limit=2`**
```json
{
  "data": [
    {
      "id": 1,
      "name_ar": "مطعم البيك",
      "name_en": "Al Baik",
      "latitude": 24.7136,
      "longitude": 46.6753,
      "rating": 4.7,
      "price_level": 1,
      "categories": [{ "id": 8, "name_en": "Fast Food", ... }],
      "working_hours": [...],
      "images": [...],
      "social_links": [...]
    }
  ],
  "total": 12,
  "page": 0,
  "limit": 2
}
```

**`GET /api/categories`**
```json
{
  "data": [
    { "id": 2, "name_ar": "مقاهي", "name_en": "Cafés", "icon": "☕" },
    ...
  ]
}
```

---

## Connect your Flutter app

In `lib/core/constants/api_constants.dart` the base URL is set via `--dart-define`:

```bash
# Development (local machine → Android emulator)
flutter run --dart-define=USE_MOCK_API=false \
            --dart-define=API_BASE_URL=http://10.0.2.2:3000/api

# Development (local machine → iOS simulator)
flutter run --dart-define=USE_MOCK_API=false \
            --dart-define=API_BASE_URL=http://localhost:3000/api

# Development (local machine → Chrome)
flutter run --dart-define=USE_MOCK_API=false \
            --dart-define=API_BASE_URL=http://localhost:3000/api \
            -d chrome

# Development (local machine → physical device on same Wi-Fi)
flutter run --dart-define=USE_MOCK_API=false \
            --dart-define=API_BASE_URL=http://192.168.1.x:3000/api

# Production
flutter run --dart-define=USE_MOCK_API=false \
            --dart-define=API_BASE_URL=https://api.your-domain.com/api
```

> **Tip:** You can also combine with Gemma 4:
> ```bash
> flutter run \
>   --dart-define=USE_MOCK_API=false \
>   --dart-define=API_BASE_URL=http://localhost:3000/api \
>   --dart-define=GEMINI_API_KEY=your_key_here
> ```

---

## Project structure

```
la2eny-backend/
├── data/                   ← SQLite database file (git-ignored)
├── src/
│   ├── index.js            ← Express app + server startup
│   ├── db/
│   │   ├── database.js     ← SQLite connection + schema creation
│   │   └── seed.js         ← Seeds 12 GCC sample places
│   ├── models/
│   │   └── placeModel.js   ← All DB queries (places + categories)
│   ├── routes/
│   │   ├── places.js       ← GET|POST /api/places[/:id]
│   │   ├── categories.js   ← GET|POST /api/categories
│   │   └── health.js       ← GET /api/health
│   ├── middleware/
│   │   ├── auth.js         ← API-key guard for write endpoints
│   │   └── errorHandler.js ← Centralised error responses
│   └── services/
│       └── logger.js       ← Winston logger
├── .env.example
├── package.json
└── README.md
```

---

## Environment variables

| Variable | Default | Description |
|---|---|---|
| `PORT` | `3000` | HTTP port |
| `NODE_ENV` | `development` | `production` enables stricter auth + JSON logging |
| `DB_PATH` | `./data/la2eny.db` | Path to the SQLite file |
| `API_SECRET` | *(none)* | Key required for POST endpoints in production |
| `CORS_ORIGINS` | `*` | Comma-separated allowed origins |
| `RATE_LIMIT_WINDOW_MS` | `60000` | Rate-limit window in ms |
| `RATE_LIMIT_MAX` | `120` | Max requests per window |

---

## Database schema

```
categories        → id, name_ar, name_en, icon, updated_at
places            → id, name_ar/en, description_ar/en, address_ar/en,
                    latitude, longitude, phone, website, rating,
                    review_count, price_level, is_active, created_at, updated_at
place_categories  → place_id, category_id  (many-to-many)
working_hours     → id, place_id, day_of_week, open_time, close_time, is_closed
place_images      → id, place_id, url, is_primary, sort_order
social_links      → id, place_id, platform, url
places_fts        → FTS5 virtual table (Arabic + English full-text search)
```

---

## Production deployment

```bash
# Set production env
NODE_ENV=production
API_SECRET=your_strong_secret
CORS_ORIGINS=https://your-flutter-web.com

# Start
npm start

# Or with PM2
npm install -g pm2
pm2 start src/index.js --name la2eny-api
pm2 save
```
