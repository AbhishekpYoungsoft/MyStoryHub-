import 'package:mystoryhub/business_logic/model/album_details.dart';

class Album {
  final int id;
  final int userId;
  final String title;
  List<Photo>? photos;

  Album({
    required this.id,
    required this.userId,
    required this.title,
    this.photos,
  });

  // Factory method to create an Album instance from JSON
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      photos: json['photos'] != null
          ? (json['photos'] as List).map((i) => Photo.fromJson(i)).toList()
          : null,
    );
  }

  // Method to create a copy of the Album instance with optional new values
  Album copyWith({
    int? id,
    int? userId,
    String? title,
    List<Photo>? photos,
  }) {
    return Album(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      photos: photos ?? this.photos,
    );
  }

  @override
  String toString() {
    return 'Album(id: $id, userId: $userId, title: $title, photos: ${photos?.length})';
  }
}

