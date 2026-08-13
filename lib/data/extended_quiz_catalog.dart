import '../models/learning_models.dart';

abstract class ExtendedQuizCatalog {
  static final List<QuizDefinition> definitions = <QuizDefinition>[
    QuizDefinition(
      id: 'quiz_topographie',
      title: 'Topographie et nivellement',
      subtitle: '10 questions • Mesures et fermetures',
      accentValue: 0xFFEC1745,
      iconName: 'topography',
      courseId: 'topographie_nivellement',
    ),
    QuizDefinition(
      id: 'quiz_geodesie',
      title: 'Géodésie et projections',
      subtitle: '10 questions • Datums et SCR',
      accentValue: 0xFF5A0B68,
      iconName: 'globe',
      courseId: 'geodesie_projections',
    ),
    QuizDefinition(
      id: 'quiz_database',
      title: 'Bases de données spatiales',
      subtitle: '10 questions • SQL et PostGIS',
      accentValue: 0xFF8A124B,
      iconName: 'database',
      courseId: 'bases_donnees_spatiales',
    ),
    QuizDefinition(
      id: 'quiz_webmapping',
      title: 'Webmapping et OGC',
      subtitle: '10 questions • Services et tuiles',
      accentValue: 0xFFFF6338,
      iconName: 'web',
      courseId: 'webmapping_ogc',
    ),
    QuizDefinition(
      id: 'quiz_geostatistique',
      title: 'Géostatistique',
      subtitle: '10 questions • Variogramme et validation',
      accentValue: 0xFFB40B4C,
      iconName: 'analytics',
      courseId: 'geostatistique',
    ),
    QuizDefinition(
      id: 'quiz_mnt',
      title: 'MNT et hydrologie',
      subtitle: '10 questions • Relief et bassins',
      accentValue: 0xFF5A0B68,
      iconName: 'terrain',
      courseId: 'mnt_hydrologie',
    ),
    QuizDefinition(
      id: 'quiz_cadastre',
      title: 'Cadastre et foncier',
      subtitle: '10 questions • Parcelles et topologie',
      accentValue: 0xFF7E063F,
      iconName: 'cadastre',
      courseId: 'cadastre_foncier',
    ),
    QuizDefinition(
      id: 'quiz_python',
      title: 'Python géomatique',
      subtitle: '10 questions • Automatisation fiable',
      accentValue: 0xFFEC1745,
      iconName: 'code',
      courseId: 'python_geomatique',
    ),
    QuizDefinition(
      id: 'quiz_collecte',
      title: 'Collecte mobile et qualité',
      subtitle: '10 questions • Formulaires et terrain',
      accentValue: 0xFFFF6338,
      iconName: 'mobile',
      courseId: 'collecte_qualite',
    ),
    QuizDefinition(
      id: 'quiz_risques',
      title: 'Environnement et risques',
      subtitle: '10 questions • Aléas et décision',
      accentValue: 0xFF168A65,
      iconName: 'environment',
      courseId: 'environnement_risques',
    ),
  ];

  static final List<QuizQuestion> questions = <QuizQuestion>[
    ..._additionsToOriginalCourses,
    ..._topography,
    ..._geodesy,
    ..._database,
    ..._webmapping,
    ..._geostatistics,
    ..._terrain,
    ..._cadastre,
    ..._python,
    ..._collection,
    ..._risks,
  ];

  static const _additionsToOriginalCourses = <QuizQuestion>[
    QuizQuestion(
      id: 'b09',
      courseId: 'bases_geomatique',
      question: 'Pourquoi conserver une copie brute des données ?',
      options: [
        'Pour pouvoir reproduire ou corriger les traitements',
        'Pour supprimer les métadonnées',
        'Pour réduire la précision',
        'Pour éviter toute sauvegarde',
      ],
      correctIndex: 0,
      explanation:
          'La source intacte permet de reprendre le traitement sans perdre l’information acquise.',
    ),
    QuizQuestion(
      id: 'b10',
      courseId: 'bases_geomatique',
      question: 'La complétude d’un jeu de données mesure surtout :',
      options: [
        'La présence des objets et attributs attendus',
        'La couleur des symboles',
        'La vitesse du réseau',
        'Le prix du capteur',
      ],
      correctIndex: 0,
      explanation:
          'La complétude vérifie si les éléments nécessaires sont présents et renseignés.',
    ),
    QuizQuestion(
      id: 'c09',
      courseId: 'cartographie',
      question:
          'Quel usage de la couleur convient à des catégories sans ordre ?',
      options: [
        'Des teintes distinctes',
        'Une seule progression clair-foncé',
        'Une taille proportionnelle seulement',
        'Aucune légende',
      ],
      correctIndex: 0,
      explanation:
          'Des teintes différentes distinguent des catégories nominales sans suggérer un classement.',
    ),
    QuizQuestion(
      id: 'c10',
      courseId: 'cartographie',
      question: 'Quel élément renforce la traçabilité d’une carte ?',
      options: [
        'Les sources et la date',
        'Une décoration non expliquée',
        'Le zoom maximal',
        'Un titre très long uniquement',
      ],
      correctIndex: 0,
      explanation:
          'Sources, auteur, date et référentiel permettent d’évaluer et de réutiliser la carte.',
    ),
    QuizQuestion(
      id: 's09',
      courseId: 'sig_qgis',
      question: 'Quel outil regroupe des polygones ayant la même valeur ?',
      options: ['Dissolution', 'Tampon', 'Découpage', 'Géocodage'],
      correctIndex: 0,
      explanation:
          'La dissolution supprime les limites internes selon un attribut commun.',
    ),
    QuizQuestion(
      id: 's10',
      courseId: 'sig_qgis',
      question: 'Pourquoi un modèle de traitement SIG est-il utile ?',
      options: [
        'Il rend une chaîne d’opérations reproductible',
        'Il remplace toutes les données',
        'Il choisit le SCR au hasard',
        'Il supprime le contrôle qualité',
      ],
      correctIndex: 0,
      explanation:
          'Le modèle conserve l’ordre et les paramètres des traitements pour les rejouer.',
    ),
    QuizQuestion(
      id: 'g09',
      courseId: 'gnss_coordonnees',
      question: 'Une solution RTK fixe indique généralement :',
      options: [
        'Une ambiguïté de phase résolue',
        'Une absence totale de satellites',
        'Un datum inconnu',
        'Une batterie vide',
      ],
      correctIndex: 0,
      explanation:
          'La solution fixe correspond à la résolution des ambiguïtés et offre en général la meilleure précision RTK.',
    ),
    QuizQuestion(
      id: 'g10',
      courseId: 'gnss_coordonnees',
      question: 'La hauteur mesurée directement par GNSS est principalement :',
      options: [
        'Ellipsoïdale',
        'Orthométrique sans correction',
        'Toujours égale au niveau marin',
        'Une pente',
      ],
      correctIndex: 0,
      explanation:
          'Le GNSS fournit une hauteur par rapport à l’ellipsoïde ; un modèle de géoïde sert à obtenir une altitude usuelle.',
    ),
    QuizQuestion(
      id: 't09',
      courseId: 'teledetection',
      question: 'Que mesure une matrice de confusion ?',
      options: [
        'Les accords et confusions entre classes',
        'La distance entre satellites',
        'La focale du drone',
        'Le nombre de pixels uniquement',
      ],
      correctIndex: 0,
      explanation:
          'Elle compare classes prédites et références pour évaluer la classification.',
    ),
    QuizQuestion(
      id: 't10',
      courseId: 'teledetection',
      question: 'Pourquoi corriger l’atmosphère dans certaines analyses ?',
      options: [
        'Pour mieux comparer la réflectance entre dates',
        'Pour ajouter des nuages',
        'Pour modifier l’orbite',
        'Pour créer des parcelles',
      ],
      correctIndex: 0,
      explanation:
          'La diffusion et l’absorption atmosphériques peuvent masquer les variations réelles de surface.',
    ),
    QuizQuestion(
      id: 'p09',
      courseId: 'photogrammetrie_drone',
      question: 'Quelle surface pose souvent problème aux points homologues ?',
      options: [
        'Une eau uniforme et réfléchissante',
        'Un sol texturé',
        'Une cible contrastée',
        'Un mur détaillé',
      ],
      correctIndex: 0,
      explanation:
          'Les surfaces uniformes ou changeantes offrent peu de détails stables à associer entre images.',
    ),
    QuizQuestion(
      id: 'p10',
      courseId: 'photogrammetrie_drone',
      question: 'Voler plus bas entraîne généralement :',
      options: [
        'Un GSD plus fin et davantage d’images',
        'Un GSD plus grand et moins de détails',
        'Aucun changement',
        'La suppression du recouvrement',
      ],
      correctIndex: 0,
      explanation:
          'À capteur constant, une hauteur plus faible améliore le GSD mais augmente le volume de mission.',
    ),
  ];

