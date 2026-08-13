import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/course_catalog.dart';
import '../models/learning_models.dart';

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

class DailyMission {
  const DailyMission({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.rewardXp,
  });

  final String id;
  final String title;
  final String description;
  final int progress;
  final int target;
  final int rewardXp;

  bool get completed => progress >= target;
}

class GameSessionReward {
  const GameSessionReward({
    required this.bonusXp,
    required this.completedMissionTitles,
    required this.lifeRestored,
  });

  static const empty = GameSessionReward(
    bonusXp: 0,
    completedMissionTitles: <String>[],
    lifeRestored: false,
  );

  final int bonusXp;
  final List<String> completedMissionTitles;
  final bool lifeRestored;
}

class AppController extends ChangeNotifier {
  AppController._(this._preferences);

  static const _completedCoursesKey = 'completed_courses';
  static const _quizScoresKey = 'quiz_best_scores';
  static const _xpKey = 'gamification.xp';
  static const _streakKey = 'gamification.streak';
  static const _lastActivityKey = 'gamification.lastActivityDate';
  static const _notificationPromptSeenKey = 'notifications.promptSeen';
  static const _dailyDateKey = 'game.dailyDate';
  static const _dailyQuickKey = 'game.dailyQuickCompleted';
  static const _dailyCorrectKey = 'game.dailyCorrectAnswers';
  static const _dailyTimedKey = 'game.dailyTimedCompleted';
  static const _livesKey = 'game.lives';
  static const dailyLives = 10;

  final SharedPreferences _preferences;
  final Set<String> _completedCourseIds = <String>{};
  final Map<String, int> _bestQuizPercentages = <String, int>{};

  int _xp = 0;
  int _streakDays = 0;
  DateTime? _lastActivityDate;
  bool _notificationsEnabled = true;
  bool _notificationPromptSeen = false;
  String _dailyDate = '';
  bool _dailyQuickCompleted = false;
  int _dailyCorrectAnswers = 0;
  bool _dailyTimedCompleted = false;
  int _lives = dailyLives;

  static Future<AppController> create() async {
    final preferences = await SharedPreferences.getInstance();
    final controller = AppController._(preferences);
    controller._restore();
    await controller._ensureDailyState();
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
  bool get canStartGame => _lives > 0;

  List<DailyMission> get dailyMissions => <DailyMission>[
    DailyMission(
      id: 'quick',
      title: 'Échauffement express',
      description: 'Terminer un quiz rapide de 5 ou 10 questions.',
      progress: _dailyQuickCompleted ? 1 : 0,
      target: 1,
      rewardXp: 20,
    ),
    DailyMission(
      id: 'correct',
      title: 'Œil de lynx',
      description: 'Trouver 5 bonnes réponses aujourd’hui.',
      progress: _dailyCorrectAnswers.clamp(0, 5).toInt(),
      target: 5,
      rewardXp: 25,
    ),
    DailyMission(
      id: 'timed',
      title: 'Plus vite que le GPS',
      description: 'Terminer un mini-défi chronométré.',
      progress: _dailyTimedCompleted ? 1 : 0,
      target: 1,
      rewardXp: 30,
    ),
  ];

  int get completedDailyMissionCount =>
      dailyMissions.where((mission) => mission.completed).length;

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
    _lives += 2;
    _touchActivity();
    await Future.wait([
      _preferences.setStringList(
        _completedCoursesKey,
        _completedCourseIds.toList(growable: false),
      ),
      _persistGamification(),
      _persistDailyGame(),
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
    await Future.wait([
      _preferences.setString(_quizScoresKey, jsonEncode(_bestQuizPercentages)),
      _persistGamification(),
    ]);
    notifyListeners();
    return reward;
  }

  Future<void> setNotificationPromptSeen() async {
    _notificationPromptSeen = true;
    await _preferences.setBool(_notificationPromptSeenKey, true);
    notifyListeners();
  }

  Future<void> confirmAutomaticReminders() async {
    _notificationsEnabled = true;
    notifyListeners();
  }

  Future<void> loseLife() async {
    if (_lives <= 0) return;
    _lives--;
    notifyListeners();
    await _preferences.setInt(_livesKey, _lives);
  }

  /// Compatibilité avec l'écran de défi rapide des premières versions 1.4.
  Future<GameSessionReward> recordQuickChallenge() {
    return recordGameSession(
      mode: QuizPlayMode.quick,
      correct: 0,
      total: 1,
      completed: true,
    );
  }

  /// Compatibilité avec l'écran de défi chronométré des premières versions 1.4.
  Future<GameSessionReward> recordTimedChallenge() {
    return recordGameSession(
      mode: QuizPlayMode.timed,
      correct: 0,
      total: 1,
      completed: true,
    );
  }

  Future<GameSessionReward> recordGameSession({
    required QuizPlayMode mode,
    required int correct,
    required int total,
    required bool completed,
  }) async {
    if (total <= 0) return GameSessionReward.empty;

    final completedBefore = <String, bool>{
      for (final mission in dailyMissions) mission.id: mission.completed,
    };
    if (completed && mode == QuizPlayMode.quick) _dailyQuickCompleted = true;
    if (completed && mode == QuizPlayMode.timed) _dailyTimedCompleted = true;
    _dailyCorrectAnswers += correct;

    final newlyCompleted = dailyMissions
        .where(
          (mission) =>
              mission.completed && !(completedBefore[mission.id] ?? false),
        )
        .toList(growable: false);
    final bonusXp = newlyCompleted.fold<int>(
      0,
      (sum, mission) => sum + mission.rewardXp,
    );
    var lifeRestored = false;
    if (mode.usesLives && correct == total && _lives < dailyLives) {
      _lives++;
      lifeRestored = true;
    }
    _xp += bonusXp;
    _touchActivity();
    await Future.wait([_persistDailyGame(), _persistGamification()]);
    notifyListeners();
    return GameSessionReward(
      bonusXp: bonusXp,
      completedMissionTitles: newlyCompleted
          .map((mission) => mission.title)
          .toList(growable: false),
      lifeRestored: lifeRestored,
    );
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

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> _ensureDailyState() async {
    final today = _todayKey();
    if (_dailyDate == today) return;
    _dailyDate = today;
    _dailyQuickCompleted = false;
    _dailyCorrectAnswers = 0;
    _dailyTimedCompleted = false;
    _lives = dailyLives;
    await _persistDailyGame();
  }

  Future<bool> _persistDailyGame() async {
    final results = await Future.wait([
      _preferences.setString(_dailyDateKey, _dailyDate),
      _preferences.setBool(_dailyQuickKey, _dailyQuickCompleted),
      _preferences.setInt(_dailyCorrectKey, _dailyCorrectAnswers),
      _preferences.setBool(_dailyTimedKey, _dailyTimedCompleted),
      _preferences.setInt(_livesKey, _lives),
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
    _notificationsEnabled = true;
    _notificationPromptSeen =
        _preferences.getBool(_notificationPromptSeenKey) ?? false;
    _dailyDate = _preferences.getString(_dailyDateKey) ?? '';
    _dailyQuickCompleted = _preferences.getBool(_dailyQuickKey) ?? false;
    _dailyCorrectAnswers = _preferences.getInt(_dailyCorrectKey) ?? 0;
    _dailyTimedCompleted = _preferences.getBool(_dailyTimedKey) ?? false;
    _lives = (_preferences.getInt(_livesKey) ?? dailyLives)
        .clamp(0, 999)
        .toInt();
  }
}
