import 'package:fitcards/utilities/key_value_pair_model.dart';
import 'package:hive/hive.dart';

@HiveType()
class WorkoutLogModel extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  List<KeyValuePair> entries;

  WorkoutLogModel(this.index, this.entries);
}

