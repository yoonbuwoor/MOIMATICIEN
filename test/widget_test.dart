import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moi_geomaticien/app.dart';
import 'package:moi_geomaticien/state/app_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('l’accueil affiche la marque et les modules principaux', (
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
    expect(find.text('Certifs'), findsOneWidget);
    expect(find.text('Progression'), findsOneWidget);
    expect(find.text('Voir les cours'), findsOneWidget);
  });

  testWidgets('l’écran Certifications affiche parcours et contact masqué', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues(<String, Object>{
      'notifications.promptSeen': true,
    });
    final controller = await AppController.create();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Certifs'));
    await tester.pumpAndSettle();

    expect(find.text('Certifications professionnelles'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.dragUntilVisible(
      find.text('12 parcours'),
      find.byKey(const PageStorageKey('certifications-scroll')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('12 parcours'), findsOneWidget);
    expect(find.textContaining('00221782780302'), findsNothing);
    expect(find.textContaining('novateur221@gmail.com'), findsNothing);
  });

  testWidgets('l’écran Progression affiche niveaux, quiz et certification', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
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

    expect(find.text('Progression professionnelle'), findsOneWidget);
    expect(find.text('Niveau 2'), findsOneWidget);
    expect(find.text('quiz tentés'), findsOneWidget);
    expect(find.text('Certification professionnelle'), findsOneWidget);
    expect(find.textContaining('badge'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('l’accueil affiche les contacts et plusieurs réflexes terrain', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues(<String, Object>{
      'notifications.promptSeen': true,
    });
    final controller = await AppController.create();
    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();

    final scroll = find.byKey(const PageStorageKey('home-scroll'));
    await tester.dragUntilVisible(
      find.text('WhatsApp direct'),
      scroll,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    expect(find.text('WhatsApp direct'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Rejoindre la communauté'), findsOneWidget);
    expect(find.textContaining('221782780302'), findsNothing);
    expect(find.textContaining('novateur221@gmail.com'), findsNothing);

    await tester.dragUntilVisible(
      find.text('Réflexes terrain'),
      scroll,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    final tipFinder = find.descendant(
      of: find.byKey(const ValueKey<String>('field-tip-text')),
      matching: find.byType(Text),
    );
    final firstTip = tester.widget<Text>(tipFinder).data;
    await tester.tap(find.byTooltip('Afficher un autre réflexe'));
    await tester.pumpAndSettle();
    final secondTip = tester.widget<Text>(tipFinder).data;

    expect(firstTip, isNot(equals(secondTip)));
    expect(tester.takeException(), isNull);
  });

  testWidgets('le premier lancement explique le rappel automatique', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();

    expect(find.text('Votre rappel toutes les 12 h'), findsOneWidget);
    expect(find.text('Continuer'), findsOneWidget);
    expect(find.text('Pas maintenant'), findsNothing);
    expect(controller.notificationsEnabled, isTrue);
  });

  testWidgets('le hub propose les modes rapides et les missions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues(<String, Object>{
      'notifications.promptSeen': true,
    });
    final controller = await AppController.create();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quiz'));
    await tester.pumpAndSettle();

    expect(find.text('Rapide 5'), findsOneWidget);
    expect(find.text('Rapide 10'), findsOneWidget);
    expect(find.textContaining('10 lettres'), findsOneWidget);
    await tester.drag(
      find.byKey(const PageStorageKey('quiz-hub-scroll')),
      const Offset(0, -450),
    );
    await tester.pumpAndSettle();
    expect(find.text('Missions du jour'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
