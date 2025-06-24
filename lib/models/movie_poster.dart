class MoviePoster {
  final String id;
  final String title;
  final String posterUrl;
  final String year;
  final String type;

  MoviePoster({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.year,
    required this.type,
  });

  factory MoviePoster.fromJson(Map<String, dynamic> json) {
    return MoviePoster(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      posterUrl: json['poster'] ?? '',
      year: json['year']?.toString() ?? '',
      type: json['type'] ?? '',
    );
  }
}
