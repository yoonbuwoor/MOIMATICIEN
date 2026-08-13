import 'package:flutter/material.dart';

import '../services/notification_service.dart';
import '../services/reminder_service.dart';
import '../state/app_controller.dart';
import 'course_list_screen.dart';
import 'home_screen.dart';
import 'quiz_hub_screen.dart';
import 'progress_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({required this.controller, super.key});

  final AppController controller;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _offerReminders());
  }

  Future<void> _offerReminders() async {
    if (!mounted || widget.controller.notificationPromptSeen) return;
    final enable = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.notifications_active_rounded, size: 38),
        title: const Text('Un rappel toutes les 12 h ?'),
        content: const Text(
          'Moi Géomaticien peut vous rappeler de garder votre série, gagner des XP et avancer dans les cours. Vous pourrez désactiver les rappels à tout moment.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Pas maintenant'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.notifications_rounded),
            label: const Text('Activer'),
          ),
        ],
      ),
    );
    await widget.controller.setNotificationPromptSeen();
    if (enable != true || !mounted) return;
    try {
      final granted = await NotificationService.instance.requestPermission();
      await widget.controller.setNotificationsEnabled(granted);
      await ReminderService.refreshSchedule(enabled: granted);
      if (!granted && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Autorisation refusée. Vous pourrez réessayer dans Progression.',
            ),
          ),
        );
      }
    } catch (error) {
      debugPrint('Activation des rappels impossible : $error');
    }
  }

  void _selectTab(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(
        controller: widget.controller,
        onOpenCourses: () => _selectTab(1),
        onOpenQuizzes: () => _selectTab(2),
      ),
      CourseListScreen(controller: widget.controller),
      QuizHubScreen(controller: widget.controller),
      ProgressScreen(controller: widget.controller),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Cours',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz_rounded),
            label: 'Quiz',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            selectedIcon: Icon(Icons.workspace_premium_rounded),
            label: 'Progression',
          ),
        ],
      ),
    );
  }
}