  static const _topography = <QuizQuestion>[
    QuizQuestion(
      id: 'to01',
      courseId: 'topographie_nivellement',
      question: 'La planimétrie décrit principalement :',
      options: [
        'La position horizontale',
        'La couleur du sol',
        'La météo',
        'La compression des images',
      ],
      correctIndex: 0,
      explanation:
          'La planimétrie concerne X et Y, tandis que l’altimétrie concerne les hauteurs.',
    ),
    QuizQuestion(
      id: 'to02',
      courseId: 'topographie_nivellement',
      question:
          'Avec une lecture arrière de 1,20 m et une lecture avant de 0,85 m, la dénivelée vaut :',
      options: ['+0,35 m', '-0,35 m', '+2,05 m', '0 m'],
      correctIndex: 0,
      explanation:
          'La dénivelée vaut arrière moins avant : 1,20 − 0,85 = +0,35 m.',
    ),
    QuizQuestion(
      id: 'to03',
      courseId: 'topographie_nivellement',
      question: 'Pourquoi équilibrer les portées en nivellement ?',
      options: [
        'Pour réduire certaines erreurs systématiques',
        'Pour changer de datum',
        'Pour créer un raster',
        'Pour éviter toute fermeture',
      ],
      correctIndex: 0,
      explanation:
          'Des distances arrière et avant proches compensent notamment les erreurs de visée et de courbure.',
    ),
    QuizQuestion(
      id: 'to04',
      courseId: 'topographie_nivellement',
      question: 'Une polygonale fermée permet de contrôler :',
      options: [
        'Les fermetures angulaire et linéaire',
        'Le NDVI',
        'Les bandes spectrales',
        'Le format GeoJSON',
      ],
      correctIndex: 0,
      explanation:
          'Le retour sur un point connu permet de comparer coordonnées et angles calculés aux valeurs attendues.',
    ),
    QuizQuestion(
      id: 'to05',
      courseId: 'topographie_nivellement',
      question: 'Avant une mesure à la station totale, il faut notamment :',
      options: [
        'Centrer et caler l’instrument',
        'Supprimer la hauteur de cible',
        'Choisir une projection web',
        'Éteindre l’affichage',
      ],
      correctIndex: 0,
      explanation:
          'Un mauvais centrage ou calage introduit des erreurs dans les angles et positions.',
    ),
    QuizQuestion(
      id: 'to06',
      courseId: 'topographie_nivellement',
      question: 'L’azimut est un angle mesuré généralement depuis :',
      options: [
        'Le nord dans le sens horaire',
        'Le sud dans tous les cas',
        'La verticale uniquement',
        'Le centre de la Terre sans direction',
      ],
      correctIndex: 0,
      explanation:
          'La convention courante mesure l’azimut depuis le nord, dans le sens des aiguilles d’une montre.',
    ),
    QuizQuestion(
      id: 'to07',
      courseId: 'topographie_nivellement',
      question: 'Que faire si la fermeture dépasse la tolérance ?',
      options: [
        'Rechercher l’erreur et remesurer si nécessaire',
        'Compenser automatiquement sans contrôle',
        'Supprimer le point connu',
        'Changer les unités',
      ],
      correctIndex: 0,
      explanation:
          'Une compensation n’est acceptable qu’après avoir écarté une faute de mesure ou de saisie.',
    ),
    QuizQuestion(
      id: 'to08',
      courseId: 'topographie_nivellement',
      question: 'Le carnet de terrain doit conserver :',
      options: [
        'Les observations brutes et incidents',
        'Seulement le résultat final',
        'Uniquement les couleurs',
        'Aucune hauteur',
      ],
      correctIndex: 0,
      explanation:
          'Les mesures originales assurent la traçabilité et permettent les recalculs.',
    ),
    QuizQuestion(
      id: 'to09',
      courseId: 'topographie_nivellement',
      question: 'Une mire est utilisée principalement avec :',
      options: [
        'Un niveau',
        'Un serveur WMS',
        'Un radar satellite',
        'Une base PostGIS',
      ],
      correctIndex: 0,
      explanation:
          'Le niveau vise une mire graduée pour déterminer des différences d’altitude.',
    ),
    QuizQuestion(
      id: 'to10',
      courseId: 'topographie_nivellement',
      question: 'La hauteur de prisme doit être :',
      options: [
        'Mesurée et enregistrée',
        'Toujours supposée nulle',
        'Convertie en degrés',
        'Ignorée en stationnement',
      ],
      correctIndex: 0,
      explanation:
          'Une hauteur de cible erronée fausse les altitudes calculées.',
    ),
  ];

