import 'package:flutter/material.dart';

import '../models/learning_models.dart';
import '../theme/app_theme.dart';

class ScreenHeading extends StatelessWidget {
  const ScreenHeading({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: const TextStyle(
            color: AppColors.coral,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 7),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.title,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    required this.course,
    required this.completed,
    required this.onTap,
    this.compact = false,
    super.key,
  });

  final Course course;
  final bool completed;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final accent = Color(course.accentValue);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: compact
            ? SizedBox(
                width: 272,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CourseImage(
                      course: course,
                      completed: completed,
                      height: 142,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      child: _CourseInfo(course: course, accent: accent),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CourseImage(
                    course: course,
                    completed: completed,
                    height: 184,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                    child: _CourseInfo(course: course, accent: accent),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CourseImage extends StatelessWidget {
  const _CourseImage({
    required this.course,
    required this.completed,
    required this.height,
  });

  final Course course;
  final bool completed;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            course.imageAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: Color(course.accentValue),
              child: const Icon(
                Icons.map_rounded,
                color: Colors.white,
                size: 58,
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0x99000000)],
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 14,
            child: _Pill(
              label: course.category,
              foreground: Colors.white,
              background: const Color(0xB8241620),
            ),
          ),
          if (completed)
            const Positioned(
              right: 14,
              top: 14,
              child: CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                child: Icon(Icons.check_rounded, size: 21),
              ),
            ),
          Positioned(
            left: 14,
            bottom: 12,
            child: Row(
              children: [
                _Pill(
                  label: '≈ ${course.readingMinutes} min',
                  icon: Icons.schedule_rounded,
                  foreground: Colors.white,
                  background: const Color(0xB8241620),
                ),
                const SizedBox(width: 8),
                _Pill(
                  label: course.level.label,
                  foreground: Colors.white,
                  background: const Color(0xB8241620),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseInfo extends StatelessWidget {
  const _CourseInfo({required this.course, required this.accent});

  final Course course;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 7),
        Text(
          course.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Text(
              'Ouvrir le cours',
              style: TextStyle(
                color: accent,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward_rounded, color: accent, size: 18),
          ],
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.foreground,
    required this.background,
    this.icon,
  });

  final String label;
  final Color foreground;
  final Color background;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                color: foreground,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData quizIcon(String name) {
  switch (name) {
    case 'explore':
      return Icons.explore_rounded;
    case 'map':
      return Icons.map_rounded;
    case 'layers':
      return Icons.layers_rounded;
    case 'satellite':
      return Icons.satellite_alt_rounded;
    case 'image':
      return Icons.image_search_rounded;
    case 'drone':
      return Icons.flight_rounded;
    case 'topography':
      return Icons.architecture_rounded;
    case 'globe':
      return Icons.public_rounded;
    case 'database':
      return Icons.storage_rounded;
    case 'web':
      return Icons.language_rounded;
    case 'analytics':
      return Icons.query_stats_rounded;
    case 'terrain':
      return Icons.terrain_rounded;
    case 'cadastre':
      return Icons.grid_4x4_rounded;
    case 'code':
      return Icons.code_rounded;
    case 'mobile':
      return Icons.phonelink_ring_rounded;
    case 'environment':
      return Icons.eco_rounded;
    case 'trophy':
      return Icons.emoji_events_rounded;
    default:
      return Icons.quiz_rounded;
  }
}
