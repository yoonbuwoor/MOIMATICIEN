# Validation de la version 1.2.0+3

Contrôles effectués dans l’espace de travail :

- `flutter pub get` avec Flutter 3.44.9 et Dart 3.12.2 : réussi ;
- `flutter analyze --no-fatal-infos --no-fatal-warnings` : aucun problème ;
- `flutter test` : 14 tests sur 14 réussis ;
- 16 identifiants de cours uniques ;
- 160 identifiants de questions uniques ;
- 12 identifiants de parcours de certification uniques ;
- 8 parties pédagogiques dans le cours Photogrammétrie par drone ;
- 10 questions pour chacun des 16 cours ;
- 17 définitions de quiz, dont le défi transversal de 20 questions ;
- toutes les images référencées existent ;
- manifeste Android XML valide ;
- `pubspec.yaml` et `.github/workflows/main.yml` valides ;
- script de configuration Android compilé par Python ;
- autorisations `INTERNET` et `POST_NOTIFICATIONS`, WorkManager et désucrage Java configurés ;
- liens WhatsApp, e-mail, communauté, confidentialité et Drone Atlas centralisés ;
- page HTML de confidentialité autonome et responsive contrôlée ;
- étape CI de rejet au-delà de 94 Mio pour APK et AAB.

Les contrôles Flutter ont été exécutés avec la même version que le workflow GitHub Actions. Le build Android binaire est produit par `main.yml`, qui compile l’APK et l’AAB avec Flutter 3.44.9.
