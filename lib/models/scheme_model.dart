import 'package:fitcards/models/base_model.dart';

enum schemeType {
  reps,
  time,
}

class SchemeModel extends BaseModel {
  final schemeType type;

  SchemeModel({name, id, this.type}) : super(name, id);

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    var schemeType = convertToEnum(json['type']);

    return SchemeModel(
        name: getName(baseModel.name, schemeType), type: schemeType);
  }

  static List<SchemeModel> fromJsonList(json) {
    var tempList = List<SchemeModel>(); // ignore: deprecated_member_use

    for (var item in json) {
      tempList.add(new SchemeModel.fromJson(item));
    }

    return tempList;
  }

  static String getName(String baseName, schemeType type) {
    var suffix = type == schemeType.reps ? 'Reps' : 'seconds';

    return '$baseName $suffix';
  }

  static schemeType convertToEnum(String json) {
    var scheme = schemeType.values
        .firstWhere((e) => e.toString().replaceAll('schemeType.', '') == json);

    return scheme;
  }
}
