import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';

/// Data-driven PDF generator: renders any protocol straight from its parsed
/// sections/fields, so the PDF always matches the markdown form definition.
///
/// Rules (mirror the on-screen form):
///  - fields hidden by show_if are skipped (uses [FormFieldDef.isVisible]);
///  - empty / unfilled fields are skipped;
///  - sections with no real data are dropped entirely;
///  - repeatable sections render one "Title #n" block per filled item;
///  - field type drives rendering (photo/signature/checkbox/display text/text).
class GenericProtocolPdfGenerator {
  static pw.Document generate({
    required int protocolId,
    required String title,
    required String typeCode,
    required String customerName,
    required List<FormSection> sections,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
    String languageCode = 'de',
  }) {
    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber =
        DateFormatter.protocolNumber(typeCode, DateTime.now(), protocolId);

    final widgets = <pw.Widget>[];
    for (final section in sections) {
      final built = section.isRepeatable
          ? _repeatableSection(
              section, repeatableData[section.id] ?? const [], languageCode)
          : _flatSection(section, data, languageCode);
      if (built != null) widgets.add(built);
    }

    return PdfGeneratorBase.createDocument(
      title: title,
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: widgets,
    );
  }

  // ─── Non-repeatable section ────────────────────────────────────────────────
  static pw.Widget? _flatSection(
    FormSection section,
    Map<String, dynamic> data,
    String lang,
  ) {
    final fields = <pw.Widget>[];
    var hasData = false;
    for (final f in section.fields) {
      if (!f.isVisible(data)) continue;
      final rendered = _renderField(f, data[f.id], lang);
      if (rendered.isEmpty) continue;
      if (f.type != FieldType.displayText) hasData = true;
      fields.addAll(rendered);
    }
    if (!hasData) return null; // nothing meaningful filled in this section
    return PdfGeneratorBase.buildSection(section.localizedLabel(lang), fields);
  }

  // ─── Repeatable section ────────────────────────────────────────────────────
  static pw.Widget? _repeatableSection(
    FormSection section,
    List<Map<String, dynamic>> items,
    String lang,
  ) {
    final fields = <pw.Widget>[];
    var shown = 0;
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final itemFields = <pw.Widget>[];
      var hasData = false;
      for (final f in section.fields) {
        if (!f.isVisible(item)) continue;
        final rendered = _renderField(f, item[f.id], lang);
        if (rendered.isEmpty) continue;
        if (f.type != FieldType.displayText) hasData = true;
        itemFields.addAll(rendered);
      }
      if (!hasData) continue;
      shown++;
      if (fields.isNotEmpty) fields.add(pw.SizedBox(height: 6));
      fields.add(
        pw.Text(
          '${section.localizedLabel(lang)} #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ),
      );
      fields.addAll(itemFields);
    }
    if (shown == 0) return null;
    return PdfGeneratorBase.buildSection(section.localizedLabel(lang), fields);
  }

  // ─── Single field ──────────────────────────────────────────────────────────
  static List<pw.Widget> _renderField(
    FormFieldDef f,
    dynamic value,
    String lang,
  ) {
    final label = f.localizedLabel(lang);
    switch (f.type) {
      case FieldType.displayText:
        return [PdfGeneratorBase.buildDisplayTextField(label)];

      case FieldType.signature:
        if (value is String && value.isNotEmpty) {
          return [PdfGeneratorBase.buildSignatureField(label, value)];
        }
        return [];

      case FieldType.photo:
      case FieldType.multiphoto:
        return _hasPhoto(value)
            ? [PdfGeneratorBase.buildPhotoField(label, value)]
            : [];

      case FieldType.checkbox:
        // Confirmation checkbox: only show when checked.
        final checked = value == true || value == 'true';
        return checked
            ? [PdfGeneratorBase.buildFieldRow(label, 'Ja')]
            : [];

      case FieldType.file:
        final s = PdfGeneratorBase.safeString(value).trim();
        if (s.isEmpty) return [];
        final name = s.split(RegExp(r'[\\/]')).last;
        return [PdfGeneratorBase.buildFieldRow(label, name)];

      case FieldType.repeatable:
        return [];

      default:
        final s = PdfGeneratorBase.safeString(value).trim();
        if (s.isEmpty || s == '-') return [];
        return [PdfGeneratorBase.buildFieldRow(label, s)];
    }
  }

  static bool _hasPhoto(dynamic v) {
    if (v is List) return v.any((e) => e is String && e.isNotEmpty);
    return v is String && v.isNotEmpty;
  }
}