  static const _geodesy = <QuizQuestion>[
    QuizQuestion(
      id: 'ge01',
      courseId: 'geodesie_projections',
      question: 'L’ellipsoïde est :',
      options: [
        'Une surface mathématique régulière',
        'Une photographie aérienne',
        'Une table attributaire',
        'Un réseau routier',
      ],
      correctIndex: 0,
      explanation:
          'L’ellipsoïde approxime la forme terrestre pour les calculs géodésiques.',
    ),
    QuizQuestion(
      id: 'ge02',
      courseId: 'geodesie_projections',
      question: 'Le géoïde est surtout lié :',
      options: [
        'Au champ de gravité et au niveau moyen des mers',
        'Aux couleurs d’une carte',
        'À la résolution d’écran',
        'Aux parcelles uniquement',
      ],
      correctIndex: 0,
      explanation:
          'Le géoïde sert de référence physique aux altitudes orthométriques.',
    ),
    QuizQuestion(
      id: 'ge03',
      courseId: 'geodesie_projections',
      question: 'Une projection conforme préserve localement :',
      options: [
        'Les angles',
        'Toutes les distances mondiales',
        'Toutes les surfaces et distances',
        'Les attributs SQL',
      ],
      correctIndex: 0,
      explanation:
          'La conformité maintient les angles locaux mais d’autres déformations subsistent.',
    ),
    QuizQuestion(
      id: 'ge04',
      courseId: 'geodesie_projections',
      question: 'La largeur d’une zone UTM est de :',
      options: [
        '6 degrés de longitude',
        '1 degré de latitude',
        '30 degrés',
        '360 kilomètres fixes',
      ],
      correctIndex: 0,
      explanation: 'Le système UTM découpe le globe en 60 zones de six degrés.',
    ),
    QuizQuestion(
      id: 'ge05',
      courseId: 'geodesie_projections',
      question: 'Attribuer un SCR à une couche signifie :',
      options: [
        'Déclarer comment interpréter ses coordonnées',
        'Recalculer automatiquement toutes ses positions',
        'Créer un MNT',
        'Mesurer son altitude',
      ],
      correctIndex: 0,
      explanation:
          'Définir un SCR n’est pas une reprojection ; cela décrit les coordonnées existantes.',
    ),
    QuizQuestion(
      id: 'ge06',
      courseId: 'geodesie_projections',
      question: 'Pour calculer une surface fiable, on préfère :',
      options: [
        'Un SCR projeté adapté',
        'Des degrés sans précaution',
        'Une image sans coordonnées',
        'Un fichier texte seul',
      ],
      correctIndex: 0,
      explanation:
          'Un système métrique adapté limite les déformations pour la zone étudiée.',
    ),
    QuizQuestion(
      id: 'ge07',
      courseId: 'geodesie_projections',
      question: 'WGS 84 est principalement :',
      options: [
        'Un datum géocentrique mondial',
        'Une projection équivalente locale',
        'Un format de fichier',
        'Un algorithme de classification',
      ],
      correctIndex: 0,
      explanation:
          'WGS 84 définit un référentiel global utilisé notamment par le GPS.',
    ),
    QuizQuestion(
      id: 'ge08',
      courseId: 'geodesie_projections',
      question: 'Une transformation de datum nécessite parfois :',
      options: [
        'Une grille de correction',
        'Une nouvelle palette',
        'Une tuiles PNG',
        'Un filtre de formulaire',
      ],
      correctIndex: 0,
      explanation:
          'Les différences locales entre référentiels peuvent être modélisées par des grilles.',
    ),
    QuizQuestion(
      id: 'ge09',
      courseId: 'geodesie_projections',
      question: 'Le code EPSG sert à :',
      options: [
        'Identifier un système de référence',
        'Noter une batterie',
        'Compter des pixels',
        'Nommer un enquêteur',
      ],
      correctIndex: 0,
      explanation:
          'Un code EPSG identifie de manière standardisée un SCR et ses paramètres.',
    ),
    QuizQuestion(
      id: 'ge10',
      courseId: 'geodesie_projections',
      question: 'Après reprojection, le meilleur contrôle est :',
      options: [
        'Comparer des points connus',
        'Changer la couleur',
        'Réduire le nombre de champs',
        'Supprimer les métadonnées',
      ],
      correctIndex: 0,
      explanation:
          'Des points de référence révèlent un mauvais SCR ou une transformation inadaptée.',
    ),
  ];

