import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mam_solar/core/parsers/protocol_md_parser.dart';

void main() {
  test('ac_acceptance.md parses into the BSH structure with show_if logic', () {
    final source =
        File('assets/protocols/ac_acceptance.md').readAsStringSync();
    final parsed = ProtocolMdParser.parseMarkdown('ac_acceptance', source);

    // Not an error result, correct title.
    expect(parsed.sections.any((s) => s.id == 'error'), isFalse,
        reason: 'parser returned an error result');
    expect(parsed.titleDe, 'AC-Abnahmeprotokoll');

    // All 9 BSH sections present (IBN split into two: meters + rest).
    final ids = parsed.sections.map((s) => s.id).toList();
    expect(
      ids,
      containsAll(<String>[
        'customer_data',
        'inverter',
        'storage',
        'potential_rail',
        'meter_cabinet',
        'meter_ibn_meters',
        'meter_ibn',
        'heat_pump',
        'cable_routes',
        'cleanliness',
        'completion',
      ]),
    );

    // Repeatable sections.
    expect(parsed.sections.firstWhere((s) => s.id == 'inverter').isRepeatable,
        isTrue);
    expect(parsed.sections.firstWhere((s) => s.id == 'storage').isRepeatable,
        isTrue);
    expect(
        parsed.sections.firstWhere((s) => s.id == 'meter_ibn_meters')
            .isRepeatable,
        isTrue);

    // Global gate: Wallbox installiert? Ja -> photoWallbox.
    final cust = parsed.sections.firstWhere((s) => s.id == 'customer_data');
    final photoWallbox = cust.fields.firstWhere((f) => f.id == 'photoWallbox');
    expect(photoWallbox.showIfField, 'wallboxInstalliert');
    expect(photoWallbox.showIfValue, 'Ja');
    expect(photoWallbox.isVisible({'wallboxInstalliert': 'Nein'}), isFalse);
    expect(photoWallbox.isVisible({'wallboxInstalliert': 'Ja'}), isTrue);

    // OR gate inside the repeatable storage item (module 2 shown for 2/3/4).
    final storage = parsed.sections.firstWhere((s) => s.id == 'storage');
    final mod2 =
        storage.fields.firstWhere((f) => f.id == 'photoModul2Aufgesteckt');
    expect(mod2.showIfValues, containsAll(<String>['2', '3', '4']));
    expect(mod2.isVisible({'anzahlAkkumodule': '1'}), isFalse);
    expect(mod2.isVisible({'anzahlAkkumodule': '3'}), isTrue);

    // Kabelweg über 25m? Ja -> zusätzliche Meter.
    final cable = parsed.sections.firstWhere((s) => s.id == 'cable_routes');
    final meters = cable.fields.firstWhere((f) => f.id == 'zusaetzlicheMeter');
    expect(meters.isVisible({'kabelwegUeber25m': 'Nein'}), isFalse);
    expect(meters.isVisible({'kabelwegUeber25m': 'Ja'}), isTrue);
  });
}
