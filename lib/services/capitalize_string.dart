String capitalize(String string) {
  if (string == null) {
    throw ArgumentError("String: $string");
  }
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
}
