// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_pair_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeyValuePairAdapter extends TypeAdapter<KeyValuePair> {
  @override
  final typeId = 4;

  @override
  KeyValuePair read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KeyValuePair(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KeyValuePair obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.value);
  }
}
