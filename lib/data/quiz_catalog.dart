import '../models/learning_models.dart';
import 'extended_quiz_catalog.dart';

abstract class QuizCatalog {
  static final List<QuizDefinition> definitions = <QuizDefinition>[
    QuizDefinition(
      id: 'quiz_bases',
      title: 'Bases de la géomatique',
      subtitle: '10 questions • Fondamentaux',
      accentValue: 0xFFEC1745,
      iconName: 'explore',
      courseId: 'bases_geomatique',
    ),
    QuizDefinition(
      id: 'quiz_carto',
      title: 'Cartographie',
      subtitle: '10 questions • Échelle et sémiologie',
      accentValue: 0xFFFF6338,
      iconName: 'map',
      courseId: 'cartographie',
    ),
    QuizDefinition(
      id: 'quiz_sig',
      title: 'SIG et analyse spatiale',
      subtitle: '10 questions • Couches et traitements',
      accentValue: 0xFF8A124B,
      iconName: 'layers',
      courseId: 'sig_qgis',
    ),
    QuizDefinition(
      id: 'quiz_gnss',
      title: 'GNSS et coordonnées',
      subtitle: '10 questions • Terrain et précision',
      accentValue: 0xFF5A0B68,
      iconName: 'satellite',
      courseId: 'gnss_coordonnees',
    ),
    QuizDefinition(
      id: 'quiz_teledetection',
      title: 'Télédétection',
      subtitle: '10 questions • Images et spectre',
      accentValue: 0xFFB40B4C,
      iconName: 'image',
      courseId: 'teledetection',
    ),
    QuizDefinition(
      id: 'quiz_photogrammetrie',
      title: 'Photogrammétrie drone',
      subtitle: '10 questions • Acquisition et qualité',
      accentValue: 0xFF7E063F,
      iconName: 'drone',
      courseId: 'photogrammetrie_drone',
    ),
    ...ExtendedQuizCatalog.definitions,
    QuizDefinition(
      id: 'defi_geomaticien',
      title: 'Défi du géomaticien',
      subtitle: '20 questions • Tous les domaines',
      accentValue: 0xFF241620,
      iconName: 'trophy',
    ),
  ];

