import 'package:intl/intl.dart';

class AppDateFormatter {
  static String formatShort(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('MMM d, h:mm a').format(date);
  }
}
