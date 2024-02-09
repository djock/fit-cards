import 'package:fitcards/models/base_model.dart';

class ExerciseModel extends BaseModel {
  final int? points;

  ExerciseModel({name, id, this.points}) : super(name, id);

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    var points = json['points'];

    return ExerciseModel(
        name: baseModel.name, id: baseModel.id, points: points);
  }

  static List<ExerciseModel> fromJsonList(json) {
    return json
        .map<ExerciseModel>((obj) => ExerciseModel.fromJson(obj))
        .toList();
  }
}
