import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static Color getColor(DateTime? date) {
    if (date != null) {
      return (date.isAfter(DateTime.now())) ? Colors.green : Colors.red;
    }
    return Colors.black;
  }

  static String? getDate(DateTime? date) {
    if (date != null) {
      initializeDateFormatting();
      final formatter = DateFormat('dd MMM yyyy', 'ru_RU');
      return formatter.format(date);
    }
    return null;
  }
}
