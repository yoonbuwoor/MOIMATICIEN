import 'package:flutter/material.dart';

import '../data/course_catalog.dart';
import '../models/learning_models.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';
import 'course_detail_screen.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({required this.controller, super.key});

  final AppController controller;

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  String _query = '';
  CourseLevel? _selectedLevel;

  List<Course> get _filteredCourses {
    final normalized = _query.trim().toLowerCase();
    return CourseCatalog.courses
        .where((course) {
          final matchesLevel =
              _selectedLevel == null || course.level == _selectedLevel;
          final matchesQuery =
              normalized.isEmpty ||
              course.title.toLowerCase().contains(normalized) ||
              course.subtitle.toLowerCase().contains(normalized) ||
              course.category.toLowerCase().contains(normalized);
          return matchesLevel && matchesQuery;
        })
        .toList(growable: false);
  }

  void _openCourse(Course course) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) =>
            CourseDetailScreen(course: course, controller: widget.controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          final courses = _filteredCourses;
          return ListView(
            key: const PageStorageKey('courses-scroll'),
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 112),
            children: [
              const ScreenHeading(
                eyebrow: 'Bibliothèque',
                title: 'Cours de géomatique',
                subtitle:
                    'Progressez à votre rythme avec des fiches illustrées et directement utiles.',
              ),
              const SizedBox(height: 22),
              TextField(
                onChanged: (value) => setState(() => _query = value),
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Rechercher un cours ou un domaine',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: 14),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Tous'),
                      selected: _selectedLevel == null,
                      onSelected: (_) => setState(() => _selectedLevel = null),
                    ),
                    const SizedBox(width: 8),
                    ...CourseLevel.values.map(
                      (level) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(level.label),
                          selected: _selectedLevel == level,
                          onSelected: (_) =>
                              setState(() => _selectedLevel = level),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Text(
                    '${courses.length} cours',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.download_done_rounded,
                    color: AppColors.success,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Disponibles hors ligne',
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (courses.isEmpty)
                const _EmptyCourses()
              else
                for (var index = 0; index < courses.length; index++) ...[
                  CourseCard(
                    course: courses[index],
                    completed: widget.controller.isCourseCompleted(
                      courses[index].id,
                    ),
                    onTap: () => _openCourse(courses[index]),
                  ),
                  if (index != courses.length - 1) const SizedBox(height: 16),
                ],
            ],
          );
        },
      ),
    );
  }
}

class _EmptyCourses extends StatelessWidget {
  const _EmptyCourses();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            color: AppColors.muted,
            size: 52,
          ),
          const SizedBox(height: 12),
          Text(
            'Aucun cours trouvé',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 5),
          Text(
            'Essayez un autre mot-clé ou retirez le filtre.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
