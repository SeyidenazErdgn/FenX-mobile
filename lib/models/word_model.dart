class Word {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String? imagePath2;
  final String experiment;
  final String interdisciplinary;
  final String dailyLife;

  const Word({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    this.imagePath2,
    required this.experiment,
    required this.interdisciplinary,
    required this.dailyLife,
  });
}
