import 'package:flutter/material.dart';

import '../data/certification_catalog.dart';
import '../data/course_catalog.dart';
import '../services/external_links.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({
    required this.controller,
    required this.onOpenCertifications,
    super.key,
  });

  final AppController controller;
  final VoidCallback onOpenCertifications;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ListView(
            key: const PageStorageKey('progress-scroll'),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 112),
            children: [
              const ScreenHeading(
                eyebrow: 'Votre parcours',
                title: 'Progression professionnelle',
                subtitle:
                    'Suivez vos cours, vos quiz, vos XP et préparez une certification adaptée à votre secteur.',
              ),
              const SizedBox(height: 22),
              _LevelCard(controller: controller),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.local_fire_department_rounded,
                      value: '${controller.streakDays}',
                      label: 'jours de série',
                      color: AppColors.coral,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.quiz_rounded,
                      value: '${controller.bestQuizPercentages.length}',
                      label: 'quiz tentés',
                      color: AppColors.burgundy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _ProfessionalCertificationCard(
                onOpenCertifications: onOpenCertifications,
              ),
              const SizedBox(height: 28),
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.softRose,
                    foregroundColor: AppColors.burgundy,
                    child: Icon(Icons.notifications_active_rounded),
                  ),
                  title: const Text(
                    'Rappel automatique toutes les 12 h',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: const Text(
                    'Toujours programmé dans l’application. Le téléphone conserve le contrôle de l’autorisation système.',
                  ),
                  trailing: const Icon(
                    Icons.lock_clock_rounded,
                    color: AppColors.burgundy,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _JourneyCard(controller: controller),
              const SizedBox(height: 18),
              Center(
                child: TextButton.icon(
                  onPressed: () => openExternalLink(
                    context,
                    ExternalLinks.privacy,
                    failureMessage:
                        'La politique de confidentialité ne peut pas être ouverte.',
                  ),
                  icon: const Icon(Icons.privacy_tip_outlined, size: 18),
                  label: const Text('Politique de confidentialité'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfessionalCertificationCard extends StatelessWidget {
  const _ProfessionalCertificationCard({required this.onOpenCertifications});

  final VoidCallback onOpenCertifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.burgundy, AppColors.purple],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white12,
                foregroundColor: AppColors.coral,
                child: Icon(Icons.workspace_premium_rounded),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Certification professionnelle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${CertificationCatalog.modules.length} parcours sectoriels sont proposés par Novateur221, avec modalités et évaluation définies avant l’inscription.',
            style: const TextStyle(
              color: Color(0xFFE8DCE2),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 15),
          FilledButton.icon(
            onPressed: onOpenCertifications,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.burgundy,
            ),
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Voir les parcours professionnels'),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.ink, AppColors.burgundy, AppColors.purple],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 66,
                height: 66,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: Text(
                  '${controller.level}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Niveau ${controller.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${controller.xp} XP au total',
                      style: const TextStyle(
                        color: Color(0xFFE8DCE2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bolt_rounded, color: AppColors.coral, size: 38),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: controller.levelProgress,
              minHeight: 10,
              color: AppColors.coral,
              backgroundColor: Colors.white12,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            '${controller.xpToNextLevel} XP avant le niveau ${controller.level + 1}',
            style: const TextStyle(
              color: Color(0xFFD9CCD3),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final courseProgress = controller.courseProgress(
      CourseCatalog.courses.length,
    );
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.route_rounded, color: AppColors.coral, size: 34),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              '${controller.completedCourseIds.length}/${CourseCatalog.courses.length} cours • ${(courseProgress * 100).round()} % du parcours',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