  static const _database = <QuizQuestion>[
    QuizQuestion(
      id: 'db01',
      courseId: 'bases_donnees_spatiales',
      question: 'Une clé primaire doit être :',
      options: [
        'Unique et non nulle',
        'Toujours une couleur',
        'Une géométrie invalide',
        'Identique pour toutes les lignes',
      ],
      correctIndex: 0,
      explanation: 'Elle identifie sans ambiguïté chaque enregistrement.',
    ),
    QuizQuestion(
      id: 'db02',
      courseId: 'bases_donnees_spatiales',
      question: 'Le SRID d’une géométrie indique :',
      options: [
        'Son système de référence',
        'Sa taille en mégaoctets',
        'Son auteur uniquement',
        'Son mot de passe',
      ],
      correctIndex: 0,
      explanation: 'Le SRID associe la géométrie à un référentiel spatial.',
    ),
    QuizQuestion(
      id: 'db03',
      courseId: 'bases_donnees_spatiales',
      question: 'ST_Intersects teste si deux géométries :',
      options: [
        'Partagent une portion d’espace',
        'Ont le même nom',
        'Ont la même couleur',
        'Sont dans deux bases différentes',
      ],
      correctIndex: 0,
      explanation:
          'La fonction renvoie vrai lorsque les géométries ne sont pas spatialement disjointes.',
    ),
    QuizQuestion(
      id: 'db04',
      courseId: 'bases_donnees_spatiales',
      question: 'ST_Transform sert à :',
      options: [
        'Reprojeter une géométrie',
        'Créer un utilisateur',
        'Compresser une photo',
        'Dessiner une légende',
      ],
      correctIndex: 0,
      explanation: 'ST_Transform recalcule les coordonnées dans un autre SCR.',
    ),
    QuizQuestion(
      id: 'db05',
      courseId: 'bases_donnees_spatiales',
      question: 'Un index GiST accélère surtout :',
      options: [
        'Les recherches spatiales',
        'La saisie du titre',
        'La charge de batterie',
        'La prise de vue',
      ],
      correctIndex: 0,
      explanation:
          'Il réduit le nombre de géométries candidates grâce aux boîtes englobantes.',
    ),
    QuizQuestion(
      id: 'db06',
      courseId: 'bases_donnees_spatiales',
      question: 'EXPLAIN aide à :',
      options: [
        'Comprendre le plan d’une requête',
        'Changer de datum',
        'Créer une orthophoto',
        'Mesurer un angle',
      ],
      correctIndex: 0,
      explanation:
          'Le plan d’exécution montre comment la base accède et joint les données.',
    ),
    QuizQuestion(
      id: 'db07',
      courseId: 'bases_donnees_spatiales',
      question: 'Une transaction garantit principalement :',
      options: [
        'Un ensemble d’opérations cohérent',
        'Une connexion internet permanente',
        'Un style de carte',
        'Une meilleure résolution raster',
      ],
      correctIndex: 0,
      explanation:
          'Les opérations sont validées ensemble ou annulées en cas d’échec.',
    ),
    QuizQuestion(
      id: 'db08',
      courseId: 'bases_donnees_spatiales',
      question: 'Quel principe protège le mieux la base ?',
      options: [
        'Accorder le minimum de droits nécessaire',
        'Partager le compte administrateur',
        'Désactiver les sauvegardes',
        'Supprimer les contraintes',
      ],
      correctIndex: 0,
      explanation:
          'Le moindre privilège limite les conséquences d’une erreur ou compromission.',
    ),
    QuizQuestion(
      id: 'db09',
      courseId: 'bases_donnees_spatiales',
      question: 'Une contrainte CHECK sert à :',
      options: [
        'Bloquer des valeurs invalides',
        'Afficher le nord',
        'Créer un satellite',
        'Augmenter le GSD',
      ],
      correctIndex: 0,
      explanation: 'Elle impose une condition métier directement dans la base.',
    ),
    QuizQuestion(
      id: 'db10',
      courseId: 'bases_donnees_spatiales',
      question: 'Une sauvegarde est réellement fiable lorsqu’elle est :',
      options: [
        'Restaurée et testée',
        'Seulement annoncée',
        'Stockée dans la même table',
        'Sans date',
      ],
      correctIndex: 0,
      explanation:
          'Le test de restauration vérifie que les fichiers permettent effectivement de récupérer le service.',
    ),
  ];

  static const _webmapping = <QuizQuestion>[
    QuizQuestion(
      id: 'wm01',
      courseId: 'webmapping_ogc',
      question: 'Le client d’une carte web est généralement :',
      options: [
        'Le navigateur ou l’application',
        'Le satellite',
        'La borne cadastrale',
        'Le géoïde',
      ],
      correctIndex: 0,
      explanation:
          'Le client affiche les couches et gère les interactions avec l’utilisateur.',
    ),
    QuizQuestion(
      id: 'wm02',
      courseId: 'webmapping_ogc',
      question: 'Un service WMS renvoie surtout :',
      options: [
        'Une image cartographique rendue',
        'Une base complète modifiable',
        'Un signal GNSS',
        'Un carnet terrain',
      ],
      correctIndex: 0,
      explanation:
          'WMS produit des cartes sous forme d’images à partir des couches du serveur.',
    ),
    QuizQuestion(
      id: 'wm03',
      courseId: 'webmapping_ogc',
      question: 'Un WFS expose principalement :',
      options: [
        'Des entités vectorielles',
        'Des vidéos de drone',
        'Des altitudes sans position',
        'Un thème graphique',
      ],
      correctIndex: 0,
      explanation:
          'WFS permet d’interroger et récupérer des objets géographiques.',
    ),
    QuizQuestion(
      id: 'wm04',
      courseId: 'webmapping_ogc',
      question: 'Les tuiles vectorielles sont stylées :',
      options: [
        'Côté client',
        'Uniquement dans le satellite',
        'Dans le carnet papier',
        'Par le récepteur GNSS',
      ],
      correctIndex: 0,
      explanation:
          'Elles transportent des géométries compactes auxquelles l’application applique un style.',
    ),
    QuizQuestion(
      id: 'wm05',
      courseId: 'webmapping_ogc',
      question: 'Pourquoi généraliser aux petits zooms ?',
      options: [
        'Pour réduire densité et volume',
        'Pour ajouter tous les détails',
        'Pour changer le datum',
        'Pour mesurer une altitude',
      ],
      correctIndex: 0,
      explanation:
          'À l’échelle d’un pays, les détails locaux encombrent et alourdissent inutilement la carte.',
    ),
    QuizQuestion(
      id: 'wm06',
      courseId: 'webmapping_ogc',
      question: 'Le cache sert à :',
      options: [
        'Réutiliser des réponses stables',
        'Supprimer le serveur',
        'Créer une topologie',
        'Corriger le géoïde',
      ],
      correctIndex: 0,
      explanation:
          'Le cache réduit les calculs, le trafic et le temps de réponse.',
    ),
    QuizQuestion(
      id: 'wm07',
      courseId: 'webmapping_ogc',
      question: 'GeoJSON est adapté à :',
      options: [
        'L’échange d’objets géographiques sur le web',
        'La mesure de hauteur instrumentale',
        'Le stockage d’une orthophoto massive',
        'La correction RTK',
      ],
      correctIndex: 0,
      explanation:
          'GeoJSON est un format texte web simple pour géométries et attributs.',
    ),
    QuizQuestion(
      id: 'wm08',
      courseId: 'webmapping_ogc',
      question: 'Une API publique doit éviter de renvoyer :',
      options: [
        'Des attributs sensibles inutiles',
        'Une documentation',
        'Des statuts d’erreur',
        'Des identifiants de ressource',
      ],
      correctIndex: 0,
      explanation:
          'La minimisation des données réduit les risques et le poids des réponses.',
    ),
    QuizQuestion(
      id: 'wm09',
      courseId: 'webmapping_ogc',
      question: 'Sur mobile, une bonne carte prévoit :',
      options: [
        'Des cibles tactiles assez grandes',
        'Des boutons minuscules',
        'Aucun état de chargement',
        'Uniquement le survol de souris',
      ],
      correctIndex: 0,
      explanation:
          'Les commandes doivent rester accessibles au doigt et indiquer leur état.',
    ),
    QuizQuestion(
      id: 'wm10',
      courseId: 'webmapping_ogc',
      question: 'Quel test révèle mieux la performance réelle ?',
      options: [
        'Une connexion mobile lente',
        'Uniquement un serveur local rapide',
        'Un écran vide',
        'Une impression papier',
      ],
      correctIndex: 0,
      explanation:
          'Tester des conditions contraintes révèle les charges trop lourdes et les erreurs réseau.',
    ),
  ];

