import 'package:hive/hive.dart';

part 'journal_entry.g.dart';


@HiveType(typeId: 1)
class JournalEntry extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  String mood;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  String ambienceTitle;

  JournalEntry({
    required this.id,
    required this.text,
    required this.mood,
    required this.timestamp,
    required this.ambienceTitle, 
  });
}