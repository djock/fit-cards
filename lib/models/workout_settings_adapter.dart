import 'package:fitcards/models/workout_settings_model.dart';
import 'package:hive/hive.dart';

class WorkoutSettingsModelAdapter extends TypeAdapter<WorkoutSettingsModel> {
  @override
  final typeId = 2;

  @override
  WorkoutSettingsModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutSettingsModel(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as bool,
      fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutSettingsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.rounds)
      ..writeByte(1)
      ..write(obj.restTime)
      ..writeByte(2)
      ..write(obj.workTime)
      ..writeByte(3)
      ..write(obj.canSkipExercise)
      ..writeByte(4)
      ..write(obj.maxDuration);
  }
}
