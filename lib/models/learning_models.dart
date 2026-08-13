enum CourseLevel { debutant, intermediaire, avance }

extension CourseLevelLabel on CourseLevel {
  String get label {
    switch (this) {
      case CourseLevel.debutant:
        return 'Débutant';
      case CourseLevel.intermediaire:
        return 'Intermédiaire';
      case CourseLevel.avance:
        return 'Avancé';
    }
  }
}

class CourseSection {
  const CourseSection({
    required this.title,
    required this.body,
    required this.keyPoints,
    this.fieldNote,
  });

  final String title;
  final String body;
  final List<String> keyPoints;
  final String? fieldNote;
}

class Course {
  const Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.level,
    required this.imageAsset,
    required this.accentValue,
    required this.objectives,
    required this.sections,
  });

  final String id;
  final String title;
  final String subtitle;
  final String category;
  final CourseLevel level;
  final String imageAsset;
  final int accentValue;
  final List<String> objectives;
  final List<CourseSection> sections;

  /// Estimation volontairement prudente, calculée sur le contenu réellement
  /// affiché (180 mots/minute), avec un court temps pour parcourir les listes.
  int get readingMinutes {
    final text = <String>[
      title,
      subtitle,
      ...objectives,
      for (final section in sections) ...[
        section.title,
        section.body,
        ...section.keyPoints,
        if (section.fieldNote != null) section.fieldNote!,
      ],
    ].join(' ');
    final words = text
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
    final reading = (words / 180).ceil();
    final scanTime = (sections.length / 3).ceil();
    return (reading + scanTime).clamp(2, 20);
  }
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.courseId,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String id;
  final String courseId;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

class QuizDefinition {
  const QuizDefinition({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.accentValue,
    required this.iconName,
    this.courseId,
  });

  final String id;
  final String title;
  final String subtitle;
  final int accentValue;
  final String iconName;
  final String? courseId;
}

enum QuizPlayMode { standard, quick, timed }

extension QuizPlayModeRules on QuizPlayMode {
  bool get usesLives => this != QuizPlayMode.standard;
  bool get isTimed => this == QuizPlayMode.timed;
}
