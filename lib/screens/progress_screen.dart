import 'package:flutter/material.dart';

import '../data/course_catalog.dart';
import '../services/notification_service.dart';
import '../services/reminder_service.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({required this.controller, super.key});

  final AppController controller;

  Future<void> _toggleNotifications(BuildContext context, bool enabled) async {
    var finalValue = enabled;
    try {
      if (enabled) {
        finalValue = await NotificationService.instance.requestPermission();
      }
      await controller.setNotificationsEnabled(finalValue);
      await ReminderService.refreshSchedule(enabled: finalValue);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              finalValue
                  ? 'Rappels activés toutes les 12 heures.'
                  : enabled
                  ? 'Autorisation de notification non accordée.'
                  : 'Rappels désactivés.',
            ),
          ),
        );
      }
    } catch (error) {
      debugPrint('Modification des rappels impossible : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final badges = controller.badges;
          return ListView(
            key: const PageStorageKey('progress-scroll'),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 112),
            children: [
              const ScreenHeading(
                eyebrow: 'Votre aventure',
                title: 'Progression & récompenses',
                subtitle:
                    'Apprenez, gardez votre série et débloquez les dix badges du parcours.',
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
                      icon: Icons.workspace_premium_rounded,
                      value:
                          '${controller.unlockedBadgeCount}/${badges.length}',
                      label: 'badges gagnés',
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text('Vos badges', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(
                'Les badges verrouillés montrent le prochain objectif à atteindre.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: badges.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.92,
                ),
                itemBuilder: (context, index) =>
                    _BadgeCard(badge: badges[index]),
              ),
              const SizedBox(height: 28),
              Card(
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  secondary: CircleAvatar(
                    backgroundColor: AppColors.softRose,
                    foregroundColor: AppColors.burgundy,
                    child: Icon(
                      controller.notificationsEnabled
                          ? Icons.notifications_active_rounded
                          : Icons.notifications_off_outlined,
                    ),
                  ),
                  title: const Text(
                    'Rappels toutes les 12 h',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: const Text(
                    'Des encouragements locaux, sans connexion requise.',
                  ),
                  value: controller.notificationsEnabled,
                  onChanged: (value) => _toggleNotifications(context, value),
                ),
              ),
              const SizedBox(height: 14),
              _JourneyCard(controller: controller),
            ],
          );
        },
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

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({required this.badge});

  final LearningBadge badge;

  @override
  Widget build(BuildContext context) {
    final color = Color(badge.colorValue);
    return Card(
      color: badge.unlocked ? Colors.white : const Color(0xFFF5F0F2),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: badge.unlocked
                  ? color.withValues(alpha: 0.13)
                  : const Color(0xFFE7DFE2),
              foregroundColor: badge.unlocked ? color : AppColors.muted,
              child: Icon(_badgeIcon(badge.iconName), size: 27),
            ),
            const Spacer(),
            Text(
              badge.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: badge.unlocked ? AppColors.ink : AppColors.muted,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              badge.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              badge.unlocked ? 'DÉBLOQUÉ' : 'À DÉBLOQUER',
              style: TextStyle(
                color: badge.unlocked ? color : AppColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
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

IconData _badgeIcon(String name) {
  switch (name) {
    case 'flag':
      return Icons.flag_rounded;
    case 'explore':
      return Icons.explore_rounded;
    case 'map':
      return Icons.map_rounded;
    case 'satellite':
      return Icons.satellite_alt_rounded;
    case 'star':
      return Icons.star_rounded;
    case 'fire':
      return Icons.local_fire_department_rounded;
    case 'quiz':
      return Icons.quiz_rounded;
    case 'trophy':
      return Icons.emoji_events_rounded;
    case 'bolt':
      return Icons.bolt_rounded;
    case 'crown':
      return Icons.workspace_premium_rounded;
    default:
      return Icons.lock_rounded;
  }
}
