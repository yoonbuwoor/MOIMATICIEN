import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import '../models/learning_models.dart';
import '../services/external_links.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({
    required this.course,
    required this.controller,
    super.key,
  });

  final Course course;
  final AppController controller;

  void _openQuiz(BuildContext context) {
    final quiz = QuizCatalog.quizForCourse(course.id);
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) =>
            QuizScreen(definition: quiz, controller: controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = Color(course.accentValue);
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final completed = controller.isCourseCompleted(course.id);
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 294,
                backgroundColor: accent,
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(course.imageAsset, fit: BoxFit.cover),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x22000000), Color(0xCC000000)],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.category.toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.coral,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              course.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 29,
                                height: 1.08,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.7,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Row(
                              children: [
                                const Icon(
                                  Icons.menu_book_rounded,
                                  size: 16,
                                  color: Colors.white70,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '≈ ${course.readingMinutes} min de lecture',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.signal_cellular_alt_rounded,
                                  size: 16,
                                  color: Colors.white70,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  course.level.label,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 124),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      course.subtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 22),
                    _ObjectivesCard(course: course, accent: accent),
                    const SizedBox(height: 28),
                    Text(
                      'Le cours',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Ouvrez chaque partie pour lire les explications et retenir l’essentiel.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 14),
                    for (
                      var index = 0;
                      index < course.sections.length;
                      index++
                    ) ...[
                      _SectionCard(
                        section: course.sections[index],
                        accent: accent,
                        initiallyExpanded: index == 0,
                      ),
                      if (index != course.sections.length - 1)
                        const SizedBox(height: 12),
                    ],
                    if (course.id == 'photogrammetrie_drone') ...[
                      const SizedBox(height: 18),
                      const _DroneAtlasAcademyCard(),
                    ],
                    const SizedBox(height: 26),
                    _QuizInvitation(
                      accent: accent,
                      onPressed: () => _openQuiz(context),
                    ),
                    if (completed) ...[
                      const SizedBox(height: 16),
                      const _CompletedBanner(),
                    ],
                  ]),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 14),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final completed = controller.isCourseCompleted(course.id);
            return FilledButton.icon(
              onPressed: completed
                  ? () => _openQuiz(context)
                  : () async {
                      final reward = await controller.markCourseCompleted(
                        course.id,
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Leçon terminée • +$reward XP et +2 vies ! Votre série continue.',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
              icon: Icon(
                completed
                    ? Icons.quiz_rounded
                    : Icons.check_circle_outline_rounded,
              ),
              label: Text(
                completed ? 'Passer au quiz' : 'Marquer comme terminé',
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DroneAtlasAcademyCard extends StatelessWidget {
  const _DroneAtlasAcademyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF241620), Color(0xFF650238)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.coral,
                foregroundColor: Colors.white,
                child: Icon(Icons.flight_takeoff_rounded),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Allez plus loin avec Drone Atlas Academy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Télécharger l’application Drone Atlas Academy pour en connaître plus.',
            style: TextStyle(
              color: Color(0xFFE8DCE2),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => openExternalLink(
                context,
                ExternalLinks.droneAtlasAcademy,
                failureMessage:
                    'La page de Drone Atlas Academy ne peut pas être ouverte.',
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.burgundy,
              ),
              icon: const Icon(Icons.download_rounded),
              label: const Text('Télécharger Drone Atlas Academy'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ObjectivesCard extends StatelessWidget {
  const _ObjectivesCard({required this.course, required this.accent});

  final Course course;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color.alphaBlend(accent.withValues(alpha: 0.08), Colors.white),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.track_changes_rounded, color: accent),
              const SizedBox(width: 9),
              Text('Objectifs', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 13),
          for (final objective in course.objectives)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_rounded, color: accent, size: 19),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      objective,
                      style: Theme.of(context).textTheme.bodyMedium,
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.section,
    required this.accent,
    required this.initiallyExpanded,
  });

  final CourseSection section;
  final Color accent;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
          iconColor: accent,
          collapsedIconColor: AppColors.burgundy,
          title: Text(
            section.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            const Divider(color: Color(0xFFF0E2E7)),
            const SizedBox(height: 9),
            Text(section.body, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 17),
            for (final point in section.keyPoints)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Text(
                        point,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            if (section.fieldNote != null) ...[
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF2D9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.tips_and_updates_rounded,
                      color: AppColors.warning,
                      size: 21,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        section.fieldNote!,
                        style: const TextStyle(
                          color: Color(0xFF684A16),
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuizInvitation extends StatelessWidget {
  const _QuizInvitation({required this.accent, required this.onPressed});

  final Color accent;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.ink, accent]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.psychology_alt_rounded,
            color: AppColors.coral,
            size: 38,
          ),
          const SizedBox(height: 12),
          const Text(
            'Prêt à vérifier vos acquis ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Répondez aux 20 questions, gagnez des XP et découvrez l’explication immédiatement.',
            style: TextStyle(
              color: Color(0xFFE0D3DA),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.burgundy,
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Commencer le quiz'),
          ),
        ],
      ),
    );
  }
}

class _CompletedBanner extends StatelessWidget {
  const _CompletedBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F7F0),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(Icons.verified_rounded, color: AppColors.success),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Cours terminé — vous pouvez le relire à tout moment.',
              style: TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
