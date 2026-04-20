
part of 'ambience_model.dart';

class AmbienceAdapter extends TypeAdapter<Ambience> {
  @override
  final int typeId = 0;

  @override
  Ambience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Ambience(
      id: fields[0] as String,
      title: fields[1] as String,
      tag: fields[2] as String,
      duration: fields[3] as String,
      audio: fields[4] as String,
      description: fields[5] as String,
      imageUrl: fields[6] as String,
      category: fields[7] as String,
      sensoryElements: (fields[8] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Ambience obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.tag)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.audio)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.sensoryElements);
  }
}