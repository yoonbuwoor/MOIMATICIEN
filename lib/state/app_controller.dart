import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/course_catalog.dart';
import '../services/reminder_preferences.dart';

class LearningBadge {
  const LearningBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.colorValue,
    required this.unlocked,
  });

  final String id;
  final String title;
  final String description;
  final String iconName;
  final int colorValue;
  final bool unlocked;
}

class AppController extends ChangeNotifier {
  AppController._(this._preferences);

  static const _completedCoursesKey = 'completed_courses';
  static const _quizScoresKey = 'quiz_best_scores';
  static const _xpKey = 'gamification.xp';
  static const _streakKey = 'gamification.streak';
  static const _lastActivityKey = 'gamification.lastActivityDate';
  static const _notificationPromptSeenKey = 'notifications.promptSeen';
  static const _livesKey = 'gamification.lives';
  static const _livesDateKey = 'gamification.livesDate';
  static const _dailyKey = 'gamification.daily';
  static const _dailyDateKey = 'gamification.dailyDate';

  final SharedPreferences _preferences;
  final Set<String> _completedCourseIds = <String>{};
  final Map<String, int> _bestQuizPercentages = <String, int>{};

  int _xp = 0;
  int _streakDays = 0;
  DateTime? _lastActivityDate;
  bool _notificationsEnabled = false;
  bool _notificationPromptSeen = false;
  int _lives = 3;
  DateTime? _livesDate;
  int _dailyQuick = 0;
  int _dailyCorrect = 0;
  int _dailyTimed = 0;
  int _dailyXp = 0;
  DateTime? _dailyDate;

  static Future<AppController> create() async {
    final preferences = await SharedPreferences.getInstance();
    final controller = AppController._(preferences);
    controller._restore();
    return controller;
  }

  Set<String> get completedCourseIds => Set.unmodifiable(_completedCourseIds);
  Map<String, int> get bestQuizPercentages =>
      Map.unmodifiable(_bestQuizPercentages);
  int get xp => _xp;
  int get level => (_xp ~/ 500) + 1;
  int get xpInCurrentLevel => _xp % 500;
  int get xpToNextLevel => 500 - xpInCurrentLevel;
  double get levelProgress => xpInCurrentLevel / 500;
  int get streakDays => _streakDays;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get notificationPromptSeen => _notificationPromptSeen;
  int get lives => _lives;
  int get dailyQuick => _dailyQuick;
  int get dailyCorrect => _dailyCorrect;
  int get dailyTimed => _dailyTimed;
  int get dailyXp => _dailyXp;
  int get dailyMissionCompletedCount => (dailyQuick >= 1 ? 1 : 0) + (dailyCorrect >= 5 ? 1 : 0) + (dailyTimed >= 1 ? 1 : 0);

  bool isCourseCompleted(String courseId) =>
      _completedCourseIds.contains(courseId);
  int? bestScoreFor(String quizId) => _bestQuizPercentages[quizId];

  double courseProgress(int totalCourses) => totalCourses == 0
      ? 0.0
      : (_completedCourseIds.length / totalCourses).clamp(0.0, 1.0).toDouble();

