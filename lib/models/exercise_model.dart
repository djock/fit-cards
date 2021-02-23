import 'package:fitcards/models/base_model.dart';

enum schemeType {
  reps,
  time,
}

class ExerciseModel extends BaseModel {

  ExerciseModel({name, id}) : super(name, id);

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);

    return ExerciseModel(name: baseModel.name, id: baseModel.id);
  }

  static List<ExerciseModel> fromJsonList(json) {
    return json.map<ExerciseModel>((obj) => ExerciseModel.fromJson(obj)).toList();
  }
}
