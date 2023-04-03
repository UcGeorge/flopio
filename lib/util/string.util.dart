import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';

class StringUtil {
  static String capitalize(String input) => input
      .split(' ')
      .map((e) => e[0].toUpperCase() + e.toLowerCase().substring(1))
      .join(' ');
}

extension StringUtils on String {
  String get capitalize => split(' ')
      .map((e) => e[0].toUpperCase() + e.toLowerCase().substring(1))
      .join(' ');

  String lowerCamelToKebab() {
    String output = replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'),
        (match) => '${match.group(1)}-${match.group(2)?.toLowerCase()}');
    return output.toLowerCase();
  }

  String get toHash => sha256.convert(utf8.encode(this)).toString();
}

extension Currency on num {
  String get formatAsCurrency => NumberFormat.currency(
        name: "NGN ",
        decimalDigits: 0,
      ).format(this);
}
