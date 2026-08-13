import 'package:flutter/material.dart';

import 'screens/main_shell.dart';
import 'state/app_controller.dart';
import 'theme/app_theme.dart';

class MoiGeomaticienApp extends StatelessWidget {
  const MoiGeomaticienApp({required this.controller, super.key});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moi Géomaticien',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: MainShell(controller: controller),
    );
  }
}
