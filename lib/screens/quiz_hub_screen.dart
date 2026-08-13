import 'dart:math';

import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import '../models/learning_models.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';
import 'quiz_screen.dart';

class QuizHubScreen extends StatelessWidget {
  const QuizHubScreen({required this.controller, super.key});

  final AppController controller;

  void _openQuiz(BuildContext context, QuizDefinition definition) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) =>
            QuizScreen(definition: definition, controller: controller),
      ),
    );
  }

  void _openQuickQuiz(
    BuildContext context, {
    required int questionCount,
    required QuizPlayMode mode,
  }) {
    if (!controller.canStartGame) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Oups, plus de cœur aujourd’hui ! Ils reviennent demain. Les quiz thématiques restent accessibles.',
          ),
        ),
      );
      return;
    }
    final questions = List<QuizQuestion>.of(QuizCatalog.questions)
      ..shuffle(Random());
    final timed = mode == QuizPlayMode.timed;
    final definition = QuizDefinition(
      id: timed ? 'sprint_10' : 'quick_$questionCount',
      title: timed ? 'Sprint chrono' : 'Quiz éclair $questionCount',
      subtitle: timed
          ? '$questionCount questions • 15 secondes chacune'
          : '$questionCount questions choisies au hasard',
      accentValue: timed ? 0xFFFF6338 : 0xFF8A124B,
      iconName: timed ? 'bolt' : 'quiz',
    );
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => QuizScreen(
          definition: definition,
          controller: controller,
          sessionQuestions: questions.take(questionCount).toList(),
          playMode: mode,
          secondsPerQuestion: timed ? 15 : 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ListView(
            key: const PageStorageKey('quiz-hub-scroll'),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 112),
            children: [
              const ScreenHeading(
                eyebrow: 'Entraînement',
                title: 'Quiz de géomatique',
                subtitle:
                    '34 quiz thématiques de 20 questions, avec correction immédiate et explication après chaque réponse.',
              ),
              const SizedBox(height: 22),
              _QuizSummary(controller: controller),
              const SizedBox(height: 18),
              _GameArena(
                controller: controller,
                onQuickFive: () => _openQuickQuiz(
                  context,
                  questionCount: 5,
                  mode: QuizPlayMode.quick,
                ),
                onQuickTen: () => _openQuickQuiz(
                  context,
                  questionCount: 10,
                  mode: QuizPlayMode.quick,
                ),
                onTimed: () => _openQuickQuiz(
                  context,
                  questionCount: 10,
                  mode: QuizPlayMode.timed,
                ),
              ),
              const SizedBox(height: 18),
              _DailyMissions(controller: controller),
              const SizedBox(height: 28),
              Text(
                'Choisissez un thème',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 14),
              for (
                var index = 0;
                index < QuizCatalog.definitions.length;
                index++
              ) ...[
                _QuizCard(
                  definition: QuizCatalog.definitions[index],
                  bestScore: controller.bestScoreFor(
                    QuizCatalog.definitions[index].id,
                  ),
                  onTap: () =>
                      _openQuiz(context, QuizCatalog.definitions[index]),
                ),
                if (index != QuizCatalog.definitions.length - 1)
                  const SizedBox(height: 12),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _GameArena extends StatelessWidget {
  const _GameArena({
    required this.controller,
    required this.onQuickFive,
    required this.onQuickTen,
    required this.onTimed,
  });

  final AppController controller;
  final VoidCallback onQuickFive;
  final VoidCallback onQuickTen;
  final VoidCallback onTimed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.ink, AppColors.burgundy],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  '🎮 Zone de jeu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              _LivesPill(lives: controller.lives),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Des questions surprises, des combos et 10 cœurs par jour, comme les 10 lettres de « géomatique ». Une erreur en mode jeu coûte un cœur… aïe !',
            style: TextStyle(color: Color(0xFFE7D9E0), height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: onQuickFive,
                  icon: const Icon(Icons.flash_on_rounded),
                  label: const Text('Rapide 5'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: onQuickTen,
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text('Rapide 10'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onTimed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.coral,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.timer_rounded),
              label: const Text('Mini-défi chrono • 10 × 15 s'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LivesPill extends StatelessWidget {
  const _LivesPill({required this.lives});

  final int lives;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '❤️ $lives',
        semanticsLabel:
            '$lives cœur(s) disponible(s), ${AppController.dailyLives} offerts chaque jour',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class _DailyMissions extends StatelessWidget {
  const _DailyMissions({required this.controller});

  final AppController controller;

  IconData _iconFor(String id) {
    switch (id) {
      case 'quick':
        return Icons.rocket_launch_rounded;
      case 'timed':
        return Icons.timer_rounded;
      default:
        return Icons.visibility_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final missions = controller.dailyMissions;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.coral,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Missions du jour',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  '${controller.completedDailyMissionCount}/${missions.length}',
                  style: const TextStyle(
                    color: AppColors.burgundy,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (var index = 0; index < missions.length; index++) ...[
              _MissionRow(
                mission: missions[index],
                icon: _iconFor(missions[index].id),
              ),
              if (index != missions.length - 1) const Divider(height: 22),
            ],
          ],
        ),
      ),
    );
  }
}

class _MissionRow extends StatelessWidget {
  const _MissionRow({required this.mission, required this.icon});

  final DailyMission mission;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color = mission.completed ? AppColors.success : AppColors.burgundy;
    return Row(
      children: [
        CircleAvatar(
          radius: 19,
          backgroundColor: color.withValues(alpha: 0.11),
          foregroundColor: color,
          child: Icon(mission.completed ? Icons.check_rounded : icon, size: 20),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mission.title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 2),
              Text(
                mission.description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          mission.completed
              ? '+${mission.rewardXp} XP ✓'
              : '${mission.progress}/${mission.target}',
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _QuizSummary extends StatelessWidget {
  const _QuizSummary({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final scores = controller.bestQuizPercentages.values;
    final average = scores.isEmpty
        ? 0
        : (scores.reduce((a, b) => a + b) / scores.length).round();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.burgundy, AppColors.purple],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.coral,
              size: 35,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Votre tableau de bord',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  scores.isEmpty
                      ? 'Lancez votre premier quiz et gagnez des XP.'
                      : '${scores.length} quiz • $average% de moyenne • ${controller.xp} XP',
                  style: const TextStyle(
                    color: Color(0xFFE5D7DF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizCard extends StatelessWidget {
  const _QuizCard({
    required this.definition,
    required this.bestScore,
    required this.onTap,
  });

  final QuizDefinition definition;
  final int? bestScore;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = Color(definition.accentValue);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  quizIcon(definition.iconName),
                  color: accent,
                  size: 29,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      definition.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      definition.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (definition.courseId != null) ...[
                      const SizedBox(height: 7),
                      Text(
                        '${QuizCatalog.questionsFor(definition).length} questions corrigées',
                        style: TextStyle(
                          color: accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                    if (bestScore != null) ...[
                      const SizedBox(height: 7),
                      Text(
                        'Meilleur score : $bestScore%',
                        style: TextStyle(
                          color: accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right_rounded, color: accent),
            ],
          ),
        ),
      ),
    );
  }
}
