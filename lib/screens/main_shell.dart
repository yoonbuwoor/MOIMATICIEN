import 'package:flutter/material.dart';

import '../state/app_controller.dart';
import 'course_list_screen.dart';
import 'home_screen.dart';
import 'quiz_hub_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({required this.controller, super.key});

  final AppController controller;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

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
        ],
      ),
    );
  }
}
