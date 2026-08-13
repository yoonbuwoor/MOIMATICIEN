# Validation technique — Moi Géomaticien 1.3.0

## Contenu contrôlé

- 34 cours et plus de 136 sections pédagogiques ;
- 680 questions uniques ;
- 34 quiz thématiques de 20 questions ;
- 1 défi transversal de 68 questions ;
- estimation des temps de lecture dérivée du contenu, sans durée manuelle ;
- 12 illustrations originales, dont 8 scènes haute définition ;
- 12 parcours de certification sectoriels ;
- illustrations haute définition dédiées aux certifications et au drone ;
- icônes Android générées pour les cinq densités standards.

## Contrôles réalisés

- analyse syntaxique de tous les fichiers Dart : réussie ;
- analyse Flutter 3.44.9 : aucun problème ;
- seize tests unitaires et widgets : tous réussis ;
- unicité des identifiants de cours et de questions : contrôlée ;
- cohérence des chemins d’assets : contrôlée ;
- validation YAML du workflow GitHub Actions : réussie ;
- validation XML des ressources Android : réussie ;
- compilation Python du configurateur Android : réussie ;
- absence de Firebase et d’API distante : contrôlée ;
- permission Internet limitée à l’ouverture volontaire des liens externes : configurée ;
- permission Android 13 pour les notifications et tâche périodique WorkManager : configurées ;
- limite CI de 94 Mio pour APK et AAB : configurée.

## Compilation Flutter

La validation locale utilise Flutter 3.44.9 et Dart 3.12.2, comme le workflow. Le projet contient un workflow GitHub Actions qui répète `flutter analyze` et `flutter test`, puis compile automatiquement l’APK et l’AAB de production.
