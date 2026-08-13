#!/usr/bin/env bash
set -euo pipefail

flutter create --platforms=android --org com.novateur221 --project-name moi_geomaticien .
python3 tool/configure_android.py
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter build apk --release
flutter build appbundle --release

max_bytes=$((94 * 1024 * 1024))
for file in build/app/outputs/flutter-apk/app-release.apk build/app/outputs/bundle/release/app-release.aab; do
  size=$(stat -c%s "$file")
  if (( size > max_bytes )); then
    echo "ERREUR : $file dépasse 94 Mo."
    exit 1
  fi
done

echo "APK : build/app/outputs/flutter-apk/app-release.apk"
echo "AAB : build/app/outputs/bundle/release/app-release.aab"
