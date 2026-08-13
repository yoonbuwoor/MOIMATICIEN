# Validation de la version 1.1.0+2

Contrôles effectués dans l’espace de travail :

- syntaxe des 5 160 lignes Dart analysée avec le parseur Tree-sitter Dart : valide ;
- `flutter pub get` avec Flutter 3.44.9 et Dart 3.12.2 : réussi ;
- `flutter analyze --no-fatal-infos --no-fatal-warnings` : aucun problème ;
- `flutter test` : 10 tests sur 10 réussis ;
- 16 identifiants de cours uniques ;
- 160 identifiants de questions uniques ;
- 10 questions pour chacun des 16 cours ;
- 17 définitions de quiz, dont le défi transversal de 20 questions ;
- toutes les images référencées existent ;
- manifeste Android XML valide ;
- `pubspec.yaml` et `.github/workflows/main.yml` valides ;
- script de configuration Android compilé par Python ;
- autorisation `POST_NOTIFICATIONS`, WorkManager et désucrage Java configurés ;
- étape CI de rejet au-delà de 94 Mio pour APK et AAB.

Les contrôles Flutter ont été exécutés avec la même version que le workflow GitHub Actions. Le build Android binaire est produit par `main.yml`, qui compile l’APK et l’AAB avec Flutter 3.44.9.
