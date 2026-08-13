import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';
import 'reminder_preferences.dart';

const String learningReminderTaskId = 'moi-geomaticien-reminder-12h';
const String learningReminderTaskName = 'show-learning-reminder';

@pragma('vm:entry-point')
void learningReminderCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    if (task != learningReminderTaskName &&
        task != Workmanager.iOSBackgroundTask) {
      return true;
    }
    final preferences = SharedPreferencesAsync();
    final now = DateTime.now();
    final rawLastReminder = await preferences.getString(lastReminderAtKey);
    final lastReminder = DateTime.tryParse(rawLastReminder ?? '');
    if (lastReminder != null &&
        now.toUtc().difference(lastReminder.toUtc()) <
            const Duration(hours: 11, minutes: 45)) {
      return true;
    }
    await NotificationService.instance.showLearningReminder();
    await preferences.setString(
      lastReminderAtKey,
      now.toUtc().toIso8601String(),
    );
    return true;
  });
}

class ReminderService {
  static Future<void> initialize() async {
    await Workmanager().initialize(learningReminderCallbackDispatcher);
    final preferences = SharedPreferencesAsync();
    await refreshSchedule();
  }

  static Future<void> refreshSchedule() async {
    await Workmanager().registerPeriodicTask(
      learningReminderTaskId,
      learningReminderTaskName,
      frequency: const Duration(hours: 12),
      initialDelay: const Duration(hours: 12),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
    );
  }
}
