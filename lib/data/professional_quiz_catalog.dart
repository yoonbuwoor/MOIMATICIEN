import '../models/learning_models.dart';
import 'professional_course_catalog.dart';

abstract class ProfessionalQuizCatalog {
  static final List<QuizDefinition> definitions = ProfessionalCourseCatalog
      .courses
      .map(
        (course) => QuizDefinition(
          id: 'quiz_${course.id}',
          title: course.title,
          subtitle: '20 questions • ${course.category}',
          accentValue: course.accentValue,
          iconName: _iconFor(course.category),
          courseId: course.id,
        ),
      )
      .toList(growable: false);

  static final List<QuizQuestion> questions = ProfessionalCourseCatalog.courses
      .expand(_questionsForCourse)
      .toList(growable: false);

  static Iterable<QuizQuestion> _questionsForCourse(Course course) sync* {
    final concepts = <_Concept>[
      for (final section in course.sections)
        for (final point in section.keyPoints)
          _Concept(section: section.title, statement: point),
    ];
    if (concepts.isEmpty) return;

    for (var index = 0; index < 20; index++) {
      final concept = concepts[index % concepts.length];
      final section = course.sections[index % course.sections.length];
      final correctIndex = (index * 3 + course.id.length) % 4;
      final correct = _correctAnswer(index, concept, section);
      final distractors = _distractors(index, course, concept);
      final options = <String>[];
      var distractorIndex = 0;
      for (var optionIndex = 0; optionIndex < 4; optionIndex++) {
        if (optionIndex == correctIndex) {
          options.add(correct);
        } else {
          options.add(distractors[distractorIndex++]);
        }
      }
      yield QuizQuestion(
        id: '${course.id}_q${(index + 1).toString().padLeft(2, '0')}',
        courseId: course.id,
        question: _question(index, course, concept, section),
        options: options,
        correctIndex: correctIndex,
        explanation:
            '${concept.statement} Cette règle appartient à la partie « ${concept.section} » et doit être appliquée en tenant compte des données, du contexte et des contrôles du projet.',
      );
    }
  }

  static String _question(
    int index,
    Course course,
    _Concept concept,
    CourseSection section,
  ) {
    switch (index % 5) {
      case 0:
        return 'Dans « ${course.title} », quelle pratique est recommandée pour ${concept.section.toLowerCase()} ?';
      case 1:
        return 'Quelle décision correspond le mieux au contrôle présenté dans « ${section.title} » ?';
      case 2:
        return 'Avant de valider un résultat de ${course.category.toLowerCase()}, que faut-il privilégier ?';
      case 3:
        return 'Quel énoncé respecte la méthode professionnelle de ce module ?';
      default:
        return 'Quelle action améliore le plus la traçabilité dans « ${course.title} » ?';
    }
  }

  static String _correctAnswer(
    int index,
    _Concept concept,
    CourseSection section,
  ) {
    final contextualControl =
        'Contrôler ${section.title.toLowerCase()}, les données et les hypothèses avant la décision';
    final contextualTrace =
        'Conserver les sources et paramètres de ${section.title.toLowerCase()} avec les limites du résultat';
    switch (index % 5) {
      case 1:
        return concept.statement;
      case 2:
        return contextualControl;
      case 3:
        return concept.statement;
      case 4:
        return contextualTrace;
      default:
        return concept.statement;
    }
  }

  static List<String> _distractors(int index, Course course, _Concept concept) {
    final pool = <String>[
      'Ignorer le référentiel et utiliser les valeurs telles quelles',
      'Supprimer les données brutes dès que le résultat est affiché',
      'Choisir la méthode uniquement selon la couleur de la carte',
      'Considérer toute sortie logicielle comme exacte sans contrôle',
      'Masquer les limites et les hypothèses pour simplifier la présentation',
      'Remplacer la validation par une capture d’écran',
      'Appliquer le même seuil à tous les territoires sans vérification',
      'Partager toutes les données, y compris les informations sensibles',
      'Confondre résolution fine et précision garantie',
      'Modifier les sources directement sans copie de sauvegarde',
      'Conclure à une causalité à partir de la seule proximité spatiale',
      'Omettre la date, les unités et la méthode de production',
    ];
    final start =
        (index * 2 + course.id.length + concept.statement.length) % pool.length;
    return <String>[
      pool[start],
      pool[(start + 4) % pool.length],
      pool[(start + 8) % pool.length],
    ];
  }

  static String _iconFor(String category) {
    switch (category) {
      case 'Logiciels':
        return 'layers';
      case 'Télédétection':
      case 'Cloud géospatial':
        return 'image';
      case '3D':
        return 'terrain';
      case 'Terrain':
        return 'mobile';
      case 'Environnement':
      case 'Agriculture':
        return 'environment';
      case 'Intelligence artificielle':
        return 'analytics';
      case 'Serveur SIG':
        return 'web';
      case 'Gouvernance':
      case 'Données ouvertes':
        return 'database';
      default:
        return 'map';
    }
  }
}

class _Concept {
  const _Concept({required this.section, required this.statement});

  final String section;
  final String statement;
}
