class Travel {
  final String id;
  final String title;
  final String country;
  final String region;
  final String startDate;
  final String endDate;
  final String category;
  final String description;
  final bool isFavorite;

  Travel({
    required this.id,
    required this.title,
    required this.country,
    required this.region,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.description,
    required this.isFavorite,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      id: json['id'],
      title: json['title'],
      country: json['country'],
      region: json['region'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      category: json['category'],
      description: json['description'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'country': country,
      'region': region,
      'startDate': startDate,
      'endDate': endDate,
      'category': category,
      'description': description,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  Travel copyWith({
    String? id,
    String? title,
    String? country,
    String? region,
    String? startDate,
    String? endDate,
    String? category,
    String? description,
    bool? isFavorite,
  }) {
    return Travel(
      id: id ?? this.id,
      title: title ?? this.title,
      country: country ?? this.country,
      region: region ?? this.region,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      category: category ?? this.category,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