  static const _geostatistics = <QuizQuestion>[
    QuizQuestion(
      id: 'gs01',
      courseId: 'geostatistique',
      question: 'Avant une interpolation, il faut d’abord :',
      options: [
        'Explorer et contrôler les mesures',
        'Choisir la plus belle palette',
        'Supprimer les extrêmes',
        'Créer une notification',
      ],
      correctIndex: 0,
      explanation:
          'La distribution, les unités et le plan d’échantillonnage conditionnent toute interprétation.',
    ),
    QuizQuestion(
      id: 'gs02',
      courseId: 'geostatistique',
      question: 'L’autocorrélation spatiale signifie que :',
      options: [
        'Des valeurs proches peuvent se ressembler',
        'Toutes les valeurs sont identiques',
        'La position est inutile',
        'Les données sont forcément causales',
      ],
      correctIndex: 0,
      explanation:
          'La proximité peut être associée à une similarité statistique sans prouver une cause.',
    ),
    QuizQuestion(
      id: 'gs03',
      courseId: 'geostatistique',
      question: 'L’anisotropie indique que la structure spatiale :',
      options: [
        'Varie selon la direction',
        'Est absente',
        'Dépend du format de fichier',
        'Est toujours circulaire',
      ],
      correctIndex: 0,
      explanation:
          'La portée ou la variabilité peut différer selon les directions.',
    ),
    QuizQuestion(
      id: 'gs04',
      courseId: 'geostatistique',
      question: 'Dans un variogramme, la portée est :',
      options: [
        'La distance au-delà de laquelle la corrélation devient faible',
        'La valeur minimale du raster',
        'Le nombre de classes',
        'La résolution d’écran',
      ],
      correctIndex: 0,
      explanation: 'La portée caractérise l’échelle spatiale de la dépendance.',
    ),
    QuizQuestion(
      id: 'gs05',
      courseId: 'geostatistique',
      question: 'L’effet pépite peut représenter :',
      options: [
        'Erreur de mesure ou variabilité très locale',
        'La taille du serveur',
        'Un système de coordonnées',
        'Une couleur obligatoire',
      ],
      correctIndex: 0,
      explanation:
          'Une discontinuité à l’origine traduit bruit ou variation sous le pas d’échantillonnage.',
    ),
    QuizQuestion(
      id: 'gs06',
      courseId: 'geostatistique',
      question: 'Le krigeage fournit généralement :',
      options: [
        'Une estimation et une variance',
        'Seulement une légende',
        'Un itinéraire',
        'Une base GNSS',
      ],
      correctIndex: 0,
      explanation:
          'Le modèle spatial permet de calculer une valeur prédite et son incertitude.',
    ),
    QuizQuestion(
      id: 'gs07',
      courseId: 'geostatistique',
      question: 'La validation croisée consiste à :',
      options: [
        'Prédire des observations laissées de côté',
        'Valider sur les mêmes points sans retrait',
        'Changer le SCR',
        'Créer des points aléatoires sans mesure',
      ],
      correctIndex: 0,
      explanation:
          'Chaque observation est temporairement retirée puis estimée à partir des autres.',
    ),
    QuizQuestion(
      id: 'gs08',
      courseId: 'geostatistique',
      question: 'Une valeur aberrante doit être :',
      options: [
        'Vérifiée avant toute décision',
        'Toujours supprimée',
        'Toujours doublée',
        'Convertie en texte',
      ],
      correctIndex: 0,
      explanation:
          'Elle peut être une erreur, mais aussi un phénomène réel important.',
    ),
    QuizQuestion(
      id: 'gs09',
      courseId: 'geostatistique',
      question: 'La carte d’incertitude doit être :',
      options: [
        'Présentée avec l’interpolation',
        'Cachée',
        'Remplacée par un titre',
        'Convertie en photo',
      ],
      correctIndex: 0,
      explanation:
          'Elle montre où la prédiction est moins fiable et évite une fausse précision.',
    ),
    QuizQuestion(
      id: 'gs10',
      courseId: 'geostatistique',
      question: 'L’extrapolation loin des échantillons est :',
      options: [
        'À limiter et signaler',
        'Toujours très fiable',
        'Indépendante du modèle',
        'Une validation',
      ],
      correctIndex: 0,
      explanation:
          'Sans observations proches, le modèle repose fortement sur des hypothèses.',
    ),
  ];

