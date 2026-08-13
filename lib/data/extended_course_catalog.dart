import '../models/learning_models.dart';

abstract class ExtendedCourseCatalog {
  static final List<Course> courses = <Course>[
    Course(
      id: 'topographie_nivellement',
      title: 'Topographie et nivellement',
      subtitle:
          'Mesurer angles, distances et altitudes avec une méthode de terrain rigoureuse.',
      category: 'Topographie',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/topographie_geodesie.png',
      accentValue: 0xFFEC1745,
      objectives: [
        'Préparer un cheminement topographique',
        'Calculer une altitude par nivellement direct',
        'Contrôler la fermeture et documenter la précision',
      ],
      sections: [
        CourseSection(
          title: '1. Planimétrie et altimétrie',
          body:
              'La planimétrie détermine la position horizontale des points, tandis que l’altimétrie décrit leur hauteur. Une station totale mesure des angles et des distances ; un niveau et une mire déterminent des dénivelées avec une grande stabilité.',
          keyPoints: [
            'Matérialiser des points durables et bien identifiés.',
            'Centrer et caler chaque instrument avant les observations.',
            'Noter unités, hauteur d’instrument et hauteur de cible.',
          ],
        ),
        CourseSection(
          title: '2. Nivellement direct',
          body:
              'Une lecture arrière est prise sur un point d’altitude connue, puis une lecture avant sur le point à déterminer. La dénivelée vaut lecture arrière moins lecture avant. Les portées équilibrées réduisent plusieurs erreurs systématiques.',
          keyPoints: [
            'Dénivelée = lecture arrière − lecture avant.',
            'Altitude suivante = altitude précédente + dénivelée.',
            'Équilibrer approximativement les distances arrière et avant.',
          ],
          fieldNote:
              'Fermez le cheminement sur un repère connu pour mesurer l’erreur de fermeture.',
        ),
        CourseSection(
          title: '3. Polygonation et orientation',
          body:
              'Un cheminement polygonal relie des stations successives. À partir d’un azimut connu, les angles et distances permettent de calculer les coordonnées. Une polygonale fermée offre des contrôles angulaires et linéaires.',
          keyPoints: [
            'Orienter la station avec une visée arrière fiable.',
            'Effectuer des lectures répétées lorsque la précision l’exige.',
            'Comparer fermeture mesurée et tolérance du cahier des charges.',
          ],
        ),
        CourseSection(
          title: '4. Carnet et contrôle qualité',
          body:
              'Le carnet de terrain conserve les observations brutes, croquis, codes de points et incidents. Les compensations ne remplacent jamais une mesure incohérente : les résidus doivent être analysés avant leur répartition.',
          keyPoints: [
            'Conserver les observations brutes sans les écraser.',
            'Calculer les fermetures avant de quitter le site.',
            'Joindre photos, croquis et repères de contrôle.',
          ],
        ),
      ],
    ),
    Course(
      id: 'geodesie_projections',
      title: 'Géodésie et projections',
      subtitle:
          'Datums, ellipsoïdes et transformations pour superposer les données sans décalage.',
      category: 'Référentiels',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/topographie_geodesie.png',
      accentValue: 0xFF5A0B68,
      objectives: [
        'Distinguer ellipsoïde, datum et géoïde',
        'Choisir une projection adaptée au territoire',
        'Éviter une transformation de coordonnées incorrecte',
      ],
      sections: [
        CourseSection(
          title: '1. Modéliser la Terre',
          body:
              'L’ellipsoïde est une surface mathématique régulière utilisée pour calculer latitude et longitude. Le géoïde représente une surface équipotentielle proche du niveau moyen des mers. Un datum relie l’ellipsoïde au monde réel.',
          keyPoints: [
            'WGS 84 est un datum géocentrique mondial.',
            'La hauteur ellipsoïdale diffère de l’altitude orthométrique.',
            'Le modèle de géoïde permet de passer de l’une à l’autre.',
          ],
        ),
        CourseSection(
          title: '2. Pourquoi projeter ?',
          body:
              'Une projection transforme la surface courbe de la Terre vers un plan. Toute projection déforme au moins les angles, distances, surfaces ou directions. Le choix dépend donc de l’étendue et du type d’analyse.',
          keyPoints: [
            'Une projection conforme préserve localement les angles.',
            'Une projection équivalente préserve les surfaces.',
            'Les calculs métriques exigent un SCR projeté approprié.',
          ],
        ),
        CourseSection(
          title: '3. UTM et zones',
          body:
              'Le système UTM divise le globe en zones de six degrés de longitude. Il fournit des coordonnées en mètres et limite les déformations près du méridien central. Une zone incorrecte peut produire des positions plausibles mais fausses.',
          keyPoints: [
            'Identifier zone et hémisphère.',
            'Éviter un UTM unique pour un territoire couvrant plusieurs zones.',
            'Enregistrer le code EPSG complet avec chaque jeu de données.',
          ],
          fieldNote:
              'Au Sénégal, vérifiez toujours le datum et la zone avant d’importer des coordonnées.',
        ),
        CourseSection(
          title: '4. Transformation et reprojection',
          body:
              'Changer l’étiquette d’un SCR ne modifie pas les coordonnées. Une reprojection recalcule réellement les positions. Entre deux datums, une transformation géodésique et parfois une grille de correction sont nécessaires.',
          keyPoints: [
            'Définir le SCR source seulement lorsqu’il est connu.',
            'Choisir la transformation adaptée à la zone géographique.',
            'Contrôler plusieurs points connus après transformation.',
          ],
        ),
      ],
    ),
    Course(
      id: 'bases_donnees_spatiales',
      title: 'Bases de données spatiales',
      subtitle:
          'Structurer, interroger et sécuriser de grands volumes avec PostGIS.',
      category: 'Données',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFF8A124B,
      objectives: [
        'Modéliser des tables géographiques cohérentes',
        'Écrire des requêtes spatiales utiles',
        'Comprendre index, contraintes et transactions',
      ],
      sections: [
        CourseSection(
          title: '1. Modèle relationnel spatial',
          body:
              'Une base spatiale ajoute des géométries et opérateurs géographiques au modèle relationnel. Chaque table doit posséder une clé primaire, des types explicites et des contraintes décrivant les valeurs autorisées.',
          keyPoints: [
            'Séparer les entités selon leur rôle métier.',
            'Éviter de dupliquer une information stable dans plusieurs tables.',
            'Documenter le type géométrique et le SRID attendu.',
          ],
        ),
        CourseSection(
          title: '2. SQL spatial',
          body:
              'PostGIS propose des fonctions comme ST_Intersects, ST_Within, ST_Distance et ST_Buffer. Une requête associe filtres attributaires et relations spatiales pour répondre précisément à une question territoriale.',
          keyPoints: [
            'ST_Intersects teste si deux géométries partagent un espace.',
            'ST_Area calcule une surface dans les unités du SCR.',
            'ST_Transform reprojette une géométrie dans une requête.',
          ],
        ),
        CourseSection(
          title: '3. Index et performances',
          body:
              'Un index spatial GiST réduit le nombre de géométries comparées grâce à leurs boîtes englobantes. Il accélère fortement les recherches, sans remplacer un filtre correct ni une analyse du plan d’exécution.',
          keyPoints: [
            'Indexer les colonnes souvent utilisées dans les jointures spatiales.',
            'Utiliser EXPLAIN pour comprendre une requête lente.',
            'Limiter les colonnes et lignes retournées.',
          ],
          fieldNote:
              'Une fonction appliquée inutilement à toute la colonne peut empêcher un bon usage de l’index.',
        ),
        CourseSection(
          title: '4. Intégrité et sauvegarde',
          body:
              'Les transactions regroupent plusieurs opérations : elles sont toutes validées ou toutes annulées. Les rôles limitent les droits. Une stratégie de sauvegarde doit être testée par une restauration réelle.',
          keyPoints: [
            'Utiliser des contraintes pour bloquer les données invalides.',
            'Accorder le minimum de privilèges nécessaire.',
            'Automatiser et tester les sauvegardes.',
          ],
        ),
      ],
    ),
    Course(
      id: 'webmapping_ogc',
      title: 'Webmapping et services OGC',
      subtitle:
          'Publier des cartes rapides avec tuiles, API et standards interopérables.',
      category: 'Web SIG',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFFFF6338,
      objectives: [
        'Distinguer WMS, WFS et tuiles vectorielles',
        'Concevoir une architecture web cartographique',
        'Optimiser performance et accessibilité',
      ],
      sections: [
        CourseSection(
          title: '1. Architecture d’une carte web',
          body:
              'Le navigateur affiche une interface, demande des fonds et des données à des serveurs, puis les dessine avec une bibliothèque cartographique. Les traitements lourds et les données sensibles restent généralement côté serveur.',
          keyPoints: [
            'Client : interactions, styles et affichage.',
            'Serveur : données, règles d’accès et traitements.',
            'Cache : réponses réutilisées pour réduire la latence.',
          ],
        ),
        CourseSection(
          title: '2. WMS, WFS et API',
          body:
              'Un WMS renvoie une image de carte déjà rendue. Un WFS fournit des entités vectorielles interrogeables. Les API modernes exposent des ressources par URL et formats web, souvent GeoJSON.',
          keyPoints: [
            'WMS pour visualiser rapidement une carte composée.',
            'WFS ou API Features pour manipuler des objets.',
            'Ne publier que les attributs réellement nécessaires.',
          ],
        ),
        CourseSection(
          title: '3. Tuiles et niveaux de zoom',
          body:
              'Les tuiles découpent la carte en petits carrés adressés par zoom, colonne et ligne. Les tuiles raster transportent des images ; les tuiles vectorielles transportent des géométries compactes stylées dans le client.',
          keyPoints: [
            'Généraliser les données aux petits niveaux de zoom.',
            'Mettre en cache les tuiles stables.',
            'Limiter la densité visuelle pour garder une carte lisible.',
          ],
        ),
        CourseSection(
          title: '4. Performance et expérience',
          body:
              'Une carte utile charge vite, fonctionne sur petit écran, explique ses symboles et reste utilisable au clavier. Il faut mesurer le poids des réponses, regrouper les requêtes et prévoir les erreurs réseau.',
          keyPoints: [
            'Afficher un état de chargement et un message d’erreur clair.',
            'Compresser les données et paginer les résultats volumineux.',
            'Tester contraste, taille des cibles et navigation mobile.',
          ],
          fieldNote:
              'Testez avec une connexion mobile lente, pas seulement sur le Wi-Fi du bureau.',
        ),
      ],
    ),
    Course(
      id: 'geostatistique',
      title: 'Géostatistique et interpolation',
      subtitle:
          'Explorer la dépendance spatiale et estimer une variable entre les mesures.',
      category: 'Analyse',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/terrain_geostatistics.png',
      accentValue: 0xFFB40B4C,
      objectives: [
        'Analyser la distribution et les valeurs aberrantes',
        'Interpréter un variogramme',
        'Valider une interpolation sans surinterpréter',
      ],
      sections: [
        CourseSection(
          title: '1. Explorer avant d’interpoler',
          body:
              'Une carte de points ne suffit pas. Histogramme, moyenne, médiane, dispersion, unités et protocole d’échantillonnage révèlent asymétries et biais. Une valeur extrême peut être une erreur ou un phénomène important.',
          keyPoints: [
            'Contrôler coordonnées, unités et doublons.',
            'Comparer distribution globale et répartition spatiale.',
            'Ne supprimer une valeur qu’avec une justification documentée.',
          ],
        ),
        CourseSection(
          title: '2. Autocorrélation spatiale',
          body:
              'Des observations proches tendent souvent à se ressembler. Cette dépendance spatiale est la base de la géostatistique. Elle varie selon la distance et parfois la direction, phénomène appelé anisotropie.',
          keyPoints: [
            'Une dépendance n’implique pas une causalité.',
            'Le pas d’échantillonnage limite le détail estimable.',
            'Rechercher une tendance globale avant le modèle local.',
          ],
        ),
        CourseSection(
          title: '3. Variogramme et krigeage',
          body:
              'Le variogramme décrit l’augmentation de la dissimilarité avec la distance. La portée indique la distance de corrélation, le palier la variance stabilisée et l’effet pépite la variabilité à très courte distance ou l’erreur.',
          keyPoints: [
            'Ajuster un modèle cohérent aux points expérimentaux.',
            'Le krigeage fournit estimation et variance associée.',
            'Un modèle complexe n’est pas automatiquement meilleur.',
          ],
          fieldNote:
              'Affichez toujours la carte d’incertitude avec la surface interpolée.',
        ),
        CourseSection(
          title: '4. Validation croisée',
          body:
              'La validation croisée retire successivement des observations et les prédit avec les autres. Les erreurs mesurent biais et précision. Il faut aussi inspecter leur structure spatiale et les zones éloignées des échantillons.',
          keyPoints: [
            'Comparer plusieurs méthodes avec les mêmes plis de validation.',
            'Examiner erreur moyenne et erreur quadratique.',
            'Masquer les zones où l’extrapolation serait injustifiée.',
          ],
        ),
      ],
    ),
    Course(
      id: 'mnt_hydrologie',
      title: 'MNT et analyse hydrologique',
      subtitle:
          'Du relief brut aux pentes, bassins versants et réseaux d’écoulement.',
      category: 'Relief',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/terrain_geostatistics.png',
      accentValue: 0xFF5A0B68,
      objectives: [
        'Distinguer MNT, MNS et résolution',
        'Extraire pente et direction d’écoulement',
        'Délimiter un bassin versant contrôlé',
      ],
      sections: [
        CourseSection(
          title: '1. Choisir un modèle d’altitude',
          body:
              'Un MNS contient le sommet des objets, alors qu’un MNT cherche le terrain nu. La résolution est la taille des cellules ; la précision verticale décrit l’erreur d’altitude. Une petite cellule ne garantit pas une altitude exacte.',
          keyPoints: [
            'Vérifier source, date, résolution et précision verticale.',
            'Reprojeter dans un SCR métrique avant les dérivées.',
            'Rechercher trous, bandes et valeurs aberrantes.',
          ],
        ),
        CourseSection(
          title: '2. Pente, exposition et ombrage',
          body:
              'La pente mesure la variation maximale d’altitude autour d’une cellule. L’exposition donne l’orientation de cette pente. L’ombrage simule une illumination et facilite la lecture, mais ne remplace pas les valeurs du MNT.',
          keyPoints: [
            'Préciser si la pente est en degrés ou en pourcentage.',
            'Tester plusieurs azimuts pour l’ombrage.',
            'Les dérivées amplifient le bruit du MNT.',
          ],
        ),
        CourseSection(
          title: '3. Écoulement et dépressions',
          body:
              'Les algorithmes hydrologiques attribuent à chaque cellule une direction vers un voisin plus bas. Les dépressions artificielles peuvent interrompre le réseau et doivent être comblées avec prudence.',
          keyPoints: [
            'Corriger les dépressions selon le contexte du terrain.',
            'L’accumulation compte les cellules qui alimentent un emplacement.',
            'Un seuil d’accumulation transforme le flux en réseau de drainage.',
          ],
        ),
        CourseSection(
          title: '4. Bassins versants',
          body:
              'À partir d’un exutoire correctement positionné, les directions d’écoulement délimitent la zone contributive. Le résultat doit être comparé aux rivières, courbes de niveau et observations de terrain.',
          keyPoints: [
            'Accrocher l’exutoire au bon axe d’écoulement.',
            'Tester la sensibilité à la résolution et au seuil.',
            'Documenter les corrections imposées au relief.',
          ],
          fieldNote:
              'Un ouvrage hydraulique absent du MNT peut modifier complètement le bassin calculé.',
        ),
      ],
    ),
    Course(
      id: 'cadastre_foncier',
      title: 'Cadastre et information foncière',
      subtitle:
          'Parcelles, droits et plans fiables au service de la gestion du territoire.',
      category: 'Foncier',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/urban_cadastre.png',
      accentValue: 0xFF7E063F,
      objectives: [
        'Comprendre les composantes d’un système cadastral',
        'Contrôler la topologie parcellaire',
        'Relier géométrie, documents et droits avec prudence',
      ],
      sections: [
        CourseSection(
          title: '1. Parcelle et information foncière',
          body:
              'Le cadastre décrit des unités spatiales, leurs identifiants et certaines informations associées. La carte n’est pas toujours la preuve juridique du droit : documents, institutions et cadre légal restent déterminants.',
          keyPoints: [
            'Attribuer un identifiant stable à chaque parcelle.',
            'Séparer personnes, droits, documents et géométries.',
            'Tracer la source et la date de chaque modification.',
          ],
        ),
        CourseSection(
          title: '2. Levé et précision',
          body:
              'La méthode de levé dépend de la précision réglementaire, du contexte et de la matérialisation des limites. Les bornes doivent être décrites et les observations rattachées à des points de référence fiables.',
          keyPoints: [
            'Ne pas confondre précision graphique et précision de bornage.',
            'Conserver le croquis et les observations terrain.',
            'Signaler explicitement les limites incertaines ou litigieuses.',
          ],
        ),
        CourseSection(
          title: '3. Topologie parcellaire',
          body:
              'Dans une couverture cadastrale, les parcelles ne doivent généralement ni se chevaucher ni laisser de trous non expliqués. Des limites communes doivent partager les mêmes sommets pour éviter les micro-polygones.',
          keyPoints: [
            'Contrôler chevauchements, trous et géométries invalides.',
            'Utiliser l’accrochage avec une tolérance justifiée.',
            'Ne pas déplacer une limite sans procédure de validation.',
          ],
        ),
        CourseSection(
          title: '4. Mise à jour et confidentialité',
          body:
              'Un cadastre perd rapidement sa valeur s’il n’est pas mis à jour. Les opérations doivent suivre un workflow, conserver un historique et protéger les données personnelles selon les règles applicables.',
          keyPoints: [
            'Versionner les modifications et leurs justificatifs.',
            'Limiter l’accès aux attributs sensibles.',
            'Publier uniquement les informations autorisées.',
          ],
          fieldNote:
              'Une carte cadastrale doit toujours mentionner sa portée et sa date de validité.',
        ),
      ],
    ),
    Course(
      id: 'python_geomatique',
      title: 'Python pour la géomatique',
      subtitle:
          'Automatiser des traitements reproductibles sans perdre le contrôle des données.',
      category: 'Automatisation',
      level: CourseLevel.avance,
      imageAsset: 'assets/images/geodata_automation.png',
      accentValue: 0xFFEC1745,
      objectives: [
        'Structurer un script géospatial lisible',
        'Automatiser un traitement par lots',
        'Ajouter contrôles, journaux et tests simples',
      ],
      sections: [
        CourseSection(
          title: '1. De la tâche manuelle au script',
          body:
              'L’automatisation est utile lorsqu’une suite d’étapes est répétitive, volumineuse ou doit être reproduite. Le script doit recevoir des entrées explicites, produire des sorties prévisibles et ne jamais écraser les sources par défaut.',
          keyPoints: [
            'Décomposer le traitement en petites fonctions.',
            'Utiliser des noms qui expriment l’unité et le contenu.',
            'Séparer configuration, logique et fichiers produits.',
          ],
        ),
        CourseSection(
          title: '2. Vecteurs et rasters',
          body:
              'GeoPandas facilite les tables vectorielles, Shapely les opérations géométriques et Rasterio les rasters. PyProj gère les transformations de coordonnées. Chaque bibliothèque conserve des hypothèses qu’il faut vérifier.',
          keyPoints: [
            'Lire et contrôler le SCR immédiatement.',
            'Valider les géométries avant une superposition.',
            'Traiter les rasters par fenêtres lorsque les fichiers sont grands.',
          ],
        ),
        CourseSection(
          title: '3. Traitement par lots',
          body:
              'Un pipeline parcourt des fichiers selon une règle contrôlée, valide leur schéma puis exécute les mêmes opérations. Les erreurs doivent identifier le fichier concerné sans masquer les traitements déjà réussis.',
          keyPoints: [
            'Filtrer les extensions et ignorer les fichiers temporaires.',
            'Créer un dossier de sortie distinct.',
            'Journaliser durée, paramètres et erreurs.',
          ],
          fieldNote:
              'Testez d’abord sur trois petits fichiers représentatifs avant de lancer tout le répertoire.',
        ),
        CourseSection(
          title: '4. Reproductibilité',
          body:
              'Un environnement fixe les versions des dépendances. Des assertions vérifient colonnes, emprise et nombre d’entités. Un échantillon de référence permet de détecter une régression après modification du script.',
          keyPoints: [
            'Versionner le code et le fichier de dépendances.',
            'Écrire les paramètres dans les métadonnées de sortie.',
            'Conserver un petit jeu de données de test.',
          ],
        ),
      ],
    ),
    Course(
      id: 'collecte_qualite',
      title: 'Collecte mobile et qualité',
      subtitle:
          'Concevoir un formulaire terrain, synchroniser et contrôler les observations.',
      category: 'Terrain',
      level: CourseLevel.debutant,
      imageAsset: 'assets/images/field_collaboration.png',
      accentValue: 0xFFFF6338,
      objectives: [
        'Préparer un formulaire mobile robuste',
        'Organiser une collecte hors connexion',
        'Mettre en place des contrôles qualité rapides',
      ],
      sections: [
        CourseSection(
          title: '1. Partir du protocole',
          body:
              'Le formulaire traduit une méthode de collecte. Chaque champ doit répondre à un besoin, posséder un type correct et une consigne compréhensible. Les listes contrôlées réduisent les variantes d’écriture.',
          keyPoints: [
            'Définir champs obligatoires et valeurs autorisées.',
            'Éviter les questions ambiguës ou redondantes.',
            'Prévoir la valeur inconnue au lieu d’inventer une réponse.',
          ],
        ),
        CourseSection(
          title: '2. Position et contexte',
          body:
              'La précision du téléphone dépend du ciel, du matériel et du temps d’observation. Une photo orientée, un commentaire et l’identifiant de l’enquêteur complètent utilement la position.',
          keyPoints: [
            'Afficher la précision estimée avant validation.',
            'Ne pas collecter derrière une vitre lorsque la précision est critique.',
            'Enregistrer date, heure et méthode de localisation.',
          ],
        ),
        CourseSection(
          title: '3. Hors connexion et synchronisation',
          body:
              'Les fonds et formulaires doivent être préparés avant le départ. La synchronisation peut rencontrer des doublons ou conflits ; un identifiant unique et une règle de résolution évitent la perte silencieuse.',
          keyPoints: [
            'Télécharger la zone de travail avant le terrain.',
            'Tester batterie, stockage et sauvegarde locale.',
            'Synchroniser par petits lots et vérifier les compteurs.',
          ],
          fieldNote:
              'Effectuez une collecte pilote complète, de la saisie jusqu’à l’export final.',
        ),
        CourseSection(
          title: '4. Contrôle quotidien',
          body:
              'Une revue en fin de journée permet de retourner rapidement sur un site. Les contrôles portent sur complétude, positions hors emprise, doublons, valeurs impossibles et cohérence entre photo et attributs.',
          keyPoints: [
            'Cartographier les points immédiatement après synchronisation.',
            'Comparer le nombre prévu et le nombre reçu.',
            'Documenter les corrections sans effacer la trace initiale.',
          ],
        ),
      ],
    ),
    Course(
      id: 'environnement_risques',
      title: 'SIG environnemental et risques',
      subtitle:
          'Combiner aléas, enjeux et vulnérabilité pour appuyer une décision responsable.',
      category: 'Environnement',
      level: CourseLevel.intermediaire,
      imageAsset: 'assets/images/environment_risk.png',
      accentValue: 0xFF168A65,
      objectives: [
        'Distinguer aléa, exposition, vulnérabilité et risque',
        'Construire une analyse multicritère transparente',
        'Communiquer l’incertitude et les limites',
      ],
      sections: [
        CourseSection(
          title: '1. Les composantes du risque',
          body:
              'Un aléa décrit un phénomène potentiellement dommageable. Les enjeux sont les personnes, bâtiments ou écosystèmes exposés. La vulnérabilité exprime leur sensibilité et leur capacité à faire face.',
          keyPoints: [
            'Un aléa fort sans enjeu exposé ne produit pas le même risque.',
            'Les données sociales complètent les données physiques.',
            'La période de référence doit être précisée.',
          ],
        ),
        CourseSection(
          title: '2. Préparer les critères',
          body:
              'Pente, distance à l’eau, occupation du sol ou densité peuvent avoir des unités différentes. Ils doivent être normalisés selon une règle justifiée avant combinaison. Les poids traduisent un choix qui doit rester visible.',
          keyPoints: [
            'Aligner emprise, résolution et SCR des rasters.',
            'Justifier seuils et fonctions de normalisation.',
            'Tester plusieurs jeux de poids.',
          ],
        ),
        CourseSection(
          title: '3. Scénarios et incertitude',
          body:
              'Une carte de risque est un modèle, pas une certitude. Des scénarios explorent différentes hypothèses. La sensibilité mesure l’effet d’un paramètre sur le classement final et révèle les zones instables.',
          keyPoints: [
            'Séparer données observées et hypothèses.',
            'Cartographier les zones de désaccord entre scénarios.',
            'Valider avec événements passés et expertise locale.',
          ],
          fieldNote:
              'Ne masquez jamais une forte incertitude derrière une palette de couleurs très précise.',
        ),
        CourseSection(
          title: '4. Carte pour l’action',
          body:
              'La restitution doit correspondre à l’usage : préparation, intervention, évacuation ou planification. Elle indique sources, date, scénario et limites, tout en protégeant les personnes vulnérables.',
          keyPoints: [
            'Mettre en avant les décisions possibles.',
            'Éviter de stigmatiser un quartier ou une population.',
            'Prévoir une version imprimable et une version mobile.',
          ],
        ),
      ],
    ),
  ];
}
