import 'package:flutter_test/flutter_test.dart';
import 'package:moi_geomaticien/models/learning_models.dart';
import 'package:moi_geomaticien/state/app_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('un cours terminé récompense en XP et démarre une série', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();

    final firstReward = await controller.markCourseCompleted('cartographie');
    final duplicateReward = await controller.markCourseCompleted(
      'cartographie',
    );

    expect(firstReward, 120);
    expect(duplicateReward, 0);
    expect(controller.xp, 120);
    expect(controller.lives, 12);
    expect(controller.streakDays, 1);
    expect(controller.isCourseCompleted('cartographie'), isTrue);
  });

  test('un quiz enregistre le meilleur score et attribue des XP', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();

    final reward = await controller.saveQuizScore(
      quizId: 'quiz_carto',
      correct: 8,
      total: 10,
    );

    expect(reward, greaterThan(0));
    expect(controller.bestScoreFor('quiz_carto'), 80);
    expect(controller.xp, reward);
    expect(
      controller.badges
          .firstWhere((badge) => badge.id == 'cartographer')
          .unlocked,
      isTrue,
    );
  });

  test('une série inactive depuis plus d’un jour revient à zéro', () async {
    final oldDate = DateTime.now().subtract(const Duration(days: 3));
    SharedPreferences.setMockInitialValues(<String, Object>{
      'gamification.streak': 5,
      'gamification.lastActivityDate': oldDate.toIso8601String(),
    });

    final controller = await AppController.create();

    expect(controller.streakDays, 0);
  });

  test('les vies diminuent sans jamais passer sous zéro', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();

    for (var index = 0; index < AppController.dailyLives + 2; index++) {
      await controller.loseLife();
    }

    expect(controller.lives, 0);
    expect(controller.canStartGame, isFalse);
  });

  test('un quiz rapide parfait valide les missions et rend un cœur', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();
    await controller.loseLife();

    final reward = await controller.recordGameSession(
      mode: QuizPlayMode.quick,
      correct: 5,
      total: 5,
      completed: true,
    );

    expect(reward.bonusXp, 45);
    expect(reward.completedMissionTitles, hasLength(2));
    expect(reward.lifeRestored, isTrue);
    expect(controller.lives, AppController.dailyLives);
    expect(controller.completedDailyMissionCount, 2);
  });

  test('les cœurs et les missions reviennent au nouveau jour', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'game.dailyDate': '2000-01-01',
      'game.dailyQuickCompleted': true,
      'game.dailyCorrectAnswers': 99,
      'game.dailyTimedCompleted': true,
      'game.lives': 0,
    });

    final controller = await AppController.create();

    expect(controller.lives, AppController.dailyLives);
    expect(controller.completedDailyMissionCount, 0);
  });

  test('terminer une leçon ajoute réellement deux vies', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();
    await controller.loseLife();
    await controller.loseLife();
    await controller.loseLife();

    await controller.markCourseCompleted('cartographie');

    expect(controller.lives, 9);
  });
}
