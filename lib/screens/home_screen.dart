import 'package:flutter/material.dart';

import '../data/course_catalog.dart';
import '../models/learning_models.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.controller,
    required this.onOpenCourses,
    required this.onOpenQuizzes,
    required this.onOpenCertifications,
    super.key,
  });

  final AppController controller;
  final VoidCallback onOpenCourses;
  final VoidCallback onOpenQuizzes;
  final VoidCallback onOpenCertifications;

  void _openCourse(BuildContext context, Course course) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) =>
            CourseDetailScreen(course: course, controller: controller),
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
          final completed = controller.completedCourseIds;
          final nextCourse = _firstIncomplete(completed);
          final progress = controller.courseProgress(
            CourseCatalog.courses.length,
          );
          return CustomScrollView(
            key: const PageStorageKey('home-scroll'),
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 112),
                sliver: SliverList.list(
                  children: [
                    const _BrandHeader(),
                    const SizedBox(height: 22),
                    _HeroPanel(
                      onOpenCourses: onOpenCourses,
                      onOpenQuizzes: onOpenQuizzes,
                    ),
                    const SizedBox(height: 22),
                    _ProgressPanel(
                      completedCount: completed.length,
                      totalCourses: CourseCatalog.courses.length,
                      progress: progress,
                      quizCount: controller.bestQuizPercentages.length,
                      level: controller.level,
                      xp: controller.xp,
                      streakDays: controller.streakDays,
                      badgeCount: controller.unlockedBadgeCount,
                    ),
                    const SizedBox(height: 28),
                    SectionTitle(
                      title: nextCourse == null
                          ? 'Parcours terminé !'
                          : 'Continuez à apprendre',
                      actionLabel: 'Tous les cours',
                      onAction: onOpenCourses,
                    ),
                    const SizedBox(height: 14),
                    if (nextCourse != null)
                      CourseCard(
                        course: nextCourse,
                        completed: false,
                        onTap: () => _openCourse(context, nextCourse),
                      )
                    else
                      _CompletionCard(onOpenQuizzes: onOpenQuizzes),
                    const SizedBox(height: 28),
                    SectionTitle(
                      title: 'À découvrir',
                      actionLabel: 'Voir tout',
                      onAction: onOpenCourses,
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 345,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: CourseCatalog.courses.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final course = CourseCatalog.courses[index];
                          return CourseCard(
                            compact: true,
                            course: course,
                            completed: completed.contains(course.id),
                            onTap: () => _openCourse(context, course),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 26),
                    _CertificationTeaser(
                      onOpenCertifications: onOpenCertifications,
                    ),
                    const SizedBox(height: 16),
                    const _FieldTip(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Course? _firstIncomplete(Set<String> completed) {
    for (final course in CourseCatalog.courses) {
      if (!completed.contains(course.id)) return course;
    }
    return null;
  }
}

class _CertificationTeaser extends StatelessWidget {
  const _CertificationTeaser({required this.onOpenCertifications});

  final VoidCallback onOpenCertifications;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/certifications_hero.png',
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xF2241620), Color(0x7A241620)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'NOUVEAU • CERTIFICATIONS',
                    style: TextStyle(
                      color: AppColors.coral,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Faites reconnaître vos compétences.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      height: 1.12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: onOpenCertifications,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.burgundy,
                      minimumSize: const Size(0, 44),
                    ),
                    icon: const Icon(Icons.workspace_premium_rounded),
                    label: const Text('Découvrir les parcours'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 58,
          height: 58,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.burgundy,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Color(0x24650238),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Image.asset(
            'assets/brand/app_symbol.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 13),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MOI GÉOMATICIEN',
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'by Novateur221',
                style: TextStyle(
                  color: AppColors.burgundy,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.onOpenCourses, required this.onOpenQuizzes});

  final VoidCallback onOpenCourses;
  final VoidCallback onOpenQuizzes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3D062E), AppColors.burgundy, Color(0xFF9D0B48)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x38650238),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            top: -40,
            child: Icon(
              Icons.public_rounded,
              size: 170,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  'APPRENDRE • COMPRENDRE • PRATIQUER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Que nul n’entre ici\ns’il n’est Géomaticien.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  height: 1.08,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 11),
              const Text(
                'Des notions claires, des exemples concrets et des quiz corrigés pour progresser partout.',
                style: TextStyle(
                  color: Color(0xFFEFDCE6),
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: onOpenCourses,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.burgundy,
                    ),
                    icon: const Icon(Icons.menu_book_rounded),
                    label: const Text('Voir les cours'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onOpenQuizzes,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                    ),
                    icon: const Icon(Icons.bolt_rounded),
                    label: const Text('Faire un quiz'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressPanel extends StatelessWidget {
  const _ProgressPanel({
    required this.completedCount,
    required this.totalCourses,
    required this.progress,
    required this.quizCount,
    required this.level,
    required this.xp,
    required this.streakDays,
    required this.badgeCount,
  });

  final int completedCount;
  final int totalCourses;
  final double progress;
  final int quizCount;
  final int level;
  final int xp;
  final int streakDays;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        backgroundColor: AppColors.softRose,
                        strokeCap: StrokeCap.round,
                      ),
                      Center(
                        child: Text(
                          '${(progress * 100).round()}%',
                          style: const TextStyle(
                            color: AppColors.burgundy,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 17),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Votre progression',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$completedCount cours sur $totalCourses terminés',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$quizCount quiz déjà tentés',
                        style: const TextStyle(
                          color: AppColors.coral,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF0E2E7)),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _MiniReward(
                    icon: Icons.bolt_rounded,
                    value: '$xp XP',
                    color: AppColors.warning,
                  ),
                ),
                Expanded(
                  child: _MiniReward(
                    icon: Icons.military_tech_rounded,
                    value: 'Niv. $level',
                    color: AppColors.burgundy,
                  ),
                ),
                Expanded(
                  child: _MiniReward(
                    icon: Icons.local_fire_department_rounded,
                    value: '$streakDays j',
                    color: AppColors.coral,
                  ),
                ),
                Expanded(
                  child: _MiniReward(
                    icon: Icons.workspace_premium_rounded,
                    value: '$badgeCount',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniReward extends StatelessWidget {
  const _MiniReward({
    required this.icon,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 21),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _CompletionCard extends StatelessWidget {
  const _CompletionCard({required this.onOpenQuizzes});

  final VoidCallback onOpenQuizzes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F7F1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFBDE5D4)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.success,
            size: 48,
          ),
          const SizedBox(height: 10),
          Text(
            'Bravo, tous les cours sont terminés.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onOpenQuizzes,
            child: const Text('Relever le défi final'),
          ),
        ],
      ),
    );
  }
}

class _FieldTip extends StatelessWidget {
  const _FieldTip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.coral,
            foregroundColor: Colors.white,
            child: Icon(Icons.lightbulb_rounded),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Réflexe du terrain',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Une coordonnée sans système de référence est une information incomplète. Notez toujours le code EPSG.',
                  style: TextStyle(
                    color: Color(0xFFD8CDD3),
                    fontSize: 13,
                    height: 1.45,
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
