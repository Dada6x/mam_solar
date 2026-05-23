import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';

class PdfGeneratorBase {
  static final _font = pw.Font.helvetica();
  static final _fontBold = pw.Font.helveticaBold();

  static PdfColor get _green => PdfColor.fromInt(0xFF2e7d32);
  static PdfColor get _labelGray => PdfColor.fromInt(0xFF555555);

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
              width: 60,
              height: 40,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromInt(0xFFf9a825),
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Center(
                child: pw.Text( //TODO add logo here 
                  'MS',
                  style: pw.TextStyle(font: _fontBold, fontSize: 12),
                ),
              ),
            ),
            pw.Text(
              title,
              style: pw.TextStyle(font: _fontBold, fontSize: 16),
            ),
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
          'Customer: $customerName',
          style: pw.TextStyle(font: _font, fontSize: 10),
        ),
        pw.Text(
          'Date: $date',
          style: pw.TextStyle(font: _font, fontSize: 10),
        ),
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
              'BSH GmbH & Co. KG, Bamberger Str. 44, 97631 Bad Königshofen',
              style: pw.TextStyle(font: _font, fontSize: 8, color: _labelGray),
            ),
            pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
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
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: pw.BoxDecoration(
            color: _green,
            borderRadius: pw.BorderRadius.circular(2),
          ),
          child: pw.Text(
            title,
            style: pw.TextStyle(
              font: _fontBold,
              fontSize: 11,
              color: PdfColors.white,
            ),
          ),
        ),
        pw.SizedBox(height: 8),
        ...fields,
        pw.SizedBox(height: 12),
      ],
    );
  }

  // ---------------------------
  // FIELD ROW
  // ---------------------------
  static pw.Widget buildFieldRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 160,
            child: pw.Text(
              label,
              style: pw.TextStyle(font: _font, fontSize: 9, color: _labelGray),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value.isEmpty ? '-' : value,
              style: pw.TextStyle(font: _font, fontSize: 10),
            ),
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
  static pw.Widget buildPhotoField(String label, String? imagePath) {
    final image = _imageFromPath(imagePath);

    if (image == null) {
      return buildFieldRow(label, '[Photo not found]');
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(font: _font, fontSize: 9, color: _labelGray),
        ),
        pw.SizedBox(height: 4),
        pw.Image(
          image,
          width: 120,
          height: 80,
          fit: pw.BoxFit.cover,
        ),
        pw.SizedBox(height: 8),
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
          style: pw.TextStyle(font: _font, fontSize: 9, color: _labelGray),
        ),
        pw.SizedBox(height: 4),
        pw.Container(
          width: 200,
          height: 60,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey),
          ),
          child: pw.Image(
            image,
            fit: pw.BoxFit.contain,
          ),
        ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  // ---------------------------
  // SAFE STRING
  // ---------------------------
  static String safeString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}