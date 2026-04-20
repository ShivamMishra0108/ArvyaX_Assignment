import 'package:aether_2/data/models/journal_entry.dart';

class JournalData {
  static final List<JournalEntry> entries = [
    JournalEntry(
      id: '1',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ambienceTitle: 'Forest Focus',
      mood: 'Calm',
      text: 'The gentle sounds of the forest helped me find clarity. I felt more centered and present throughout the session.',
    ),
    JournalEntry(
      id: '2',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      ambienceTitle: 'Ocean Waves',
      mood: 'Grounded',
      text: 'The rhythm of the waves matched my breathing perfectly. A sense of peace washed over me.',
    ),
    JournalEntry(
      id: '3',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      ambienceTitle: 'Gentle Rain',
      mood: 'Sleepy',
      text: 'Such a soothing experience. The rain sounds made me feel safe and cozy, ready for deep rest.',
    ),
  ];
}
