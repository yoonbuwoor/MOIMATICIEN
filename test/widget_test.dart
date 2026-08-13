import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:moi_geomaticien/app.dart';
import 'package:moi_geomaticien/state/app_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('l’accueil affiche la marque et les deux modules', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();
    await controller.setNotificationPromptSeen();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();

    expect(find.text('MOI GÉOMATICIEN'), findsOneWidget);
    expect(find.text('Cours'), findsOneWidget);
    expect(find.text('Quiz'), findsOneWidget);
    expect(find.text('Progression'), findsOneWidget);
    expect(find.text('Voir les cours'), findsOneWidget);
  });

  testWidgets('l’écran Progression affiche niveaux, badges et rappels', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues(<String, Object>{
      'notifications.promptSeen': true,
      'gamification.xp': 720,
      'gamification.streak': 3,
    });
    final controller = await AppController.create();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Progression'));
    await tester.pumpAndSettle();

    expect(find.text('Progression & récompenses'), findsOneWidget);
    expect(find.text('Niveau 2'), findsOneWidget);
    expect(find.text('Assidu'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('le premier lancement propose les rappels sans les imposer', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();

    expect(find.text('Un rappel toutes les 12 h ?'), findsOneWidget);
    await tester.tap(find.text('Pas maintenant'));
    await tester.pumpAndSettle();

    expect(controller.notificationPromptSeen, isTrue);
    expect(controller.notificationsEnabled, isFalse);
  });
}
