#!/usr/bin/env bash
set -euo pipefail

flutter create --platforms=android --org com.novateur221 --project-name moi_geomaticien .
python3 tool/configure_android.py
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter build apk --release
flutter build appbundle --release

echo "APK : build/app/outputs/flutter-apk/app-release.apk"
echo "AAB : build/app/outputs/bundle/release/app-release.aab"
