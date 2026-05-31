class JsonReader {
  const JsonReader._();

  static String stringValue(Map<String, dynamic> json, String key) {
    final value = json[key];
    return value?.toString() ?? '';
  }

  static num numValue(Map<String, dynamic> json, String key) {
    final value = json[key];

    if (value is num) {
      return value;
    }

    return num.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int intValue(Map<String, dynamic> json, String key) {
    return numValue(json, key).toInt();
  }

  static Map<String, dynamic> mapValue(Map<String, dynamic> json, String key) {
    final value = json[key];

    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return <String, dynamic>{};
  }
}
