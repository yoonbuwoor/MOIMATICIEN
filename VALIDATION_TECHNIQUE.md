# Validation technique — Moi Géomaticien 1.1.0

## Contenu contrôlé

- 16 cours et plus de 64 sections pédagogiques ;
- 160 questions uniques ;
- 16 quiz thématiques de 10 questions ;
- 1 défi transversal de 20 questions ;
- 10 illustrations originales, dont 6 scènes haute définition ;
- icônes Android générées pour les cinq densités standards.

## Contrôles réalisés

- analyse syntaxique de tous les fichiers Dart : réussie ;
- analyse Flutter 3.44.9 : aucun problème ;
- dix tests unitaires et widgets : tous réussis ;
- unicité des identifiants de cours et de questions : contrôlée ;
- cohérence des chemins d’assets : contrôlée ;
- validation YAML du workflow GitHub Actions : réussie ;
- validation XML des ressources Android : réussie ;
- compilation Python du configurateur Android : réussie ;
- absence de Firebase, d’API distante et de permission Internet dans le manifeste de production : contrôlée ;
- permission Android 13 pour les notifications et tâche périodique WorkManager : configurées ;
- limite CI de 94 Mio pour APK et AAB : configurée.

## Compilation Flutter

La validation locale utilise Flutter 3.44.9 et Dart 3.12.2, comme le workflow. Le projet contient un workflow GitHub Actions qui répète `flutter analyze` et `flutter test`, puis compile automatiquement l’APK et l’AAB de production.
