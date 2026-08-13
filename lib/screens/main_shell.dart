import 'package:flutter/material.dart';

import '../services/notification_service.dart';
import '../services/reminder_service.dart';
import '../state/app_controller.dart';
import 'certification_screen.dart';
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
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.notifications_active_rounded, size: 38),
        title: const Text('Votre rappel toutes les 12 h'),
        content: const Text(
          'Moi Géomaticien programme automatiquement un rappel pour garder votre série et réussir les missions du jour. Android ou iOS vous demandera son autorisation système.',
        ),
        actions: [
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.notifications_rounded),
            label: const Text('Continuer'),
          ),
        ],
      ),
    );
    await widget.controller.setNotificationPromptSeen();
    if (!mounted) return;
    try {
      final granted = await NotificationService.instance.requestPermission();
      await widget.controller.confirmAutomaticReminders();
      await ReminderService.refreshSchedule();
      if (!granted && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Le rappel reste programmé, mais le système a refusé son affichage. Vous pouvez autoriser les notifications dans les réglages du téléphone.',
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
        onOpenCertifications: () => _selectTab(3),
      ),
      CourseListScreen(controller: widget.controller),
      QuizHubScreen(controller: widget.controller),
      const CertificationScreen(),
      ProgressScreen(
        controller: widget.controller,
        onOpenCertifications: () => _selectTab(3),
      ),
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
            label: 'Certifs',
          ),
          NavigationDestination(
            icon: Icon(Icons.workspace_premium_outlined),
            selectedIcon: Icon(Icons.emoji_events_rounded),
            label: 'Progression',
          ),
        ],
      ),
    );
  }
}
