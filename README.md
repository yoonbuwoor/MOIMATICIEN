# Moi Géomaticien

Application Flutter d’apprentissage de la géomatique créée par **Novateur221**.

## Première version

- 6 cours illustrés disponibles hors ligne ;
- 48 questions réparties en 6 quiz thématiques ;
- un défi transversal de 12 questions ;
- correction et explication après chaque réponse ;
- progression des cours et meilleurs scores enregistrés localement ;
- interface mobile claire, responsive et sans compte utilisateur ;
- identité visuelle « Moi Géomaticien — by Novateur221 ».

## Domaines couverts

1. Fondamentaux de la géomatique
2. Cartographie
3. SIG et analyse spatiale
4. GNSS et systèmes de coordonnées
5. Télédétection
6. Photogrammétrie par drone

## Lancer le projet

Prérequis : Flutter 3.44.9 ou une version stable compatible, Java 17 et Python 3.

À la première utilisation, complétez la plateforme Android puis lancez l’application :

```bash
flutter create --platforms=android --org com.novateur221 --project-name moi_geomaticien .
python3 tool/configure_android.py
flutter pub get
flutter run
```

Sous Windows, `build_android.bat` automatise la préparation, les tests et la compilation des deux formats Android.

## Compiler Android

```bash
flutter build apk --release
flutter build appbundle --release
```

Les fichiers sont créés dans :

- `build/app/outputs/flutter-apk/app-release.apk`
- `build/app/outputs/bundle/release/app-release.aab`

Le workflow GitHub Actions inclus compile automatiquement **l’APK et l’AAB** et les publie dans un même artefact téléchargeable.

## Identité Android

- Nom public : `Moi Géomaticien`
- Package : `com.novateur221.moi_geomaticien`
- Version : `1.0.0+1`
- Android minimum : `7.0 (API 24)`

## Modifier les contenus

- Cours : `lib/data/course_catalog.dart`
- Quiz : `lib/data/quiz_catalog.dart`
- Illustrations : `assets/images/`
- Logo : `assets/brand/`

Tous les contenus de cette version sont intégrés dans l’application : aucune connexion Internet n’est nécessaire pour apprendre ou répondre aux quiz.
