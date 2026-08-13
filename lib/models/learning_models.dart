enum CourseLevel { debutant, intermediaire }

extension CourseLevelLabel on CourseLevel {
  String get label {
    switch (this) {
      case CourseLevel.debutant:
        return 'Débutant';
      case CourseLevel.intermediaire:
        return 'Intermédiaire';
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
    required this.durationMinutes,
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
  final int durationMinutes;
  final CourseLevel level;
  final String imageAsset;
  final int accentValue;
  final List<String> objectives;
  final List<CourseSection> sections;
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
