import 'package:aether_2/data/models/journal_entry.dart';
import 'package:hive/hive.dart';

class JournalRepository {
  final Box<JournalEntry> box = Hive.box<JournalEntry>('journal');

  Future<void> saveEntry(JournalEntry entry) async {
    await box.add(entry);
  }

  List<JournalEntry> getEntries() {
    return box.values.toList().reversed.toList();
  }
}