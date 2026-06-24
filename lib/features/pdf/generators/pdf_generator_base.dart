import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';

class PdfGeneratorBase {
  static final _font = pw.Font.helvetica();
  static final _fontBold = pw.Font.helveticaBold();
  static Uint8List? _logoBytes;

  static Future<void> loadLogo() async {
    if (_logoBytes != null) return;
    try {
      final data = await rootBundle.load('assets/logo.png');
      _logoBytes = data.buffer.asUint8List();
    } catch (_) {
      _logoBytes = null;
    }
  }

  // Brand accent for PDFs (kept blue to match the app redesign).
  static PdfColor get _green => PdfColor.fromInt(0xFF2196F3);
  static PdfColor get _labelGray => PdfColor.fromInt(0xFF555555);
  static PdfColor get _textDark => PdfColor.fromInt(0xFF1F2933);

  // ---------------------------
  // DOCUMENT
  // ---------------------------
  static pw.Document createDocument({
    required String title,
    required String protocolNumber,
    required String customerName,
    required String date,
    required List<pw.Widget> sections,
  }) {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(title, protocolNumber),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildSummaryRow(customerName, date),
          pw.SizedBox(height: 8),
          pw.Divider(color: _green, thickness: 1),
          pw.SizedBox(height: 16),
          ...sections,
        ],
      ),
    );

    return doc;
  }

  // ---------------------------
  // HEADER
  // ---------------------------
  static pw.Widget _buildHeader(String title, String protocolNumber) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              width: 80,
              height: 54,
              decoration: pw.BoxDecoration(
                color: _green,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: _logoBytes != null
                  ? pw.Image(
                      pw.MemoryImage(_logoBytes!),
                      fit: pw.BoxFit.contain,
                    )
                  : pw.Center(
                      child: pw.Text(
                        'MS',
                        style: pw.TextStyle(
                          font: _fontBold,
                          fontSize: 12,
                          color: PdfColors.white,
                        ),
                      ),
                    ),
            ),
            pw.Text(title, style: pw.TextStyle(font: _fontBold, fontSize: 16)),
            pw.Text(
              protocolNumber,
              style: pw.TextStyle(font: _font, fontSize: 9, color: _labelGray),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Divider(color: _green, thickness: 2),
      ],
    );
  }

  // ---------------------------
  // SUMMARY
  // ---------------------------
  static pw.Widget _buildSummaryRow(String customerName, String date) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Kunde: $customerName',
          style: pw.TextStyle(font: _font, fontSize: 10),
        ),
        pw.Text('Datum: $date', style: pw.TextStyle(font: _font, fontSize: 10)),
      ],
    );
  }

  // ---------------------------
  // FOOTER
  // ---------------------------
  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300, thickness: 0.5),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'MAM Solarbau, Sperlingstr. 2, 86179 Augsburg',
              style: pw.TextStyle(font: _font, fontSize: 8, color: _labelGray),
            ),
            pw.Text(
              'Seite ${context.pageNumber} von ${context.pagesCount}',
              style: pw.TextStyle(font: _font, fontSize: 8, color: _labelGray),
            ),
            pw.Text(
              DateFormatter.formatDateTime(DateTime.now()),
              style: pw.TextStyle(font: _font, fontSize: 8, color: _labelGray),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------
  // SECTION
  // ---------------------------
  static pw.Widget buildSection(String title, List<pw.Widget> fields) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: pw.BoxDecoration(
            color: _green,
            borderRadius: pw.BorderRadius.circular(3),
          ),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              font: _fontBold,
              fontSize: 14,
              color: PdfColors.white,
            ),
          ),
        ),
        pw.SizedBox(height: 10),
        ...fields,
        pw.SizedBox(height: 18),
      ],
    );
  }

  // ---------------------------
  // FIELD ROW
  // ---------------------------
  static pw.Widget buildFieldRow(String label, String value) {
    if (value.isEmpty) return pw.SizedBox(height: 0);
    // Stacked layout (BSH style): bold label on top, value below — far more
    // readable for long German labels than a narrow two-column row.
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 9),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(font: _fontBold, fontSize: 11, color: _textDark),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            value,
            style: pw.TextStyle(font: _font, fontSize: 12, color: _textDark),
          ),
        ],
      ),
    );
  }

  // ---------------------------
  // IMAGE HELPERS
  // ---------------------------
  static pw.ImageProvider? _imageFromPath(String? path) {
    if (path == null || path.isEmpty) return null;

    final file = File(path);
    if (!file.existsSync()) return null;

    return pw.MemoryImage(file.readAsBytesSync());
  }

  // ---------------------------
  // PHOTO FIELD
  // ---------------------------
  static pw.Widget buildPhotoField(String label, dynamic value) {
    if (value == null) {
      return buildFieldRow(label, '[Photo not found]');
    }

    List<String> paths;
    if (value is List) {
      paths = value.cast<String>().where((p) => p.isNotEmpty).toList();
    } else if (value is String && value.isNotEmpty) {
      paths = [value];
    } else {
      return buildFieldRow(label, '[Photo not found]');
    }

    final images = paths.map((p) {
      final img = _imageFromPath(p);
      if (img == null) return null;
      return pw.Column(
        children: [
          pw.Image(img, width: 240, height: 180, fit: pw.BoxFit.contain),
          pw.SizedBox(height: 6),
        ],
      );
    }).whereType<pw.Widget>().toList();

    if (images.isEmpty) {
      return buildFieldRow(label, '[Photo not found]');
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(font: _fontBold, fontSize: 11, color: _textDark),
        ),
        pw.SizedBox(height: 6),
        ...images,
        pw.SizedBox(height: 12),
      ],
    );
  }

  // ---------------------------
  // SIGNATURE FIELD
  // ---------------------------
  static pw.Widget buildSignatureField(String label, String? imagePath) {
    final image = _imageFromPath(imagePath);

    if (image == null) {
      return buildFieldRow(label, '[Not signed]');
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(font: _fontBold, fontSize: 11, color: _textDark),
        ),
        pw.SizedBox(height: 6),
        pw.Container(
          width: 260,
          height: 100,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey),
          ),
          child: pw.Image(image, fit: pw.BoxFit.contain),
        ),
        pw.SizedBox(height: 12),
      ],
    );
  }

  // ---------------------------
  // DISPLAY TEXT
  // ---------------------------
  static pw.Widget buildDisplayTextField(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: _font,
          fontSize: 10.5,
          color: _textDark,
          fontStyle: pw.FontStyle.italic,
        ),
      ),
    );
  }

  // ---------------------------
  // SAFE STRING
  // ---------------------------
  static String safeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  // ---------------------------
  // FIELD LOGGING
  // ---------------------------
  static final Logger _pdfLog = Logger();

  /// Logs expected fields vs actual data. Call within each generator.
  static void logExpectedFields(Map<String, dynamic> data, String generatorName, List<String> expectedFlatKeys) {
    _pdfLog.i('=== $generatorName: Expected vs Actual Fields ===');
    final present = <String>[];
    final missing = <String>[];
    for (final key in expectedFlatKeys) {
      if (data.containsKey(key) && data[key] != null && data[key].toString().trim().isNotEmpty) {
        present.add(key);
      } else {
        missing.add(key);
      }
    }
    _pdfLog.i('$generatorName: ${present.length}/${expectedFlatKeys.length} fields present');
    if (missing.isNotEmpty) {
      _pdfLog.w('$generatorName: MISSING fields (${missing.length}): $missing');
    }
    // Log all unknown keys (present in data but not in expected list)
    final unexpected = data.keys.where((k) => !expectedFlatKeys.contains(k) && k != '_repeatable').toList();
    if (unexpected.isNotEmpty) {
      _pdfLog.i('$generatorName: Extra fields in data (${unexpected.length}): $unexpected');
    }
  }

  /// Logs expected vs actual repeatable data.
  static void logExpectedRepeatableFields(Map<String, List<Map<String, dynamic>>> repeatableData, String generatorName, Map<String, List<String>> expectedRepeatableKeys) {
    _pdfLog.i('=== $generatorName: Expected vs Actual Repeatable Fields ===');
    for (final entry in expectedRepeatableKeys.entries) {
      final sectionId = entry.key;
      final expectedKeys = entry.value;
      final items = repeatableData[sectionId] ?? [];
      _pdfLog.i('$sectionId: ${items.length} items, expected per item: ${expectedKeys.length} keys');
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        final missingInItem = expectedKeys.where((k) => item[k] == null || item[k].toString().trim().isEmpty).toList();
        if (missingInItem.isNotEmpty) {
          _pdfLog.w('$sectionId[$i]: MISSING keys: $missingInItem');
        }
      }
    }
  }
}
