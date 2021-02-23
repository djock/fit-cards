class BaseModel {
  final String name;
  final int id;

  BaseModel(this.name, this.id);

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return new BaseModel(json['name'].toString(), json['id']);
  }
}
