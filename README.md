# LocalAI — AI-Powered Local Discovery App

GCC-market bilingual (Arabic/English) business discovery app with on-device AI.

## 🚀 Quick Start

### Prerequisites
- Flutter 3.22+ (`flutter --version`)
- Dart 3.3+
- Android Studio or Xcode

### Setup (run once)
```bash
cd localai_app
chmod +x setup.sh
./setup.sh
```

This runs:
1. `flutter pub get` — installs all packages
2. `dart run build_runner build` — generates Drift database code (`*.g.dart`)
3. `flutter gen-l10n` — generates Arabic/English localizations

### Run the app
```bash
# Development (without backend — shows empty state)
flutter run

# With your backend
flutter run --dart-define=API_BASE_URL=https://your-backend.com/api
```

## 📁 Project Structure

```
lib/
├── main.dart               # Entry point
├── app.dart                # App root, theme, locale, lifecycle
├── core/                   # Constants, theme, errors, utils
├── domain/                 # Entities, repository interfaces
├── data/                   # Database, API, sync engine
├── ai/                     # AI conversation (MediaPipe — stub for now)
└── presentation/           # Screens, providers, router
```

## 🗺️ Feature Status

| Feature | Status | Week |
|---------|--------|------|
| Home screen | ✅ Complete | 3 |
| Discover + Search | ✅ Complete | 3 |
| Filter & Sort | ✅ Complete | 3 |
| Place Detail + Map | ✅ Complete | 4 |
| AI Chat (rule-based) | ✅ Complete | 5-6 |
| Delta Sync | ✅ Complete | 2 |
| Offline SQLite cache | ✅ Complete | 2 |
| Favorites | ✅ Complete | 7 |
| Profile + Settings | ✅ Complete | 7 |
| MediaPipe LLM | 🔜 Integrate model file | Post-MVP |
| Voice (STT/TTS) | 🔜 | v1.1 |
| Apple Sign-In | 🔜 | v1.1 |

## 🤖 AI Chat

Currently uses a **rule-based preference extractor** that:
- Detects cuisine type, budget, distance from natural language
- Ranks places using a weighted scoring algorithm
- Works fully offline

To integrate **Gemma 3 1B (MediaPipe)**:
1. Download model: `gemma-3-1b-it-int4.task` from Google AI
2. Place in `assets/models/`
3. Replace `_extractPreferences()` in `chat_screen.dart` with MediaPipe LLM inference

## 🔗 Backend API

Your backend must expose:
```
GET /api/places?page=0&limit=100          # Full sync
GET /api/places?updated_since=2024-01-01  # Delta sync
GET /api/categories                        # All categories
```

Expected place JSON structure is in the documentation.

## 🌍 Languages

- Arabic (RTL) — full UI + AI conversation
- English (LTR) — full UI + AI conversation
- Auto-detects device language on first launch
- Toggle in Profile screen

## 🗄️ Architecture

Clean Architecture: `Presentation → Domain → Data`
- **State**: Flutter Riverpod (manual providers, no code gen)
- **Database**: Drift + SQLite + FTS5 (Arabic/English full-text search)
- **Maps**: OpenStreetMap via flutter_map (free, offline)
- **Sync**: Delta sync with `updated_since` timestamp
