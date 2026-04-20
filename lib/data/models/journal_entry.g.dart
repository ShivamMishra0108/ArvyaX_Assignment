
part of 'journal_entry.dart';

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 1;

  @override
  JournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return JournalEntry(
      id: fields[0] as String,
      text: fields[1] as String,
      mood: fields[2] as String,
      timestamp: fields[3] as DateTime,
      ambienceTitle: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer
      ..writeByte(5) 
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.mood)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.ambienceTitle);
  }
}