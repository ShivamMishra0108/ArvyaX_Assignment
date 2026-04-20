import 'package:aether_2/data/models/journal_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/journal_repository.dart';

final journalProvider =
    StateNotifierProvider<JournalController, List<JournalEntry>>(
        (ref) => JournalController());

class JournalController extends StateNotifier<List<JournalEntry>> {
  final repo = JournalRepository();

  JournalController() : super([]) {
    load();
  }

  void load() {
    state = repo.getEntries();
  }

  Future<void> addEntry(JournalEntry entry) async {
    await repo.saveEntry(entry);
    load();
  }
}