  static const _terrain = <QuizQuestion>[
    QuizQuestion(
      id: 'mh01',
      courseId: 'mnt_hydrologie',
      question: 'Un MNS représente :',
      options: [
        'Le sommet du sol et des objets',
        'Uniquement le sol nu',
        'Une table sans altitude',
        'Un service web',
      ],
      correctIndex: 0,
      explanation: 'Le modèle de surface inclut bâtiments et végétation.',
    ),
    QuizQuestion(
      id: 'mh02',
      courseId: 'mnt_hydrologie',
      question: 'La résolution d’un MNT correspond à :',
      options: [
        'La taille de cellule',
        'La précision verticale garantie',
        'La date uniquement',
        'La couleur dominante',
      ],
      correctIndex: 0,
      explanation:
          'La résolution décrit l’espacement de la grille, pas directement l’erreur d’altitude.',
    ),
    QuizQuestion(
      id: 'mh03',
      courseId: 'mnt_hydrologie',
      question: 'Une pente de 100 % correspond approximativement à :',
      options: ['45 degrés', '100 degrés', '1 degré', '0 degré'],
      correctIndex: 0,
      explanation:
          'Une hausse égale à la distance horizontale donne une tangente de 1, donc 45°.',
    ),
    QuizQuestion(
      id: 'mh04',
      courseId: 'mnt_hydrologie',
      question: 'L’exposition d’une pente donne :',
      options: [
        'Sa direction',
        'Sa surface totale',
        'Le nombre de pixels',
        'Son propriétaire',
      ],
      correctIndex: 0,
      explanation:
          'L’exposition indique l’azimut vers lequel la pente descend.',
    ),
    QuizQuestion(
      id: 'mh05',
      courseId: 'mnt_hydrologie',
      question: 'L’ombrage est surtout :',
      options: [
        'Une aide visuelle à la lecture du relief',
        'Une mesure d’altitude brute',
        'Un datum',
        'Une table SQL',
      ],
      correctIndex: 0,
      explanation:
          'Il simule un éclairage mais ne remplace pas les valeurs du MNT.',
    ),
    QuizQuestion(
      id: 'mh06',
      courseId: 'mnt_hydrologie',
      question: 'L’accumulation de flux compte :',
      options: [
        'Les cellules contribuant à un emplacement',
        'Les bâtiments seulement',
        'Les satellites visibles',
        'Les attributs vides',
      ],
      correctIndex: 0,
      explanation:
          'Elle mesure la surface amont en nombre ou surface de cellules.',
    ),
    QuizQuestion(
      id: 'mh07',
      courseId: 'mnt_hydrologie',
      question: 'Pourquoi combler certaines dépressions ?',
      options: [
        'Pour rétablir un écoulement interrompu artificiellement',
        'Pour créer des montagnes',
        'Pour changer de zone UTM',
        'Pour supprimer les rivières',
      ],
      correctIndex: 0,
      explanation:
          'Des puits dus au bruit peuvent bloquer les algorithmes hydrologiques.',
    ),
    QuizQuestion(
      id: 'mh08',
      courseId: 'mnt_hydrologie',
      question: 'L’exutoire doit être :',
      options: [
        'Accroché au bon axe d’écoulement',
        'Placé au hasard',
        'Toujours au point le plus haut',
        'Sans coordonnées',
      ],
      correctIndex: 0,
      explanation: 'Un léger décalage peut délimiter le mauvais bassin.',
    ),
    QuizQuestion(
      id: 'mh09',
      courseId: 'mnt_hydrologie',
      question: 'Les dérivées de terrain ont tendance à :',
      options: [
        'Amplifier le bruit du MNT',
        'Supprimer toute erreur',
        'Créer des métadonnées',
        'Réduire automatiquement la résolution',
      ],
      correctIndex: 0,
      explanation:
          'Pente et courbure réagissent fortement aux variations locales d’altitude.',
    ),
    QuizQuestion(
      id: 'mh10',
      courseId: 'mnt_hydrologie',
      question: 'Un bassin calculé doit être comparé :',
      options: [
        'Aux rivières et observations terrain',
        'Uniquement au titre',
        'À la batterie du téléphone',
        'Au format CSV',
      ],
      correctIndex: 0,
      explanation:
          'Les données indépendantes révèlent ouvrages manquants ou erreurs du relief.',
    ),
  ];

  static const _cadastre = <QuizQuestion>[
    QuizQuestion(
      id: 'cf01',
      courseId: 'cadastre_foncier',
      question: 'Une parcelle cadastrale doit posséder :',
      options: [
        'Un identifiant stable',
        'Le même identifiant que toutes les autres',
        'Aucun historique',
        'Une couleur juridique',
      ],
      correctIndex: 0,
      explanation:
          'Un identifiant unique relie la géométrie aux documents et opérations.',
    ),
    QuizQuestion(
      id: 'cf02',
      courseId: 'cadastre_foncier',
      question:
          'La carte cadastrale est-elle toujours une preuve juridique suffisante ?',
      options: [
        'Non, cela dépend du cadre légal et des documents',
        'Oui, sans exception',
        'Seulement si elle est colorée',
        'Seulement en raster',
      ],
      correctIndex: 0,
      explanation:
          'Le statut du plan et la preuve des droits dépendent des institutions et de la loi.',
    ),
    QuizQuestion(
      id: 'cf03',
      courseId: 'cadastre_foncier',
      question: 'Deux parcelles voisines devraient généralement :',
      options: [
        'Partager exactement leur limite commune',
        'Se chevaucher légèrement',
        'Laisser un trou invisible',
        'Avoir le même identifiant',
      ],
      correctIndex: 0,
      explanation:
          'Une topologie partagée évite doublons, micro-polygones et incohérences.',
    ),
    QuizQuestion(
      id: 'cf04',
      courseId: 'cadastre_foncier',
      question: 'Un chevauchement parcellaire non justifié est :',
      options: [
        'Une erreur topologique',
        'Une projection conforme',
        'Un index spatial',
        'Une altitude',
      ],
      correctIndex: 0,
      explanation:
          'Deux unités exclusives ne doivent pas occuper la même surface.',
    ),
    QuizQuestion(
      id: 'cf05',
      courseId: 'cadastre_foncier',
      question: 'La tolérance d’accrochage doit être :',
      options: [
        'Adaptée à la précision des données',
        'Toujours énorme',
        'Toujours nulle',
        'Choisie selon la couleur',
      ],
      correctIndex: 0,
      explanation:
          'Une tolérance trop grande déplace les limites ; trop petite laisse des écarts.',
    ),
    QuizQuestion(
      id: 'cf06',
      courseId: 'cadastre_foncier',
      question: 'Une limite litigieuse doit être :',
      options: [
        'Signalée explicitement',
        'Déplacée sans trace',
        'Supprimée',
        'Transformée en photo',
      ],
      correctIndex: 0,
      explanation:
          'L’incertitude et le statut de validation font partie de l’information foncière.',
    ),
    QuizQuestion(
      id: 'cf07',
      courseId: 'cadastre_foncier',
      question: 'Pourquoi versionner les modifications ?',
      options: [
        'Pour conserver qui, quand et pourquoi',
        'Pour masquer les anciennes limites',
        'Pour réduire les droits',
        'Pour créer un MNT',
      ],
      correctIndex: 0,
      explanation:
          'L’historique rend les opérations auditables et parfois réversibles.',
    ),
    QuizQuestion(
      id: 'cf08',
      courseId: 'cadastre_foncier',
      question: 'Les données personnelles doivent être :',
      options: [
        'Protégées selon les règles applicables',
        'Toujours publiques',
        'Dupliquées partout',
        'Sans contrôle d’accès',
      ],
      correctIndex: 0,
      explanation:
          'La publication cartographique ne justifie pas l’exposition d’informations sensibles.',
    ),
    QuizQuestion(
      id: 'cf09',
      courseId: 'cadastre_foncier',
      question:
          'La précision graphique d’un ancien plan est-elle égale à un bornage moderne ?',
      options: [
        'Non',
        'Toujours',
        'Seulement en PDF',
        'Seulement avec une légende',
      ],
      correctIndex: 0,
      explanation:
          'La méthode, l’échelle et la finalité peuvent être très différentes.',
    ),
    QuizQuestion(
      id: 'cf10',
      courseId: 'cadastre_foncier',
      question: 'Une mise à jour foncière doit suivre :',
      options: [
        'Un workflow validé et traçable',
        'Une modification anonyme directe',
        'Une suppression des justificatifs',
        'Un tirage aléatoire',
      ],
      correctIndex: 0,
      explanation:
          'Les changements sensibles nécessitent validation, documents et historique.',
    ),
  ];