  List<LearningBadge> get badges => <LearningBadge>[
    LearningBadge(
      id: 'first_course',
      title: 'Premiers pas',
      description: 'Terminer un premier cours.',
      iconName: 'flag',
      colorValue: 0xFFEC1745,
      unlocked: _completedCourseIds.isNotEmpty,
    ),
    LearningBadge(
      id: 'five_courses',
      title: 'Explorateur',
      description: 'Terminer cinq cours.',
      iconName: 'explore',
      colorValue: 0xFFFF6338,
      unlocked: _completedCourseIds.length >= 5,
    ),
    LearningBadge(
      id: 'cartographer',
      title: 'Cartographe',
      description: 'Obtenir au moins 80 % en cartographie.',
      iconName: 'map',
      colorValue: 0xFF8A124B,
      unlocked: (_bestQuizPercentages['quiz_carto'] ?? 0) >= 80,
    ),
    LearningBadge(
      id: 'precision',
      title: 'Précision GNSS',
      description: 'Obtenir au moins 80 % au quiz GNSS.',
      iconName: 'satellite',
      colorValue: 0xFF5A0B68,
      unlocked: (_bestQuizPercentages['quiz_gnss'] ?? 0) >= 80,
    ),
    LearningBadge(
      id: 'perfect',
      title: 'Sans faute',
      description: 'Réaliser un score parfait.',
      iconName: 'star',
      colorValue: 0xFFF59E0B,
      unlocked: _bestQuizPercentages.values.any((score) => score == 100),
    ),
    LearningBadge(
      id: 'streak',
      title: 'Assidu',
      description: 'Apprendre trois jours de suite.',
      iconName: 'fire',
      colorValue: 0xFFFF6338,
      unlocked: _streakDays >= 3,
    ),
    LearningBadge(
      id: 'quiz_fan',
      title: 'Esprit quiz',
      description: 'Tenter huit quiz différents.',
      iconName: 'quiz',
      colorValue: 0xFFB40B4C,
      unlocked: _bestQuizPercentages.length >= 8,
    ),
    LearningBadge(
      id: 'challenge',
      title: 'Grand défi',
      description: 'Atteindre 70 % au défi du géomaticien.',
      iconName: 'trophy',
      colorValue: 0xFF168A65,
      unlocked: (_bestQuizPercentages['defi_geomaticien'] ?? 0) >= 70,
    ),
    LearningBadge(
      id: 'expert',
      title: 'Expert en devenir',
      description: 'Accumuler 3 000 XP.',
      iconName: 'bolt',
      colorValue: 0xFF7E063F,
      unlocked: _xp >= 3000,
    ),
    LearningBadge(
      id: 'master',
      title: 'Maître géomaticien',
      description: 'Terminer tout le parcours.',
      iconName: 'crown',
      colorValue: 0xFF241620,
      unlocked: CourseCatalog.courses.every(
        (course) => _completedCourseIds.contains(course.id),
      ),
    ),
  ];

  int get unlockedBadgeCount => badges.where((badge) => badge.unlocked).length;

  Future<int> markCourseCompleted(String courseId) async {
    if (!_completedCourseIds.add(courseId)) return 0;
    const reward = 120;
    _xp += reward;
    _touchActivity();
    await Future.wait([
      _preferences.setStringList(
        _completedCoursesKey,
        _completedCourseIds.toList(growable: false),
      ),
      _persistGamification(),
    ]);
    notifyListeners();
    return reward;
  }

  Future<int> saveQuizScore({
    required String quizId,
    required int correct,
    required int total,
  }) async {
    if (total == 0) return 0;
    final percentage = ((correct / total) * 100).round();
    final previous = _bestQuizPercentages[quizId] ?? 0;
    final improvement = percentage > previous ? percentage - previous : 0;
    final reward =
        10 + (correct * 5) + (improvement ~/ 2) + (percentage == 100 ? 25 : 0);

    if (percentage > previous || !_bestQuizPercentages.containsKey(quizId)) {
      _bestQuizPercentages[quizId] = percentage;
    }
    _xp += reward;
    _touchActivity();
    if (percentage == 100) await addLife();
    await Future.wait([
      _preferences.setString(_quizScoresKey, jsonEncode(_bestQuizPercentages)),
      _persistGamification(),
    ]);
    notifyListeners();
    return reward;
  }

  Future<int> recordQuickChallenge({required int correct, required int total}) async {
    _refreshDailyState();
    final reward = 20 + (correct * 8) + (correct == total ? 30 : 0);
    _xp += reward; _dailyQuick++; _dailyCorrect += correct; _dailyXp += reward; _touchActivity();
    if (correct < (total / 2).ceil()) await loseLife();
    await _persistDailyGamification(); await _persistGamification(); notifyListeners(); return reward;
  }

  Future<int> recordTimedChallenge({required int correct, required int total, required bool completed}) async {
    _refreshDailyState();
    final reward = 30 + (correct * 10) + (completed ? 25 : 0);
    _xp += reward; _dailyTimed++; _dailyCorrect += correct; _dailyXp += reward; _touchActivity();
    await _persistDailyGamification(); await _persistGamification(); notifyListeners(); return reward;
  }

  Future<void> loseLife() async { _refreshDailyState(); if (_lives <= 0) return; _lives--; await _preferences.setInt(_livesKey, _lives); notifyListeners(); }
  Future<void> addLife() async { _refreshDailyState(); if (_lives >= 3) return; _lives++; await _preferences.setInt(_livesKey, _lives); notifyListeners(); }
  Future<void> claimDailyBonus() async { _refreshDailyState(); if (_dailyXp >= 150) return; _dailyXp = 150; _xp += 50; await _persistDailyGamification(); await _persistGamification(); notifyListeners(); }

