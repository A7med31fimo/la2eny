#!/bin/bash
set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  LocalAI App — Setup Script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "▶ Step 1/4: Clean old lock and cache..."
rm -f pubspec.lock
rm -rf .dart_tool
rm -rf build

echo "▶ Step 2/4: Installing dependencies..."
flutter pub get

echo "▶ Step 3/4: Generating Drift database code..."
# Use flutter pub run (not dart run) to ensure Flutter context is available
flutter pub run build_runner build --delete-conflicting-outputs

echo "▶ Step 4/4: Generating localizations..."
flutter gen-l10n

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Setup complete!"
echo ""
echo "  Run the app:"
echo "  flutter run --dart-define=API_BASE_URL=https://your-backend.com/api"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
