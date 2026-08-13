class CertificationModule {
  const CertificationModule({
    required this.id,
    required this.title,
    required this.sector,
    required this.summary,
    required this.skills,
    required this.audience,
    required this.duration,
    required this.level,
    required this.iconName,
    required this.accentValue,
  });

  final String id;
  final String title;
  final String sector;
  final String summary;
  final List<String> skills;
  final String audience;
  final String duration;
  final String level;
  final String iconName;
  final int accentValue;
}
