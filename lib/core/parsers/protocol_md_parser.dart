import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mam_solar/core/parsers/parsed_protocol.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';

class ProtocolMdParser {
  ProtocolMdParser._();

  static final _log = Logger();
  @visibleForTesting
  static final Map<String, ParsedProtocol> cache = {};

  /// Parses a protocol by type. Uses cache if version unchanged.
  static Future<ParsedProtocol> parse(String protocolType) async {
    final typeKey = _typeKeyFromArg(protocolType);

    try {
      final source = await _loadSource(typeKey);
      final version = _scanVersion(source);

      final cacheKey = '$typeKey:$version';
      final cached = cache[cacheKey];
      if (cached != null) return cached;

      final parsed = parseMarkdown(typeKey, source);
      cache[cacheKey] = parsed;
      return parsed;
    } catch (e, st) {
      _log.e('parse failed for $protocolType', error: e, stackTrace: st);
      return errorResult(typeKey, e.toString());
    }
  }

  /// Forces re-parse, bypasses cache. Call after file import.
  static Future<ParsedProtocol> parseForce(String protocolType) async {
    final typeKey = _typeKeyFromArg(protocolType);
    cache.removeWhere((key, _) => key.startsWith('$typeKey:'));
    return parse(protocolType);
  }

  /// Returns list of available protocol types by scanning
  /// both assets/protocols/ and the documents override folder.
  static Future<List<String>> availableTypes() async {
    final types = <String>{'ac_acceptance', 'work_order', 'damage_report', 'installation_report'};

    try {
      final dir = await getApplicationDocumentsDirectory();
      final overrideDir = Directory('${dir.path}/protocols');
      if (overrideDir.existsSync()) {
        for (final file in overrideDir.listSync()) {
          if (file is File && file.path.endsWith('.md')) {
            types.add(_typeKeyFromPath(file.path));
          }
        }
      }
    } catch (_) {}

    return types.toList()..sort();
  }

  /// Saves an .md string to the documents override folder.
  static Future<void> saveOverride(String protocolType, String mdContent) async {
    final dir = await getApplicationDocumentsDirectory();
    final overrideDir = Directory('${dir.path}/protocols');
    if (!overrideDir.existsSync()) overrideDir.createSync(recursive: true);

    final file = File('${overrideDir.path}/$protocolType.md');
    await file.writeAsString(mdContent);

    cache.removeWhere((key, _) => key.startsWith('$protocolType:'));
  }

  /// Deletes the documents override, reverting to bundled asset.
  static Future<void> removeOverride(String protocolType) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/protocols/$protocolType.md');
    if (file.existsSync()) await file.delete();

