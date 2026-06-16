import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class InstallationReportPdfGenerator {
  // ── Flat keys expected in `data` ─────────────────────────────────────────

  static const _expectedFlatKeys = [
    // Section: Customer Data
    'surveyTechnician', 'customerName', 'street', 'houseNumber',
    'zipCode', 'installationCity', 'email', 'phone',

    // Section: Storage Info
    'pvsNumber', 'storageType', 'storageTypeOther',

    // Section 1: Roof – Overview
    'photoOverview', 'roofCovering',

    // Section 1: Tile Roof Details
    'scaffoldOnSidewalk', 'isolateOverheadLine', 'externalLightning',
    'satDishPresent', 'mustMoveSatDish', 'newSatDishLocation',
    'photoNewSatDishLocation',

    // Section 2: DC Cable Route
    'dcCableLengthMeters',
    'photoDcCableRoute',

    // Section 3: Electrical – HAK
    'photoHak',
    'hakFuseAmps',
    'hakHousingMaterial',
    'hakOpenableWithoutProvider',
    'distanceMeterToHak',
    'photosWayToMeter',

    // Section 3: Meter Cabinet (existing)
    'photoMeterCabinet',
    'typeLabelPresent', 'photoTypeLabel',

    // Section 3: Main Meter
    'photoMainMeter', 'mainMeterNumber', 'mainMeterPurpose',

    // Section 3: Additional Meters
    'additionalMetersPresent',

    // Section 3: Meter Consolidation & Other
    'meterConsolidation', 'otherEnergySystems',

    // Section 3: Optional ZK
    'photoOptionalZkLocation',
    'photosCableRoutes',

    // Section 4: Signal Measurement – Existing ZK
    'signalTMobileExisting',
    'signalVodafoneExisting',
    'signalTelefonicaExisting',
    'photoSignalExisting',

    // Section 4: Signal Measurement – Optional ZK
    'signalTMobileOptional',
    'signalVodafoneOptional',
    'signalTelefonicaOptional',
    'photoSignalOptional',

    // Section 5: Storage / Inverter
    'photosInstallLocation',
    'storageOnFireproofSurface', 'inverterOnFireproofWall',
    'customerInformedTemperature', 'storageLocation',
    'distanceInverterToZk',
    'photosCableInverterToZk',

    // Section 6: Earthing
    'mainEarthingPresent', 'photosEarthing',
    'distanceEarthingToStorage', 'distanceEarthingToZk',

    // Section 7: Internet
    'internetAvailable', 'customerLaysCableThemselves',
    'distanceRouterToStorage', 'photosInternetCableRoute',

    // Section 8: Wallbox
    'wallboxOrdered', 'photoWallboxLocation', 'distanceWallboxToZk',
    'photosWallboxCable',

    // Section 9: Blackout Package
    'blackoutOrdered', 'photoNubLocation', 'photosNubCableRoute',

    // Section 10: Heat Pump
    'heatPumpOrdered', 'photoHeatPumpLocation',
    'distanceHeatPumpToZk', 'heatPumpTechnicalData',

    // Section 11: Notes & Planning
    'dcAcSameRoute', 'customerCablingWish',
    'dcNotes', 'acNotes', 'organizationalNotes', 'techRemarks',
    'photosSpecial',
    'detailsRecorded',

    // Section 12: Additional Info
    // (repeatable section: additional_info with note + image)

    // Section 13: Signatures
    'location', 'customerFullName', 'signatureDate', 'signatureTime',
    'customerSignature', 'techSignature',
  ];

  static const _expectedRepeatableKeys = {
    'roofSurfaces': [
      'dormersPresent',
      'photosRoof',
      'eaveHeightMeters',
      'eaveOverhangCm',
      'vergeOverhangCm',
      'ridgeTilesMortared',
      'rafterWidthCm',
      'rafterHeightCm',
      'rafterDistanceCm',
      'photoRafterMeasurements',
      'visibleRafters',
      'aboveRoofInsulation',
      'feltPlugs',
      'roofPitchDegrees',
      'photoRoofPitch',
      'tileType',
      'photoTile',
      'tileHeightCm',
      'tileWidthCm',
      'tilesScrewedOrClamped',
      'hasReplacementTiles',
      'customerInformedAboutTiles',
    ],
    'additionalMeters': ['photoMeter', 'meterNumber', 'meterPurpose'],
    'additional_info': ['note', 'image'],
  };

  // ── Entry point ──────────────────────────────────────────────────────────

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(
      data,
      'AufmassReportPdfGenerator',
      _expectedFlatKeys,
    );
    PdfGeneratorBase.logExpectedRepeatableFields(
      repeatableData,
      'AufmassReportPdfGenerator',
      _expectedRepeatableKeys,
    );

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'AM',
      DateTime.now(),
      protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'Aufmassprotokoll',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildCustomerDataSection(data),
        _buildStorageInfoSection(data),
        _buildRoofOverviewSection(data),
        _buildTileRoofDetailsSection(data),
        _buildRoofSurfacesSection(repeatableData['roofSurfaces'] ?? []),
        _buildDcCableRouteSection(data),
        _buildHakSection(data),
        _buildWayToMeterSection(data),
        _buildMeterCabinetSection(data),
        _buildMainMeterSection(data),
        _buildAdditionalMetersSection(
          data,
          repeatableData['additionalMeters'] ?? [],
        ),
        _buildConsolidationSection(data),
        _buildOptionalZkSection(data),
        _buildSignalMeasurementSection(data),
        _buildStorageInverterSection(data),
        _buildEarthingSection(data),
        _buildInternetSection(data),
        _buildWallboxSection(data),
        _buildBlackoutSection(data),
        _buildHeatPumpSection(data),
        _buildNotesSection(data),
        _buildAdditionalInfoSection(repeatableData),
        _buildFinalAcceptanceSection(data),
      ],
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  static String _yesNo(dynamic value) {
    if (value == true || value == 'yes') return 'Ja';
    if (value == false || value == 'no') return 'Nein';
    return PdfGeneratorBase.safeString(value);
  }

  // ── Section builders ─────────────────────────────────────────────────────

  // 0. Customer Data
  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Kundendaten', [
      PdfGeneratorBase.buildFieldRow(
        'Aufmaßtechniker vor Ort',
        PdfGeneratorBase.safeString(data['surveyTechnician']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Kunde',
        PdfGeneratorBase.safeString(data['customerName']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Straße',
        PdfGeneratorBase.safeString(data['street']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Hausnummer',
        PdfGeneratorBase.safeString(data['houseNumber']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'PLZ',
        PdfGeneratorBase.safeString(data['zipCode']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Montageort',
        PdfGeneratorBase.safeString(data['installationCity']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'E-Mail',
        PdfGeneratorBase.safeString(data['email']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Telefon',
        PdfGeneratorBase.safeString(data['phone']),
      ),
    ]);
  }

  // 0. Storage Info
  static pw.Widget _buildStorageInfoSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Speicher', [
      PdfGeneratorBase.buildFieldRow(
        'PVS Nummer / Auftrags ID',
        PdfGeneratorBase.safeString(data['pvsNumber']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Speicherart',
        PdfGeneratorBase.safeString(data['storageType']),
      ),
      if (data['storageType'] == 'other')
        PdfGeneratorBase.buildFieldRow(
          'Speicherart (Sonstige)',
          PdfGeneratorBase.safeString(data['storageTypeOther']),
        ),
    ]);
  }

  // 1. Roof – Overview
  static pw.Widget _buildRoofOverviewSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('1. Dach – Übersicht', [
      PdfGeneratorBase.buildPhotoField(
        'Luftbildübersicht mit Zeichnung',
        data['photoOverview'],
      ),
      PdfGeneratorBase.buildFieldRow(
        'Dacheindeckung',
        PdfGeneratorBase.safeString(data['roofCovering']),
      ),
    ]);
  }

  // 1. Tile Roof Details
  static pw.Widget _buildTileRoofDetailsSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('1. Ziegeldach Details', [
      PdfGeneratorBase.buildFieldRow(
        'Gerüst auf Gehweg/Straße',
        _yesNo(data['scaffoldOnSidewalk']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Freileitung isolieren',
        _yesNo(data['isolateOverheadLine']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Äußerer Blitzschutz vorhanden',
        _yesNo(data['externalLightning']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'SAT Schüssel auf belegter Dachfläche',
        _yesNo(data['satDishPresent']),
      ),
      if (data['satDishPresent'] == 'yes') ...[
        PdfGeneratorBase.buildFieldRow(
          'SAT Schüssel versetzen',
          _yesNo(data['mustMoveSatDish']),
        ),
        if (data['mustMoveSatDish'] == 'yes') ...[
          PdfGeneratorBase.buildFieldRow(
            'Neuer SAT-Standort',
            PdfGeneratorBase.safeString(data['newSatDishLocation']),
          ),
          PdfGeneratorBase.buildPhotoField(
            'Neuer SAT-Standort Foto',
            data['photoNewSatDishLocation'],
          ),
        ],
      ],
    ]);
  }

  // 1. Roof Surfaces (repeatable)
  static pw.Widget _buildRoofSurfacesSection(
    List<Map<String, dynamic>> surfaces,
  ) {
    if (surfaces.isEmpty) {
      return PdfGeneratorBase.buildSection('1. Dachflächen', [
        PdfGeneratorBase.buildFieldRow('Dachflächen', 'Keine Einträge'),
      ]);
    }

    final rows = <pw.Widget>[];
    for (var i = 0; i < surfaces.length; i++) {
      final s = surfaces[i];
      rows.addAll([
        PdfGeneratorBase.buildFieldRow('Dachfläche', '${i + 1}'),
        PdfGeneratorBase.buildFieldRow(
          'Gauben vorhanden',
          _yesNo(s['dormersPresent']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Dachfotos (außen + innen)',
          s['photosRoof'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Traufhöhe (H1/H2) in m',
          PdfGeneratorBase.safeString(s['eaveHeightMeters']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Traufüberstand in cm',
          PdfGeneratorBase.safeString(s['eaveOverhangCm']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Firstziegel vermörtelt',
          _yesNo(s['ridgeTilesMortared']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Dachüberstand Ortgang in cm',
          PdfGeneratorBase.safeString(s['vergeOverhangCm']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Sparrenbreite in cm',
          PdfGeneratorBase.safeString(s['rafterWidthCm']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Sparrenhöhe in cm',
          PdfGeneratorBase.safeString(s['rafterHeightCm']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Sparrenabstand in cm (M-M)',
          PdfGeneratorBase.safeString(s['rafterDistanceCm']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Fotos Sparrenmaße',
          s['photoRafterMeasurements'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Sichtsparren',
          _yesNo(s['visibleRafters']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Aufdachdämmung',
          _yesNo(s['aboveRoofInsulation']),
        ),
        PdfGeneratorBase.buildFieldRow('Pappdocken', _yesNo(s['feltPlugs'])),
        PdfGeneratorBase.buildFieldRow(
          'Dachneigung (°)',
          PdfGeneratorBase.safeString(s['roofPitchDegrees']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Messung Dachneigung',
          s['photoRoofPitch'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Ziegeltyp',
          PdfGeneratorBase.safeString(s['tileType']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Ziegelfotos (oben/unten) mit Deckmaßen',
          s['photoTile'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Deckhöhe in cm',
          PdfGeneratorBase.safeString(s['tileHeightCm']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Deckbreite in cm',
          PdfGeneratorBase.safeString(s['tileWidthCm']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Ziegel geschraubt/geklammert',
          _yesNo(s['tilesScrewedOrClamped']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Ersatzziegel vorhanden',
          _yesNo(s['hasReplacementTiles']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Kunde über 20 Ersatzziegel informiert',
          _yesNo(s['customerInformedAboutTiles']),
        ),
      ]);
    }
    return PdfGeneratorBase.buildSection('1. Dachflächen', rows);
  }

  // 2. DC Cable Route
  static pw.Widget _buildDcCableRouteSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('2. DC Kabelweg', [
      PdfGeneratorBase.buildPhotoField(
        'Fotos geplanter DC-Kabelweg (Linien BLAU)',
        data['photoDcCableRoute'],
      ),
      PdfGeneratorBase.buildFieldRow(
        'Länge Kabelweg in m',
        PdfGeneratorBase.safeString(data['dcCableLengthMeters']),
      ),
    ]);
  }

  // 3. HAK
  static pw.Widget _buildHakSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('3. Hausanschlusskasten (HAK)', [
      PdfGeneratorBase.buildPhotoField('HAK geöffnet', data['photoHak']),
      PdfGeneratorBase.buildFieldRow(
        'Absicherung (A)',
        PdfGeneratorBase.safeString(data['hakFuseAmps']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'HAK Gehäusematerial',
        PdfGeneratorBase.safeString(data['hakHousingMaterial']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'HAK ohne Energieversorger öffenbar',
        _yesNo(data['hakOpenableWithoutProvider']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Abstand Zählerkasten zu HAK in m',
        PdfGeneratorBase.safeString(data['distanceMeterToHak']),
      ),
    ]);
  }

  // 3. Way to Meter Cabinet
  static pw.Widget _buildWayToMeterSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('3. Weg zum Zählerkasten', [
      PdfGeneratorBase.buildPhotoField(
        'Weg zum Zählerkasten',
        data['photosWayToMeter'],
      ),
    ]);
  }

  // 3. Meter Cabinet (existing)
  static pw.Widget _buildMeterCabinetSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('3. Zählerschrank Bestand', [
      PdfGeneratorBase.buildPhotoField(
        'Zählerschrank (alle Abdeckungen offen)',
        data['photoMeterCabinet'],
      ),
      PdfGeneratorBase.buildFieldRow(
        'Typenschild vorhanden',
        _yesNo(data['typeLabelPresent']),
      ),
      if (data['typeLabelPresent'] == 'yes')
        PdfGeneratorBase.buildPhotoField(
          'Typenschild Foto',
          data['photoTypeLabel'],
        ),
    ]);
  }

  // 3. Main Meter
  static pw.Widget _buildMainMeterSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('3. Hauptzähler', [
      PdfGeneratorBase.buildPhotoField(
        'Hauptzähler Foto',
        data['photoMainMeter'],
      ),
      PdfGeneratorBase.buildFieldRow(
        'Zählernummer Bezugszähler',
        PdfGeneratorBase.safeString(data['mainMeterNumber']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Zweck des Zählers',
        PdfGeneratorBase.safeString(data['mainMeterPurpose']),
      ),
    ]);
  }

  // 3. Additional Meters (repeatable)
  static pw.Widget _buildAdditionalMetersSection(
    Map<String, dynamic> data,
    List<Map<String, dynamic>> meters,
  ) {
    final rows = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow(
        'Zusätzliche Zähler vorhanden',
        _yesNo(data['additionalMetersPresent']),
      ),
    ];

    if (data['additionalMetersPresent'] == 'yes') {
      for (var i = 0; i < meters.length; i++) {
        final m = meters[i];
        rows.addAll([
          PdfGeneratorBase.buildFieldRow('Zähler', '${i + 1}'),
          PdfGeneratorBase.buildPhotoField('Zähler Foto', m['photoMeter']),
          PdfGeneratorBase.buildFieldRow(
            'Zählernummer',
            PdfGeneratorBase.safeString(m['meterNumber']),
          ),
          PdfGeneratorBase.buildFieldRow(
            'Zweck',
            PdfGeneratorBase.safeString(m['meterPurpose']),
          ),
        ]);
      }
    }

    return PdfGeneratorBase.buildSection('3. Zusätzliche Zähler', rows);
  }

  // 3. Consolidation & Other Systems
  static pw.Widget _buildConsolidationSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('3. Zusammenlegung & Sonstiges', [
      PdfGeneratorBase.buildFieldRow(
        'Zählerzusammenlegung',
        _yesNo(data['meterConsolidation']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Andere Energieerzeugungsanlagen vorhanden',
        _yesNo(data['otherEnergySystems']),
      ),
    ]);
  }

  // 3. Optional ZK
  static pw.Widget _buildOptionalZkSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('3. Optionaler Zählerschrank', [
      PdfGeneratorBase.buildPhotoField(
        'Montageort optionaler ZK',
        data['photoOptionalZkLocation'],
      ),
      PdfGeneratorBase.buildPhotoField(
        'Kabelweg HAK → ZK / Bestand → Optional',
        data['photosCableRoutes'],
      ),
    ]);
  }

  // 4. Signal Measurement
  static pw.Widget _buildSignalMeasurementSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('4. Pegelmessung', [
      // Existing ZK location
      PdfGeneratorBase.buildFieldRow(
        'T-Mobile RSRP (ZK Bestand, dBm)',
        PdfGeneratorBase.safeString(data['signalTMobileExisting']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Vodafone RSRP (ZK Bestand, dBm)',
        PdfGeneratorBase.safeString(data['signalVodafoneExisting']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Telefonica RSRP (ZK Bestand, dBm)',
        PdfGeneratorBase.safeString(data['signalTelefonicaExisting']),
      ),
      PdfGeneratorBase.buildPhotoField(
        'Foto Messgerät + Antenne (ZK Bestand)',
        data['photoSignalExisting'],
      ),
      // Optional ZK location
      PdfGeneratorBase.buildFieldRow(
        'T-Mobile RSRP (ZK optional, dBm)',
        PdfGeneratorBase.safeString(data['signalTMobileOptional']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Vodafone RSRP (ZK optional, dBm)',
        PdfGeneratorBase.safeString(data['signalVodafoneOptional']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Telefonica RSRP (ZK optional, dBm)',
        PdfGeneratorBase.safeString(data['signalTelefonicaOptional']),
      ),
      PdfGeneratorBase.buildPhotoField(
        'Foto Messgerät + Antenne (ZK optional)',
        data['photoSignalOptional'],
      ),
    ]);
  }

  // 5. Storage / Inverter
  static pw.Widget _buildStorageInverterSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('5. Speicher / Wechselrichter', [
      PdfGeneratorBase.buildPhotoField(
        'Montageort mit Bemaßung',
        data['photosInstallLocation'],
      ),
      PdfGeneratorBase.buildFieldRow(
        'Speicher auf brandschutzsicherem Untergrund',
        _yesNo(data['storageOnFireproofSurface']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Wechselrichter auf brandschutzsicherer Wand',
        _yesNo(data['inverterOnFireproofWall']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Kunde über Betriebstemperatur 15–35 °C informiert',
        _yesNo(data['customerInformedTemperature']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Speicherstandort',
        PdfGeneratorBase.safeString(data['storageLocation']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Entfernung WR/Speicher zum ZK in m',
        PdfGeneratorBase.safeString(data['distanceInverterToZk']),
      ),
      PdfGeneratorBase.buildPhotoField(
        'Kabelweg WR/Speicher → ZK (rote Linien)',
        data['photosCableInverterToZk'],
      ),
    ]);
  }

  // 6. Earthing
  static pw.Widget _buildEarthingSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('6. Erdung', [
      PdfGeneratorBase.buildFieldRow(
        'Haupterdung vorhanden',
        _yesNo(data['mainEarthingPresent']),
      ),
      PdfGeneratorBase.buildPhotoField(
        'Fotos Erdung (Hauptpunkt + Schiene + Kabelweg)',
        data['photosEarthing'],
      ),
      PdfGeneratorBase.buildFieldRow(
        'Entfernung Erdung → Speicher in m',
        PdfGeneratorBase.safeString(data['distanceEarthingToStorage']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Entfernung Erdung → ZK in m',
        PdfGeneratorBase.safeString(data['distanceEarthingToZk']),
      ),
    ]);
  }

  // 7. Internet
  static pw.Widget _buildInternetSection(Map<String, dynamic> data) {
    final rows = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow(
        'Internetverbindung vorhanden',
        _yesNo(data['internetAvailable']),
      ),
    ];
    if (data['internetAvailable'] == 'yes') {
      rows.addAll([
        PdfGeneratorBase.buildFieldRow(
          'Kunde verlegt Leitung selbst',
          _yesNo(data['customerLaysCableThemselves']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Entfernung Router → Speicher in m',
          PdfGeneratorBase.safeString(data['distanceRouterToStorage']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Kabelweg Router → WR/Speicher + Typenschild',
          data['photosInternetCableRoute'],
        ),
      ]);
    }
    return PdfGeneratorBase.buildSection('7. Internetanschluss', rows);
  }

  // 8. Wallbox
  static pw.Widget _buildWallboxSection(Map<String, dynamic> data) {
    final rows = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow(
        'Wallbox bei MAM Solarbau beauftragt',
        _yesNo(data['wallboxOrdered']),
      ),
    ];
    if (data['wallboxOrdered'] == 'yes') {
      rows.addAll([
        PdfGeneratorBase.buildPhotoField(
          'Montageort Wallbox',
          data['photoWallboxLocation'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Entfernung Wallbox → ZK in m',
          PdfGeneratorBase.safeString(data['distanceWallboxToZk']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Kabelweg Wallbox',
          data['photosWallboxCable'],
        ),
      ]);
    }
    return PdfGeneratorBase.buildSection('8. Wallbox', rows);
  }

  // 9. Blackout Package
  static pw.Widget _buildBlackoutSection(Map<String, dynamic> data) {
    final rows = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow(
        'Blackout-Paket bei MAM Solarbau beauftragt',
        _yesNo(data['blackoutOrdered']),
      ),
    ];
    if (data['blackoutOrdered'] == 'yes') {
      rows.addAll([
        PdfGeneratorBase.buildPhotoField(
          'Montageort NUB',
          data['photoNubLocation'],
        ),
        PdfGeneratorBase.buildPhotoField(
          'Kabelweg NUB → ZK',
          data['photosNubCableRoute'],
        ),
      ]);
    }
    return PdfGeneratorBase.buildSection('9. Blackout Paket', rows);
  }

  // 11. Notes & Planning
  static pw.Widget _buildNotesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection(
      '11. Bemerkungen & Planung',
      [
        PdfGeneratorBase.buildFieldRow(
          'Kabelweg DC und AC gleich',
          _yesNo(data['dcAcSameRoute']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Leitungsverlegung',
          PdfGeneratorBase.safeString(data['customerCablingWish']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'DC Bemerkungen + Kabelwegbeschreibung',
          PdfGeneratorBase.safeString(data['dcNotes']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'AC Bemerkungen + Kabelwegbeschreibung',
          PdfGeneratorBase.safeString(data['acNotes']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Materiallager / Parken / Anfahrt',
          PdfGeneratorBase.safeString(data['organizationalNotes']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Weitere Anmerkungen Aufmaßtechniker',
          PdfGeneratorBase.safeString(data['techRemarks']),
        ),
        PdfGeneratorBase.buildPhotoField(
          'Optionale Fotos Besonderheiten',
          data['photosSpecial'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Alle Details eingetragen und besprochen',
          _yesNo(data['detailsRecorded']),
        ),
      ],
    );
  }

  // 12. Heat Pump
  static pw.Widget _buildHeatPumpSection(Map<String, dynamic> data) {
    final rows = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow(
        'Wärmepumpe bei MAM Solarbau beauftragt',
        _yesNo(data['heatPumpOrdered']),
      ),
    ];
    if (data['heatPumpOrdered'] == 'yes') {
      rows.addAll([
        PdfGeneratorBase.buildPhotoField(
          'Montageort Wärmepumpe',
          data['photoHeatPumpLocation'],
        ),
        PdfGeneratorBase.buildFieldRow(
          'Entfernung Wärmepumpe → ZK in m',
          PdfGeneratorBase.safeString(data['distanceHeatPumpToZk']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Technische Daten',
          PdfGeneratorBase.safeString(data['heatPumpTechnicalData']),
        ),
      ]);
    }
    return PdfGeneratorBase.buildSection('10. Wärmepumpe', rows);
  }

  // additional info
  static pw.Widget _buildAdditionalInfoSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final infoList = repeatableData['additional_info'] ?? [];
    final fields = <pw.Widget>[];

    if (infoList.isEmpty) {
      fields.add(
        PdfGeneratorBase.buildFieldRow('Zusatzinformationen', 'Keine Daten'),
      );
    } else {
      for (var i = 0; i < infoList.length; i++) {
        final item = infoList[i];
        fields.add(
          pw.Text(
            'Zusatzinfo #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );

        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Hinweis',
            PdfGeneratorBase.safeString(item['note']),
          ),
        );
        fields.add(PdfGeneratorBase.buildPhotoField('Bild', item['image']));

        if (i < infoList.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Zusatzinformationen', fields);
  }

  // 13. Final Acceptance
  static pw.Widget _buildFinalAcceptanceSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection(
      '13. Abschluss des Aufmaßprotokolles',
      [
        PdfGeneratorBase.buildFieldRow(
          'Alle Details eingetragen und mit Kunde besprochen',
          _yesNo(data['detailsRecorded']),
        ),
        PdfGeneratorBase.buildSignatureField(
          'Kunde / Bevollmächtigter',
          data['customerSignature'] as String?,
        ),
        PdfGeneratorBase.buildFieldRow(
          'Vor- und Nachname',
          PdfGeneratorBase.safeString(data['customerFullName']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Ort',
          PdfGeneratorBase.safeString(data['location']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Datum',
          PdfGeneratorBase.safeString(data['signatureDate']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Zeitpunkt',
          PdfGeneratorBase.safeString(data['signatureTime']),
        ),
        PdfGeneratorBase.buildSignatureField(
          'Aufmaßtechniker vor Ort',
          data['techSignature'] as String?,
        ),
      ],
    );
  }
}
