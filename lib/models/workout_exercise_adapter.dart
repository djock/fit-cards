import 'package:fitcards/models/workout_exercise_model.dart';
import 'package:hive/hive.dart';

class WorkoutExerciseModelAdapter extends TypeAdapter<WorkoutExercise> {
  @override
  final typeId = 0;

  @override
  WorkoutExercise read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutExercise(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutExercise obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.exercise)
      ..writeByte(2)
      ..write(obj.scheme);
  }
}
