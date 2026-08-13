import 'package:flutter_test/flutter_test.dart';
import 'package:moi_geomaticien/app.dart';
import 'package:moi_geomaticien/state/app_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('l’accueil affiche la marque et les deux modules', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final controller = await AppController.create();

    await tester.pumpWidget(MoiGeomaticienApp(controller: controller));
    await tester.pumpAndSettle();

    expect(find.text('MOI GÉOMATICIEN'), findsOneWidget);
    expect(find.text('Cours'), findsOneWidget);
    expect(find.text('Quiz'), findsOneWidget);
    expect(find.text('Voir les cours'), findsOneWidget);
  });
}
