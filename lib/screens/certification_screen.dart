import 'package:flutter/material.dart';

import '../data/certification_catalog.dart';
import '../models/certification_models.dart';
import '../services/external_links.dart';
import '../theme/app_theme.dart';
import '../widgets/learning_widgets.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({super.key});

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  String? _selectedSector;

  List<CertificationModule> get _visibleModules {
    final selected = _selectedSector;
    if (selected == null) return CertificationCatalog.modules;
    return CertificationCatalog.modules
        .where((module) => module.sector == selected)
        .toList(growable: false);
  }

  void _showRequestSheet(CertificationModule module) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            4,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Demander ce parcours',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 7),
              Text(
                module.title,
                style: const TextStyle(
                  color: AppColors.burgundy,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choisissez un canal. Un message préparé précisera le module sans afficher les coordonnées dans l’application.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  openExternalLink(
                    this.context,
                    ExternalLinks.certificationWhatsApp(module.title),
                    failureMessage:
                        'WhatsApp ne peut pas être ouvert pour le moment.',
                  );
                },
                icon: const Icon(Icons.chat_rounded),
                label: const Text('Contacter sur WhatsApp'),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  openExternalLink(
                    this.context,
                    ExternalLinks.certificationEmail(module.title),
                    failureMessage:
                        'Aucune application e-mail disponible sur cet appareil.',
                  );
                },
                icon: const Icon(Icons.mail_outline_rounded),
                label: const Text('Écrire par e-mail'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modules = _visibleModules;
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey('certifications-scroll'),
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 112),
            sliver: SliverList.list(
              children: [
                const ScreenHeading(
                  eyebrow: 'Passez à l’étape suivante',
                  title: 'Certifications Novateur221',
                  subtitle:
                      'Des parcours sur demande, adaptés aux métiers et aux réalités de chaque secteur.',
                ),
                const SizedBox(height: 20),
                const _CertificationHero(),
                const SizedBox(height: 18),
                const _HowItWorksCard(),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Choisissez votre module',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softRose,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${CertificationCatalog.modules.length} parcours',
                        style: const TextStyle(
                          color: AppColors.burgundy,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  'Filtrez par secteur, puis ouvrez une fiche pour consulter les compétences visées.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ChoiceChip(
                        label: const Text('Tous les secteurs'),
                        selected: _selectedSector == null,
                        onSelected: (_) =>
                            setState(() => _selectedSector = null),
                      ),
                      const SizedBox(width: 8),
                      for (final sector in CertificationCatalog.sectors) ...[
                        ChoiceChip(
                          label: Text(sector),
                          selected: _selectedSector == sector,
                          onSelected: (_) =>
                              setState(() => _selectedSector = sector),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (var index = 0; index < modules.length; index++) ...[
                  _ModuleCard(
                    module: modules[index],
                    onRequest: () => _showRequestSheet(modules[index]),
                  ),
                  if (index != modules.length - 1) const SizedBox(height: 12),
                ],
                const SizedBox(height: 28),
                const _CustomPathCard(),
                const SizedBox(height: 16),
                const _CommunityCard(),
                const SizedBox(height: 18),
                const _PrivacyLink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CertificationHero extends StatelessWidget {
  const _CertificationHero();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: AspectRatio(
        aspectRatio: 16 / 10,
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
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x09000000), Color(0xCC241620)],
                  stops: [0.35, 1],
                ),
              ),
            ),
            const Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VALORISEZ VOS COMPÉTENCES',
                    style: TextStyle(
                      color: AppColors.coral,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Un parcours clair, une évaluation,\nune preuve de votre progression.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.15,
                      fontWeight: FontWeight.w900,
                    ),
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

class _HowItWorksCard extends StatelessWidget {
  const _HowItWorksCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.softRose,
                  foregroundColor: AppColors.burgundy,
                  child: Icon(Icons.route_rounded),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Comment ça marche ?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _ProcessStep(
              number: '1',
              title: 'Choisissez un domaine',
              text:
                  'Sélectionnez un module ou demandez un parcours sur mesure.',
            ),
            const _ProcessStep(
              number: '2',
              title: 'Recevez les modalités',
              text:
                  'Programme, prérequis, calendrier, tarif et critères d’évaluation sont confirmés avant l’inscription.',
            ),
            const _ProcessStep(
              number: '3',
              title: 'Formez-vous et passez l’évaluation',
              text:
                  'La certification Novateur221 est délivrée selon la réussite au parcours convenu.',
              isLast: true,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4DF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 19,
                    color: Color(0xFF9A5A00),
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Les badges ludiques de l’application ne constituent pas une certification professionnelle.',
                      style: TextStyle(
                        color: Color(0xFF744600),
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class _ProcessStep extends StatelessWidget {
  const _ProcessStep({
    required this.number,
    required this.title,
    required this.text,
    this.isLast = false,
  });

  final String number;
  final String title;
  final String text;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.burgundy,
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: const Color(0xFFE8D3DC)),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(text, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.module, required this.onRequest});

  final CertificationModule module;
  final VoidCallback onRequest;

  @override
  Widget build(BuildContext context) {
    final accent = Color(module.accentValue);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        key: PageStorageKey<String>('certification-${module.id}'),
        tilePadding: const EdgeInsets.fromLTRB(16, 9, 15, 9),
        childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        leading: CircleAvatar(
          backgroundColor: accent.withValues(alpha: 0.11),
          foregroundColor: accent,
          child: Icon(_moduleIcon(module.iconName)),
        ),
        title: Text(
          module.title,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            module.sector,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              module.summary,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 14),
          for (final skill in module.skills)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_rounded, color: accent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      skill,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          _MetaRow(icon: Icons.groups_2_outlined, text: module.audience),
          const SizedBox(height: 7),
          _MetaRow(icon: Icons.schedule_rounded, text: module.duration),
          const SizedBox(height: 7),
          _MetaRow(icon: Icons.signal_cellular_alt_rounded, text: module.level),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onRequest,
              style: FilledButton.styleFrom(backgroundColor: accent),
              icon: const Icon(Icons.workspace_premium_rounded),
              label: const Text('Demander ce parcours'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.muted, size: 17),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _CustomPathCard extends StatelessWidget {
  const _CustomPathCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.burgundy, AppColors.purple],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.tune_rounded, color: AppColors.coral, size: 34),
          const SizedBox(height: 12),
          const Text(
            'Votre secteur n’est pas dans la liste ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Novateur221 peut proposer un programme adapté à vos objectifs, vos données, votre niveau et votre contexte professionnel.',
            style: TextStyle(
              color: Color(0xFFE9DCE3),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 17),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: [
              FilledButton.icon(
                onPressed: () => openExternalLink(
                  context,
                  ExternalLinks.generalCertificationWhatsApp,
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.burgundy,
                ),
                icon: const Icon(Icons.chat_rounded),
                label: const Text('WhatsApp direct'),
              ),
              OutlinedButton.icon(
                onPressed: () => openExternalLink(
                  context,
                  ExternalLinks.generalCertificationEmail,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white38),
                ),
                icon: const Icon(Icons.mail_outline_rounded),
                label: const Text('E-mail'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFE2F6ED),
                  foregroundColor: AppColors.success,
                  child: Icon(Icons.forum_rounded),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Communauté WhatsApp Novateur221',
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Rejoignez d’autres passionnés pour parler de géomatique, partager des méthodes et découvrir des opportunités.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => openExternalLink(
                  context,
                  ExternalLinks.community,
                  failureMessage:
                      'Le lien de la communauté ne peut pas être ouvert.',
                ),
                icon: const Icon(Icons.group_add_rounded),
                label: const Text('Rejoindre la communauté'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivacyLink extends StatelessWidget {
  const _PrivacyLink();

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

IconData _moduleIcon(String name) {
  switch (name) {
    case 'map':
      return Icons.map_rounded;
    case 'survey':
      return Icons.straighten_rounded;
    case 'satellite':
      return Icons.satellite_alt_rounded;
    case 'agriculture':
      return Icons.agriculture_rounded;
    case 'cadastre':
      return Icons.grid_4x4_rounded;
    case 'database':
      return Icons.storage_rounded;
    case 'web':
      return Icons.public_rounded;
    case 'code':
      return Icons.code_rounded;
    case 'risk':
      return Icons.crisis_alert_rounded;
    case 'mobile':
      return Icons.phone_android_rounded;
    case 'drone':
      return Icons.flight_rounded;
    case 'health':
      return Icons.health_and_safety_rounded;
    default:
      return Icons.workspace_premium_rounded;
  }
}
