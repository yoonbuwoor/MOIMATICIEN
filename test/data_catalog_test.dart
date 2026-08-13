import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:moi_geomaticien/data/course_catalog.dart';
import 'package:moi_geomaticien/data/certification_catalog.dart';
import 'package:moi_geomaticien/data/quiz_catalog.dart';

void main() {
  test('le catalogue contient trente-quatre cours complets', () {
    expect(CourseCatalog.courses, hasLength(34));
    expect(
      CourseCatalog.courses.map((course) => course.id).toSet(),
      hasLength(34),
    );
    for (final course in CourseCatalog.courses) {
      expect(course.objectives.length, greaterThanOrEqualTo(3));
      expect(course.sections.length, greaterThanOrEqualTo(4));
      expect(course.imageAsset, isNotEmpty);
      expect(course.readingMinutes, inInclusiveRange(2, 20));
    }
  });

  test('les 680 questions sont valides et uniques', () {
    expect(QuizCatalog.questions, hasLength(680));
    expect(
      QuizCatalog.questions.map((question) => question.id).toSet(),
      hasLength(680),
    );
    for (final question in QuizCatalog.questions) {
      expect(question.options.length, greaterThanOrEqualTo(2));
      expect(
        question.correctIndex,
        inInclusiveRange(0, question.options.length - 1),
      );
      expect(question.explanation, isNotEmpty);
    }
  });

  test('chaque quiz thématique contient vingt questions', () {
    for (final definition in QuizCatalog.definitions.where(
      (quiz) => quiz.courseId != null,
    )) {
      expect(QuizCatalog.questionsFor(definition), hasLength(20));
    }
  });

  test('les options de chaque question sont distinctes', () {
    for (final question in QuizCatalog.questions) {
      expect(
        question.options.toSet(),
        hasLength(question.options.length),
        reason: question.id,
      );
    }
  });

  test('le catalogue propose douze certifications sectorielles complètes', () {
    expect(CertificationCatalog.modules, hasLength(12));
    expect(
      CertificationCatalog.modules.map((module) => module.id).toSet(),
      hasLength(12),
    );
    expect(CertificationCatalog.sectors.length, greaterThanOrEqualTo(8));
    for (final module in CertificationCatalog.modules) {
      expect(module.skills, hasLength(3));
      expect(module.sector, isNotEmpty);
      expect(module.audience, isNotEmpty);
      expect(module.duration, isNotEmpty);
    }
  });

  test('le module drone reste une introduction compacte', () {
    final droneCourse = CourseCatalog.byId('photogrammetrie_drone');
    expect(droneCourse.sections, hasLength(4));
    expect(droneCourse.readingMinutes, lessThanOrEqualTo(6));
    expect(
      droneCourse.sections.last.fieldNote,
      contains('Drone Atlas Academy'),
    );
  });

  test('les temps de lecture sont calculés et restent réalistes', () {
    final estimates = CourseCatalog.courses
        .map((course) => course.readingMinutes)
        .toList(growable: false);
    expect(estimates.reduce((a, b) => a < b ? a : b), greaterThanOrEqualTo(3));
    expect(estimates.reduce((a, b) => a > b ? a : b), lessThanOrEqualTo(6));
  });

  test('la page de confidentialité séparée est prête à publier', () {
    final page = File('web_legal/confidentialiteMg.html');
    expect(page.existsSync(), isTrue);
    final html = page.readAsStringSync();
    expect(html, contains('Politique de confidentialité'));
    expect(html, contains('Demandes de certification'));
    expect(html, isNot(contains('00221782780302')));
    expect(html, isNot(contains('novateur221@gmail.com')));
  });

  test('le défi final contient deux questions par cours', () {
    final challenge = QuizCatalog.definitions.last;
    expect(QuizCatalog.questionsFor(challenge), hasLength(68));
  });
}
