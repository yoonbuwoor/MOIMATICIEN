import '../models/learning_models.dart';
import 'course_catalog.dart';
import 'professional_course_catalog.dart';

abstract class QuizExpansionCatalog {
  static final List<QuizQuestion> questions = CourseCatalog.courses
      .where(
        (course) => !ProfessionalCourseCatalog.courses.any(
          (professional) => professional.id == course.id,
        ),
      )
      .expand(_questionsForCourse)
      .toList(growable: false);

  static Iterable<QuizQuestion> _questionsForCourse(Course course) sync* {
    final concepts = <_Concept>[
      for (final section in course.sections)
        for (final point in section.keyPoints)
          _Concept(section: section.title, statement: point),
    ];
    for (var index = 0; index < 10; index++) {
      final concept = concepts[(index * 2 + 1) % concepts.length];
      final correctIndex = (index + course.id.length) % 4;
      final correct = index.isEven
          ? concept.statement
          : 'Vérifier les données et les limites de ${concept.section.toLowerCase()} avant de conclure';
      final wrong = <String>[
        'Ignorer les métadonnées si la carte paraît correcte',
        'Modifier les données brutes sans conserver de copie',
        'Déduire la précision uniquement du nombre de décimales',
        'Utiliser un seuil universel sans tenir compte du territoire',
        'Supprimer les contrôles pour accélérer le traitement',
        'Confondre corrélation spatiale et causalité certaine',
      ];
      final options = <String>[];
      var wrongIndex = index % wrong.length;
      for (var optionIndex = 0; optionIndex < 4; optionIndex++) {
        if (optionIndex == correctIndex) {
          options.add(correct);
        } else {
          options.add(wrong[wrongIndex++ % wrong.length]);
        }
      }
      yield QuizQuestion(
        id: '${course.id}_x${(index + 11).toString().padLeft(2, '0')}',
        courseId: course.id,
        question: index.isEven
            ? 'Quel principe du module « ${course.title} » faut-il appliquer dans ${concept.section.toLowerCase()} ?'
            : 'Quel réflexe professionnel protège le mieux la qualité d’un travail en ${course.category.toLowerCase()} ?',
        options: options,
        correctIndex: correctIndex,
        explanation:
            '${concept.statement} Le résultat doit rester contrôlable, documenté et adapté à la décision visée.',
      );
    }
  }
}

class _Concept {
  const _Concept({required this.section, required this.statement});

  final String section;
  final String statement;
}
