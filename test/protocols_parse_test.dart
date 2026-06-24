import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mam_solar/core/parsers/protocol_md_parser.dart';
import 'package:mam_solar/features/pdf/generators/generic_protocol_pdf_generator.dart';

void main() {
  // Every bundled protocol must parse cleanly (no error result).
  const allTypes = [
    'ac_acceptance',
    'dc_acceptance',
    'work_order',
    'damage_report',
    'installation_report',
  ];

  for (final type in allTypes) {
    test('$type parses without an error section', () {
      final source = File('assets/protocols/$type.md').readAsStringSync();
      final parsed = ProtocolMdParser.parseMarkdown(type, source);
      expect(parsed.sections.any((s) => s.id == 'error'), isFalse,
          reason: '$type returned a parse error');
      expect(parsed.sections, isNotEmpty);
    });
  }

  test('parser keeps BOTH options and show_if on the same field', () {
    // Regression guard: when a field carried `options:` immediately followed by
    // `show_if:`, the stale lastField reference dropped the show_if. DC's
    // tilesProcessedCorrectly is radio (Ja/Nein) AND gated on roofType == Ziegel.
    final source =
        File('assets/protocols/dc_acceptance.md').readAsStringSync();
    final parsed = ProtocolMdParser.parseMarkdown('dc_acceptance', source);

    final tiles =
        parsed.sections.firstWhere((s) => s.id == 'tiles_substructure');
    final f = tiles.fields.firstWhere((x) => x.id == 'tilesProcessedCorrectly');

    expect(f.dropdownOptions, containsAll(<String>['Ja', 'Nein']),
        reason: 'options were lost');
    expect(f.showIfField, 'roofType', reason: 'show_if was lost');
    expect(f.isVisible({'roofType': 'Blech'}), isFalse);
    expect(f.isVisible({'roofType': 'Ziegel'}), isTrue);
  });

  test('DC gates expose conditional follow-ups (Ja/Nein -> photo/note)', () {
    final source =
        File('assets/protocols/dc_acceptance.md').readAsStringSync();
    final parsed = ProtocolMdParser.parseMarkdown('dc_acceptance', source);

    // gutterCleaned == Ja -> photosGutter ; == Nein -> note
    final completion = parsed.sections.firstWhere((s) => s.id == 'completion');
    final photos = completion.fields.firstWhere((f) => f.id == 'photosGutter');
    final note =
        completion.fields.firstWhere((f) => f.id == 'gutterNotCleanedHinweis');
    expect(photos.isVisible({'gutterCleaned': 'Ja'}), isTrue);
    expect(photos.isVisible({'gutterCleaned': 'Nein'}), isFalse);
    expect(note.isVisible({'gutterCleaned': 'Nein'}), isTrue);
    expect(note.isVisible({'gutterCleaned': 'Ja'}), isFalse);
  });

  test('work_order matches the BSH Regie structure', () {
    final source = File('assets/protocols/work_order.md').readAsStringSync();
    final parsed = ProtocolMdParser.parseMarkdown('work_order', source);

    expect(parsed.titleDe, 'Regie-/Arbeitsauftrag');
    final ids = parsed.sections.map((s) => s.id).toList();
    expect(
      ids,
      containsAll(<String>[
        'customer_data',
        'work_description',
        'completion',
        'work_photos',
        'signatures',
      ]),
    );

    // customerName so completed-search works; Ja/Nein completion gate.
    final cust = parsed.sections.firstWhere((s) => s.id == 'customer_data');
    expect(cust.fields.any((f) => f.id == 'customerName'), isTrue);
    final completion = parsed.sections.firstWhere((s) => s.id == 'completion');
    final reason = completion.fields.firstWhere((f) => f.id == 'reason');
    expect(reason.isVisible({'arbeitAbgeschlossen': 'Nein'}), isTrue);
    expect(reason.isVisible({'arbeitAbgeschlossen': 'Ja'}), isFalse);
  });

  test('installation_report (Aufmaß) has all BSH sections + show_if', () {
    final source =
        File('assets/protocols/installation_report.md').readAsStringSync();
    final parsed = ProtocolMdParser.parseMarkdown('installation_report', source);

    expect(parsed.titleDe, 'Aufmaßprotokoll');
    final ids = parsed.sections.map((s) => s.id).toList();
    expect(
      ids,
      containsAll(<String>[
        'customer_data',
        'roof',
        'roof_surfaces',
        'dc_cable_route',
        'electrical',
        'additional_meters',
        'signal_measurement',
        'storage_inverter',
        'earthing',
        'internet',
        'wallbox',
        'blackout',
        'organizational',
        'special_planning',
        'heat_pump',
        'completion',
      ]),
    );

    // Repeatable roof surfaces + additional meters.
    expect(parsed.sections.firstWhere((s) => s.id == 'roof_surfaces')
        .isRepeatable, isTrue);
    expect(parsed.sections.firstWhere((s) => s.id == 'additional_meters')
        .isRepeatable, isTrue);

    // In-item gate inside the repeatable roof surface: Sichtsparren? Ja -> photo.
    final surf = parsed.sections.firstWhere((s) => s.id == 'roof_surfaces');
    final sicht =
        surf.fields.firstWhere((f) => f.id == 'photoSichtsparren');
    expect(sicht.isVisible({'sichtsparren': 'Ja'}), isTrue);
    expect(sicht.isVisible({'sichtsparren': 'Nein'}), isFalse);

    // Global gate: Wallbox beauftragt? Ja -> mounting photos.
    final wb = parsed.sections.firstWhere((s) => s.id == 'wallbox');
    final wbPhoto =
        wb.fields.firstWhere((f) => f.id == 'photoWallboxMontageort');
    expect(wbPhoto.isVisible({'wallboxBeauftragt': 'Ja'}), isTrue);
    expect(wbPhoto.isVisible({'wallboxBeauftragt': 'Nein'}), isFalse);
  });

  test('Generic PDF renders work_order and installation_report', () async {
    for (final type in ['work_order', 'installation_report']) {
      final source = File('assets/protocols/$type.md').readAsStringSync();
      final parsed = ProtocolMdParser.parseMarkdown(type, source);
      final doc = GenericProtocolPdfGenerator.generate(
        protocolId: 1,
        title: parsed.titleDe ?? parsed.title,
        typeCode: type == 'work_order' ? 'PR' : 'AUF',
        customerName: 'Max Mustermann',
        sections: parsed.sections,
        data: <String, dynamic>{
          'customerName': 'Max Mustermann',
          'street': 'Teststraße 1',
          'email': 'max@example.de',
        },
        repeatableData: const <String, List<Map<String, dynamic>>>{},
      );
      final bytes = await doc.save();
      expect(bytes.length, greaterThan(1500), reason: '$type PDF too small');
    }
  });
}
