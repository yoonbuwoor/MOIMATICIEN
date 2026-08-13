import 'package:flutter/material.dart';

import '../data/quiz_catalog.dart';
import '../models/learning_models.dart';
import '../state/app_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.definition,
    required this.controller,
    super.key,
  });

  final QuizDefinition definition;
  final AppController controller;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _questions;
  int _currentIndex = 0;
  int _score = 0;
  int _combo = 0;
  int _bestCombo = 0;
  int? _selectedIndex;

  QuizQuestion get _question => _questions[_currentIndex];
  bool get _answered => _selectedIndex != null;
  bool get _isLast => _currentIndex == _questions.length - 1;

  @override
  void initState() {
    super.initState();
    _questions = QuizCatalog.questionsFor(widget.definition);
  }

  void _selectAnswer(int index) {
    if (_answered) return;
    final correct = index == _question.correctIndex;
    setState(() {
      _selectedIndex = index;
      if (correct) {
        _score++;
        _combo++;
        if (_combo > _bestCombo) _bestCombo = _combo;
      } else {
        _combo = 0;
      }
    });
    if (!correct) widget.controller.loseLife();
  }

  Future<void> _continue() async {
    if (!_answered) return;
    if (_isLast) {
      final earnedXp = await widget.controller.saveQuizScore(
        quizId: widget.definition.id,
        correct: _score,
        total: _questions.length,
      );
      if (!mounted) return;
      await Navigator.of(context).pushReplacement<void, void>(
        MaterialPageRoute<void>(
          builder: (context) => QuizResultScreen(
            definition: widget.definition,
            controller: widget.controller,
            score: _score,
            total: _questions.length,
            earnedXp: earnedXp,
            bestCombo: _bestCombo,
          ),
        ),
      );
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accent = Color(widget.definition.accentValue);
    final progress = (_currentIndex + 1) / _questions.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.definition.title),
        backgroundColor: AppColors.canvas,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
          children: [
            Row(
              children: [
                Text(
                  'Question ${_currentIndex + 1} sur ${_questions.length}',
                  style: const TextStyle(
                    color: AppColors.burgundy,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (_combo >= 2) ...[
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.coral.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '🔥 Combo x$_combo',
                      style: const TextStyle(
                        color: AppColors.coral,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
                Row(children: List.generate(3, (i) => Icon(i < widget.controller.lives ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: AppColors.coral, size: 17))),
                const SizedBox(width: 8),
                Text(
                  '$_score bonne${_score > 1 ? 's' : ''} réponse${_score > 1 ? 's' : ''}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                color: accent,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.ink, accent],
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    quizIcon(widget.definition.iconName),
                    color: AppColors.coral,
                    size: 34,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _question.question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            for (var index = 0; index < _question.options.length; index++) ...[
              _AnswerOption(
                letter: String.fromCharCode(65 + index),
                label: _question.options[index],
                selected: _selectedIndex == index,
                isCorrect: _answered && index == _question.correctIndex,
                isWrongSelection:
                    _answered &&
                    _selectedIndex == index &&
                    index != _question.correctIndex,
                disabled: _answered,
                onTap: () => _selectAnswer(index),
              ),
              if (index != _question.options.length - 1)
                const SizedBox(height: 11),
            ],
            if (_answered) ...[
              const SizedBox(height: 20),
              _ExplanationCard(
                correct: _selectedIndex == _question.correctIndex,
                explanation: _question.explanation,
                combo: _combo,
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 14),
        child: FilledButton.icon(
          onPressed: _answered ? _continue : null,
          icon: Icon(
            _isLast ? Icons.flag_rounded : Icons.arrow_forward_rounded,
          ),
          label: Text(_isLast ? 'Voir mon résultat' : 'Question suivante'),
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.letter,
    required this.label,
    required this.selected,
    required this.isCorrect,
    required this.isWrongSelection,
    required this.disabled,
    required this.onTap,
  });

  final String letter;
  final String label;
  final bool selected;
  final bool isCorrect;
  final bool isWrongSelection;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color borderColor;
    final Color backgroundColor;
    final Color markerColor;
    final IconData? resultIcon;

    if (isCorrect) {
      borderColor = AppColors.success;
      backgroundColor = const Color(0xFFE6F7EF);
      markerColor = AppColors.success;
      resultIcon = Icons.check_circle_rounded;
    } else if (isWrongSelection) {
      borderColor = AppColors.red;
      backgroundColor = const Color(0xFFFFE8ED);
      markerColor = AppColors.red;
      resultIcon = Icons.cancel_rounded;
    } else {
      borderColor = selected ? AppColors.burgundy : const Color(0xFFE9DCE1);
      backgroundColor = Colors.white;
      markerColor = selected ? AppColors.burgundy : const Color(0xFFF2E8EC);
      resultIcon = null;
    }

    return Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: borderColor,
          width: isCorrect || isWrongSelection ? 1.7 : 1,
        ),
      ),
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: markerColor,
                foregroundColor: selected || isCorrect || isWrongSelection
                    ? Colors.white
                    : AppColors.burgundy,
                child: Text(
                  letter,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (resultIcon != null) ...[
                const SizedBox(width: 8),
                Icon(resultIcon, color: borderColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  const _ExplanationCard({
    required this.correct,
    required this.explanation,
    required this.combo,
  });

  final bool correct;
  final String explanation;
  final int combo;

  @override
  Widget build(BuildContext context) {
    final color = correct ? AppColors.success : AppColors.red;
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.26)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct ? Icons.check_circle_rounded : Icons.info_rounded,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  correct
                      ? combo >= 3
                            ? 'Excellent combo x$combo !'
                            : 'Bonne réponse • +5 XP !'
                      : 'À retenir',
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  explanation,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({
    required this.definition,
    required this.controller,
    required this.score,
    required this.total,
    required this.earnedXp,
    required this.bestCombo,
    super.key,
  });

  final QuizDefinition definition;
  final AppController controller;
  final int score;
  final int total;
  final int earnedXp;
  final int bestCombo;

  int get percentage => ((score / total) * 100).round();

  String get message {
    if (percentage >= 90) return 'Excellent, vous maîtrisez le sujet !';
    if (percentage >= 70) return 'Très bien, les bases sont solides.';
    if (percentage >= 50) {
      return 'Bon début, une petite révision vous fera progresser.';
    }
    return 'Relisez le cours puis retentez le quiz.';
  }

  @override
  Widget build(BuildContext context) {
    final passed = percentage >= 70;
    final accent = passed ? AppColors.success : AppColors.coral;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat'),
        backgroundColor: AppColors.canvas,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 30, 24, 26),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.ink, Color(definition.accentValue)],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: .55, end: 1),
                    duration: const Duration(milliseconds: 650),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) => Transform.scale(scale: value, child: child),
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white24, width: 2),
                      ),
                      child: Icon(
                        passed ? Icons.emoji_events_rounded : Icons.menu_book_rounded,
                        color: passed ? const Color(0xFFFFC04D) : AppColors.coral,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      height: 1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    '$score bonnes réponses sur $total',
                    style: const TextStyle(
                      color: Color(0xFFE8DBE1),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.3,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _ResultReward(
                    icon: Icons.bolt_rounded,
                    value: '+$earnedXp XP',
                    label: 'récompense',
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ResultReward(
                    icon: Icons.local_fire_department_rounded,
                    value: 'x$bestCombo',
                    label: 'meilleur combo',
                    color: AppColors.coral,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: accent.withValues(alpha: 0.12),
                      foregroundColor: accent,
                      child: Icon(
                        passed ? Icons.verified_rounded : Icons.replay_rounded,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            passed
                                ? 'Objectif atteint'
                                : 'Continuez vos efforts',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            passed
                                ? 'Votre meilleur score est enregistré sur cet appareil.'
                                : 'Vous pouvez recommencer sans aucune pénalité.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement<void, void>(
                  MaterialPageRoute<void>(
                    builder: (context) => QuizScreen(
                      definition: definition,
                      controller: controller,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Recommencer ce quiz'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded),
              label: const Text('Retour aux quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultReward extends StatelessWidget {
  const _ResultReward({
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
