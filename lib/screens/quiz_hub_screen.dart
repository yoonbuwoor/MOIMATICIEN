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
