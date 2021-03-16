import 'package:fitcards/models/workout_log_model.dart';
import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:hive/hive.dart';

class WorkoutLogModelAdapter extends TypeAdapter<WorkoutLogModel> {
  @override
  final typeId = 0;

  @override
  WorkoutLogModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutLogModel(
      fields[0] as int,
      fields[1] as List<KeyValuePair>,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutLogModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.entries);
  }
}
