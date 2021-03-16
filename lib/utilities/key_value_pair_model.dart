import 'package:hive/hive.dart';
import 'package:html_unescape/html_unescape_small.dart';

part 'key_value_pair_model.g.dart';

@HiveType(typeId: 1)
class KeyValuePair {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final String value;

  KeyValuePair(this.key, this.value);

  KeyValuePair.fromData(String key, dynamic value) :
      this.key = unescape(key),
      this.value = value;

  static String unescape(String string) {
    var unescape = new HtmlUnescape();

    return unescape.convert(string);
  }
}