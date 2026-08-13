import '../models/certification_models.dart';

abstract class CertificationCatalog {
  static const modules = <CertificationModule>[
    CertificationModule(
      id: 'sig_cartographie',
      title: 'SIG & cartographie professionnelle',
      sector: 'Collectivités & bureaux d’études',
      summary:
          'Concevoir une base SIG propre, analyser les territoires et produire des cartes prêtes à la décision.',
      skills: [
        'Structuration et contrôle des données',
        'Analyses spatiales et géotraitements',
        'Sémiologie et mise en page cartographique',
      ],
      audience: 'Agents SIG, techniciens, étudiants et chargés d’études',
      duration: 'Parcours conseillé : 24 à 36 h',
      level: 'Débutant à intermédiaire',
      iconName: 'map',
      accentValue: 0xFF650238,
    ),
    CertificationModule(
      id: 'topographie_gnss',
      title: 'Topographie, GNSS & levés terrain',
      sector: 'BTP, mines & infrastructures',
      summary:
          'Préparer, réaliser et contrôler un levé en documentant les référentiels, la précision et la traçabilité.',
      skills: [
        'Planification et sécurité du levé',
        'GNSS, RTK et cheminement topographique',
        'Calculs, contrôles et carnet de terrain',
      ],
      audience: 'Géomètres, techniciens BTP, opérateurs terrain',
      duration: 'Parcours conseillé : 30 à 45 h',
      level: 'Intermédiaire',
      iconName: 'survey',
      accentValue: 0xFF5A0B68,
    ),
    CertificationModule(
      id: 'teledetection_environnement',
      title: 'Télédétection & suivi environnemental',
      sector: 'Environnement, climat & littoral',
      summary:
          'Exploiter l’imagerie satellitaire pour observer les changements, les risques et les ressources naturelles.',
      skills: [
        'Prétraitements et choix des images',
        'Indices spectraux et classifications',
        'Validation, séries temporelles et restitution',
      ],
      audience: 'ONG, services environnementaux, chercheurs et étudiants',
      duration: 'Parcours conseillé : 28 à 40 h',
      level: 'Intermédiaire',
      iconName: 'satellite',
      accentValue: 0xFFB40B4C,
    ),
    CertificationModule(
      id: 'agriculture_precision',
      title: 'Géomatique pour l’agriculture',
      sector: 'Agriculture & sécurité alimentaire',
      summary:
          'Cartographier les parcelles, suivre la végétation et transformer les observations en indicateurs utiles.',
      skills: [
        'Délimitation et collecte mobile',
        'Indices de végétation et zonage',
        'Tableaux de bord et recommandations spatiales',
      ],
      audience: 'Conseillers agricoles, coopératives, agronomes',
      duration: 'Parcours conseillé : 20 à 32 h',
      level: 'Débutant à intermédiaire',
      iconName: 'agriculture',
      accentValue: 0xFF168A65,
    ),
    CertificationModule(
      id: 'cadastre_foncier',
      title: 'Cadastre, foncier & aménagement',
      sector: 'Foncier, urbanisme & administration',
      summary:
          'Organiser les données parcellaires, documenter les limites et soutenir une gestion territoriale transparente.',
      skills: [
        'Modèle parcellaire et identifiants',
        'Topologie, qualité et historique',
        'Analyse foncière et production de plans',
      ],
      audience: 'Services fonciers, urbanistes, collectivités, juristes SIG',
      duration: 'Parcours conseillé : 30 à 42 h',
      level: 'Intermédiaire',
      iconName: 'cadastre',
      accentValue: 0xFF7E063F,
    ),
    CertificationModule(
      id: 'bases_spatiales',
      title: 'Bases de données spatiales & PostGIS',
      sector: 'Data, télécoms & systèmes d’information',
      summary:
          'Construire une base géographique robuste, interroger les relations spatiales et sécuriser les échanges.',
      skills: [
        'Modélisation relationnelle et spatiale',
        'SQL, index et requêtes PostGIS',
        'Import, contrôle, sauvegarde et documentation',
      ],
      audience: 'Administrateurs SIG, développeurs, data analysts',
      duration: 'Parcours conseillé : 28 à 40 h',
      level: 'Intermédiaire à avancé',
      iconName: 'database',
      accentValue: 0xFF315B8A,
    ),
    CertificationModule(
      id: 'webmapping',
      title: 'Webmapping & applications géospatiales',
      sector: 'Numérique, services publics & innovation',
      summary:
          'Publier une carte web rapide, lisible et adaptée aux usages mobiles avec des données maîtrisées.',
      skills: [
        'Services, tuiles et formats web',
        'Interface cartographique et accessibilité',
        'Déploiement, performances et sécurité',
      ],
      audience: 'Développeurs, géomaticiens et chefs de projet numérique',
      duration: 'Parcours conseillé : 32 à 48 h',
      level: 'Intermédiaire à avancé',
      iconName: 'web',
      accentValue: 0xFF006E7A,
    ),
    CertificationModule(
      id: 'python_geo',
      title: 'Python & automatisation géospatiale',
      sector: 'Data science & production SIG',
      summary:
          'Automatiser les tâches répétitives et créer des chaînes de traitement reproductibles et contrôlées.',
      skills: [
        'Python, GeoPandas et raster',
        'Traitements par lots et rapports',
        'Tests, journalisation et reproductibilité',
      ],
      audience: 'Géomaticiens, analystes et développeurs débutants en Python',
      duration: 'Parcours conseillé : 30 à 45 h',
      level: 'Intermédiaire',
      iconName: 'code',
      accentValue: 0xFF5B3A91,
    ),
    CertificationModule(
      id: 'risques_humanitaire',
      title: 'Cartographie des risques & humanitaire',
      sector: 'Protection civile, santé & humanitaire',
      summary:
          'Combiner aléas, enjeux et vulnérabilités pour prioriser les actions et communiquer sans ambiguïté.',
      skills: [
        'Construction d’indicateurs de risque',
        'Analyse multicritère et scénarios',
        'Cartes opérationnelles et partage responsable',
      ],
      audience: 'ONG, collectivités, protection civile et santé publique',
      duration: 'Parcours conseillé : 24 à 38 h',
      level: 'Intermédiaire',
      iconName: 'risk',
      accentValue: 0xFFCA4A2B,
    ),
    CertificationModule(
      id: 'collecte_mobile',
      title: 'Collecte mobile & qualité des géodonnées',
      sector: 'Enquêtes, réseaux & suivi de projets',
      summary:
          'Créer un formulaire géolocalisé fiable, organiser les équipes et livrer une base prête à analyser.',
      skills: [
        'Conception de formulaires et dictionnaire de données',
        'Mode hors ligne, synchronisation et supervision',
        'Contrôles qualité, corrections et traçabilité',
      ],
      audience: 'Superviseurs, enquêteurs, gestionnaires de réseaux',
      duration: 'Parcours conseillé : 16 à 28 h',
      level: 'Débutant à intermédiaire',
      iconName: 'mobile',
      accentValue: 0xFF2B6B5E,
    ),
    CertificationModule(
      id: 'drone_photogrammetrie',
      title: 'Drone & photogrammétrie responsable',
      sector: 'Inspection, agriculture & cartographie',
      summary:
          'Comprendre la chaîne photogrammétrique, préparer le contrôle qualité et cadrer une mission conforme.',
      skills: [
        'Plan de mission, GSD et recouvrements',
        'GCP, checkpoints et géoréférencement',
        'Orthomosaïque, MNS/MNT et rapport qualité',
      ],
      audience: 'Télépilotes, géomaticiens, inspecteurs et agronomes',
      duration: 'Parcours conseillé : 30 à 45 h',
      level: 'Intermédiaire',
      iconName: 'drone',
      accentValue: 0xFF92405A,
    ),
    CertificationModule(
      id: 'geo_sante',
      title: 'Géomatique appliquée à la santé',
      sector: 'Santé publique & planification sanitaire',
      summary:
          'Analyser l’accessibilité aux services et les disparités spatiales avec une attention forte à la confidentialité.',
      skills: [
        'Géocodage et agrégation protectrice',
        'Accessibilité, couverture et bassins de service',
        'Indicateurs, cartes et communication éthique',
      ],
      audience: 'Analystes santé, ONG, décideurs et chercheurs',
      duration: 'Parcours conseillé : 22 à 34 h',
      level: 'Intermédiaire',
      iconName: 'health',
      accentValue: 0xFF9E3256,
    ),
  ];

  static List<String> get sectors =>
      modules.map((module) => module.sector).toSet().toList(growable: false);
}
