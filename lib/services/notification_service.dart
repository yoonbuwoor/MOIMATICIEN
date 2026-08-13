import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();
  static const _channelId = 'moi_geomaticien_learning';
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(settings: settings);
    _initialized = true;
  }

  Future<bool> requestPermission() async {
    await initialize();
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final androidGranted = await android?.requestNotificationsPermission();
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final iosGranted = await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    return androidGranted ?? iosGranted ?? true;
  }

  Future<void> showLearningReminder() async {
    await initialize();
    const reminders = <List<String>>[
      [
        'Votre série vous attend 🔥',
        'Un mini-quiz suffit pour garder le rythme et gagner des XP.',
      ],
      [
        'Prêt pour une mission géomatique ?',
        'Explorez un cours illustré pendant quelques minutes.',
      ],
      [
        'Défi cartographique du jour',
        'Testez vos connaissances et avancez vers votre prochain objectif.',
      ],
      [
        'Cap sur le niveau suivant !',
        'Votre parcours Moi Géomaticien continue hors connexion.',
      ],
    ];
    final slot =
        DateTime.now().millisecondsSinceEpoch ~/
        const Duration(hours: 12).inMilliseconds;
    final reminder = reminders[slot % reminders.length];
    await _plugin.show(
      id: 22112,
      title: reminder[0],
      body: reminder[1],
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Rappels d’apprentissage',
          channelDescription:
              'Un rappel local toutes les 12 heures pour continuer à apprendre',
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: 'learning-reminder',
    );
  }
}