  static const _python = <QuizQuestion>[
    QuizQuestion(
      id: 'py01',
      courseId: 'python_geomatique',
      question: 'Une bonne première étape d’automatisation est :',
      options: [
        'Décrire clairement entrées et sorties',
        'Écraser les sources',
        'Copier tout dans une fonction',
        'Ignorer les erreurs',
      ],
      correctIndex: 0,
      explanation: 'Un contrat clair rend le script prévisible et testable.',
    ),
    QuizQuestion(
      id: 'py02',
      courseId: 'python_geomatique',
      question: 'GeoPandas est surtout utilisé pour :',
      options: [
        'Les données vectorielles tabulaires',
        'Piloter un drone',
        'Créer des alarmes exactes',
        'Mesurer une mire',
      ],
      correctIndex: 0,
      explanation:
          'GeoPandas associe les opérations de tables à des géométries.',
    ),
    QuizQuestion(
      id: 'py03',
      courseId: 'python_geomatique',
      question: 'Rasterio travaille principalement avec :',
      options: [
        'Des rasters géoréférencés',
        'Des droits fonciers',
        'Des messages SMS',
        'Des angles de polygonale',
      ],
      correctIndex: 0,
      explanation: 'Rasterio lit, écrit et traite les grilles géographiques.',
    ),
    QuizQuestion(
      id: 'py04',
      courseId: 'python_geomatique',
      question: 'PyProj sert notamment à :',
      options: [
        'Transformer des coordonnées',
        'Créer une légende',
        'Gérer une batterie',
        'Interroger un formulaire',
      ],
      correctIndex: 0,
      explanation:
          'PyProj expose les transformations et systèmes de référence de PROJ.',
    ),
    QuizQuestion(
      id: 'py05',
      courseId: 'python_geomatique',
      question: 'Pourquoi traiter un grand raster par fenêtres ?',
      options: [
        'Pour limiter la mémoire utilisée',
        'Pour perdre le SCR',
        'Pour ajouter du bruit',
        'Pour supprimer les pixels',
      ],
      correctIndex: 0,
      explanation:
          'Les blocs permettent de traiter des données plus grandes que la mémoire disponible.',
    ),
    QuizQuestion(
      id: 'py06',
      courseId: 'python_geomatique',
      question: 'Un journal de traitement doit contenir :',
      options: [
        'Paramètres, durée et erreurs',
        'Seulement une couleur',
        'Le mot de passe de la base',
        'Aucune date',
      ],
      correctIndex: 0,
      explanation: 'Ces éléments facilitent diagnostic et reproduction.',
    ),
    QuizQuestion(
      id: 'py07',
      courseId: 'python_geomatique',
      question: 'Le dossier de sortie devrait être :',
      options: [
        'Distinct des données brutes',
        'Identique avec écrasement automatique',
        'Toujours temporaire sans trace',
        'Sans nom',
      ],
      correctIndex: 0,
      explanation:
          'La séparation protège les sources et clarifie les produits.',
    ),
    QuizQuestion(
      id: 'py08',
      courseId: 'python_geomatique',
      question: 'Fixer les versions des dépendances améliore :',
      options: [
        'La reproductibilité',
        'La couleur des rasters',
        'La réception GNSS',
        'La précision du niveau',
      ],
      correctIndex: 0,
      explanation:
          'Le même environnement réduit les changements de comportement entre machines.',
    ),
    QuizQuestion(
      id: 'py09',
      courseId: 'python_geomatique',
      question: 'Un jeu de données de test doit être :',
      options: [
        'Petit mais représentatif',
        'Toujours gigantesque',
        'Sans géométrie',
        'Secret sans accès au développeur',
      ],
      correctIndex: 0,
      explanation:
          'Un échantillon ciblé donne des tests rapides couvrant les cas importants.',
    ),
    QuizQuestion(
      id: 'py10',
      courseId: 'python_geomatique',
      question: 'Avant un traitement par lots complet, il faut :',
      options: [
        'Tester sur quelques fichiers',
        'Lancer sans contrôle',
        'Supprimer les logs',
        'Modifier toutes les sources',
      ],
      correctIndex: 0,
      explanation:
          'Un essai limité révèle format inattendu, erreur de SCR ou sortie incorrecte.',
    ),
  ];

