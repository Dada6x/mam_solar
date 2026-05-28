import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class AcProtocolPdfGenerator {
  static const _expectedFlatKeys = [
    // Customer Data
    'customerName', 'street', 'houseNumber', 'city', 'zipCode', 'email', 'phone',
    'installationDate', 'installationTime',
    'installerName', 'partnerCompany',

    // Installation Type
    'backupInstalled', 
    'inspectionCompleted', 'inspectionReason',
    'groundRodInstalled', 'privateMeterInstalled',

    'installationType', 'storageManufacturer', 'wallboxInstalled',
    'supervisorIntroduced', 'shoeCoversWorn',

    // Equipotential Bonding
    'componentsConnected',
    'eqEarthingConnected', 'eqUkConnected', 'eqDcOvervoltageConnected', 'eqInverterConnected',
    'photoBonding',

    // Meter Cabinet
    'newCabinetInstalled', 'allComponentsInstalled', 'touchProtection',
    'apzWiring', 'apzInstalled',
    'existingSystemChanges','energridInstalled',
    'photoCabinet',
    'photoNewFuse', 'photoApzCable', 'photoApzWiringMeter',
    'photoEnergrid',
    'photoPvLabel', 'photoNewCabinet', 'photoOldCabinet', 'photoSlsOrNh',
    'photoAcOvervoltage', 'photoRcd', 'photoCableRouteToNewCabinet',
    'photoApzCableInside', 'photoApzMeterConnections',

    // Meter Registration
    'newMeterType',
    'remoteControlPresent', 'photoRemoteControl',
    'removeRemoteControl',
    'meterConsolidation', 'consolidationDescription',
    'meterRemarks',
    'measurementConcept',
    'meterType', 'meterRemovalNeeded', 'meterReplacementNeeded',
    'remoteControl',
    'photoMeter', 'photoMeterReadings',

    // Heat Pump
    'heatPumpOrdered',
    'photoSubDistribution', 'photoFusesHeatPump',
    'heatPumpRequested',

    // Cable Routes
    'photoCableRoute',
    'routeOver25m', 'additionalMeters',
    'notes',

    // Cleanliness
    'siteCleanedUp',

    // Final Acceptance
    'detailsRecorded',
    'measurementProtocol',
    'completionDate', 'completionTime',
    'remarks',
    'systemOperational', 'customerInformed', 'invoiceApproved',
    // additional info 
    'note', 'image',

    // Customer Signature
    'customerSignature', 'customerFullName',

    // Installer Signature
    'installerSignature',
  ];

  static const _expectedRepeatableKeys = {
    'inverter': [
      'inverterCount', 'brand', 'model', 'serialNumber', 'networkType',
      'installedCorrectly', 'mountedOnFireproofSurface', 'normsFollowed',
      'fusesPerSpec', 'fusesRemark',
      'manufacturerStandardsFollowed',
      'photoDataplate', 'photoAcGrid', 'photoAcBackup', 'photoCommunicationPlug',
      'photoThreeCommunicationPorts', 'photoEarthingLeft', 'photoEarthingRight',
      'photoPlcOrWlanExtender', 'photoDcBatteryCables', 'photoFinalInstall',
    ],
    'battery_storage': [
      'batteryBrand', 'batteryModel', 'batterySid',
      'batteryTowers', 'batteryModulesPerTower', 'serialNumbers',
      'standardsFollowed',
      'photoQrCode', 'photoBatteryConnections', 'photoEmsNumber', 'photoAcPlugOpen',
      'photoBatteryWithoutCovers', 'photoBatteryWithCovers', 'photoBatteryFromDistance',
      'photoBatteryBase', 'photoBatteryEarthing', 'photoBatteryTowerFinal',
    ],
    'distribution_board': [
      'photoDistBoard', 'additionalDetails',
    ],
    'protection_devices': [
      'photoProtectionDevice', 'noChangesMade', 'systemStabilityTested', 'enerGridUsed',
    ],
    'existingMeters': [
      'meterNumber', 'meterType', 'photoMeter',
    ],
    'meter_registration': [
      'newMeterType', 'remoteControlPrdesent', 'photoRemoteControl',
      'removeRemoteControl', 'meterConsolidation', 'consolidationDescription',
      'meterRemarks', 'meterRemovalNeeded', 'meterReplacementNeeded',
      'photoMeterReadings', 'measurementConcept',
    ],
    'additional_info': [
      'note', 'image',
    ],
  };

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(data, 'AcProtocolPdfGenerator', _expectedFlatKeys);
    PdfGeneratorBase.logExpectedRepeatableFields(repeatableData, 'AcProtocolPdfGenerator', _expectedRepeatableKeys);

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'AC', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'AC Abnahmeprotokoll',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildCustomerDataSection(data),
        _buildInstallationDetailsSection(data),
        _buildInverterSection(repeatableData),
        _buildBatteryStorageSection(repeatableData),
        // _buildEquipotentialBondingSection(data),
        _buildDistributionBoardSection(repeatableData),
        _buildMeterCabinetSection(data),
        _buildProtectionDevicesSection(repeatableData),
        _buildMeterRegistrationSection(repeatableData),
        _buildHeatPumpSection(data),
        _buildCableRoutesSection(data),
        _buildCleanlinessSection(data),
        _buildFinalAcceptanceSection(data),
        _buildRemarksSection(data),
        _buildAdditionalInfoSection(repeatableData),
        _buildSignaturesSection(data),
      ],
    );
  }

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Kundendaten', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['customerName'])),
      PdfGeneratorBase.buildFieldRow('Straße', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('Hausnummer', PdfGeneratorBase.safeString(data['houseNumber'])),
      PdfGeneratorBase.buildFieldRow('Stadt', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('PLZ', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('E-Mail', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Telefon', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('Installationsdatum', PdfGeneratorBase.safeString(data['installationDate'])),
      PdfGeneratorBase.buildFieldRow('Installationszeit', PdfGeneratorBase.safeString(data['installationTime'])),
      PdfGeneratorBase.buildFieldRow('Installateur', PdfGeneratorBase.safeString(data['installerName'])),
      PdfGeneratorBase.buildFieldRow('Partnerunternehmen', PdfGeneratorBase.safeString(data['partnerCompany'])),
    ]);
  }

  static pw.Widget _buildInstallationDetailsSection(Map<String, dynamic> data) {
    final backupInstalled = data['backupInstalled'] == true || data['backupInstalled'] == 'yes';
    final inspectionCompleted = data['inspectionCompleted'];
    final inspectionNotDone = inspectionCompleted == false ||
        inspectionCompleted == 'no' ||
        inspectionCompleted == 'not_possible';

    return PdfGeneratorBase.buildSection('Installationsdetails', [
      PdfGeneratorBase.buildFieldRow('Typ', PdfGeneratorBase.safeString(data['installationType'])),
      PdfGeneratorBase.buildFieldRow('Speicherhersteller', PdfGeneratorBase.safeString(data['storageManufacturer'])),
      PdfGeneratorBase.buildFieldRow('Wallbox', data['wallboxInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Backup-System installiert', backupInstalled ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow(
        'Inspektion abgeschlossen',
        inspectionCompleted == 'not_possible'
            ? 'Nicht möglich'
            : (inspectionCompleted == true || inspectionCompleted == 'yes' ? 'Ja' : 'Nein'),
      ),
      if (inspectionNotDone)
        PdfGeneratorBase.buildFieldRow('Grund für fehlende Inspektion', PdfGeneratorBase.safeString(data['inspectionReason'])),
      PdfGeneratorBase.buildFieldRow('Erdungsstab installiert', _yesNo(data['groundRodInstalled'])),
      PdfGeneratorBase.buildFieldRow('Privater Zwischenzähler installiert', _yesNo(data['privateMeterInstalled'])),
      PdfGeneratorBase.buildFieldRow('Einweisung durchgeführt', data['supervisorIntroduced'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Überschuhe getragen', data['shoeCoversWorn'] == true ? 'Ja' : 'Nein'),
    ]);
  }

  static pw.Widget _buildInverterSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final inverters = repeatableData['inverter'] ?? [];
    final fields = <pw.Widget>[];
    if (inverters.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Wechselrichter', 'Keine Daten'));
    } else {
      for (var i = 0; i < inverters.length; i++) {
        final inv = inverters[i];
        fields.add(pw.Text(
          'Wechselrichter #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Marke', PdfGeneratorBase.safeString(inv['brand'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Modell', PdfGeneratorBase.safeString(inv['model'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Seriennummer', PdfGeneratorBase.safeString(inv['serialNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Netztyp', PdfGeneratorBase.safeString(inv['networkType'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Korrekt installiert', _yesNo(inv['installedCorrectly'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Auf brandschutzsicherem Untergrund montiert', _yesNo(inv['mountedOnFireproofSurface'])));
        fields.add(PdfGeneratorBase.buildFieldRow(
          'Herstellervorgaben eingehalten',
          _yesNo(inv['normsFollowed'] ?? inv['manufacturerStandardsFollowed']),
        ));
        fields.add(PdfGeneratorBase.buildPhotoField('Typenschild', inv['photoDataplate']));
        fields.add(PdfGeneratorBase.buildPhotoField('AC Netz', inv['photoAcGrid']));
        fields.add(PdfGeneratorBase.buildPhotoField('AC Backup', inv['photoAcBackup']));
        fields.add(PdfGeneratorBase.buildPhotoField('Kommunikationsstecker', inv['photoCommunicationPlug']));
        fields.add(PdfGeneratorBase.buildPhotoField('Drei Kommunikationsports', inv['photoThreeCommunicationPorts']));
        fields.add(PdfGeneratorBase.buildPhotoField('Erdung links', inv['photoEarthingLeft']));
        fields.add(PdfGeneratorBase.buildPhotoField('Erdung rechts', inv['photoEarthingRight']));
        fields.add(PdfGeneratorBase.buildPhotoField('PLC / WLAN Extender', inv['photoPlcOrWlanExtender']));
        fields.add(PdfGeneratorBase.buildPhotoField('DC Batteriekabel', inv['photoDcBatteryCables']));
        fields.add(PdfGeneratorBase.buildPhotoField('Endmontage', inv['photoFinalInstall']));
        if (i < inverters.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Wechselrichter', fields);
  }

  static pw.Widget _buildBatteryStorageSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final batteries = repeatableData['battery_storage'] ?? [];
    final fields = <pw.Widget>[];
    if (batteries.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Batteriespeicher', 'Keine Daten'));
    } else {
      for (var i = 0; i < batteries.length; i++) {
        final battery = batteries[i];
        fields.add(pw.Text(
          'Batteriespeicher #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Marke', PdfGeneratorBase.safeString(battery['batteryBrand'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Modell', PdfGeneratorBase.safeString(battery['batteryModel'])));
        fields.add(PdfGeneratorBase.buildFieldRow('SID', PdfGeneratorBase.safeString(battery['batterySid'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Türme', PdfGeneratorBase.safeString(battery['batteryTowers'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Module pro Turm', PdfGeneratorBase.safeString(battery['batteryModulesPerTower'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Seriennummern', PdfGeneratorBase.safeString(battery['serialNumbers'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Herstellervorgaben eingehalten', _yesNo(battery['standardsFollowed'])));
        fields.add(PdfGeneratorBase.buildPhotoField('QR-Code', battery['photoQrCode']));
        fields.add(PdfGeneratorBase.buildPhotoField('Anschlüsse', battery['photoBatteryConnections']));
        fields.add(PdfGeneratorBase.buildPhotoField('EMS-Nummer', battery['photoEmsNumber']));
        fields.add(PdfGeneratorBase.buildPhotoField('AC-Stecker geöffnet', battery['photoAcPlugOpen']));
        fields.add(PdfGeneratorBase.buildPhotoField('Einheit ohne Abdeckungen', battery['photoBatteryWithoutCovers']));
        fields.add(PdfGeneratorBase.buildPhotoField('Einheit mit Abdeckungen', battery['photoBatteryWithCovers']));
        fields.add(PdfGeneratorBase.buildPhotoField('Einheit aus der Distanz', battery['photoBatteryFromDistance']));
        fields.add(PdfGeneratorBase.buildPhotoField('Batteriesockel nivelliert', battery['photoBatteryBase']));
        fields.add(PdfGeneratorBase.buildPhotoField('Batterieerdung', battery['photoBatteryEarthing']));
        fields.add(PdfGeneratorBase.buildPhotoField('Batterieturm Endmontage', battery['photoBatteryTowerFinal']));
        if (i < batteries.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Batteriespeicher', fields);
  }

//! IDK if they needs it or not 
  // static pw.Widget _buildEquipotentialBondingSection(Map<String, dynamic> data) {
  //   return PdfGeneratorBase.buildSection('Potenzialausgleichsschiene', [
  //     PdfGeneratorBase.buildFieldRow('Komponenten wie vorgegeben angeschlossen', _yesNo(data['componentsConnected'])),
  //     PdfGeneratorBase.buildFieldRow('Erdung angeschlossen', _yesNo(data['eqEarthingConnected'])),
  //     PdfGeneratorBase.buildFieldRow('UK angeschlossen', _yesNo(data['eqUkConnected'])),
  //     PdfGeneratorBase.buildFieldRow('DC-Überspannungsschutz angeschlossen', _yesNo(data['eqDcOvervoltageConnected'])),
  //     PdfGeneratorBase.buildFieldRow('Wechselrichter angeschlossen', _yesNo(data['eqInverterConnected'])),
  //     PdfGeneratorBase.buildPhotoField('Foto Potenzialausgleich', data['photoBonding']),
  //   ]);
  // }

  static pw.Widget _buildDistributionBoardSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final boards = repeatableData['distribution_board'] ?? [];
    final fields = <pw.Widget>[];

    if (boards.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Unterverteiler', 'Keine Daten'));
    } else {
      for (var i = 0; i < boards.length; i++) {
        final board = boards[i];
        fields.add(pw.Text(
          'Unterverteiler #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildPhotoField('Foto', board['photoDistBoard']));
        fields.add(PdfGeneratorBase.buildFieldRow('Zusätzliche Details', PdfGeneratorBase.safeString(board['additionalDetails'])));
        if (i < boards.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Unterverteiler', fields);
  }

  static pw.Widget _buildMeterCabinetSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Zählerschrank', [
      PdfGeneratorBase.buildFieldRow('Neuer Schrank installiert', _yesNo(data['newCabinetInstalled'])),
      PdfGeneratorBase.buildFieldRow('Alle Komponenten installiert', _yesNo(data['allComponentsInstalled'])),
      PdfGeneratorBase.buildFieldRow('Berührungsschutz', _yesNo(data['touchProtection'])),
      PdfGeneratorBase.buildPhotoField('Foto Schrank', data['photoCabinet']),
      PdfGeneratorBase.buildFieldRow(
        'APZ-Verdrahtung vorhanden',
        _yesNo(data['apzWiring'] ?? data['apzWiringConnected']),
      ),
      PdfGeneratorBase.buildFieldRow('APZ installiert', _yesNo(data['apzInstalled'])),
      PdfGeneratorBase.buildPhotoField('Neue Sicherung (lesbar)', data['photoNewFuse']),
      PdfGeneratorBase.buildPhotoField('Kabel in APZ', data['photoApzCable']),
      PdfGeneratorBase.buildPhotoField('APZ-Verdrahtung am Zähler', data['photoApzWiringMeter']),
      PdfGeneratorBase.buildFieldRow('Änderungen an bestehender Elektroanlage', PdfGeneratorBase.safeString(data['existingSystemChanges'])),
      PdfGeneratorBase.buildFieldRow('EnerGrid oder gleichwertig installiert', _yesNo(data['energridInstalled'])),
      PdfGeneratorBase.buildPhotoField('Foto EnerGrid', data['photoEnergrid']),
      PdfGeneratorBase.buildPhotoField('PV-Aufkleber', data['photoPvLabel']),
      PdfGeneratorBase.buildPhotoField('Neuer Schrank', data['photoNewCabinet']),
      PdfGeneratorBase.buildPhotoField('Alter Schrank', data['photoOldCabinet']),
      PdfGeneratorBase.buildPhotoField('SLS / NH', data['photoSlsOrNh']),
      PdfGeneratorBase.buildPhotoField('AC-Überspannungsschutz', data['photoAcOvervoltage']),
      PdfGeneratorBase.buildPhotoField('RCD', data['photoRcd']),
      PdfGeneratorBase.buildPhotoField('Kabelweg zum neuen Schrank', data['photoCableRouteToNewCabinet']),
      PdfGeneratorBase.buildPhotoField('APZ-Kabel innen', data['photoApzCableInside']),
      PdfGeneratorBase.buildPhotoField('APZ-Zähleranschlüsse', data['photoApzMeterConnections']),
    ]);
  }

  static pw.Widget _buildProtectionDevicesSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final devices = repeatableData['protection_devices'] ?? [];
    final fields = <pw.Widget>[];

    if (devices.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Neue Schutzgeräte', 'Keine Daten'));
    } else {
      for (var i = 0; i < devices.length; i++) {
        final device = devices[i];
        fields.add(pw.Text(
          'Schutzgerät #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildPhotoField('Foto', device['photoProtectionDevice']));
        fields.add(PdfGeneratorBase.buildFieldRow('Keine Änderungen vorgenommen', _yesNo(device['noChangesMade'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Netzstabilität getestet', _yesNo(device['systemStabilityTested'])));
        fields.add(PdfGeneratorBase.buildFieldRow('EnerGrid verwendet', _yesNo(device['enerGridUsed'])));
        if (i < devices.length - 1) {
          fields.add(pw.SizedBox(height: 10));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Neue Schutzgeräte', fields);
  }

  static pw.Widget _buildMeterRegistrationSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[];
    final registrations = repeatableData['meter_registration'] ?? [];
    final existingMeters = repeatableData['existingMeters'] ?? [];

    if (existingMeters.isNotEmpty) {
      for (var i = 0; i < existingMeters.length; i++) {
        final meter = existingMeters[i];
        fields.add(pw.Text('Vorhandener Zähler #${i + 1}', style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10)));
        fields.add(PdfGeneratorBase.buildFieldRow('Zählernummer', PdfGeneratorBase.safeString(meter['meterNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Zweck', PdfGeneratorBase.safeString(meter['meterType'])));
        fields.add(PdfGeneratorBase.buildPhotoField('Zählerfoto', meter['photoMeter']));
      }
    }

    for (var i = 0; i < registrations.length; i++) {
      final reg = registrations[i];
      fields.add(pw.SizedBox(height: 8));
      fields.add(pw.Text('Zähleranmeldung #${i + 1}', style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10)));
      fields.add(PdfGeneratorBase.buildFieldRow('Neuer Zählertyp', PdfGeneratorBase.safeString(reg['newMeterType'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Fernsteuerung vorhanden', _yesNo(reg['remoteControlPrdesent'])));
      if (reg['remoteControlPrdesent'] == true || reg['remoteControlPrdesent'] == 'yes') {
        fields.add(PdfGeneratorBase.buildPhotoField('Foto Fernsteuerung', reg['photoRemoteControl']));
      }
      fields.add(PdfGeneratorBase.buildFieldRow('Fernsteuerung entfernen', _yesNo(reg['removeRemoteControl'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Zählerzusammenlegung', _yesNo(reg['meterConsolidation'])));
      if (reg['meterConsolidation'] == true || reg['meterConsolidation'] == 'yes') {
        fields.add(PdfGeneratorBase.buildFieldRow('Beschreibung Zusammenlegung', PdfGeneratorBase.safeString(reg['consolidationDescription'])));
      }
      fields.add(PdfGeneratorBase.buildFieldRow('Bemerkungen', PdfGeneratorBase.safeString(reg['meterRemarks'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Ausbau erforderlich', _yesNo(reg['meterRemovalNeeded'])));
      fields.add(PdfGeneratorBase.buildFieldRow('Austausch erforderlich', _yesNo(reg['meterReplacementNeeded'])));
      fields.add(PdfGeneratorBase.buildPhotoField('Zählerstand', reg['photoMeterReadings']));
      fields.add(PdfGeneratorBase.buildFieldRow('Messkonzept', PdfGeneratorBase.safeString(reg['measurementConcept'])));
    }

    return PdfGeneratorBase.buildSection('Zähleranmeldung (IBN)', fields);
  }

  static pw.Widget _buildHeatPumpSection(Map<String, dynamic> data) {
    final ordered = data['heatPumpOrdered'] ?? data['heatPumpRequested'];
    final isOrdered = ordered == true || ordered == 'yes';
    return PdfGeneratorBase.buildSection('Wärmepumpenauftrag', [
      PdfGeneratorBase.buildFieldRow('Wärmepumpe bei MAM Solarbau beauftragt', _yesNo(ordered)),
      if (isOrdered) ...[
        PdfGeneratorBase.buildPhotoField('Unterverteiler / ZK-Integration', data['photoSubDistribution']),
        PdfGeneratorBase.buildPhotoField('Wärmepumpensicherungen (lesbar)', data['photoFusesHeatPump']),
      ],
    ]);
  }

  static pw.Widget _buildCableRoutesSection(Map<String, dynamic> data) {
    final over25m = data['routeOver25m'] == true || data['routeOver25m'] == 'yes';
    return PdfGeneratorBase.buildSection('Kabelwege', [
      PdfGeneratorBase.buildPhotoField('Vollständiger AC-Kabelweg', data['photoCableRoute']),
      PdfGeneratorBase.buildFieldRow('Kabelweg über 25 m', _yesNo(data['routeOver25m'])),
      if (over25m)
        PdfGeneratorBase.buildFieldRow('Zusätzliche Meter installiert', PdfGeneratorBase.safeString(data['additionalMeters'])),
      PdfGeneratorBase.buildFieldRow('Hinweise', PdfGeneratorBase.safeString(data['notes'])),
    ]);
  }

  static pw.Widget _buildCleanlinessSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Sauberkeit', [
      PdfGeneratorBase.buildFieldRow(
        'Abfall im eigenen Fahrzeug entsorgt, Baustelle sauber hinterlassen',
        _yesNo(data['siteCleanedUp']),
      ),
    ]);
  }

  static pw.Widget _buildFinalAcceptanceSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Abschlussprüfung', [
      PdfGeneratorBase.buildFieldRow('Alle Details eingetragen und mit Kunde besprochen', _yesNo(data['detailsRecorded'])),
      PdfGeneratorBase.buildFieldRow('Abschlussdatum', PdfGeneratorBase.safeString(data['completionDate'])),
      PdfGeneratorBase.buildFieldRow('Abschlusszeit', PdfGeneratorBase.safeString(data['completionTime'])),
      PdfGeneratorBase.buildFieldRow('Anlage betriebsbereit', _yesNo(data['systemOperational'])),
      PdfGeneratorBase.buildFieldRow('Kunde eingewiesen', _yesNo(data['customerInformed'])),
      PdfGeneratorBase.buildFieldRow('Rechnung genehmigt', _yesNo(data['invoiceApproved'])),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Bemerkungen', [
      PdfGeneratorBase.buildFieldRow('Bemerkungen', PdfGeneratorBase.safeString(data['remarksGeneral'])),
    ]);
  }

  static pw.Widget _buildAdditionalInfoSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final infoList = repeatableData['additional_info'] ?? [];
    final fields = <pw.Widget>[];

    if (infoList.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Zusatzinformationen', 'Keine Daten'));
    } else {
      for (var i = 0; i < infoList.length; i++) {
        final item = infoList[i];
        fields.add(pw.Text(
          'Zusatzinfo #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Hinweis', PdfGeneratorBase.safeString(item['note'])));
        fields.add(PdfGeneratorBase.buildPhotoField('Bild', item['image']));
        if (i < infoList.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Zusatzinformationen', fields);
  }

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Unterschriften', [
      PdfGeneratorBase.buildFieldRow('Vollständiger Name des Kunden', PdfGeneratorBase.safeString(data['customerFullName'])),
      PdfGeneratorBase.buildSignatureField('Unterschrift Kunde / Bevollmächtigter', data['customerSignature'] as String?),
      PdfGeneratorBase.buildDisplayTextField(
        'Der Anlagenbetreiber und das Installationsunternehmen erklären, dass die oben genannte Anlage am Datum der Unterzeichnung der AC- und DC-Abnahmeprotokolle technisch betriebsbereit im Sinne von § 3 Nr. 30 EEG (2021) ist.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'Die Einspruchsfrist beträgt 14 Tage; nach Ablauf dieser Frist gilt das Abnahmeprotokoll als bestätigt.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'Der ausführende Elektroinstallateur bestätigt mit seiner Unterschrift, dass die Elektroanlage gemäß den aktuell geltenden DIN-VDE-Normen sowie TAB und TAR installiert, gemessen und abgenommen wurde.',
      ),
      PdfGeneratorBase.buildSignatureField('Unterschrift Elektriker / Vor-Ort-Partner', data['installerSignature'] as String?),
    ]);
  }

  /// Hilfsfunktion: wandelt bool, 'yes'/'no' oder null in 'Ja' / 'Nein' um
  static String _yesNo(dynamic value) {
    if (value == true || value == 'yes') return 'Ja';
    if (value == false || value == 'no') return 'Nein';
    if (value == 'not_possible') return 'Nicht möglich';
    return '-';
  }
}