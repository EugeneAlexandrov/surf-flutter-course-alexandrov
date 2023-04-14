import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:places/app_strings.dart';

class AppUtils {
  static Color colorByDate(DateTime? date) {
    if (date != null) {
      return (date.isAfter(DateTime.now())) ? Colors.green : Colors.red;
    }
    return Colors.black;
  }

  static String dateToString(DateTime? date) {
    if (date != null) {
      initializeDateFormatting();
      final formatter = DateFormat('dd MMM yyyy', 'ru_RU');
      return formatter.format(date);
    }
    return AppStrings.utilsDate;
  }
}
