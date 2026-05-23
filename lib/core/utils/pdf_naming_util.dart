import 'package:mam_solar/core/utils/date_formatter.dart';

class PdfNamingUtil {
  PdfNamingUtil._();

  static String generateFileName(String protocolType, String customerName, DateTime date) {
    final sanitizedCustomer = customerName
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(' ', '_');
    final dateStr = DateFormatter.formatDateForFileName(date);
    return '${protocolType}_${sanitizedCustomer}_$dateStr.pdf';
  }
}
