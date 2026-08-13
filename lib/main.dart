import 'package:flutter/material.dart';

import 'app.dart';
import 'services/notification_service.dart';
import 'services/reminder_service.dart';
import 'state/app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = await AppController.create();
  try {
    await NotificationService.instance.initialize();
    await ReminderService.initialize();
  } catch (error) {
    debugPrint('Initialisation des rappels indisponible : $error');
  }
  runApp(MoiGeomaticienApp(controller: controller));
}
