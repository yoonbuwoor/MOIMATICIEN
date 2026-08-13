# Validation technique — Moi Géomaticien 1.0.0

## Contenu contrôlé

- 6 cours ;
- 25 sections pédagogiques ;
- 48 questions uniques ;
- 6 quiz thématiques de 8 questions ;
- 1 défi transversal de 12 questions ;
- 4 illustrations originales optimisées en WebP ;
- icônes Android générées pour les cinq densités standards.

## Contrôles réalisés

- analyse syntaxique de tous les fichiers Dart : réussie ;
- unicité des identifiants de cours et de questions : contrôlée ;
- cohérence des chemins d’assets : contrôlée ;
- validation YAML du workflow GitHub Actions : réussie ;
- validation XML des ressources Android : réussie ;
- compilation Python du configurateur Android : réussie ;
- absence de Firebase, d’API distante et de permission Internet dans le manifeste de production : contrôlée.

## Compilation Flutter

L’environnement de création ne contient pas le SDK Flutter. La compilation binaire locale n’y a donc pas été exécutée. Le projet contient un workflow GitHub Actions qui installe Flutter 3.44.9, exécute `flutter analyze` et `flutter test`, puis compile automatiquement l’APK et l’AAB de production.