  void _refreshDailyState() {
    final now = DateTime.now(); final today = DateTime(now.year, now.month, now.day);
    if (_dailyDate == null || !_sameDay(_dailyDate!, today)) { _dailyDate = today; _dailyQuick = 0; _dailyCorrect = 0; _dailyTimed = 0; _dailyXp = 0; }
    if (_livesDate == null || !_sameDay(_livesDate!, today)) { _livesDate = today; _lives = 3; _preferences.setInt(_livesKey, _lives); _preferences.setString(_livesDateKey, today.toIso8601String()); }
  }
  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
  Future<bool> _persistDailyGamification() async {
    final results = await Future.wait([
      _preferences.setInt(_livesKey, _lives), _preferences.setString(_livesDateKey, _livesDate?.toIso8601String() ?? ''),
      _preferences.setString(_dailyKey, jsonEncode({'quick': _dailyQuick, 'correct': _dailyCorrect, 'timed': _dailyTimed, 'xp': _dailyXp})),
      _preferences.setString(_dailyDateKey, _dailyDate?.toIso8601String() ?? ''),
    ]); return results.every((saved) => saved);
  }

  Future<void> setNotificationPromptSeen() async {
    _notificationPromptSeen = true;
    await _preferences.setBool(_notificationPromptSeenKey, true);
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    await _preferences.setBool(notificationsEnabledKey, enabled);
    notifyListeners();
  }

  void _touchActivity() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final previous = _lastActivityDate;
    if (previous == null) {
      _streakDays = 1;
    } else {
      final previousDay = DateTime(previous.year, previous.month, previous.day);
      final gap = today.difference(previousDay).inDays;
      if (gap == 1) {
        _streakDays++;
      } else if (gap > 1) {
        _streakDays = 1;
      }
    }
    _lastActivityDate = today;
  }

  Future<bool> _persistGamification() async {
    final results = await Future.wait([
      _preferences.setInt(_xpKey, _xp),
      _preferences.setInt(_streakKey, _streakDays),
      _preferences.setString(
        _lastActivityKey,
        _lastActivityDate?.toIso8601String() ?? '',
      ),
    ]);
    return results.every((saved) => saved);
  }

  void _restore() {
    _completedCourseIds.addAll(
      _preferences.getStringList(_completedCoursesKey) ?? const <String>[],
    );
    final rawScores = _preferences.getString(_quizScoresKey);
    if (rawScores != null && rawScores.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawScores) as Map<String, dynamic>;
        for (final entry in decoded.entries) {
          final score = entry.value;
          if (score is int) _bestQuizPercentages[entry.key] = score;
        }
      } on Object {
        // Une ancienne préférence invalide ne doit jamais empêcher le démarrage.
      }
    }
    _xp =
        _preferences.getInt(_xpKey) ??
        (_completedCourseIds.length * 120) +
            _bestQuizPercentages.values.fold<int>(
              0,
              (sum, score) => sum + score,
            );
    _streakDays = _preferences.getInt(_streakKey) ?? 0;
    _lastActivityDate = DateTime.tryParse(
      _preferences.getString(_lastActivityKey) ?? '',
    );
    final lastActivity = _lastActivityDate;
    if (lastActivity != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final activityDay = DateTime(
        lastActivity.year,
        lastActivity.month,
        lastActivity.day,
      );
      if (today.difference(activityDay).inDays > 1) _streakDays = 0;
    }
    _notificationsEnabled =
        _preferences.getBool(notificationsEnabledKey) ?? false;
    _notificationPromptSeen = _preferences.getBool(_notificationPromptSeenKey) ?? false;
    _lives = _preferences.getInt(_livesKey) ?? 3;
    _livesDate = DateTime.tryParse(_preferences.getString(_livesDateKey) ?? '');
    _dailyDate = DateTime.tryParse(_preferences.getString(_dailyDateKey) ?? '');
    final rawDaily = _preferences.getString(_dailyKey);
    if (rawDaily != null && rawDaily.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawDaily) as Map<String, dynamic>;
        _dailyQuick = (decoded['quick'] as num?)?.toInt() ?? 0;
        _dailyCorrect = (decoded['correct'] as num?)?.toInt() ?? 0;
        _dailyTimed = (decoded['timed'] as num?)?.toInt() ?? 0;
        _dailyXp = (decoded['xp'] as num?)?.toInt() ?? 0;
      } on Object {}
    }
    _refreshDailyState();
  }
}
