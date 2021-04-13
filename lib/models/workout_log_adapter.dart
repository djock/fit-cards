import 'package:fitcards/models/workout_log_model.dart';
import 'package:hive/hive.dart';

class WorkoutLogModelAdapter extends TypeAdapter<WorkoutLogModel> {
  @override
  final typeId = 1;

  @override
  WorkoutLogModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutLogModel(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as int,
      fields[3] as int,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutLogModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.exercises)
      ..writeByte(4)
      ..write(obj.points);
  }
}