    cache.removeWhere((key, _) => key.startsWith('$protocolType:'));
  }

  // ─── helpers ────────────────────────────────────────────────

  static String _typeKeyFromArg(String arg) {
    return arg.replaceAll('.md', '').replaceAll(RegExp(r'^.*/'), '');
  }

  static String _typeKeyFromPath(String path) {
    return path.split('/').last.replaceAll('.md', '');
  }

  static Future<String> _loadSource(String typeKey) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final overrideFile = File('${dir.path}/protocols/$typeKey.md');
      if (overrideFile.existsSync()) {
        return await overrideFile.readAsString();
      }
    } catch (_) {}

    return await rootBundle.loadString('assets/protocols/$typeKey.md');
  }

  static String _scanVersion(String source) {
    final match = RegExp(r'^version:\s*(.+)$', multiLine: true).firstMatch(source);
    return match?.group(1)?.trim() ?? '0';
  }

  @visibleForTesting
  static ParsedProtocol parseMarkdown(String typeKey, String source) {
    final lines = source.split('\n');
    final frontmatter = <String, String>{};
    final sections = <FormSection>[];
    String bodyStart = '';

    // ── parse frontmatter ──
    if (lines.isNotEmpty && lines[0].trim() == '---') {
      int endIdx = -1;
      for (int i = 1; i < lines.length; i++) {
        if (lines[i].trim() == '---') {
          endIdx = i;
          break;
        }
        final colonPos = lines[i].indexOf(':');
        if (colonPos > 0) {
          final key = lines[i].substring(0, colonPos).trim();
          final value = lines[i].substring(colonPos + 1).trim();
          frontmatter[key] = value;
        }
      }
      if (endIdx > 0) {
        bodyStart = lines.skip(endIdx + 1).join('\n');
      }
    } else {
      bodyStart = source;
    }

    final protocolType = frontmatter['protocol'] ?? typeKey;
    final title = frontmatter['title'] ?? protocolType;
    final titleDe = frontmatter['title_de'];
    final titleAr = frontmatter['title_ar'];
    final version = frontmatter['version'] ?? '1.0';

    // ── parse body ──
    final bodyLines = bodyStart.split('\n');
    List<FormFieldDef>? currentFields;
    List<List<FormFieldDef>>? currentFieldPages;
    String? currentSectionId;
    String? currentSectionLabel;
    bool currentRepeatable = false;
    int currentMin = 1;
    int currentMax = 10;
    bool currentMerged = false;
    FormFieldDef? lastField;

    void _finalizeSection() {
      if (currentSectionId != null && currentFields != null) {
        sections.add(FormSection(
          id: currentSectionId!,
          labelKey: currentSectionLabel ?? currentSectionId!,
          fields: List.from(currentFields!),
          isRepeatable: currentRepeatable,
          minRepeat: currentMin,
          maxRepeat: currentMax,
          merged: currentMerged,
          fieldPages: currentFieldPages != null && currentFieldPages!.length > 1
              ? List.from(currentFieldPages!)
              : const [],
        ));
      }
      currentFields = null;
      currentFieldPages = null;
      currentSectionId = null;
      currentSectionLabel = null;
      currentRepeatable = false;
      currentMin = 1;
      currentMax = 10;
      currentMerged = false;
      lastField = null;
    }

    for (final rawLine in bodyLines) {
      final line = rawLine.trim();

      if (line.isEmpty || (line.startsWith('#') && !line.startsWith('##') && !line.startsWith('+ ##'))) continue;

      // merged section heading
      if (line.startsWith('+ ## ')) {
        _finalizeSection();
        currentSectionLabel = line.substring(4).trim();
        currentFields = [];
        currentFieldPages = [[]];
        currentMerged = true;
        continue;
      }

      // section heading
      if (line.startsWith('## ')) {
        _finalizeSection();
        currentSectionLabel = line.substring(3).trim();
        currentFields = [];
        currentFieldPages = [[]];
        continue;
      }

      // page break within a section
      if (line == '---') {
        if (currentFieldPages != null) {
          currentFieldPages!.add([]);
        }
        continue;
      }

      // section metadata
      if (line.startsWith('section_id:')) {
        currentSectionId = line.substring('section_id:'.length).trim();
        continue;
      }
      if (line.startsWith('repeatable:')) {
        currentRepeatable = _parseBool(line.substring('repeatable:'.length).trim());
        continue;
      }
      if (line.startsWith('min:')) {
        currentMin = int.tryParse(line.substring('min:'.length).trim()) ?? 1;
        continue;
      }
      if (line.startsWith('max:')) {
        currentMax = int.tryParse(line.substring('max:'.length).trim()) ?? 10;
        continue;
      }

      // field line
      if (line.startsWith('- ')) {
        final fieldParts = line.substring(2).split('|').map((s) => s.trim()).toList();
        if (fieldParts.length >= 4) {
          final fieldId = fieldParts[0];
          final fieldType = _parseFieldType(fieldParts[1]);
          final required = fieldParts[2].toLowerCase() == 'required';
          final label = fieldParts[3];
          final labelDe = fieldParts.length > 4 ? fieldParts[4] : null;
          final labelAr = fieldParts.length > 5 ? fieldParts[5] : null;

          lastField = FormFieldDef(
            id: fieldId,
            labelKey: label,
            type: fieldType,
            required: required,
            labelDe: labelDe,
            labelAr: labelAr,
          );
          currentFields?.add(lastField!);
          if (currentFieldPages != null && currentFieldPages!.isNotEmpty) {
            currentFieldPages!.last.add(lastField!);
          }
        }
        continue;
      }

      // options line
      if (line.startsWith('options:') && lastField != null && lastField!.type == FieldType.dropdown) {
        final idx = currentFields!.indexOf(lastField!);
        if (idx >= 0) {
          final opts = line.substring('options:'.length).split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
          final updated = FormFieldDef(
            id: lastField!.id,
            labelKey: lastField!.labelKey,
            type: lastField!.type,
            required: lastField!.required,
            dropdownOptions: opts,
            showIfField: lastField!.showIfField,
            showIfOperator: lastField!.showIfOperator,
            showIfValue: lastField!.showIfValue,
            labelDe: lastField!.labelDe,
            labelAr: lastField!.labelAr,
          );
          currentFields![idx] = updated;
          _syncFieldToPages(lastField!, updated, currentFieldPages);
        }
        continue;
      }

      // show_if line
      if (line.startsWith('show_if:') && lastField != null) {
        final expr = line.substring('show_if:'.length).trim();
        final eqMatch = RegExp(r'^(\S+)\s*==\s*(.+)$').firstMatch(expr);
        final neqMatch = RegExp(r'^(\S+)\s*!=\s*(.+)$').firstMatch(expr);
        final match = eqMatch ?? neqMatch;
        if (match != null) {
          final showFieldId = match.group(1)!.trim();
          final op = eqMatch != null ? '==' : '!=';
          final showVal = match.group(2)!.trim().replaceAll('"', '').replaceAll("'", '');

          final idx = currentFields!.indexOf(lastField!);
          if (idx >= 0) {
            final updated = FormFieldDef(
              id: lastField!.id,
              labelKey: lastField!.labelKey,
              type: lastField!.type,
              required: lastField!.required,
              dropdownOptions: lastField!.dropdownOptions,
              showIfField: showFieldId,
              showIfOperator: op,
              showIfValue: showVal,
              labelDe: lastField!.labelDe,
              labelAr: lastField!.labelAr,
            );
            currentFields![idx] = updated;
            _syncFieldToPages(lastField!, updated, currentFieldPages);
          }
        }
        continue;
      }
    }

    _finalizeSection();

    if (sections.isEmpty && source.trim().isNotEmpty &&
        !source.trim().startsWith('---') &&
        !source.contains('\n## ')) {
      return errorResult(typeKey, 'Malformed protocol definition: no valid sections found');
    }

    return ParsedProtocol(
      type: protocolType,
      title: title,
      titleDe: titleDe,
      titleAr: titleAr,
      version: version,
      sections: sections,
    );
  }

  @visibleForTesting
  static ParsedProtocol errorResult(String typeKey, String message) {
    return ParsedProtocol(
      type: typeKey,
      title: 'Error',
      version: '0',
      sections: [
        FormSection(
          id: 'error',
          labelKey: 'Parse Error',
          fields: [
            FormFieldDef(
              id: 'error_msg',
              labelKey: message,
              type: FieldType.text,
            ),
          ],
        ),
      ],
    );
  }

  static FieldType _parseFieldType(String raw) {
    switch (raw.toLowerCase()) {
      case 'text':
      case 'email':
        return FieldType.text;
      case 'number':
        return FieldType.number;
      case 'date':
        return FieldType.date;
      case 'time':
        return FieldType.time;
      case 'checkbox':
        return FieldType.checkbox;
      case 'dropdown':
        return FieldType.dropdown;
      case 'photo':
        return FieldType.photo;
      case 'signature':
        return FieldType.signature;
      case 'textarea':
        return FieldType.textarea;
      default:
        return FieldType.text;
    }
  }

  static bool _parseBool(String raw) {
    return raw.toLowerCase() == 'true' || raw == '1';
  }

  /// Replaces all occurrences of [oldField] with [newField] in [pages].
  static void _syncFieldToPages(FormFieldDef oldField, FormFieldDef newField, List<List<FormFieldDef>>? pages) {
    if (pages == null) return;
    for (final page in pages) {
      for (int i = 0; i < page.length; i++) {
        if (identical(page[i], oldField)) {
          page[i] = newField;
        }
      }
    }
  }
}
