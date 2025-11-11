String ListToString(dynamic data) {
  String message = "";
  if (data is List<dynamic>) {
    // ignore: unnecessary_cast
    message = (data as List<dynamic>).join(", ");
  } else if (data is String) {
    message = data;
  }
  return message;
}