  static final List<QuizQuestion> questions = <QuizQuestion>[
    QuizQuestion(
      id: 'b01',
      courseId: 'bases_geomatique',
      question: 'Quelle définition décrit le mieux la géomatique ?',
      options: [
        'La création exclusive de cartes papier',
        'L’ensemble des méthodes pour acquérir, gérer, analyser et représenter des données localisées',
        'La mesure des distances uniquement avec un GPS',
        'La programmation de logiciels sans composante spatiale',
      ],
      correctIndex: 1,
      explanation:
          'La géomatique couvre tout le cycle de l’information géographique, de la collecte jusqu’à l’analyse et la restitution.',
    ),
    QuizQuestion(
      id: 'b02',
      courseId: 'bases_geomatique',
      question:
          'Quel modèle convient le mieux pour représenter des parcelles cadastrales ?',
      options: [
        'Raster',
        'Polygones vectoriels',
        'Texte brut',
        'Nuage de mots',
      ],
      correctIndex: 1,
      explanation:
          'Une parcelle est une surface délimitée : le polygone vectoriel conserve ses limites et ses attributs.',
    ),
    QuizQuestion(
      id: 'b03',
      courseId: 'bases_geomatique',
      question: 'Dans une image raster, la plus petite unité est :',
      options: ['Le sommet', 'Le pixel', 'Le segment', 'La parcelle'],
      correctIndex: 1,
      explanation:
          'Un raster est une grille régulière composée de pixels, chacun portant une valeur.',
    ),
    QuizQuestion(
      id: 'b04',
      courseId: 'bases_geomatique',
      question:
          'Quel élément explique la source, la date et la précision d’une donnée ?',
      options: [
        'La symbologie',
        'Les métadonnées',
        'Le fond de carte',
        'Le zoom',
      ],
      correctIndex: 1,
      explanation:
          'Les métadonnées documentent l’origine, la méthode, le référentiel et les limites d’utilisation.',
    ),
    QuizQuestion(
      id: 'b05',
      courseId: 'bases_geomatique',
      question:
          'Quelle action doit précéder le choix d’un capteur ou d’un logiciel ?',
      options: [
        'Définir le besoin et la décision à éclairer',
        'Créer immédiatement la légende',
        'Exporter un PDF',
        'Supprimer les données brutes',
      ],
      correctIndex: 0,
      explanation:
          'Le besoin détermine l’échelle, la précision, les données et les méthodes réellement nécessaires.',
    ),
    QuizQuestion(
      id: 'b06',
      courseId: 'bases_geomatique',
      question: 'La table attributaire d’une couche décrit principalement :',
      options: [
        'Les caractéristiques des objets',
        'La couleur de l’écran',
        'La vitesse du processeur',
        'La taille du logiciel',
      ],
      correctIndex: 0,
      explanation:
          'Chaque ligne correspond à une entité et chaque champ à une caractéristique de cette entité.',
    ),
    QuizQuestion(
      id: 'b07',
      courseId: 'bases_geomatique',
      question: 'Quelle pratique protège le mieux les données originales ?',
      options: [
        'Travailler directement sur l’unique copie',
        'Séparer les données brutes, les fichiers de travail et les sauvegardes',
        'Renommer tous les fichiers « final »',
        'Supprimer les métadonnées',
      ],
      correctIndex: 1,
      explanation:
          'La séparation des sources, traitements et sauvegardes assure la traçabilité et permet de revenir en arrière.',
    ),
    QuizQuestion(
      id: 'b08',
      courseId: 'bases_geomatique',
      question: 'Une route est généralement représentée en vecteur par :',
      options: [
        'Un point',
        'Une ligne',
        'Un pixel unique',
        'Une étiquette seule',
      ],
      correctIndex: 1,
      explanation:
          'Une ligne représente efficacement un objet allongé comme une route, une piste ou un cours d’eau.',
    ),
    QuizQuestion(
      id: 'c01',
      courseId: 'cartographie',
      question: 'À l’échelle 1:50 000, 1 cm sur la carte représente :',
      options: ['50 m', '500 m', '5 km', '50 km'],
      correctIndex: 1,
      explanation: '50 000 cm correspondent à 500 m sur le terrain.',
    ),
    QuizQuestion(
      id: 'c02',
      courseId: 'cartographie',
      question: 'Une carte à grande échelle montre généralement :',
      options: [
        'Un grand territoire avec peu de détails',
        'Une petite zone avec beaucoup de détails',
        'Uniquement des images satellites',
        'Aucune information métrique',
      ],
      correctIndex: 1,
      explanation:
          'Une grande échelle possède un petit dénominateur et représente finement une zone limitée.',
    ),
    QuizQuestion(
      id: 'c03',
      courseId: 'cartographie',
      question: 'Une courbe de niveau relie des points :',
      options: [
        'De même population',
        'De même altitude',
        'De même longitude uniquement',
        'De même couleur',
      ],
      correctIndex: 1,
      explanation:
          'Les courbes de niveau permettent de lire le relief en reliant les positions de même altitude.',
    ),
    QuizQuestion(
      id: 'c04',
      courseId: 'cartographie',
      question: 'Des courbes de niveau très rapprochées indiquent :',
      options: [
        'Une pente forte',
        'Une plaine parfaitement plate',
        'Une route large',
        'Une erreur de projection',
      ],
      correctIndex: 0,
      explanation:
          'L’altitude change fortement sur une courte distance : la pente est donc forte.',
    ),
    QuizQuestion(
      id: 'c05',
      courseId: 'cartographie',
      question:
          'Pour représenter des catégories sans ordre, il est préférable d’utiliser :',
      options: [
        'Une gamme du clair au foncé',
        'Des teintes distinctes de valeur comparable',
        'Une seule couleur identique',
        'Des tailles proportionnelles uniquement',
      ],
      correctIndex: 1,
      explanation:
          'Des teintes différentes distinguent des catégories qualitatives sans suggérer un ordre artificiel.',
    ),
    QuizQuestion(
      id: 'c06',
      courseId: 'cartographie',
      question: 'Quel élément indique la signification des symboles ?',
      options: [
        'La légende',
        'Le cadre',
        'Le format du papier',
        'Le nom du fichier',
      ],
      correctIndex: 0,
      explanation:
          'La légende traduit les symboles et couleurs réellement présents sur la carte.',
    ),
    QuizQuestion(
      id: 'c07',
      courseId: 'cartographie',
      question: 'Pourquoi généralise-t-on les objets à petite échelle ?',
      options: [
        'Pour augmenter artificiellement la précision',
        'Pour préserver la lisibilité malgré le faible espace disponible',
        'Pour supprimer les sources',
        'Pour convertir un raster en texte',
      ],
      correctIndex: 1,
      explanation:
          'À petite échelle, tous les détails ne peuvent pas rester visibles ; ils doivent être sélectionnés et simplifiés.',
    ),
    QuizQuestion(
      id: 'c08',
      courseId: 'cartographie',
      question: 'Une bonne hiérarchie visuelle signifie que :',
      options: [
        'Tous les éléments ont exactement le même poids',
        'Le message principal est perçu avant les informations secondaires',
        'La légende masque la carte',
        'Le nord est toujours placé à gauche',
      ],
      correctIndex: 1,
      explanation:
          'La composition guide le regard vers l’information principale, puis vers les détails nécessaires.',
    ),
    QuizQuestion(
      id: 's01',
      courseId: 'sig_qgis',
      question:
          'Quel outil crée une zone à distance donnée autour d’un objet ?',
      options: ['Découpage', 'Zone tampon', 'Dissolution', 'Géoréférencement'],
      correctIndex: 1,
      explanation:
          'La zone tampon, ou buffer, matérialise une distance autour d’une géométrie.',
    ),
    QuizQuestion(
      id: 's02',
      courseId: 'sig_qgis',
      question:
          'Pour extraire les routes situées dans une commune, on utilise principalement :',
      options: [
        'Clip / découpage',
        'Tri alphabétique',
        'Calculatrice simple',
        'Rotation de la carte',
      ],
      correctIndex: 0,
      explanation:
          'Le découpage conserve les portions d’une couche présentes dans l’emprise choisie.',
    ),
    QuizQuestion(
      id: 's03',
      courseId: 'sig_qgis',
      question: 'Une jointure attributaire nécessite généralement :',
      options: [
        'Une clé commune entre deux tables',
        'La même couleur de symbole',
        'Le même nombre de pixels',
        'Une connexion satellite',
      ],
      correctIndex: 0,
      explanation:
          'La clé commune permet d’associer les lignes correspondantes entre les tables.',
    ),
    QuizQuestion(
      id: 's04',
      courseId: 'sig_qgis',
      question: 'Attribuer un nouveau SCR à une couche sans reprojection :',
      options: [
        'Transforme correctement toutes les coordonnées',
        'Change seulement l’interprétation des coordonnées existantes',
        'Améliore automatiquement leur précision',
        'Crée une sauvegarde',
      ],
      correctIndex: 1,
      explanation:
          'Définir un SCR ne recalcule pas les coordonnées. Une reprojection est nécessaire pour les transformer.',
    ),
    QuizQuestion(
      id: 's05',
      courseId: 'sig_qgis',
      question:
          'Quelle règle topologique est pertinente pour des parcelles adjacentes ?',
      options: [
        'Elles ne doivent pas se chevaucher',
        'Elles doivent toutes avoir la même superficie',
        'Elles doivent être des points',
        'Elles ne doivent avoir aucun attribut',
      ],
      correctIndex: 0,
      explanation:
          'Les chevauchements créent une double occupation incohérente dans un parcellaire.',
    ),
    QuizQuestion(
      id: 's06',
      courseId: 'sig_qgis',
      question:
          'Quel format ouvert peut contenir plusieurs couches dans un seul fichier ?',
      options: ['GeoPackage', 'TXT non structuré', 'JPEG', 'MP3'],
      correctIndex: 0,
      explanation:
          'GeoPackage est un conteneur spatial ouvert adapté aux couches vectorielles et raster.',
    ),
    QuizQuestion(
      id: 's07',
      courseId: 'sig_qgis',
      question:
          'Pour sélectionner les écoles à moins de 2 km d’un hôpital, il faut surtout :',
      options: [
        'Une relation de proximité spatiale',
        'Une jointure sur le nom de l’école',
        'Une palette de couleurs',
        'Une image sans coordonnées',
      ],
      correctIndex: 0,
      explanation:
          'La requête dépend de la distance entre géométries et non d’un attribut textuel.',
    ),
    QuizQuestion(
      id: 's08',
      courseId: 'sig_qgis',
      question: 'Pourquoi conserver les données sources intactes ?',
      options: [
        'Pour pouvoir reproduire et vérifier les traitements',
        'Pour empêcher toute analyse',
        'Pour supprimer les métadonnées',
        'Pour éviter les systèmes de coordonnées',
      ],
      correctIndex: 0,
      explanation:
          'Une source intacte permet de relancer le traitement et d’auditer les résultats.',
    ),
    QuizQuestion(
      id: 'g01',
      courseId: 'gnss_coordonnees',
      question: 'Le calcul d’une position GNSS repose principalement sur :',
      options: [
        'La trilatération',
        'La classification supervisée',
        'La dissolution',
        'La sémiologie graphique',
      ],
      correctIndex: 0,
      explanation:
          'Le récepteur combine les distances estimées vers plusieurs satellites par trilatération.',
    ),
    QuizQuestion(
      id: 'g02',
      courseId: 'gnss_coordonnees',
      question:
          'Pourquoi faut-il au moins quatre satellites pour une position 3D GNSS ?',
      options: [
        'Pour calculer X, Y, Z et l’erreur d’horloge du récepteur',
        'Pour colorier quatre couches',
        'Pour mesurer quatre parcelles',
        'Pour créer quatre sauvegardes',
      ],
      correctIndex: 0,
      explanation:
          'La quatrième inconnue est le décalage de l’horloge du récepteur.',
    ),
    QuizQuestion(
      id: 'g03',
      courseId: 'gnss_coordonnees',
      question: 'Un PDOP faible indique généralement :',
      options: [
        'Une géométrie des satellites favorable',
        'Une batterie vide',
        'Un mauvais format de fichier',
        'Une altitude forcément nulle',
      ],
      correctIndex: 0,
      explanation:
          'Un faible facteur de dilution traduit une bonne répartition géométrique des satellites.',
    ),
    QuizQuestion(
      id: 'g04',
      courseId: 'gnss_coordonnees',
      question: 'Le multitrajet est causé par :',
      options: [
        'Des signaux réfléchis avant d’atteindre l’antenne',
        'Une légende trop longue',
        'Un pixel trop grand',
        'Une couleur trop sombre',
      ],
      correctIndex: 0,
      explanation:
          'Les bâtiments, véhicules et surfaces métalliques peuvent réfléchir les signaux GNSS.',
    ),
    QuizQuestion(
      id: 'g05',
      courseId: 'gnss_coordonnees',
      question: 'La principale différence entre RTK et PPK est que :',
      options: [
        'Le RTK applique les corrections en temps réel, le PPK après la mission',
        'Le PPK ne mesure aucune coordonnée',
        'Le RTK est un type de carte papier',
        'Ils utilisent des unités incompatibles',
      ],
      correctIndex: 0,
      explanation:
          'Les deux méthodes exploitent des corrections, mais pas au même moment du flux de travail.',
    ),
    QuizQuestion(
      id: 'g06',
      courseId: 'gnss_coordonnees',
      question: 'La hauteur fournie directement par le GNSS est généralement :',
      options: [
        'Ellipsoïdale',
        'Orthométrique sans correction',
        'Toujours négative',
        'Une distance plane',
      ],
      correctIndex: 0,
      explanation:
          'Le GNSS se réfère à l’ellipsoïde ; un modèle de géoïde est nécessaire pour obtenir une altitude usuelle.',
    ),
    QuizQuestion(
      id: 'g07',
      courseId: 'gnss_coordonnees',
      question:
          'Pour mesurer des distances en mètres dans un SIG, on privilégie :',
      options: [
        'Un système projeté adapté à la zone',
        'Des coordonnées en degrés sans précaution',
        'Une image sans géoréférencement',
        'Une capture d’écran',
      ],
      correctIndex: 0,
      explanation:
          'Un système projeté localement adapté réduit les déformations pour les mesures planimétriques.',
    ),
    QuizQuestion(
      id: 'g08',
      courseId: 'gnss_coordonnees',
      question:
          'Quelle information doit toujours accompagner une liste de coordonnées ?',
      options: [
        'Le système de référence utilisé',
        'La couleur du récepteur',
        'Le prix du téléphone',
        'Le nom du dossier uniquement',
      ],
      correctIndex: 0,
      explanation:
          'Sans référentiel, les valeurs X/Y ou latitude/longitude peuvent être ambiguës ou mal placées.',
    ),
    QuizQuestion(
      id: 't01',
      courseId: 'teledetection',
      question: 'Un capteur passif mesure principalement :',
      options: [
        'Une énergie naturelle réfléchie ou émise',
        'Uniquement un signal qu’il émet lui-même',
        'La population par questionnaire',
        'La longueur des routes manuellement',
      ],
      correctIndex: 0,
      explanation:
          'Les capteurs optiques passifs utilisent souvent l’énergie solaire réfléchie par les surfaces.',
    ),
    QuizQuestion(
      id: 't02',
      courseId: 'teledetection',
      question: 'La résolution spatiale correspond principalement :',
      options: [
        'À la taille du pixel au sol',
        'Au nombre de dates',
        'Au nombre de classes',
        'À la vitesse Internet',
      ],
      correctIndex: 0,
      explanation:
          'La dimension du pixel détermine le niveau de détail spatial observable.',
    ),
    QuizQuestion(
      id: 't03',
      courseId: 'teledetection',
      question: 'La résolution temporelle décrit :',
      options: [
        'La fréquence d’observation d’une même zone',
        'La taille du capteur',
        'Le nombre de couleurs de la légende',
        'La précision d’un GNSS',
      ],
      correctIndex: 0,
      explanation:
          'Elle est liée au délai de revisite et à la capacité de suivre les changements dans le temps.',
    ),
    QuizQuestion(
      id: 't04',
      courseId: 'teledetection',
      question: 'La formule correcte du NDVI est :',
      options: [
        '(PIR − Rouge) / (PIR + Rouge)',
        '(Bleu + Vert) × Rouge',
        'PIR / altitude',
        'Rouge − latitude',
      ],
      correctIndex: 0,
      explanation:
          'Le NDVI exploite le contraste entre forte réflectance dans le proche infrarouge et absorption dans le rouge.',
    ),
    QuizQuestion(
      id: 't05',
      courseId: 'teledetection',
      question:
          'Quelle longueur d’onde est particulièrement utile pour la végétation saine ?',
      options: [
        'Le proche infrarouge',
        'Le son',
        'Les ondes Wi-Fi uniquement',
        'Aucune bande',
      ],
      correctIndex: 0,
      explanation:
          'La végétation saine réfléchit fortement le proche infrarouge.',
    ),
    QuizQuestion(
      id: 't06',
      courseId: 'teledetection',
      question: 'Une classification supervisée nécessite :',
      options: [
        'Des échantillons d’entraînement connus',
        'Uniquement un titre de carte',
        'Aucune donnée de référence',
        'Une seule bande vide',
      ],
      correctIndex: 0,
      explanation:
          'L’algorithme apprend les caractéristiques des classes à partir d’exemples représentatifs.',
    ),
    QuizQuestion(
      id: 't07',
      courseId: 'teledetection',
      question: 'Pourquoi séparer entraînement et validation ?',
      options: [
        'Pour évaluer le modèle sur des données indépendantes',
        'Pour doubler artificiellement le score',
        'Pour supprimer les classes rares',
        'Pour changer le système de coordonnées',
      ],
      correctIndex: 0,
      explanation:
          'Valider sur les mêmes exemples que l’apprentissage surestime la performance réelle.',
    ),
    QuizQuestion(
      id: 't08',
      courseId: 'teledetection',
      question:
          'Quel capteur actif est particulièrement connu pour fonctionner de nuit et par temps nuageux ?',
      options: [
        'Le radar',
        'Une caméra RGB passive',
        'Un scanner papier',
        'Un thermomètre analogique',
      ],
      correctIndex: 0,
      explanation:
          'Le radar émet des micro-ondes et dépend moins de l’éclairage solaire ou de la couverture nuageuse.',
    ),
    QuizQuestion(
      id: 'p01',
      courseId: 'photogrammetrie_drone',
      question:
          'Pourquoi les images d’une mission photogrammétrique doivent-elles se recouvrir ?',
      options: [
        'Pour identifier les mêmes détails sur plusieurs images et reconstruire la géométrie',
        'Pour réduire le nombre de points homologues à zéro',
        'Pour éviter toute position GNSS',
        'Pour supprimer la texture du terrain',
      ],
      correctIndex: 0,
      explanation:
          'Les correspondances entre images sont au cœur de l’estimation des caméras et de la reconstruction 3D.',
    ),
    QuizQuestion(
      id: 'p02',
      courseId: 'photogrammetrie_drone',
      question: 'Le GSD représente :',
      options: [
        'La dimension au sol d’un pixel',
        'Le nombre de satellites visibles',
        'La durée de vie de la batterie',
        'La pente moyenne uniquement',
      ],
      correctIndex: 0,
      explanation:
          'Le Ground Sampling Distance relie un pixel de l’image à une dimension réelle au sol.',
    ),
    QuizQuestion(
      id: 'p03',
      courseId: 'photogrammetrie_drone',
      question: 'Quel est le rôle principal d’un GCP ?',
      options: [
        'Participer au géoréférencement et à l’ajustement du modèle',
        'Évaluer uniquement la batterie',
        'Remplacer toutes les images',
        'Créer une légende',
      ],
      correctIndex: 0,
      explanation:
          'Les points d’appui fournissent au calcul des coordonnées terrain précises.',
    ),
    QuizQuestion(
      id: 'p04',
      courseId: 'photogrammetrie_drone',
      question: 'Un checkpoint doit idéalement :',
      options: [
        'Rester indépendant de l’ajustement pour contrôler le résultat',
        'Être utilisé comme GCP et checkpoint à la fois',
        'Ne pas avoir de coordonnées',
        'Être placé hors de toutes les images',
      ],
      correctIndex: 0,
      explanation:
          'Un contrôle indépendant donne une estimation plus honnête de la précision finale.',
    ),
    QuizQuestion(
      id: 'p05',
      courseId: 'photogrammetrie_drone',
      question: 'Quelle affirmation distingue correctement MNS et MNT ?',
      options: [
        'Le MNS inclut les objets de surface ; le MNT cherche à représenter le sol nu',
        'Ils sont toujours strictement identiques',
        'Le MNT contient uniquement les nuages',
        'Le MNS est une table sans altitude',
      ],
      correctIndex: 0,
      explanation:
          'Bâtiments et végétation apparaissent dans le modèle de surface, mais doivent être filtrés pour le terrain.',
    ),
    QuizQuestion(
      id: 'p06',
      courseId: 'photogrammetrie_drone',
      question:
          'Une vitesse de vol trop élevée avec un temps de pose long risque surtout de produire :',
      options: [
        'Du flou de mouvement',
        'Un meilleur recouvrement automatique',
        'Un SCR différent',
        'Un géoïde plus précis',
      ],
      correctIndex: 0,
      explanation:
          'Le déplacement pendant l’exposition dégrade la netteté et donc la qualité des correspondances.',
    ),
    QuizQuestion(
      id: 'p07',
      courseId: 'photogrammetrie_drone',
      question: 'Une orthomosaïque est principalement :',
      options: [
        'Un assemblage d’images corrigé géométriquement pour permettre des mesures cohérentes',
        'Une vidéo brute du vol',
        'Une liste de satellites',
        'Une carte sans coordonnées',
      ],
      correctIndex: 0,
      explanation:
          'L’orthorectification réduit les effets de perspective et de relief avant l’assemblage.',
    ),
    QuizQuestion(
      id: 'p08',
      courseId: 'photogrammetrie_drone',
      question:
          'Quel contrôle est le plus crédible pour annoncer la précision absolue ?',
      options: [
        'Les résidus sur des checkpoints indépendants',
        'La couleur de l’orthomosaïque',
        'Le nombre total de fichiers',
        'La marque du drone uniquement',
      ],
      correctIndex: 0,
      explanation:
          'Les checkpoints non utilisés dans l’ajustement évaluent le résultat sur des références indépendantes.',
    ),
    ...ExtendedQuizCatalog.questions,
  ];

  static QuizDefinition quizForCourse(String courseId) =>
      definitions.firstWhere((quiz) => quiz.courseId == courseId);

  static List<QuizQuestion> questionsFor(QuizDefinition definition) {
    if (definition.courseId != null) {
      return questions
          .where((question) => question.courseId == definition.courseId)
          .toList(growable: false);
    }

    const challengeIds = <String>[
      'b03',
      'c04',
      's06',
      'g05',
      't08',
      'p04',
      'to03',
      'ge06',
      'db08',
      'wm04',
      'gs07',
      'mh06',
      'cf03',
      'py08',
      'cq05',
      'er09',
      'b10',
      'db10',
      'gs10',
      'er10',
    ];
    final questionsById = <String, QuizQuestion>{
      for (final question in questions) question.id: question,
    };
    return challengeIds.map((id) => questionsById[id]!).toList(growable: false);
  }
}
