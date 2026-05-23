import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd.MM.yyyy HH:mm').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDateForFileName(DateTime date) {
    return DateFormat('yyyyMMdd').format(date);
  }

  static String formatDateForDisplay(dynamic date) {
    if (date == null) return '';
    if (date is String) {
      final parsed = DateTime.tryParse(date);
      if (parsed != null) return formatDate(parsed);
      return date;
    }
    if (date is DateTime) return formatDate(date);
    return date.toString();
  }

  static String protocolNumber(String type, DateTime date, int id) {
    final dateStr = DateFormat('yyyyMMdd').format(date);
    final idStr = id.toString().padLeft(4, '0');
    return '$type-$dateStr-$idStr';
  }
}
