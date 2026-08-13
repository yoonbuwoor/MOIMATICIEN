import '../models/learning_models.dart';
import 'extended_course_catalog.dart';

abstract class CourseCatalog {
  static final List<Course> courses = <Course>[
    Course(
      id: 'bases_geomatique',
      title: 'Comprendre la géomatique',
      subtitle:
          'Les données géospatiales, leurs formes et le cycle complet d’un projet.',
      category: 'Fondamentaux',
      durationMinutes: 20,
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/cartographie.webp',
      accentValue: 0xFFEC1745,
      objectives: [
        'Définir clairement la géomatique et ses domaines',
        'Distinguer une donnée vectorielle d’une donnée raster',
        'Reconnaître les étapes d’un projet géospatial fiable',
      ],
      sections: [
        CourseSection(
          title: '1. Une science au croisement de plusieurs disciplines',
          body:
              'La géomatique regroupe les méthodes et technologies utilisées pour acquérir, organiser, analyser et représenter des informations localisées. Elle associe notamment la cartographie, la topographie, les systèmes d’information géographique, la télédétection, le GNSS et la photogrammétrie.',
          keyPoints: [
            'Une information géographique décrit un objet et sa position.',
            'La localisation permet de relier des phénomènes qui partagent un même territoire.',
            'Une carte est un résultat possible, mais la géomatique ne se limite pas à faire des cartes.',
          ],
          fieldNote:
              'Avant de collecter une donnée, formulez la décision qu’elle devra éclairer.',
        ),
        CourseSection(
          title: '2. Vecteur et raster',
          body:
              'Le modèle vectoriel représente les objets par des points, des lignes et des polygones. Il convient aux bornes, routes et parcelles. Le modèle raster découpe l’espace en pixels réguliers. Il est adapté aux images satellites, orthophotos, modèles d’altitude et cartes continues.',
          keyPoints: [
            'Point : position ponctuelle, comme un forage ou une école.',
            'Ligne : objet allongé, comme une route ou un cours d’eau.',
            'Polygone : surface fermée, comme une commune ou une parcelle.',
            'Raster : matrice de pixels possédant chacun une valeur.',
          ],
        ),
        CourseSection(
          title: '3. Attributs, métadonnées et qualité',
          body:
              'La géométrie indique où se trouve l’objet. La table attributaire précise ce qu’il est. Les métadonnées documentent la source, la date, la méthode, le système de coordonnées, la précision et les limites d’utilisation. Sans ces informations, une donnée devient difficile à évaluer et à réutiliser.',
          keyPoints: [
            'Précision : proximité entre une mesure et la valeur vraie.',
            'Exactitude thématique : justesse de la classe attribuée à un objet.',
            'Actualité : adéquation entre la date de la donnée et le besoin.',
            'Complétude : présence des objets et attributs attendus.',
          ],
        ),
        CourseSection(
          title: '4. Le cycle d’un projet géospatial',
          body:
              'Un bon projet commence par le besoin, poursuit avec la préparation, la collecte, le contrôle qualité, le traitement, l’analyse et la restitution. La sauvegarde, la documentation et l’archivage ne sont pas des tâches secondaires : ils garantissent la traçabilité du résultat.',
          keyPoints: [
            'Cadrer le besoin et l’échelle de travail.',
            'Choisir une méthode de collecte compatible avec la précision attendue.',
            'Contrôler les données avant toute analyse.',
            'Restituer un résultat compréhensible et documenté.',
          ],
          fieldNote:
              'Conservez toujours une copie brute, une copie de travail et une sauvegarde séparée.',
        ),
      ],
    ),
    Course(
      id: 'cartographie',
      title: 'Cartographie efficace',
      subtitle:
          'Échelle, sémiologie graphique, relief et mise en page d’une carte lisible.',
      category: 'Cartographie',
      durationMinutes: 25,
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/cartographie.webp',
      accentValue: 0xFFFF6338,
      objectives: [
        'Interpréter correctement une échelle cartographique',
        'Choisir des figurés adaptés au type de donnée',
        'Composer une carte hiérarchisée et lisible',
      ],
      sections: [
        CourseSection(
          title: '1. Échelle et niveau de détail',
          body:
              'L’échelle exprime le rapport entre une distance sur la carte et la distance réelle. À 1:50 000, un centimètre sur la carte représente 50 000 centimètres, soit 500 mètres sur le terrain. Une grande échelle, comme 1:2 000, montre une petite zone avec beaucoup de détails.',
          keyPoints: [
            'Grande échelle : petit dénominateur et nombreux détails.',
            'Petite échelle : grand territoire et forte généralisation.',
            'La précision de la source doit être cohérente avec l’échelle d’affichage.',
          ],
        ),
        CourseSection(
          title: '2. Sémiologie graphique',
          body:
              'La forme, la taille, la valeur, la couleur, l’orientation et la texture constituent les variables visuelles. Pour des catégories, on utilise des couleurs distinctes. Pour une quantité ordonnée, une progression de valeur ou de taille est plus appropriée.',
          keyPoints: [
            'Les symboles doivent traduire la nature de la variable.',
            'Une couleur plus foncée suggère généralement une valeur plus forte.',
            'Évitez d’utiliser trop de classes ou des couleurs difficiles à distinguer.',
          ],
          fieldNote:
              'Testez votre carte en niveaux de gris pour vérifier que la hiérarchie reste perceptible.',
        ),
        CourseSection(
          title: '3. Représenter le relief',
          body:
              'Une courbe de niveau relie des points de même altitude. Des courbes rapprochées indiquent une pente forte, tandis que des courbes espacées indiquent une pente douce. L’ombrage, les teintes hypsométriques et les modèles numériques complètent cette lecture.',
          keyPoints: [
            'L’équidistance est la différence d’altitude entre deux courbes successives.',
            'Les courbes ne se croisent normalement pas.',
            'Le sens des vallées peut être lu grâce à la forme en V des courbes.',
          ],
        ),
        CourseSection(
          title: '4. Mise en page et hiérarchie',
          body:
              'Le titre présente le message principal. La légende explique les symboles utiles. L’échelle, l’orientation, les sources, l’auteur, la date et le système de coordonnées renforcent la compréhension et la traçabilité. Tous les éléments ne doivent pas avoir le même poids visuel.',
          keyPoints: [
            'La carte principale doit être le premier élément perçu.',
            'La légende suit l’ordre visuel des informations représentées.',
            'Les marges et espaces vides améliorent la lecture.',
            'Une carte doit répondre à une question précise.',
          ],
        ),
      ],
    ),
    Course(
      id: 'sig_qgis',
      title: 'SIG et analyse spatiale',
      subtitle:
          'Organiser des couches, interroger l’espace et produire une analyse reproductible.',
      category: 'SIG',
      durationMinutes: 32,
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/sig.webp',
      accentValue: 0xFF8A124B,
      objectives: [
        'Comprendre l’organisation d’un projet SIG',
        'Choisir les principaux outils d’analyse spatiale',
        'Éviter les erreurs de projection et de topologie',
      ],
      sections: [
        CourseSection(
          title: '1. Couches, entités et tables',
          body:
              'Un SIG organise les phénomènes en couches thématiques. Chaque entité possède une géométrie et une ligne dans une table attributaire. Les identifiants uniques permettent de relier les objets à des informations externes sans dupliquer inutilement les données.',
          keyPoints: [
            'Une couche doit représenter une famille d’objets cohérente.',
            'Un identifiant stable facilite les jointures et les mises à jour.',
            'GeoPackage permet de regrouper plusieurs couches dans un fichier ouvert et portable.',
          ],
        ),
        CourseSection(
          title: '2. Sélection, filtre et jointure',
          body:
              'Le filtre utilise les attributs, par exemple sélectionner les communes de plus de 50 000 habitants. La sélection spatiale utilise une relation géométrique, par exemple les écoles situées dans une zone inondable. Une jointure attributaire s’appuie sur une clé commune.',
          keyPoints: [
            'Filtre attributaire : condition sur les champs de la table.',
            'Sélection spatiale : contient, intersecte, touche ou se trouve à proximité.',
            'Vérifiez l’unicité et le format des clés avant une jointure.',
          ],
        ),
        CourseSection(
          title: '3. Outils d’analyse essentiels',
          body:
              'La zone tampon mesure une proximité autour d’un objet. Le découpage extrait les données à l’intérieur d’une emprise. L’intersection combine des géométries et leurs attributs. La dissolution regroupe des entités partageant une même valeur.',
          keyPoints: [
            'Buffer : créer une distance autour d’un point, d’une ligne ou d’un polygone.',
            'Clip : découper une couche par une emprise.',
            'Intersection : conserver les parties communes de deux couches.',
            'Dissolve : supprimer les limites internes selon un attribut.',
          ],
          fieldNote:
              'Pour mesurer des distances, travaillez dans un système projeté adapté à votre zone.',
        ),
        CourseSection(
          title: '4. Projection et topologie',
          body:
              'Un système de référence de coordonnées définit la manière dont les positions sont exprimées. Deux couches peuvent se superposer à l’écran grâce à la reprojection à la volée, tout en restant stockées dans des référentiels différents. La topologie contrôle les relations attendues entre les objets.',
          keyPoints: [
            'Attribuer un SCR ne transforme pas les coordonnées existantes.',
            'Reprojeter crée de nouvelles coordonnées dans un autre référentiel.',
            'Les règles topologiques détectent chevauchements, trous et connexions incorrectes.',
          ],
        ),
        CourseSection(
          title: '5. Un traitement reproductible',
          body:
              'Nommez clairement les couches, séparez données brutes et résultats, documentez les paramètres et utilisez un modèle de traitement lorsque plusieurs opérations s’enchaînent. Un résultat professionnel doit pouvoir être reproduit par une autre personne.',
          keyPoints: [
            'Ne modifiez pas directement les données sources.',
            'Notez les versions, paramètres, dates et filtres utilisés.',
            'Contrôlez visuellement et statistiquement chaque sortie.',
          ],
        ),
      ],
    ),
    Course(
      id: 'gnss_coordonnees',
      title: 'GNSS et coordonnées',
      subtitle:
          'Positionnement, précision, RTK et choix du système de référence.',
      category: 'Terrain',
      durationMinutes: 28,
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/gnss.webp',
      accentValue: 0xFF5A0B68,
      objectives: [
        'Expliquer le principe d’un positionnement GNSS',
        'Identifier les principales sources d’erreur',
        'Préparer un levé cohérent avec le SCR du projet',
      ],
      sections: [
        CourseSection(
          title: '1. Comment le récepteur calcule sa position',
          body:
              'Le récepteur estime sa distance à plusieurs satellites en mesurant le temps de propagation des signaux. La trilatération combine ces distances pour calculer la position. Quatre satellites au minimum sont nécessaires pour déterminer X, Y, Z et corriger l’erreur d’horloge du récepteur.',
          keyPoints: [
            'GPS, Galileo, GLONASS et BeiDou sont des constellations GNSS.',
            'Davantage de satellites ne garantit pas toujours une meilleure géométrie.',
            'Un PDOP faible indique généralement une géométrie favorable.',
          ],
        ),
        CourseSection(
          title: '2. Les erreurs à surveiller',
          body:
              'L’ionosphère, la troposphère, les erreurs d’orbite et d’horloge perturbent les signaux. Près des bâtiments ou surfaces métalliques, le multitrajet fait parvenir au récepteur des signaux réfléchis. Les masques comme les arbres réduisent aussi la qualité.',
          keyPoints: [
            'Éviter les façades, véhicules et lignes électriques proches.',
            'Observer la précision estimée et la solution obtenue.',
            'Répéter ou contrôler les mesures importantes.',
          ],
          fieldNote:
              'Notez les conditions du site et photographiez chaque point de contrôle.',
        ),
        CourseSection(
          title: '3. Différentiel, RTK et PPK',
          body:
              'Une base placée sur un point connu estime les erreurs communes et transmet des corrections au mobile. En RTK, les corrections sont appliquées en temps réel. En PPK, les observations sont combinées après le terrain. Une solution fixe est généralement plus fiable qu’une solution flottante.',
          keyPoints: [
            'RTK : résultat précis disponible immédiatement si la liaison fonctionne.',
            'PPK : calcul après la mission, utile lorsque la connexion est instable.',
            'La qualité du point de base influence directement tout le levé.',
          ],
        ),
        CourseSection(
          title: '4. Référentiels et hauteurs',
          body:
              'Les coordonnées géographiques s’expriment en latitude et longitude. Les coordonnées projetées s’expriment généralement en mètres. La hauteur GNSS est ellipsoïdale, alors que l’altitude usuelle se rapporte au géoïde. Mélanger ces notions peut créer un décalage vertical important.',
          keyPoints: [
            'Toujours enregistrer le code EPSG du SCR utilisé.',
            'Ne jamais supposer qu’une valeur X/Y révèle à elle seule son référentiel.',
            'Appliquer un modèle de géoïde approprié pour obtenir une altitude orthométrique.',
          ],
        ),
      ],
    ),
    Course(
      id: 'teledetection',
      title: 'Télédétection',
      subtitle:
          'Résolutions, bandes spectrales et extraction d’informations depuis l’espace.',
      category: 'Imagerie',
      durationMinutes: 30,
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/teledetection.webp',
      accentValue: 0xFFB40B4C,
      objectives: [
        'Distinguer les quatre grandes résolutions d’une image',
        'Comprendre la signature spectrale des objets',
        'Préparer une classification avec des contrôles fiables',
      ],
      sections: [
        CourseSection(
          title: '1. Observer sans contact direct',
          body:
              'La télédétection mesure l’énergie réfléchie ou émise par les objets. Un capteur passif exploite une source naturelle, souvent le Soleil. Un capteur actif, comme le radar ou le LiDAR, émet son propre signal puis mesure son retour.',
          keyPoints: [
            'Le visible ne représente qu’une petite partie du spectre électromagnétique.',
            'Le proche infrarouge est particulièrement utile pour étudier la végétation.',
            'Le radar peut acquérir des données de nuit et à travers les nuages selon la bande utilisée.',
          ],
        ),
        CourseSection(
          title: '2. Les quatre résolutions',
          body:
              'La résolution spatiale décrit la taille du pixel au sol. La résolution spectrale concerne le nombre et la finesse des bandes. La résolution temporelle indique la fréquence de revisite. La résolution radiométrique décrit la capacité à distinguer de faibles différences d’énergie.',
          keyPoints: [
            'Un pixel plus petit montre généralement davantage de détails spatiaux.',
            'Une revisite courte aide à suivre les phénomènes rapides.',
            'Le meilleur capteur est celui dont les résolutions répondent au besoin.',
          ],
        ),
        CourseSection(
          title: '3. Indices et signatures spectrales',
          body:
              'Chaque matériau interagit différemment avec les longueurs d’onde. Une végétation saine absorbe beaucoup de rouge et réfléchit fortement le proche infrarouge. Le NDVI exploite ce contraste avec la formule (PIR − Rouge) / (PIR + Rouge).',
          keyPoints: [
            'Un indice simplifie l’information mais ne remplace pas une validation terrain.',
            'L’eau, le sol nu et les ombres peuvent perturber l’interprétation.',
            'Comparez de préférence des images corrigées et acquises dans des conditions compatibles.',
          ],
        ),
        CourseSection(
          title: '4. Classification et validation',
          body:
              'Une classification supervisée apprend à partir d’échantillons connus. Ces échantillons doivent être représentatifs, bien répartis et indépendants des données de validation. Une matrice de confusion mesure ensuite les accords et les confusions entre classes.',
          keyPoints: [
            'Séparer les échantillons d’entraînement et de validation.',
            'Examiner les nuages, ombres et décalages géométriques avant le calcul.',
            'Présenter l’exactitude globale ainsi que les erreurs par classe.',
          ],
          fieldNote:
              'Une belle carte classifiée n’est pas une preuve de précision : publiez aussi la méthode de validation.',
        ),
      ],
    ),
    Course(
      id: 'photogrammetrie_drone',
      title: 'Photogrammétrie par drone',
      subtitle:
          'Du plan de vol à l’orthomosaïque, au nuage de points et au contrôle qualité.',
      category: 'Drone',
      durationMinutes: 36,
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/teledetection.webp',
      accentValue: 0xFF7E063F,
      objectives: [
        'Préparer une acquisition avec un recouvrement adapté',
        'Distinguer GCP et points de contrôle',
        'Évaluer la qualité des principaux produits',
      ],
      sections: [
        CourseSection(
          title: '1. Géométrie de l’acquisition',
          body:
              'La photogrammétrie reconstruit la géométrie d’une scène à partir d’images qui se recouvrent. Les détails communs sont identifiés sur plusieurs clichés, puis les positions de caméra et les points 3D sont estimés. Un recouvrement longitudinal et latéral suffisant est indispensable.',
          keyPoints: [
            'La texture du terrain aide le logiciel à identifier des points homologues.',
            'L’eau, les surfaces brillantes ou uniformes sont difficiles à reconstruire.',
            'Les virages doivent être prévus hors de la zone utile lorsque cela est possible.',
          ],
        ),
        CourseSection(
          title: '2. GSD, hauteur et netteté',
          body:
              'Le GSD représente la dimension au sol d’un pixel. Il dépend notamment de la hauteur de vol, de la focale et du capteur. Voler plus bas réduit le GSD, mais augmente le nombre d’images, le temps de mission et les risques opérationnels.',
          keyPoints: [
            'Choisir le GSD selon le plus petit objet à distinguer et la précision attendue.',
            'Une vitesse trop élevée ou une lumière insuffisante favorise le flou de mouvement.',
            'Une résolution fine ne corrige pas une mauvaise géométrie de prise de vue.',
          ],
        ),
        CourseSection(
          title: '3. GCP et points de contrôle',
          body:
              'Les points d’appui au sol, ou GCP, participent à l’ajustement du modèle. Les points de contrôle indépendants ne servent pas au calcul : ils évaluent l’erreur finale. Les confondre produit une estimation trop optimiste de la précision.',
          keyPoints: [
            'Répartir les GCP en périphérie et à l’intérieur de la zone.',
            'Mesurer les points dans un référentiel et avec une précision connus.',
            'Réserver des checkpoints indépendants pour le contrôle.',
          ],
          fieldNote:
              'Inspectez chaque cible sur plusieurs images avant de l’utiliser dans l’ajustement.',
        ),
        CourseSection(
          title: '4. Produits et contrôle qualité',
          body:
              'Le nuage de points décrit la surface en 3D. Le MNS inclut bâtiments et végétation, tandis qu’un MNT cherche à représenter le sol nu. L’orthomosaïque corrige la perspective et le relief pour permettre des mesures planimétriques cohérentes.',
          keyPoints: [
            'Contrôler les trous, déformations, doubles objets et raccords.',
            'Analyser les erreurs sur les checkpoints, pas seulement sur les GCP.',
            'Documenter le GSD, le référentiel, la date, le capteur et le logiciel.',
            'Ne pas confondre précision relative et précision absolue.',
          ],
        ),
      ],
    ),
    ...ExtendedCourseCatalog.courses,
  ];

  static Course byId(String id) =>
      courses.firstWhere((course) => course.id == id);
}
