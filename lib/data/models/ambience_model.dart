import 'package:hive/hive.dart';

part 'ambience_model.g.dart';

@HiveType(typeId: 0)
class Ambience extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String tag;

  @HiveField(3)
  final String duration;

  @HiveField(4)
  final String audio;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String imageUrl;

  @HiveField(7)
  final String category;

  @HiveField(8)
  final List<String> sensoryElements;

  Ambience({
    required this.id,
    required this.title,
    required this.tag,
    required this.duration,
    required this.audio,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.sensoryElements,
  });

  factory Ambience.fromJson(Map<String, dynamic> json) {
    return Ambience(
      id: json['id'],
      title: json['title'],
      tag: json['tag'],
      duration: json['duration'],
      audio: json['audio'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      sensoryElements: List<String>.from(json['sensoryElements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tag': tag,
      'duration': duration,
      'audio': audio,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'sensoryElements': sensoryElements,
    };
  }
}


