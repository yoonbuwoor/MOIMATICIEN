import 'package:flutter_test/flutter_test.dart';
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
}


  test('les modes rapides, vies et missions quotidiennes fonctionnent', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();
    expect(controller.lives, 3);
    final reward = await controller.recordQuickChallenge(correct: 5, total: 5);
    expect(reward, greaterThan(0));
    expect(controller.dailyQuick, 1);
    expect(controller.dailyCorrect, 5);
    expect(controller.dailyMissionCompletedCount, greaterThanOrEqualTo(2));
    await controller.loseLife();
    expect(controller.lives, 2);
    await controller.addLife();
    expect(controller.lives, 3);
  });
