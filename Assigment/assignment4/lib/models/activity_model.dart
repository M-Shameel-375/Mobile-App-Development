class Activity {
  final String? id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final String? imagePath;
  final DateTime timestamp;
  final bool isSynced;

  Activity({
    this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.imagePath,
    required this.timestamp,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imagePath': imagePath,
      'timestamp': timestamp.toIso8601String(),
      'isSynced': isSynced,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      imagePath: json['imagePath'],
      timestamp: DateTime.parse(json['timestamp']),
      isSynced: json['isSynced'] ?? false,
    );
  }

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    String? imagePath,
    DateTime? timestamp,
    bool? isSynced,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
