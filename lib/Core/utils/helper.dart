import 'dart:ui';

Color hexToColor(String hexString, {double opacity = 1.0}) {
  final hexRegex = RegExp(r'^#?([0-9A-Fa-f]{6})$');
  if (!hexRegex.hasMatch(hexString)) {
    throw ArgumentError("Invalid hex color code: $hexString");
  }

  final hex = hexString.replaceAll('#', '');
  final r = int.parse(hex.substring(0, 2), radix: 16);
  final g = int.parse(hex.substring(2, 4), radix: 16);
  final b = int.parse(hex.substring(4, 6), radix: 16);

  return Color.fromRGBO(r, g, b, opacity);
}