  static const _collection = <QuizQuestion>[
    QuizQuestion(
      id: 'cq01',
      courseId: 'collecte_qualite',
      question: 'Un champ obligatoire doit correspondre :',
      options: [
        'À une information réellement indispensable',
        'À toutes les questions possibles',
        'À la couleur de l’app',
        'À un fichier vide',
      ],
      correctIndex: 0,
      explanation:
          'Trop d’obligations ralentissent la collecte et encouragent de fausses valeurs.',
    ),
    QuizQuestion(
      id: 'cq02',
      courseId: 'collecte_qualite',
      question: 'Une liste contrôlée réduit :',
      options: [
        'Les variantes d’écriture',
        'La précision GNSS',
        'La batterie automatiquement',
        'Le nombre de points satellites',
      ],
      correctIndex: 0,
      explanation: 'Elle harmonise les catégories et simplifie l’analyse.',
    ),
    QuizQuestion(
      id: 'cq03',
      courseId: 'collecte_qualite',
      question: 'La précision affichée par un téléphone doit être :',
      options: [
        'Contrôlée avant validation',
        'Toujours supposée centimétrique',
        'Ignorée',
        'Convertie en couleur',
      ],
      correctIndex: 0,
      explanation:
          'Elle varie avec l’environnement et la qualité du récepteur.',
    ),
    QuizQuestion(
      id: 'cq04',
      courseId: 'collecte_qualite',
      question: 'Avant une mission hors connexion, il faut :',
      options: [
        'Télécharger fonds et formulaires',
        'Désinstaller l’app',
        'Effacer le stockage',
        'Supprimer les listes',
      ],
      correctIndex: 0,
      explanation:
          'La zone et le questionnaire doivent être disponibles sans réseau.',
    ),
    QuizQuestion(
      id: 'cq05',
      courseId: 'collecte_qualite',
      question: 'Un identifiant unique aide à éviter :',
      options: [
        'Les doublons de synchronisation',
        'Les systèmes de coordonnées',
        'Les images satellites',
        'Les batteries externes',
      ],
      correctIndex: 0,
      explanation:
          'Il permet de reconnaître la même observation entre appareil et serveur.',
    ),
    QuizQuestion(
      id: 'cq06',
      courseId: 'collecte_qualite',
      question: 'Une collecte pilote doit couvrir :',
      options: [
        'Tout le flux jusqu’à l’export',
        'Seulement l’ouverture du formulaire',
        'Uniquement la connexion',
        'Seulement une capture d’écran',
      ],
      correctIndex: 0,
      explanation:
          'Les problèmes apparaissent souvent lors de la synchronisation ou de l’analyse.',
    ),
    QuizQuestion(
      id: 'cq07',
      courseId: 'collecte_qualite',
      question: 'Une photo terrain est plus utile si elle est :',
      options: [
        'Orientée et liée à l’observation',
        'Anonyme et sans contexte',
        'Toujours très compressée sans contrôle',
        'Sans date',
      ],
      correctIndex: 0,
      explanation:
          'Orientation, lien et commentaire rendent la photo interprétable.',
    ),
    QuizQuestion(
      id: 'cq08',
      courseId: 'collecte_qualite',
      question: 'Le contrôle quotidien permet :',
      options: [
        'De revenir rapidement corriger une omission',
        'De supprimer les sources',
        'De changer le datum au hasard',
        'De garantir zéro erreur',
      ],
      correctIndex: 0,
      explanation:
          'Une vérification précoce évite de découvrir les manques après avoir quitté la zone.',
    ),
    QuizQuestion(
      id: 'cq09',
      courseId: 'collecte_qualite',
      question: 'Une position hors emprise est :',
      options: [
        'Un signal à vérifier',
        'Toujours correcte',
        'Toujours à supprimer',
        'Une projection',
      ],
      correctIndex: 0,
      explanation:
          'Elle peut révéler une erreur GNSS, une saisie au bureau ou un vrai cas exceptionnel.',
    ),
    QuizQuestion(
      id: 'cq10',
      courseId: 'collecte_qualite',
      question: 'Les corrections de données doivent être :',
      options: ['Traçables', 'Invisibles', 'Sans auteur', 'Sans justification'],
      correctIndex: 0,
      explanation: 'La trace protège l’intégrité du projet et permet un audit.',
    ),
  ];

  static const _risks = <QuizQuestion>[
    QuizQuestion(
      id: 'er01',
      courseId: 'environnement_risques',
      question: 'Un aléa est :',
      options: [
        'Un phénomène potentiellement dommageable',
        'Une personne exposée',
        'Un format de fichier',
        'Un droit cadastral',
      ],
      correctIndex: 0,
      explanation:
          'L’aléa décrit la probabilité ou intensité d’un phénomène dangereux.',
    ),
    QuizQuestion(
      id: 'er02',
      courseId: 'environnement_risques',
      question: 'Les enjeux sont :',
      options: [
        'Les personnes, biens ou milieux exposés',
        'Uniquement les satellites',
        'Les couleurs de carte',
        'Les index SQL',
      ],
      correctIndex: 0,
      explanation: 'Les enjeux désignent ce qui pourrait subir des dommages.',
    ),
    QuizQuestion(
      id: 'er03',
      courseId: 'environnement_risques',
      question: 'La vulnérabilité exprime :',
      options: [
        'La sensibilité et capacité à faire face',
        'La longitude',
        'La taille d’un pixel',
        'Le nombre de tuiles',
      ],
      correctIndex: 0,
      explanation:
          'À exposition égale, des groupes ou bâtiments peuvent être plus vulnérables.',
    ),
    QuizQuestion(
      id: 'er04',
      courseId: 'environnement_risques',
      question: 'Avant de combiner des rasters, il faut aligner :',
      options: [
        'SCR, résolution et emprise',
        'Seulement les couleurs',
        'Les mots de passe',
        'Les titres',
      ],
      correctIndex: 0,
      explanation:
          'Des grilles non alignées produisent des comparaisons incohérentes.',
    ),
    QuizQuestion(
      id: 'er05',
      courseId: 'environnement_risques',
      question: 'Normaliser les critères permet de :',
      options: [
        'Les rendre comparables',
        'Garantir qu’ils sont vrais',
        'Supprimer l’incertitude',
        'Créer un GNSS',
      ],
      correctIndex: 0,
      explanation:
          'Les échelles différentes doivent être transformées selon une règle explicite.',
    ),
    QuizQuestion(
      id: 'er06',
      courseId: 'environnement_risques',
      question: 'Les poids d’une analyse multicritère sont :',
      options: [
        'Des choix à justifier',
        'Des vérités universelles',
        'Des coordonnées',
        'Des formats image',
      ],
      correctIndex: 0,
      explanation: 'Ils traduisent des priorités et influencent le résultat.',
    ),
    QuizQuestion(
      id: 'er07',
      courseId: 'environnement_risques',
      question: 'Une analyse de sensibilité mesure :',
      options: [
        'L’effet des hypothèses sur le résultat',
        'La lumière du capteur',
        'La largeur UTM',
        'Le nombre de bornes',
      ],
      correctIndex: 0,
      explanation:
          'Elle révèle les classements qui changent lorsque paramètres ou poids varient.',
    ),
    QuizQuestion(
      id: 'er08',
      courseId: 'environnement_risques',
      question: 'Une carte de risque est :',
      options: [
        'Un modèle avec des limites',
        'Une certitude absolue',
        'Une preuve juridique universelle',
        'Un simple fond décoratif',
      ],
      correctIndex: 0,
      explanation: 'Elle dépend de données, périodes, scénarios et hypothèses.',
    ),
    QuizQuestion(
      id: 'er09',
      courseId: 'environnement_risques',
      question: 'Une bonne validation utilise notamment :',
      options: [
        'Des événements passés et l’expertise locale',
        'Seulement la couleur rouge',
        'Un titre accrocheur',
        'Aucune donnée indépendante',
      ],
      correctIndex: 0,
      explanation:
          'Les observations historiques et connaissances de terrain confrontent le modèle à la réalité.',
    ),
    QuizQuestion(
      id: 'er10',
      courseId: 'environnement_risques',
      question: 'La restitution doit afficher :',
      options: [
        'Sources, scénario, date et limites',
        'Uniquement les zones fortes',
        'Les données personnelles sensibles',
        'Aucune incertitude',
      ],
      correctIndex: 0,
      explanation:
          'Ces informations sont essentielles pour une décision responsable et contextualisée.',
    ),
  ];
}
