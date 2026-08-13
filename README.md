# Moi Géomaticien

Application Flutter d’apprentissage de la géomatique créée par **Novateur221**.

## Version ludique 1.4

- 34 cours illustrés disponibles hors ligne ;
- 680 questions réparties en 34 quiz thématiques de 20 questions ;
- un défi transversal de 68 questions, soit deux questions par cours ;
- correction et explication après chaque réponse ;
- progression des cours et meilleurs scores enregistrés localement ;
- modes aléatoires de 5 ou 10 questions et sprint chronométré de 10 questions ;
- missions quotidiennes, XP, niveaux, séries, combos, récompenses et animation de victoire ;
- 10 vies offertes chaque jour (les 10 lettres de « géomatique ») et 2 vies gagnées par leçon terminée ;
- rappels locaux automatiquement programmés toutes les 12 heures ;
- interface mobile claire, responsive et sans compte utilisateur ;
- espace **Certifications** avec 12 parcours adaptés à différents secteurs ;
- demandes sur mesure par WhatsApp ou e-mail, coordonnées masquées dans l’interface ;
- accès direct à la communauté WhatsApp Novateur221 ;
- temps de lecture réalistes calculés automatiquement selon le nombre de mots ;
- module drone compact de 4 parties et renvoi vers Drone Atlas Academy ;
- politique de confidentialité dédiée, prête à publier sur Netlify ;
- identité visuelle « Moi Géomaticien — by Novateur221 ».

## Domaines couverts

1. Fondamentaux de la géomatique
2. Cartographie
3. SIG et analyse spatiale
4. GNSS et systèmes de coordonnées
5. Télédétection
6. Photogrammétrie par drone
7. Topographie et nivellement
8. Géodésie et projections
9. Bases de données spatiales et PostGIS
10. Webmapping et services OGC
11. Géostatistique et interpolation
12. MNT et analyse hydrologique
13. Cadastre et information foncière
14. Python pour la géomatique
15. Collecte mobile et contrôle qualité
16. SIG environnemental et analyse des risques
17. QGIS pratique et ArcGIS Pro
18. Google Earth Engine
19. LiDAR et nuages de points
20. Imagerie radar SAR
21. Occupation du sol et changements
22. Agriculture et santé publique
23. Réseaux, transport et urbanisme
24. Géomarketing
25. OpenStreetMap et données ouvertes
26. Métadonnées et gouvernance
27. GeoServer et publication SIG
28. Kit terrain
29. Intelligence artificielle géospatiale
30. Gestion de projet, portfolio et métiers

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

Le workflow `.github/workflows/main.yml` compile automatiquement **l’APK et l’AAB**, vérifie que chaque fichier reste sous **94 Mo**, puis les publie dans un même artefact téléchargeable.

## Identité Android

- Nom public : `Moi Géomaticien`
- Package : `com.novateur221.moi_geomaticien`
- Version : `1.4.1+6`
- Android minimum : `7.0 (API 24)`

## Modifier les contenus

- Cours : `lib/data/course_catalog.dart`, `extended_course_catalog.dart` et `professional_course_catalog.dart`
- Quiz : `lib/data/quiz_catalog.dart`, `extended_quiz_catalog.dart`, `quiz_expansion_catalog.dart` et `professional_quiz_catalog.dart`
- Certifications : `lib/data/certification_catalog.dart`
- Illustrations : `assets/images/`
- Logo : `assets/brand/`
- Page Netlify : `web_legal/confidentialiteMg.html`

Les cours, quiz, images et la progression restent disponibles hors ligne. Une connexion n’est utilisée que lorsque l’utilisateur choisit d’ouvrir un lien externe : contact, communauté, confidentialité ou téléchargement de Drone Atlas Academy.

## Confidentialité

Le bouton visible **Politique de confidentialité** ouvre la page publique sans afficher son adresse technique. Pour obtenir exactement l’URL attendue, déposez `web_legal/confidentialiteMg.html` à la racine du site Netlify `novateur.netlify.app`.

## Rappels d’apprentissage

Au premier lancement, l’application explique le rappel automatique puis demande l’autorisation système. Un travail périodique local prépare ensuite un rappel environ toutes les 12 heures. Android peut décaler son exécution selon l’économie de batterie et l’utilisateur garde toujours le contrôle de l’autorisation dans les réglages du téléphone. Aucun bouton de désactivation n’est proposé dans l’application.
