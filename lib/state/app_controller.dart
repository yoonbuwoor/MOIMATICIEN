import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends ChangeNotifier {
  AppController._(this._preferences);

  static const _completedCoursesKey = 'completed_courses';
  static const _quizScoresKey = 'quiz_best_scores';

  final SharedPreferences _preferences;
  final Set<String> _completedCourseIds = <String>{};
  final Map<String, int> _bestQuizPercentages = <String, int>{};

  static Future<AppController> create() async {
    final preferences = await SharedPreferences.getInstance();
    final controller = AppController._(preferences);
    controller._restore();
    return controller;
  }

  Set<String> get completedCourseIds => Set.unmodifiable(_completedCourseIds);

  Map<String, int> get bestQuizPercentages =>
      Map.unmodifiable(_bestQuizPercentages);

  bool isCourseCompleted(String courseId) =>
      _completedCourseIds.contains(courseId);

  int? bestScoreFor(String quizId) => _bestQuizPercentages[quizId];

  double courseProgress(int totalCourses) => totalCourses == 0
      ? 0.0
      : (_completedCourseIds.length / totalCourses)
          .clamp(0.0, 1.0)
          .toDouble();

  Future<void> markCourseCompleted(String courseId) async {
    if (!_completedCourseIds.add(courseId)) return;
    await _preferences.setStringList(
      _completedCoursesKey,
      _completedCourseIds.toList(growable: false),
    );
    notifyListeners();
  }

  Future<void> saveQuizScore({
    required String quizId,
    required int correct,
    required int total,
  }) async {
    if (total == 0) return;
    final percentage = ((correct / total) * 100).round();
    final previous = _bestQuizPercentages[quizId] ?? -1;
    if (percentage <= previous) return;
    _bestQuizPercentages[quizId] = percentage;
    await _preferences.setString(
      _quizScoresKey,
      jsonEncode(_bestQuizPercentages),
    );
    notifyListeners();
  }

  void _restore() {
    _completedCourseIds.addAll(
      _preferences.getStringList(_completedCoursesKey) ?? const <String>[],
    );
    final rawScores = _preferences.getString(_quizScoresKey);
    if (rawScores == null || rawScores.isEmpty) return;
    try {
      final decoded = jsonDecode(rawScores) as Map<String, dynamic>;
      for (final entry in decoded.entries) {
        final score = entry.value;
        if (score is int) _bestQuizPercentages[entry.key] = score;
      }
    } on FormatException {
      // Une ancienne préférence invalide ne doit jamais empêcher le démarrage.
    }
  }
}
