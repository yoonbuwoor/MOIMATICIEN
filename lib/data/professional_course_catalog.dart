import '../models/learning_models.dart';

abstract class ProfessionalCourseCatalog {
  static final List<Course> courses = <Course>[
    _course(
      id: 'qgis_pratique',
      title: 'QGIS : atelier pratique',
      subtitle:
          'Construire un projet propre, traiter les données et livrer une carte exploitable.',
      category: 'Logiciels',
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/sig.webp',
      accentValue: 0xFF5B7F2A,
      objectives: [
        'Organiser un projet QGIS portable',
        'Maîtriser les traitements et styles essentiels',
        'Exporter une carte et ses données sans perte',
      ],
      topics: [
        _topic(
          'Projet et sources',
          'Un projet QGIS enregistre les chemins, styles, mises en page et paramètres, mais pas nécessairement les données. Placez sources, résultats et documents dans une arborescence claire, utilisez des chemins relatifs et un GeoPackage pour limiter les fichiers dispersés.',
          [
            'Définir le SCR du projet.',
            'Séparer brut, travail et sortie.',
            'Éviter les fichiers temporaires comme livrables.',
          ],
        ),
        _topic(
          'Sélection et traitements',
          'Les expressions filtrent les attributs tandis que les algorithmes de la boîte à outils transforment réellement les couches. Vérifiez le nombre d’entités, le SCR et les géométries avant un tampon, une intersection ou une dissolution.',
          [
            'Tester sur un petit échantillon.',
            'Nommer chaque sortie.',
            'Conserver les paramètres utilisés.',
          ],
        ),
        _topic(
          'Styles et étiquettes',
          'Une symbologie catégorisée distingue des classes nominales ; une symbologie graduée représente une quantité. Les étiquettes doivent gérer priorités, chevauchements et unités afin de rester lisibles à l’échelle prévue.',
          [
            'Choisir une classification explicable.',
            'Limiter les décimales.',
            'Tester plusieurs échelles.',
          ],
        ),
        _topic(
          'Mise en page et livraison',
          'La mise en page associe carte, légende, échelle, sources et titre. Avant livraison, ouvrez le projet depuis un autre dossier, contrôlez les polices et exportez un PDF ainsi qu’un format de données ouvert lorsque le destinataire doit poursuivre le travail.',
          [
            'Vérifier les liens cassés.',
            'Inclure les métadonnées.',
            'Archiver une version finale.',
          ],
        ),
      ],
    ),
    _course(
      id: 'arcgis_pro_workflows',
      title: 'ArcGIS Pro : workflows professionnels',
      subtitle:
          'Structurer géodatabases, analyses, modèles et partages dans un environnement d’entreprise.',
      category: 'Logiciels',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFF246A9A,
      objectives: [
        'Comprendre projets, cartes et géodatabases',
        'Automatiser une chaîne avec ModelBuilder',
        'Préparer un partage maîtrisé',
      ],
      topics: [
        _topic(
          'Projet ArcGIS Pro',
          'Un projet regroupe cartes, scènes, connexions, boîtes à outils et mises en page. La géodatabase fichier gère domaines, sous-types et classes d’entités avec plus de contrôle qu’une collection de shapefiles.',
          [
            'Définir le stockage par défaut.',
            'Utiliser domaines et sous-types.',
            'Documenter les connexions externes.',
          ],
        ),
        _topic(
          'Géotraitements',
          'Les outils utilisent des paramètres, des environnements et une emprise. L’historique permet de comprendre un résultat et de relancer une opération ; il faut toutefois contrôler chaque sortie plutôt que d’enchaîner aveuglément.',
          [
            'Fixer SCR et résolution.',
            'Inspecter messages et avertissements.',
            'Préserver les données sources.',
          ],
        ),
        _topic(
          'ModelBuilder',
          'ModelBuilder transforme une suite d’outils en modèle réutilisable. Les variables exposées deviennent des paramètres ; les préconditions imposent l’ordre et les contrôles intermédiaires évitent de propager une erreur.',
          [
            'Nommer les variables.',
            'Définir des préconditions.',
            'Tester plusieurs jeux de données.',
          ],
        ),
        _topic(
          'Partage',
          'Une carte web, un paquetage ou un service ne doit contenir que les couches et champs nécessaires. Analysez la compatibilité, les droits, les volumes et les dépendances avant publication.',
          [
            'Retirer les données sensibles.',
            'Configurer les droits.',
            'Tester avec un compte destinataire.',
          ],
        ),
      ],
    ),
    _course(
      id: 'google_earth_engine',
      title: 'Google Earth Engine',
      subtitle:
          'Composer, filtrer et analyser des collections d’images à l’échelle du territoire.',
      category: 'Cloud géospatial',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/teledetection.webp',
      accentValue: 0xFF2E7D5B,
      objectives: [
        'Distinguer calcul côté serveur et côté client',
        'Préparer une collection temporelle',
        'Exporter un résultat documenté',
      ],
      topics: [
        _topic(
          'Objets distribués',
          'Les images, collections et géométries Earth Engine décrivent des calculs exécutés côté serveur. Il faut filtrer tôt, sélectionner les bandes utiles et éviter de rapatrier de grandes collections vers le client.',
          [
            'Filtrer dates et emprise.',
            'Sélectionner les bandes.',
            'Éviter getInfo dans les boucles.',
          ],
        ),
        _topic(
          'Masques et composites',
          'Un masque qualité écarte nuages et pixels douteux. Un composite médian résume plusieurs dates, mais sa période doit correspondre au phénomène étudié et ses pixels ne représentent pas tous le même jour.',
          [
            'Lire les bits qualité.',
            'Choisir une saison cohérente.',
            'Conserver la période dans les métadonnées.',
          ],
        ),
        _topic(
          'Réducteurs',
          'Les réducteurs calculent moyenne, somme, histogramme ou statistiques par région. L’échelle de calcul, la projection et la géométrie influencent les valeurs et le coût.',
          [
            'Fixer une échelle justifiée.',
            'Limiter les géométries complexes.',
            'Contrôler les unités de surface.',
          ],
        ),
        _topic(
          'Export et reproductibilité',
          'Un export doit préciser emprise, résolution, projection, bandes et valeur NoData. Le script, les sources, les filtres et la date d’exécution accompagnent le raster ou la table.',
          [
            'Nommer clairement les tâches.',
            'Vérifier les quotas.',
            'Archiver le script.',
          ],
        ),
      ],
    ),
    _course(
      id: 'lidar_nuages_points',
      title: 'LiDAR et nuages de points',
      subtitle:
          'Comprendre retours laser, classification, densité et produits altimétriques.',
      category: '3D',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/terrain_geostatistics.png',
      accentValue: 0xFF6A4C93,
      objectives: [
        'Lire les attributs d’un nuage de points',
        'Évaluer densité et classification',
        'Produire un modèle de terrain contrôlé',
      ],
      topics: [
        _topic(
          'Mesure laser',
          'Un capteur LiDAR mesure le temps de retour d’une impulsion. Plusieurs retours peuvent décrire cime, branches puis sol. La position et l’orientation du capteur sont combinées avec la distance pour calculer chaque point.',
          [
            'Distinguer retours et impulsions.',
            'Contrôler trajectoire et calibration.',
            'Conserver le référentiel vertical.',
          ],
        ),
        _topic(
          'Format et attributs',
          'LAS ou LAZ stocke coordonnées, intensité, numéro de retour, classification et autres attributs. L’en-tête renseigne échelles, emprise et système de référence.',
          [
            'Valider l’en-tête.',
            'Ne pas confondre intensité et altitude.',
            'Utiliser LAZ pour compresser sans perte.',
          ],
        ),
        _topic(
          'Classification',
          'La classe sol est estimée par des filtres qui séparent le relief des objets. Les pentes, talus, bâtiments bas et végétation dense créent des erreurs qui doivent être inspectées.',
          [
            'Afficher des profils.',
            'Corriger les classes critiques.',
            'Conserver une classe non classée.',
          ],
        ),
        _topic(
          'Produits et qualité',
          'Le MNT vient des points sol ; le MNS utilise les surfaces supérieures. Densité, zones vides, recouvrements de bandes et checkpoints altimétriques documentent la qualité.',
          [
            'Calculer la densité locale.',
            'Comparer à des points indépendants.',
            'Signaler les interpolations.',
          ],
        ),
      ],
    ),
    _course(
      id: 'radar_sar',
      title: 'Imagerie radar SAR',
      subtitle:
          'Interpréter rétrodiffusion, polarisation, speckle et géométrie radar.',
      category: 'Télédétection',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/teledetection.webp',
      accentValue: 0xFF314E89,
      objectives: [
        'Comprendre la mesure radar',
        'Reconnaître les distorsions géométriques',
        'Préparer une comparaison temporelle',
      ],
      topics: [
        _topic(
          'Capteur actif',
          'Le radar émet une onde micro-onde et mesure l’énergie renvoyée. Rugosité, humidité, géométrie et longueur d’onde influencent la rétrodiffusion ; un pixel clair ne signifie donc pas une seule propriété.',
          [
            'Acquisition jour et nuit.',
            'Sensibilité à l’humidité.',
            'Interprétation liée à l’angle.',
          ],
        ),
        _topic(
          'Polarisation',
          'Les combinaisons VV, VH, HH ou HV décrivent l’orientation de l’onde émise et reçue. Elles réagissent différemment à la végétation, aux structures et aux surfaces.',
          [
            'Comparer des polarisations compatibles.',
            'Ne pas généraliser un seuil.',
            'Documenter le mode d’acquisition.',
          ],
        ),
        _topic(
          'Speckle et terrain',
          'Le speckle est une texture granuleuse inhérente à l’imagerie cohérente. Les filtres réduisent ce bruit au prix d’une perte de détails. Le relief cause ombre, raccourcissement et renversement.',
          [
            'Filtrer avec prudence.',
            'Appliquer une correction terrain.',
            'Masquer les zones non observables.',
          ],
        ),
        _topic(
          'Séries temporelles',
          'Comparer des dates exige orbite, polarisation, résolution et prétraitements cohérents. Une variation peut venir du sol, de l’angle ou du traitement.',
          [
            'Utiliser une orbite constante.',
            'Travailler en unités cohérentes.',
            'Valider avec le terrain.',
          ],
        ),
      ],
    ),
    _course(
      id: 'occupation_sol',
      title: 'Occupation du sol et changement',
      subtitle:
          'Construire une nomenclature, classifier puis mesurer les transitions sans double comptage.',
      category: 'Environnement',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/environment_risk.png',
      accentValue: 0xFF3F7D20,
      objectives: [
        'Créer une nomenclature non ambiguë',
        'Valider chaque classe',
        'Calculer une matrice de transition',
      ],
      topics: [
        _topic(
          'Nomenclature',
          'Les classes doivent être exhaustives, mutuellement compréhensibles et adaptées à la résolution. Une définition écrite précise seuils, saison et cas limites.',
          [
            'Éviter les classes qui se chevauchent.',
            'Définir une unité minimale.',
            'Prévoir une classe inconnue.',
          ],
        ),
        _topic(
          'Échantillons',
          'Les échantillons d’entraînement couvrent la variabilité des classes. Les points de validation doivent être indépendants et provenir d’une référence assez précise.',
          [
            'Séparer entraînement et validation.',
            'Répartir spatialement.',
            'Documenter la date de référence.',
          ],
        ),
        _topic(
          'Exactitude',
          'La matrice de confusion présente exactitudes utilisateur et producteur. L’exactitude globale seule peut masquer une classe rare très mal identifiée.',
          [
            'Publier les erreurs par classe.',
            'Tenir compte du plan d’échantillonnage.',
            'Inspecter les confusions.',
          ],
        ),
        _topic(
          'Changements',
          'Une comparaison post-classification croise les cartes de deux dates. Les nomenclatures, emprises et résolutions doivent être compatibles ; sinon les faux changements dominent.',
          [
            'Aligner les grilles.',
            'Calculer les transitions.',
            'Valider les changements majeurs.',
          ],
        ),
      ],
    ),
    _course(
      id: 'geomatique_agriculture',
      title: 'Géomatique pour l’agriculture',
      subtitle:
          'Délimiter les parcelles, suivre les cultures et produire des indicateurs agronomiques prudents.',
      category: 'Agriculture',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/environment_risk.png',
      accentValue: 0xFF5A8F29,
      objectives: [
        'Structurer un parcellaire agricole',
        'Interpréter un indice de végétation',
        'Relier carte et observation terrain',
      ],
      topics: [
        _topic(
          'Parcelles',
          'La limite utile peut différer d’une limite juridique. Identifiant, culture, campagne, variété, date de semis et méthode de mesure doivent être historisés.',
          [
            'Attribuer un identifiant stable.',
            'Conserver les campagnes.',
            'Contrôler les chevauchements.',
          ],
        ),
        _topic(
          'Indices',
          'Le NDVI et d’autres indices décrivent une réponse spectrale, pas directement un rendement. Sol nu, saturation, humidité, nuages et stade phénologique modifient leur valeur.',
          [
            'Comparer des dates cohérentes.',
            'Masquer nuages et ombres.',
            'Éviter un diagnostic sans terrain.',
          ],
        ),
        _topic(
          'Zonage',
          'Des zones de gestion regroupent des comportements similaires à partir de plusieurs années ou variables. Elles guident l’observation et l’échantillonnage, mais ne prescrivent pas seules une dose.',
          [
            'Combiner plusieurs sources.',
            'Tester la stabilité temporelle.',
            'Impliquer l’agronome.',
          ],
        ),
        _topic(
          'Restitution',
          'Une carte agricole doit montrer date, unité, résolution et limites. Un tableau par parcelle facilite l’action, tandis que les données personnelles des producteurs doivent être protégées.',
          [
            'Résumer par parcelle.',
            'Signaler les pixels manquants.',
            'Limiter les données nominatives.',
          ],
        ),
      ],
    ),
    _course(
      id: 'geomatique_sante',
      title: 'Géomatique et santé publique',
      subtitle:
          'Analyser couverture, accessibilité et disparités sans exposer les personnes.',
      category: 'Santé',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/urban_cadastre.png',
      accentValue: 0xFFB23A5A,
      objectives: [
        'Cartographier des indicateurs sanitaires responsables',
        'Mesurer l’accessibilité aux services',
        'Réduire les risques de réidentification',
      ],
      topics: [
        _topic(
          'Indicateurs',
          'Un taux rapporte un événement à une population exposée. Cartographier uniquement les nombres bruts favorise les zones peuplées et peut conduire à une mauvaise interprétation.',
          [
            'Utiliser un dénominateur adapté.',
            'Afficher la période.',
            'Montrer l’incertitude des petits nombres.',
          ],
        ),
        _topic(
          'Accessibilité',
          'La distance à vol d’oiseau ignore routes, coupures et temps d’attente. Une analyse réseau utilise vitesses, modes, barrières et emplacement réel des services.',
          [
            'Nettoyer le réseau.',
            'Choisir un temps réaliste.',
            'Tester plusieurs scénarios.',
          ],
        ),
        _topic(
          'Confidentialité',
          'Un point de domicile ou de cas peut identifier une personne. Agrégation, déplacement contrôlé, suppression des petits effectifs et accès restreint limitent le risque.',
          [
            'Minimiser les données.',
            'Évaluer la réidentification.',
            'Ne pas publier les points sensibles.',
          ],
        ),
        _topic(
          'Décision',
          'La carte doit aider à cibler une enquête, une offre ou une ressource sans stigmatiser un quartier. Les causes supposées nécessitent des données complémentaires.',
          [
            'Éviter la causalité hâtive.',
            'Associer les acteurs locaux.',
            'Documenter les limites.',
          ],
        ),
      ],
    ),
    _course(
      id: 'reseaux_transport',
      title: 'Analyse de réseaux et transport',
      subtitle:
          'Calculer itinéraires, zones de desserte et accessibilité sur un réseau connecté.',
      category: 'Mobilité',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/urban_cadastre.png',
      accentValue: 0xFFD65A31,
      objectives: [
        'Préparer un réseau routable',
        'Choisir une fonction de coût',
        'Interpréter itinéraires et isochrones',
      ],
      topics: [
        _topic(
          'Topologie du réseau',
          'Les tronçons doivent se connecter aux intersections, respecter sens uniques et éviter les ruptures invisibles. Les ponts et tunnels ne se croisent pas nécessairement au même niveau.',
          [
            'Accrocher les extrémités.',
            'Modéliser les niveaux.',
            'Contrôler les composantes isolées.',
          ],
        ),
        _topic(
          'Coûts',
          'Le plus court en distance n’est pas toujours le plus rapide. Temps, interdictions, pénalités de virage, type de véhicule et état de route définissent le coût.',
          [
            'Utiliser les bonnes unités.',
            'Intégrer les restrictions.',
            'Calibrer les vitesses.',
          ],
        ),
        _topic(
          'Itinéraires',
          'Le point de départ doit être accroché au réseau. Plusieurs itinéraires peuvent être comparés selon temps, distance, sécurité ou robustesse.',
          [
            'Vérifier le sens de circulation.',
            'Afficher les hypothèses.',
            'Tester des points réels.',
          ],
        ),
        _topic(
          'Isochrones',
          'Une isochrone délimite les lieux accessibles dans une durée. Elle dépend du réseau, du mode et des vitesses ; elle ne représente pas une distance circulaire.',
          [
            'Préciser le mode.',
            'Découper les zones irréalistes.',
            'Comparer aux observations.',
          ],
        ),
      ],
    ),
    _course(
      id: 'urbanisme_planification',
      title: 'Urbanisme et planification spatiale',
      subtitle:
          'Croiser occupation du sol, contraintes et besoins pour comparer des scénarios.',
      category: 'Urbanisme',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/urban_cadastre.png',
      accentValue: 0xFF8B3A62,
      objectives: [
        'Construire un diagnostic territorial',
        'Formaliser des critères d’aptitude',
        'Comparer des scénarios traçables',
      ],
      topics: [
        _topic(
          'Diagnostic',
          'Le diagnostic associe population, services, mobilités, environnement, foncier et dynamiques temporelles. Les limites administratives ne suffisent pas à expliquer les relations fonctionnelles.',
          [
            'Croiser plusieurs échelles.',
            'Identifier les tendances.',
            'Associer données et terrain.',
          ],
        ),
        _topic(
          'Contraintes',
          'Certaines zones sont exclues par une règle ou un risque ; d’autres sont plus ou moins favorables. Séparez contraintes booléennes et critères graduels.',
          [
            'Documenter chaque seuil.',
            'Éviter le double comptage.',
            'Conserver les données sources.',
          ],
        ),
        _topic(
          'Scénarios',
          'Un scénario traduit des objectifs et hypothèses. Modifier les poids ou la croissance supposée permet d’évaluer la robustesse plutôt que de présenter une carte unique comme certaine.',
          [
            'Construire plusieurs options.',
            'Réaliser une sensibilité.',
            'Montrer les compromis.',
          ],
        ),
        _topic(
          'Concertation',
          'Une carte de travail doit être compréhensible par les habitants et permettre de noter désaccords ou savoirs locaux. La participation ne se réduit pas à valider une décision déjà prise.',
          [
            'Employer un langage clair.',
            'Tracer les contributions.',
            'Restituer les arbitrages.',
          ],
        ),
      ],
    ),
    _course(
      id: 'geo_marketing',
      title: 'Géomarketing et localisation',
      subtitle:
          'Étudier clientèle, concurrence et zones de chalandise avec des données proportionnées.',
      category: 'Entreprise',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFF9A4D25,
      objectives: [
        'Construire une zone de chalandise',
        'Comparer des sites candidats',
        'Respecter la confidentialité client',
      ],
      topics: [
        _topic(
          'Données de marché',
          'Population, pouvoir d’achat, mobilité, concurrence et ventes peuvent être spatialisés. Leur date, niveau géographique et biais déterminent la finesse acceptable.',
          [
            'Vérifier la date.',
            'Normaliser par population.',
            'Éviter les faux détails.',
          ],
        ),
        _topic(
          'Chalandise',
          'Une zone de chalandise peut venir des adresses clients ou d’un temps de trajet. Un cercle arbitraire ignore le réseau, les barrières et la concurrence.',
          [
            'Géocoder avec un score.',
            'Utiliser des isochrones.',
            'Comparer réel et potentiel.',
          ],
        ),
        _topic(
          'Score de site',
          'Un score combine accessibilité, marché, coûts et risques. Les poids expriment une stratégie ; une analyse de sensibilité révèle les sites dépendants d’une hypothèse fragile.',
          [
            'Justifier les poids.',
            'Séparer coûts et bénéfices.',
            'Tester plusieurs scénarios.',
          ],
        ),
        _topic(
          'Vie privée',
          'Les adresses clients sont des données personnelles. Agrégez les résultats, contrôlez les accès et définissez une durée de conservation.',
          [
            'Minimiser les champs.',
            'Agrégér avant partage.',
            'Supprimer selon la politique.',
          ],
        ),
      ],
    ),
    _course(
      id: 'openstreetmap',
      title: 'OpenStreetMap et données ouvertes',
      subtitle:
          'Contribuer, extraire et réutiliser des données collaboratives avec leur licence.',
      category: 'Données ouvertes',
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/field_collaboration.png',
      accentValue: 0xFF4E7B63,
      objectives: [
        'Comprendre le modèle nœud-chemin-relation',
        'Contribuer avec des sources autorisées',
        'Évaluer une extraction OSM',
      ],
      topics: [
        _topic(
          'Modèle OSM',
          'Les nœuds portent une position, les chemins ordonnent des nœuds et les relations assemblent des membres. Les tags décrivent les objets par couples clé-valeur.',
          [
            'Un chemin peut être ouvert ou fermé.',
            'Lire les conventions de tags.',
            'Ne pas déduire une complétude uniforme.',
          ],
        ),
        _topic(
          'Contribution',
          'Une contribution doit venir d’une observation, d’une imagerie autorisée ou d’une source compatible. Les commentaires de changeset expliquent la modification.',
          [
            'Ne pas copier une carte interdite.',
            'Résoudre les conflits.',
            'Faire de petits changesets cohérents.',
          ],
        ),
        _topic(
          'Extraction',
          'Overpass et les extraits régionaux permettent de récupérer un sous-ensemble. Il faut convertir les tags utiles sans effacer l’information nécessaire.',
          [
            'Limiter emprise et thèmes.',
            'Conserver les identifiants si utile.',
            'Noter la date d’extraction.',
          ],
        ),
        _topic(
          'Qualité et licence',
          'La couverture varie selon les lieux et objets. Contrôlez géométrie, tags, actualité et doublons. La réutilisation doit respecter l’attribution et les conditions ODbL.',
          [
            'Comparer au terrain.',
            'Documenter les manques.',
            'Fournir l’attribution.',
          ],
        ),
      ],
    ),
    _course(
      id: 'metadonnees_catalogage',
      title: 'Métadonnées et catalogage',
      subtitle:
          'Rendre une donnée trouvable, compréhensible, évaluée et réutilisable.',
      category: 'Gouvernance',
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/field_collaboration.png',
      accentValue: 0xFF735D78,
      objectives: [
        'Rédiger une fiche de métadonnées utile',
        'Décrire qualité et conditions d’accès',
        'Organiser un catalogue',
      ],
      topics: [
        _topic(
          'Identification',
          'Un titre précis, un résumé, une emprise, des mots-clés, une date et un responsable permettent de découvrir la ressource. Le nom du fichier ne remplace pas cette description.',
          [
            'Employer un vocabulaire partagé.',
            'Distinguer création et mise à jour.',
            'Indiquer le contact fonctionnel.',
          ],
        ),
        _topic(
          'Qualité',
          'La lignée décrit sources et transformations. Résolution, précision, complétude, contrôles et limites permettent de décider si la donnée convient à un usage.',
          [
            'Décrire la méthode.',
            'Publier les limites.',
            'Éviter les promesses vagues.',
          ],
        ),
        _topic(
          'Accès et licence',
          'Les métadonnées indiquent format, service, licence, coût et restrictions. Une ressource sensible peut être décrite sans être téléchargeable.',
          [
            'Choisir une licence claire.',
            'Séparer métadonnée et donnée.',
            'Tester les liens.',
          ],
        ),
        _topic(
          'Cycle de vie',
          'Un catalogue doit identifier versions, responsables, dates de révision et ressources obsolètes. La suppression silencieuse casse les usages.',
          [
            'Versionner les fiches.',
            'Signaler le remplacement.',
            'Planifier les revues.',
          ],
        ),
      ],
    ),
    _course(
      id: 'geoserver_publication',
      title: 'GeoServer et publication SIG',
      subtitle:
          'Publier des couches interopérables, stylées, sécurisées et observables.',
      category: 'Serveur SIG',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFF4E7A9A,
      objectives: [
        'Structurer espaces de travail et magasins',
        'Configurer services et styles',
        'Protéger et surveiller la publication',
      ],
      topics: [
        _topic(
          'Organisation',
          'Un espace de travail regroupe des ressources ; un magasin décrit la connexion aux données ; une couche publiée expose un type d’entité ou raster. N’utilisez pas le compte administrateur dans les applications.',
          [
            'Nommer les espaces.',
            'Tester la connexion.',
            'Définir les emprises.',
          ],
        ),
        _topic(
          'Services',
          'WMS fournit une représentation, WFS des entités et WMTS des tuiles. Activez uniquement les opérations nécessaires et limitez le volume des réponses.',
          [
            'Choisir le service adapté.',
            'Fixer les limites.',
            'Contrôler les formats.',
          ],
        ),
        _topic(
          'Styles',
          'SLD ou CSS cartographique décrit symboles, règles et échelles. Une règle trop générale surcharge la carte et le serveur.',
          [
            'Utiliser les échelles.',
            'Valider la légende.',
            'Mettre en cache les fonds stables.',
          ],
        ),
        _topic(
          'Sécurité',
          'Les rôles limitent couches et services. HTTPS, mises à jour, sauvegardes, journaux et surveillance complètent la configuration.',
          [
            'Changer les identifiants initiaux.',
            'Appliquer le moindre privilège.',
            'Tester une restauration.',
          ],
        ),
      ],
    ),
    _course(
      id: 'mobile_field_kit',
      title: 'Kit terrain du géomaticien',
      subtitle:
          'Préparer matériel, équipe, sécurité, collecte hors ligne et retour de mission.',
      category: 'Terrain',
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/field_collaboration.png',
      accentValue: 0xFFE05D3B,
      objectives: [
        'Construire une checklist de mission',
        'Réduire les pertes de données',
        'Organiser le contrôle quotidien',
      ],
      topics: [
        _topic(
          'Avant le départ',
          'Le plan de mission précise zone, objectifs, autorisations, personnes, contacts, risques et horaires. Chargez appareils et batteries, téléchargez fonds et testez les formulaires hors ligne.',
          [
            'Imprimer une carte de secours.',
            'Tester les appareils.',
            'Prévoir eau et protection.',
          ],
        ),
        _topic(
          'Matériel',
          'Téléphone ou tablette, récepteur, batteries externes, câbles, mire, rubalise, carnet et moyens de protection dépendent de la tâche. Chaque équipement reçoit un responsable.',
          [
            'Étiqueter le matériel.',
            'Protéger de la poussière.',
            'Prévoir des pièces simples.',
          ],
        ),
        _topic(
          'Sur le terrain',
          'Un briefing fixe rôles, codes, critères de validation et fréquence des sauvegardes. Les incidents et changements de méthode sont notés au moment où ils surviennent.',
          [
            'Ne pas improviser les codes.',
            'Contrôler la précision.',
            'Respecter les communautés.',
          ],
        ),
        _topic(
          'Retour de mission',
          'Synchronisez, sauvegardez sur deux supports, vérifiez les effectifs et produisez un rapport d’anomalies avant que l’équipe ne quitte la zone.',
          [
            'Comparer prévu et collecté.',
            'Isoler les doublons.',
            'Planifier les reprises.',
          ],
        ),
      ],
    ),
    _course(
      id: 'ia_geospatiale',
      title: 'IA appliquée aux géodonnées',
      subtitle:
          'Préparer les échantillons, entraîner, évaluer et déployer un modèle spatial responsable.',
      category: 'Intelligence artificielle',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFF6C3AA0,
      objectives: [
        'Éviter les fuites spatiales entre jeux',
        'Évaluer un modèle au-delà de l’exactitude',
        'Documenter domaine et limites',
      ],
      topics: [
        _topic(
          'Question et labels',
          'Le label doit représenter le phénomène visé avec une définition stable. Une donnée abondante mais incohérente produit un modèle difficile à interpréter.',
          [
            'Définir les classes.',
            'Auditer les annotations.',
            'Conserver les cas ambigus.',
          ],
        ),
        _topic(
          'Découpage spatial',
          'Un partage aléatoire de pixels voisins place des zones presque identiques dans entraînement et test. Un découpage par blocs ou territoires mesure mieux la généralisation.',
          [
            'Séparer spatialement.',
            'Équilibrer les classes.',
            'Garder un test final.',
          ],
        ),
        _topic(
          'Métriques',
          'Précision, rappel, F1, IoU et matrice de confusion répondent à des erreurs différentes. La métrique doit refléter le coût réel des faux positifs et faux négatifs.',
          [
            'Publier par classe.',
            'Tester plusieurs territoires.',
            'Inspecter les erreurs.',
          ],
        ),
        _topic(
          'Déploiement',
          'Le modèle doit vérifier formats, projection, résolution et plage des variables. Une dérive des données ou du territoire exige une surveillance et parfois un nouvel apprentissage.',
          [
            'Versionner modèle et données.',
            'Définir un seuil de rejet.',
            'Prévoir une validation humaine.',
          ],
        ),
      ],
    ),
    _course(
      id: 'gestion_projet_geo',
      title: 'Gestion de projet géomatique',
      subtitle:
          'Transformer un besoin en données, méthodes, responsabilités et livrables vérifiables.',
      category: 'Management',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/field_collaboration.png',
      accentValue: 0xFF7D4F50,
      objectives: [
        'Cadrer un besoin spatial',
        'Planifier qualité, risques et ressources',
        'Organiser une recette des livrables',
      ],
      topics: [
        _topic(
          'Cadrage',
          'Une demande comme faire une carte doit être traduite en décision, utilisateurs, emprise, date, échelle, précision et format. Les critères d’acceptation sont fixés avant la production.',
          [
            'Identifier le décideur.',
            'Définir les usages.',
            'Écrire les exclusions.',
          ],
        ),
        _topic(
          'Planification',
          'Le découpage du travail relie collecte, préparation, analyse, contrôle et restitution. Dépendances, responsables, coûts et marges sont visibles dans un calendrier réaliste.',
          [
            'Estimer les volumes.',
            'Prévoir les contrôles.',
            'Réserver une marge terrain.',
          ],
        ),
        _topic(
          'Risques',
          'Accès, météo, matériel, droits, données manquantes, compétences et délais constituent des risques. Pour chacun, définissez probabilité, impact, prévention et solution de repli.',
          [
            'Tenir un registre.',
            'Attribuer un responsable.',
            'Réviser régulièrement.',
          ],
        ),
        _topic(
          'Recette',
          'La recette compare livrables aux critères : complétude, précision, formats, métadonnées, performances et lisibilité. Les anomalies reçoivent une priorité et une trace de correction.',
          [
            'Préparer une checklist.',
            'Tester avec les utilisateurs.',
            'Archiver la validation.',
          ],
        ),
      ],
    ),
    _course(
      id: 'portfolio_metier',
      title: 'Portfolio et métiers de la géomatique',
      subtitle:
          'Présenter ses compétences par des preuves, comprendre les rôles et construire sa progression.',
      category: 'Carrière',
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/certifications_hero.png',
      accentValue: 0xFF8A3159,
      objectives: [
        'Identifier les principales familles de métiers',
        'Construire une étude de cas convaincante',
        'Protéger les données de son portfolio',
      ],
      topics: [
        _topic(
          'Familles de métiers',
          'Technicien terrain, cartographe, analyste SIG, administrateur de données, développeur webmapping, spécialiste télédétection ou chef de projet mobilisent des combinaisons différentes.',
          [
            'Lire les compétences demandées.',
            'Distinguer outil et méthode.',
            'Construire une spécialité progressive.',
          ],
        ),
        _topic(
          'Étude de cas',
          'Un bon projet présente le problème, les données, la méthode, les contrôles, le résultat et les limites. Une image seule ne prouve ni votre raisonnement ni votre contribution.',
          [
            'Expliquer les choix.',
            'Montrer un contrôle qualité.',
            'Quantifier le résultat.',
          ],
        ),
        _topic(
          'Présentation',
          'Deux ou trois projets bien documentés valent mieux qu’une galerie confuse. Une page lisible, des cartes accessibles et des liens fonctionnels facilitent l’évaluation.',
          ['Adapter au poste.', 'Corriger les légendes.', 'Tester sur mobile.'],
        ),
        _topic(
          'Éthique',
          'Retirez noms, coordonnées sensibles, clés et données soumises à contrat. Demandez l’autorisation avant de publier un travail réalisé pour une organisation.',
          [
            'Anonymiser les exemples.',
            'Citer les sources.',
            'Respecter les licences.',
          ],
        ),
      ],
    ),
  ];

  static Course _course({
    required String id,
    required String title,
    required String subtitle,
    required String category,
    required CourseLevel level,
    required String imageAsset,
    required int accentValue,
    required List<String> objectives,
    required List<CourseSection> topics,
  }) => Course(
    id: id,
    title: title,
    subtitle: subtitle,
    category: category,
    level: level,
    imageAsset: imageAsset,
    accentValue: accentValue,
    objectives: objectives,
    sections: topics,
  );

  static CourseSection _topic(String title, String body, List<String> points) =>
      CourseSection(title: title, body: body, keyPoints: points);
}
