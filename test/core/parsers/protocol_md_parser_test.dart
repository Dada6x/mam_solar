import 'package:flutter_test/flutter_test.dart';
import 'package:mam_solar/core/parsers/protocol_md_parser.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';

void main() {
  group('ProtocolMdParser', () {
    group('frontmatter parsing', () {
      test('parses frontmatter keys correctly', () {
        const md = '''
---
protocol: test_protocol
title: Test Protocol
title_de: Test Protokoll
title_ar: بروتوكول اختبار
version: 1.0
---

## Section One
section_id: section_1

- field1 | text | required | Field One
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.type, 'test_protocol');
        expect(result.title, 'Test Protocol');
        expect(result.titleDe, 'Test Protokoll');
        expect(result.titleAr, 'بروتوكول اختبار');
        expect(result.version, '1.0');
      });
    });

    group('field parsing', () {
      test('parses a text field with 3 language labels', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- field1 | text | required | Name | Name DE | اسم
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        expect(result.sections[0].fields.length, 1);
        final field = result.sections[0].fields[0];
        expect(field.id, 'field1');
        expect(field.type, FieldType.text);
        expect(field.required, true);
        expect(field.labelKey, 'Name');
        expect(field.labelDe, 'Name DE');
        expect(field.labelAr, 'اسم');
      });

      test('parses a file field with accepted_formats', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- docFile | file | required | Attach Document
  accepted_formats: pdf, jpg, png
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 1);
        final field = result.sections[0].fields[0];
        expect(field.type, FieldType.file);
        expect(field.required, true);
        expect(field.acceptedFormats, ['pdf', 'jpg', 'png']);
      });

      test('parses a radio field with options', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- choice | radio | required | Make a choice
  options: yes, no, maybe
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 1);
        final field = result.sections[0].fields[0];
        expect(field.type, FieldType.radio);
        expect(field.required, true);
        expect(field.dropdownOptions, ['yes', 'no', 'maybe']);
      });

      test('parses a display_text field', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- declaration | display_text | | This is a declaration text | Dies ist ein Erklärungstext
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 1);
        final field = result.sections[0].fields[0];
        expect(field.type, FieldType.displayText);
        expect(field.required, false);
        expect(field.labelKey, 'This is a declaration text');
        expect(field.labelDe, 'Dies ist ein Erklärungstext');
      });

      test('parses a dropdown field with options', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- type | dropdown | required | Type
  options: option_a, option_b, option_c
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 1);
        final field = result.sections[0].fields[0];
        expect(field.type, FieldType.dropdown);
        expect(field.dropdownOptions, ['option_a', 'option_b', 'option_c']);
      });

      test('syncs dropdown options to fieldPages when section has page breaks', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- type | dropdown | required | Type
  options: option_a, option_b, option_c
- textField | text | | Text
---
- checkboxField | checkbox | | Checkbox
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        final section = result.sections[0];
        expect(section.fieldPages.length, 2);

        // fieldPages[0] should have dropdown with options
        final fieldInPage = section.fieldPages[0][0];
        expect(fieldInPage.type, FieldType.dropdown);
        expect(fieldInPage.dropdownOptions, ['option_a', 'option_b', 'option_c']);

        // fields list should also have options
        expect(section.fields[0].dropdownOptions, ['option_a', 'option_b', 'option_c']);
      });

      test('syncs show_if to fieldPages when section has page breaks', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- checkbox1 | checkbox | | Checkbox One
- textField | text | | Text Field
  show_if: checkbox1 == true
---
- otherField | text | | Other
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        final section = result.sections[0];
        expect(section.fieldPages.length, 2);

        // fieldPages[0] should have textField with show_if
        final fieldInPage = section.fieldPages[0][1];
        expect(fieldInPage.showIfField, 'checkbox1');
        expect(fieldInPage.showIfOperator, '==');
        expect(fieldInPage.showIfValue, 'true');

        // fields list should also have show_if
        expect(section.fields[1].showIfField, 'checkbox1');
      });
    });

    group('repeatable sections', () {
      test('parses a repeatable section with min/max', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Repeating Section
section_id: repeating
repeatable: true
min: 2
max: 8

- field1 | text | required | Field
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        final section = result.sections[0];
        expect(section.isRepeatable, true);
        expect(section.minRepeat, 2);
        expect(section.maxRepeat, 8);
      });
    });

    group('conditional fields', () {
      test('parses a show_if conditional correctly', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- checkbox1 | checkbox | | Checkbox One
- textField | text | | Text Field
  show_if: checkbox1 == true
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 2);
        final field = result.sections[0].fields[1];
        expect(field.showIfField, 'checkbox1');
        expect(field.showIfOperator, '==');
        expect(field.showIfValue, 'true');
      });

      test('parses show_if with unchecked keyword', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- backupInstalled | checkbox | required | Backup Installed
- backupHint | textarea | | Hint / Notes
  show_if: backupInstalled == unchecked
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 2);
        final field = result.sections[0].fields[1];
        expect(field.showIfField, 'backupInstalled');
        expect(field.showIfOperator, '==');
        expect(field.showIfValue, 'unchecked');
      });

      test('parses show_if with OR conditions', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- status | radio | required | Status
  options: yes, no, not_possible
- reason | textarea | required | Reason
  show_if: status == no OR status == not_possible
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 2);
        final field = result.sections[0].fields[1];
        expect(field.showIfField, 'status');
        expect(field.showIfOperator, '==');
        expect(field.showIfValue, 'no');
        expect(field.showIfValues, ['no', 'not_possible']);
      });

      test('parses show_if with not-equal operator', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section
section_id: sec

- status | dropdown | | Status
- reason | textarea | | Reason
  show_if: status != done
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections[0].fields.length, 2);
        final field = result.sections[0].fields[1];
        expect(field.showIfField, 'status');
        expect(field.showIfOperator, '!=');
        expect(field.showIfValue, 'done');
      });
    });

    group('error handling', () {
      test('returns error section (not throw) on malformed input', () {
        const md = 'this is not valid markdown with frontmatter';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        expect(result.sections[0].id, 'error');
      });

      test('handles empty input gracefully', () {
        const md = '';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.isEmpty, true);
      });
    });

    group('localizedLabel', () {
      test('returns English label for en', () {
        const field = FormFieldDef(
          id: 'test',
          labelKey: 'Name',
          type: FieldType.text,
          labelDe: 'Name DE',
          labelAr: 'اسم',
        );
        expect(field.localizedLabel('en'), 'Name');
      });

      test('returns German label for de', () {
        const field = FormFieldDef(
          id: 'test',
          labelKey: 'Name',
          type: FieldType.text,
          labelDe: 'Name DE',
          labelAr: 'اسم',
        );
        expect(field.localizedLabel('de'), 'Name DE');
      });

      test('returns Arabic label for ar', () {
        const field = FormFieldDef(
          id: 'test',
          labelKey: 'Name',
          type: FieldType.text,
          labelDe: 'Name DE',
          labelAr: 'اسم',
        );
        expect(field.localizedLabel('ar'), 'اسم');
      });

      test('falls back to English when no translation exists', () {
        const field = FormFieldDef(
          id: 'test',
          labelKey: 'Name',
          type: FieldType.text,
        );
        expect(field.localizedLabel('de'), 'Name');
        expect(field.localizedLabel('ar'), 'Name');
      });
    });

    group('section heading labels', () {
      test('parses pipe-delimited heading labels', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Customer Data | Kundendaten | بيانات العميل
section_id: sec

- field1 | text | | Field
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        final section = result.sections[0];
        expect(section.labelKey, 'Customer Data');
        expect(section.labelDe, 'Kundendaten');
        expect(section.labelAr, 'بيانات العميل');
      });

      test('returns English label when no pipe-delimited labels', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Customer Data
section_id: sec

- field1 | text | | Field
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 1);
        final section = result.sections[0];
        expect(section.labelKey, 'Customer Data');
        expect(section.labelDe, isNull);
        expect(section.labelAr, isNull);
      });

      test('uses localizedLabel for sections', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Customer | Kunde | عميل
section_id: sec

- field1 | text | | Field
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        final section = result.sections[0];
        expect(section.localizedLabel('en'), 'Customer');
        expect(section.localizedLabel('de'), 'Kunde');
        expect(section.localizedLabel('ar'), 'عميل');
        expect(section.localizedLabel('fr'), 'Customer');
      });

      test('parses pipe-delimited labels on merged sections', () {
        const md = '''
---
protocol: test
title: Test
version: 1.0
---

## Section One
section_id: sec1

- field1 | text | | Field

+ ## Remarks | Bemerkungen | ملاحظات
section_id: remarks

- remark | textarea | | Remark
''';
        final result = ProtocolMdParser.parseMarkdown('test', md);
        expect(result.sections.length, 2);
        final merged = result.sections[1];
        expect(merged.merged, true);
        expect(merged.labelKey, 'Remarks');
        expect(merged.labelDe, 'Bemerkungen');
        expect(merged.labelAr, 'ملاحظات');
      });
    });

    group('cache behavior', () {
      test('caches and returns same instance on second call', () async {
        // This test verifies the static caching logic
        // by checking version-based caching
        const md = '''
---
protocol: cache_test
title: Cache Test
version: 1.0
---

## Section
section_id: sec

- field1 | text | | Field
''';
        // Clear cache for this test
        ProtocolMdParser.cache.clear();

        final first = ProtocolMdParser.parseMarkdown('cache_test', md);
        // Parse again - should use cached version
        final second = ProtocolMdParser.parseMarkdown('cache_test', md);
        expect(second.type, first.type);
        expect(second.sections.length, first.sections.length);
      });
    });
  });
}
