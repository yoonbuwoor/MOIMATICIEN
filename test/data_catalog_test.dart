import 'package:flutter_test/flutter_test.dart';
import 'package:moi_geomaticien/data/course_catalog.dart';
import 'package:moi_geomaticien/data/quiz_catalog.dart';

void main() {
  test('le catalogue contient six cours complets', () {
    expect(CourseCatalog.courses, hasLength(6));
    expect(
      CourseCatalog.courses.map((course) => course.id).toSet(),
      hasLength(6),
    );
    for (final course in CourseCatalog.courses) {
      expect(course.objectives.length, greaterThanOrEqualTo(3));
      expect(course.sections.length, greaterThanOrEqualTo(4));
      expect(course.imageAsset, isNotEmpty);
    }
  });

  test('les 48 questions sont valides et uniques', () {
    expect(QuizCatalog.questions, hasLength(48));
    expect(
      QuizCatalog.questions.map((question) => question.id).toSet(),
      hasLength(48),
    );
    for (final question in QuizCatalog.questions) {
      expect(question.options.length, greaterThanOrEqualTo(2));
      expect(question.correctIndex, inInclusiveRange(0, question.options.length - 1));
      expect(question.explanation, isNotEmpty);
    }
  });

  test('chaque quiz thématique contient huit questions', () {
    for (final definition in QuizCatalog.definitions.where(
      (quiz) => quiz.courseId != null,
    )) {
      expect(QuizCatalog.questionsFor(definition), hasLength(8));
    }
  });

  test('le défi final contient douze questions', () {
    final challenge = QuizCatalog.definitions.last;
    expect(QuizCatalog.questionsFor(challenge), hasLength(12));
  });
}
