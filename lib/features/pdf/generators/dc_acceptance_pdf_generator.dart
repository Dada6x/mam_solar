import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class DcAcceptancePdfGenerator {
  static const _expectedFlatKeys = [
    // Customer Data
    'installationDate', 'foreman', 'customerName',
    'street', 'houseNumber', 'zipCode', 'installationCity', 'email',
    'foremanIntroduced', 'shoeCoversWorn', 'guestTowelGifted',
    'doormatGifted', 'photoTowelDoormat',

    // Scaffold
    'suitableScaffoldUsed', 'roofSurfacesCount', 'scaffoldType',

    // Acceptance
    'acceptanceResult', 'defectsDescription', 'defectsPhotos',

    // Installation Documentation
    'systemType', 'senecStorage', 'moduleCount', 'moduleManufacturer',
    'moduleLabel', 'nominalPowerKwp', 'photoModuleLabel',
    'preexistingDamage', 'preexistingDamageDescription',
    'preexistingDamagePhotos', 'roofType',

    // Tiles & Substructure
    'tilesProcessedCorrectly', 'fixingPointsPerDoc',

    // Flat Vents
    'flatVentsInstalled', 'photoFlatVents',

    // Modules
    'moduleSurfacesCount', 'externalInverters', 'photoExternalInverters',

    // Cable Routing
    'cableRoutedThrough', 'photoCableRouting', 'cableUnderTiles',
    'wallBreakthrough', 'photoSealedBreakthrough', 'breakthroughSealed',
    'vaporBarrierSealed', 'photosDcRouteOutside', 'photosDcRouteInside',

    // DC Surge Protection
    'surgeProtectionNeeded', 'photoSurgeProtection',

    // DC Measurements
    'stringCount', 'photoDcConnectionsInverter',

    // Completion
    'allDetailsRecorded', 'gutterCleaned', 'photosGutter',

    // Signatures
    'location', 'completionDateTime', 'noticePeriod',
    'customerFullName', 'customerSignature', 'foremanSignature', 'emailSentTo',
  ];

  static const _expectedRepeatableKeys = {
    'scaffold_photos': [
      'scaffoldPhotoFront',
      'scaffoldPhotoTop',
    ],
    'roof_surface_docs': [
      'photoFinishedSubstructure',
      'safetyDistanceKept',
      'photoSafetyDistance',
      'cablesFixedToRail',
      'photoCableFixing',
      'substructureEarthed',
      'photoEarthingUk',
      'photoAluPerforatedTape',
      'photoPotentialRail',
      'railsEarthed',
      'cableEntrySealed',
      'photoSealing',
      'photoCableEntryTile',
    ],
    'module_surface_docs': [
      'photoFinishedModuleSurface',
      'photoStringPlan',
      'stringPlanMarked',
      'stringPlanMatchesLayout',
      'photoWiringDrawing',
      'photoModuleUnderside',
    ],
    'string_measurements': [
      'photoMeasurement',
      'stringNumberAndValue',
    ],
    'additional_info': ['note', 'image'],
  };

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(
      data,
      'DcAcceptancePdfGenerator',
      _expectedFlatKeys,
    );
    PdfGeneratorBase.logExpectedRepeatableFields(
      repeatableData,
      'DcAcceptancePdfGenerator',
      _expectedRepeatableKeys,
    );

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'DC',
      DateTime.now(),
      protocolId,
    );

    final sections = [
      _buildCustomerDataSection(data),
      _buildScaffoldSection(data, repeatableData),
      _buildAcceptanceSection(data),
      _buildInstallationDocumentationSection(data),
      _buildTilesSubstructureSection(data),
      _buildRoofSurfaceDocsSection(repeatableData),
      _buildFlatVentsSection(data),
      _buildModulesSection(data, repeatableData),
      _buildCableRoutingSection(data),
      _buildDcSurgeProtectionSection(data),
      _buildDcMeasurementsSection(data, repeatableData),
      _buildCompletionSection(data),
      _buildAdditionalInfoSection(repeatableData),
      _buildSignaturesSection(data),
    ].whereType<pw.Widget>().toList();

    return PdfGeneratorBase.createDocument(
      title: 'DC-Abnahmeprotokoll',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: sections,
    );
  }

  static pw.Widget? _buildCustomerDataSection(Map<String, dynamic> data) {
    final fields = [
      ..._field('Installationsdatum', data['installationDate']),
      ..._field('Vorarbeiter/Partner', data['foreman']),
      ..._field('Kunde', data['customerName']),
      ..._field('Straße', data['street']),
      ..._field('Hausnummer', data['houseNumber']),
      ..._field('PLZ', data['zipCode']),
      ..._field('Montageort', data['installationCity']),
      ..._field('E-Mail', data['email']),
      ..._checkbox('Vorarbeiter namentlich vorgestellt?', data['foremanIntroduced']),
      ..._checkbox('Schuhüberzieher getragen?', data['shoeCoversWorn']),
      ..._checkbox('Gästehandtuch aufgehängt/geschenkt?', data['guestTowelGifted']),
      ..._checkbox('Fußmatte erhalten?', data['doormatGifted']),
      ..._photo('Handtuch & Fußmatte', data['photoTowelDoormat']),
    ];
    return _section('Kundendaten', fields);
  }

  static pw.Widget? _buildScaffoldSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[
      ..._checkbox('Geeignetes Gerüst verwendet', data['suitableScaffoldUsed']),
      ..._field('Anzahl Dachflächen', data['roofSurfacesCount']),
      ..._field('Gerüsttyp', data['scaffoldType']),
    ];

    final photos = repeatableData['scaffold_photos'] ?? [];
    for (var i = 0; i < photos.length; i++) {
      final item = photos[i];
      final itemFields = [
        ..._photo('Frontal', item['scaffoldPhotoFront']),
        ..._photo('Von oben (ganze Breite)', item['scaffoldPhotoTop']),
      ];
      if (itemFields.isNotEmpty) {
        fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'Dachseite #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('1. Gerüst', fields);
  }

  static pw.Widget? _buildAcceptanceSection(Map<String, dynamic> data) {
    final fields = [
      ..._fieldMapped('Abnahme erfolgt', data['acceptanceResult'], _acceptanceResult),
      ..._field('Beschreibung der Mängel', data['defectsDescription']),
      ..._photo('Fotos der Mängel', data['defectsPhotos']),
    ];
    return _section('2. Abnahmeprotokoll', fields);
  }

  static pw.Widget? _buildInstallationDocumentationSection(
    Map<String, dynamic> data,
  ) {
    final fields = [
      ..._fieldMapped('Anlagentyp', data['systemType'], _systemType),
      ..._fieldMapped('Senec Speicher', data['senecStorage'], _senecStorage),
      ..._field('Anzahl Module', data['moduleCount']),
      ..._field('Modul Hersteller/Typ', data['moduleManufacturer']),
      ..._field('Modulbezeichnung', data['moduleLabel']),
      ..._field('Nennleistung (kWp)', data['nominalPowerKwp']),
      ..._photo('Typenschild Module', data['photoModuleLabel']),
      ..._checkbox('Vorschäden vorhanden?', data['preexistingDamage']),
      ..._field('Beschreibung Vorschäden', data['preexistingDamageDescription']),
      ..._photo('Fotos Vorschäden', data['preexistingDamagePhotos']),
      ..._fieldMapped('Dachtyp', data['roofType'], _roofType),
    ];
    return _section('3. Montagedokumentation', fields);
  }

  static pw.Widget? _buildTilesSubstructureSection(Map<String, dynamic> data) {
    final fields = [
      ..._checkbox('Ziegel richtig bearbeitet', data['tilesProcessedCorrectly']),
      ..._checkbox('Befestigungspunkte nach Dokumentation', data['fixingPointsPerDoc']),
    ];
    return _section('Ziegel & Unterkonstruktion', fields);
  }

  static pw.Widget? _buildRoofSurfaceDocsSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final docs = repeatableData['roof_surface_docs'] ?? [];
    final fields = <pw.Widget>[];

    for (var i = 0; i < docs.length; i++) {
      final item = docs[i];
      final itemFields = [
        ..._photo('Fertiges Dach mit Befestigungspunkten', item['photoFinishedSubstructure']),
        ..._checkbox('Sicherheitsabstand eingehalten', item['safetyDistanceKept']),
        ..._photo('Sicherheitsabstand Haken/Ziegel', item['photoSafetyDistance']),
        ..._checkbox('Kabel/Stecker an Schiene befestigt', item['cablesFixedToRail']),
        ..._photo('Befestigung Kabel/Stecker', item['photoCableFixing']),
        ..._checkbox('Erdung Unterkonstruktion durchgeführt', item['substructureEarthed']),
        ..._photo('Erdung UK (Klemme + Brücken)', item['photoEarthingUk']),
        ..._photo('Alu-Lochband', item['photoAluPerforatedTape']),
        ..._photo('Potentialausgleichsschiene', item['photoPotentialRail']),
        ..._checkbox('Schienen geerdet', item['railsEarthed']),
        ..._checkbox('Kabeleinführung abgedichtet', item['cableEntrySealed']),
        ..._photo('Abdichtung/Durchführung', item['photoSealing']),
        ..._photo('Kabeleinführung unter Ziegel', item['photoCableEntryTile']),
      ];
      if (itemFields.isNotEmpty) {
        if (fields.isNotEmpty) fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'Dachfläche #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('3a. Dachflächen-Dokumentation', fields);
  }

  static pw.Widget? _buildFlatVentsSection(Map<String, dynamic> data) {
    final fields = [
      ..._checkbox('Flachlüfter verbaut?', data['flatVentsInstalled']),
      ..._photo('Fotos Flachlüfter', data['photoFlatVents']),
    ];
    return _section('Flachlüfter', fields);
  }

  static pw.Widget? _buildModulesSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[
      ..._field('Anzahl Modulflächen', data['moduleSurfacesCount']),
      ..._checkbox('Externe Wechselrichter verbaut?', data['externalInverters']),
      ..._photo('Fotos externe Wechselrichter', data['photoExternalInverters']),
    ];

    final docs = repeatableData['module_surface_docs'] ?? [];
    for (var i = 0; i < docs.length; i++) {
      final item = docs[i];
      final itemFields = [
        ..._photo('Fertige Modulfläche', item['photoFinishedModuleSurface']),
        ..._photo('Stringplan', item['photoStringPlan']),
        ..._checkbox('Stringplan mit + / - markiert', item['stringPlanMarked']),
        ..._checkbox('Stringplan identisch mit Dachbelegung?', item['stringPlanMatchesLayout']),
        ..._photo('Verschaltung eingezeichnet', item['photoWiringDrawing']),
        ..._photo('Modulfläche Unterseite', item['photoModuleUnderside']),
      ];
      if (itemFields.isNotEmpty) {
        fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'Modulfläche #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('4. Module', fields);
  }

  static pw.Widget? _buildCableRoutingSection(Map<String, dynamic> data) {
    final fields = [
      ..._fieldMapped('Kabelverlegung durch', data['cableRoutedThrough'], _cableRoutedThrough),
      ..._photo('Kabelverlegung', data['photoCableRouting']),
      ..._checkbox('Kabel unter Ziegeln?', data['cableUnderTiles']),
      ..._checkbox('Wanddurchbruch?', data['wallBreakthrough']),
      ..._photo('Abgedichteter Durchbruch', data['photoSealedBreakthrough']),
      ..._checkbox('Durchbruch abgedichtet', data['breakthroughSealed']),
      ..._checkbox('Durchführungen Dampfbremse abgedichtet', data['vaporBarrierSealed']),
      ..._photo('DC-Kabelweg Außenbereich', data['photosDcRouteOutside']),
      ..._photo('DC-Kabelweg Innenbereich', data['photosDcRouteInside']),
    ];
    return _section('5. Kabelverlegung', fields);
  }

  static pw.Widget? _buildDcSurgeProtectionSection(Map<String, dynamic> data) {
    final fields = [
      ..._fieldMapped('Überspannungsschutz benötigt?', data['surgeProtectionNeeded'], _surgeProtectionNeeded),
      ..._photo('Überspannungsschutz', data['photoSurgeProtection']),
    ];
    return _section('6. DC-ÜSS', fields);
  }

  static pw.Widget? _buildDcMeasurementsSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[
      ..._field('Anzahl Strings', data['stringCount']),
      ..._photo('DC-Leitungen am WR/Speicher', data['photoDcConnectionsInverter']),
    ];

    final measurements = repeatableData['string_measurements'] ?? [];
    for (var i = 0; i < measurements.length; i++) {
      final item = measurements[i];
      final itemFields = [
        ..._photo('Messresultat', item['photoMeasurement']),
        ..._field('Stringnummer & Messwert', item['stringNumberAndValue']),
      ];
      if (itemFields.isNotEmpty) {
        fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'String-Messung #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('7. Messungen DC', fields);
  }

  static pw.Widget? _buildCompletionSection(Map<String, dynamic> data) {
    final fields = [
      ..._checkbox('Alle Details aufgenommen & besprochen', data['allDetailsRecorded']),
      ..._checkbox('Dachrinne gereinigt?', data['gutterCleaned']),
      ..._photo('Fotos Dachrinnen', data['photosGutter']),
    ];
    return _section('8. Abschluss', fields);
  }

  static pw.Widget _buildAdditionalInfoSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final entries = repeatableData['additional_info'] ?? [];
    final fields = <pw.Widget>[];

    if (entries.isEmpty) {
      fields.add(
        PdfGeneratorBase.buildFieldRow('Zusatzinformationen', 'Keine'),
      );
    } else {
      for (var i = 0; i < entries.length; i++) {
        final e = entries[i];
        fields.add(
          pw.Text(
            'Eintrag #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Hinweis',
            PdfGeneratorBase.safeString(e['note']),
          ),
        );
        fields.add(PdfGeneratorBase.buildPhotoField('Bild', e['image']));
        if (i < entries.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Zusätzliche Informationen', fields);
  }

  static pw.Widget? _buildSignaturesSection(Map<String, dynamic> data) {
    final fields = [
      ..._field('Ort', data['location']),
      ..._field('Datum/Zeit', data['completionDateTime']),
      if (data['noticePeriod'] != null)
        PdfGeneratorBase.buildDisplayTextField(
          'Die Widerspruchsfrist beträgt 14 Tage; nach Ablauf der Frist gilt das Abnahmeprotokoll als bestätigt.',
        ),
      ..._field('Vor- und Nachname (Kunde)', data['customerFullName']),
      ..._signature('Unterschrift Kunde', data['customerSignature']),
      ..._signature('Unterschrift Vorarbeiter', data['foremanSignature']),
      ..._field('E-Mail gesendet an', data['emailSentTo']),
    ];
    return _section('Unterschriften', fields);
  }

  // ─── Section builder ────────────────────────────────────────────────────────

  static pw.Widget? _section(String title, List<pw.Widget> fields) {
    if (fields.isEmpty) return null;
    return PdfGeneratorBase.buildSection(title, fields);
  }

  // ─── Field helpers ──────────────────────────────────────────────────────────

  static List<pw.Widget> _field(String label, dynamic value) {
    final str = PdfGeneratorBase.safeString(value);
    if (str.isEmpty || str == '-') return [];
    return [PdfGeneratorBase.buildFieldRow(label, str)];
  }

  static List<pw.Widget> _fieldMapped(
    String label,
    dynamic value,
    String Function(dynamic) mapper,
  ) {
    if (value == null) return [];
    final str = mapper(value);
    if (str.isEmpty || str == '-') return [];
    return [PdfGeneratorBase.buildFieldRow(label, str)];
  }

  static List<pw.Widget> _checkbox(String label, dynamic value) {
    if (value == null) return [];
    return [PdfGeneratorBase.buildFieldRow(label, _yesNo(value))];
  }

  static List<pw.Widget> _photo(String label, dynamic value) {
    if (value == null) return [];
    if (value is String && value.isEmpty) return [];
    return [PdfGeneratorBase.buildPhotoField(label, value)];
  }

  static List<pw.Widget> _signature(String label, dynamic value) {
    if (value == null) return [];
    if (value is String && value.isEmpty) return [];
    return [PdfGeneratorBase.buildSignatureField(label, value as String?)];
  }

  // ─── Value helpers ─────────────────────────────────────────────────────────

  static String _yesNo(dynamic value) {
    if (value == true || value == 'yes') return 'Ja';
    if (value == false || value == 'no') return 'Nein';
    return '-';
  }

  static String _acceptanceResult(dynamic value) {
    switch (value) {
      case 'defect_free':
        return 'Mangelfrei';
      case 'with_defects':
        return 'Mit Mängeln';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }

  static String _systemType(dynamic value) {
    switch (value) {
      case 'pv_only':
        return 'PV nur';
      case 'pv_with_storage':
        return 'PV mit Speicher';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }

  static String _senecStorage(dynamic value) {
    switch (value) {
      case 'senec_home_p4':
        return 'Senec Home P4';
      case 'senec_home_e4':
        return 'Senec Home E4';
      case 'senec_home_v3':
        return 'Senec Home V3';
      case 'other':
        return 'Sonstiges';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }

  static String _roofType(dynamic value) {
    switch (value) {
      case 'tile':
        return 'Ziegel';
      case 'sheet_metal':
        return 'Blech';
      case 'trapezoidal':
        return 'Trapezblech';
      case 'flat_roof':
        return 'Flachdach';
      case 'other':
        return 'Sonstiges';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }

  static String _cableRoutedThrough(dynamic value) {
    switch (value) {
      case 'facade':
        return 'Fassade';
      case 'inside':
        return 'Innen';
      case 'cable_duct':
        return 'Kabelkanal';
      case 'other':
        return 'Sonstiges';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }

  static String _surgeProtectionNeeded(dynamic value) {
    switch (value) {
      case 'no_v3_v4_kaco':
        return 'Nicht benötigt (V3/V4/Kaco)';
      case 'yes':
        return 'Ja';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }
}
