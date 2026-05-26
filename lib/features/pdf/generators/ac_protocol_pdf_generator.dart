import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class AcProtocolPdfGenerator {
  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'AC', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'AC Abnahme',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildCustomerDataSection(data),
        _buildInstallationDetailsSection(data),
        _buildInverterSection(repeatableData),
        _buildBatteryStorageSection(data),
        _buildEqualizationBarSection(data),
        _buildDistributionBoardSection(data),
        _buildMeterCabinetSection(data),
        _buildProtectionDevicesSection(data),
        _buildMeterInfoSection(data),
        _buildSection14aSection(data),
        _buildHeatPumpSection(data),
        _buildCableRoutesSection(data),
        _buildFinalAcceptanceSection(data),
        _buildRemarksSection(data),
        _buildSignaturesSection(data),
      ],
    );
  }

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Kundendaten', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['customerName'])),
      PdfGeneratorBase.buildFieldRow('Straße', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('Stadt', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('PLZ', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('E-Mail', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Telefon', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('Installationsdatum', PdfGeneratorBase.safeString(data['installationDate'])),
      PdfGeneratorBase.buildFieldRow('Installateur', PdfGeneratorBase.safeString(data['installerName'])),
      PdfGeneratorBase.buildFieldRow('Partnerunternehmen', PdfGeneratorBase.safeString(data['partnerCompany'])),
    ]);
  }

  static pw.Widget _buildInstallationDetailsSection(Map<String, dynamic> data) {
    final inspectionCompleted = data['inspectionCompleted'] == true;
    return PdfGeneratorBase.buildSection('Installationsdetails', [
      PdfGeneratorBase.buildFieldRow('Typ', PdfGeneratorBase.safeString(data['installationType'])),
      PdfGeneratorBase.buildFieldRow('Speicherhersteller', PdfGeneratorBase.safeString(data['storageManufacturer'])),
      PdfGeneratorBase.buildFieldRow('Wallbox', data['wallboxInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Backup', data['backupInstalled'] == true ? 'Ja' : 'Nein'),
      if (data['backupInstalled'] != true)
        PdfGeneratorBase.buildFieldRow('Backup-Hinweis', PdfGeneratorBase.safeString(data['backupHint'])),
      PdfGeneratorBase.buildFieldRow('Inspektion', inspectionCompleted ? 'Ja' : 'Nein'),
      if (!inspectionCompleted)
        PdfGeneratorBase.buildFieldRow('Inspektionsgrund', PdfGeneratorBase.safeString(data['inspectionReason'])),
      PdfGeneratorBase.buildFieldRow('Erdungsstab', data['groundRodInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Privater Zähler', data['privateMeterInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Einweisung', data['supervisorIntroduced'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Überschuhe', data['shoeCoversWorn'] == true ? 'Ja' : 'Nein'),
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
        fields.add(PdfGeneratorBase.buildFieldRow('Anzahl', PdfGeneratorBase.safeString(inv['inverterCount'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Marke', PdfGeneratorBase.safeString(inv['brand'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Modell', PdfGeneratorBase.safeString(inv['model'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Seriennummer', PdfGeneratorBase.safeString(inv['serialNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Netztyp', PdfGeneratorBase.safeString(inv['networkType'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Korrekt installiert', inv['installedCorrectly'] == true ? 'Ja' : 'Nein'));
        fields.add(PdfGeneratorBase.buildFieldRow('Feuerfeste Oberfläche', inv['mountedOnFireproofSurface'] == true ? 'Ja' : 'Nein'));
        fields.add(PdfGeneratorBase.buildFieldRow('Herstellerstandards eingehalten', inv['manufacturerStandardsFollowed'] == true ? 'Ja' : 'Nein'));
        fields.add(PdfGeneratorBase.buildPhotoField('Typenschild', inv['photoDataplate'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('AC-Netz', inv['photoAcGrid'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('AC-Backup', inv['photoAcBackup'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Kommunikationsstecker', inv['photoCommunicationPlug'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Drei Kommunikationsports', inv['photoThreeCommunicationPorts'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Erdung links', inv['photoEarthingLeft'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Erdung rechts', inv['photoEarthingRight'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('PLC / WLAN-Verstärker', inv['photoPlcOrWlanExtender'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('DC-Batteriekabel', inv['photoDcBatteryCables'] as String?));
        fields.add(PdfGeneratorBase.buildPhotoField('Endmontage', inv['photoFinalInstall'] as String?));
        if (i < inverters.length - 1) {
          fields.add(pw.SizedBox(height: 6));
        }
      }
    }
    return PdfGeneratorBase.buildSection('Wechselrichter', fields);
  }

  static pw.Widget _buildBatteryStorageSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Batteriespeicher', [
      PdfGeneratorBase.buildFieldRow('Marke', PdfGeneratorBase.safeString(data['batteryBrand'])),
      PdfGeneratorBase.buildFieldRow('Modell', PdfGeneratorBase.safeString(data['batteryModel'])),
      PdfGeneratorBase.buildFieldRow('Installierte Einheiten', PdfGeneratorBase.safeString(data['batteryCount'])),
      PdfGeneratorBase.buildFieldRow('SID', PdfGeneratorBase.safeString(data['batterySid'])),
      PdfGeneratorBase.buildFieldRow('Türme', PdfGeneratorBase.safeString(data['batteryTowers'])),
      PdfGeneratorBase.buildFieldRow('Module/Turm', PdfGeneratorBase.safeString(data['batteryModulesPerTower'])),
      PdfGeneratorBase.buildFieldRow('Seriennummern', PdfGeneratorBase.safeString(data['serialNumbers'])),
      PdfGeneratorBase.buildFieldRow('Standards eingehalten', data['standardsFollowed'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildPhotoField('QR-Code', data['photoQrCode'] as String?),
      PdfGeneratorBase.buildPhotoField('Anschlüsse', data['photoBatteryConnections'] as String?),
      PdfGeneratorBase.buildPhotoField('EMS-Nummer', data['photoEmsNumber'] as String?),
      PdfGeneratorBase.buildPhotoField('AC-Stecker offen', data['photoAcPlugOpen'] as String?),
      PdfGeneratorBase.buildPhotoField('Einheit ohne Abdeckungen', data['photoBatteryWithoutCovers'] as String?),
      PdfGeneratorBase.buildPhotoField('Einheit mit Abdeckungen', data['photoBatteryWithCovers'] as String?),
      PdfGeneratorBase.buildPhotoField('Einheit aus der Distanz', data['photoBatteryFromDistance'] as String?),
      PdfGeneratorBase.buildPhotoField('Batteriesockel nivelliert', data['photoBatteryBase'] as String?),
      PdfGeneratorBase.buildPhotoField('Batterieerdung', data['photoBatteryEarthing'] as String?),
      PdfGeneratorBase.buildPhotoField('Batterieturm Endmontage', data['photoBatteryTowerFinal'] as String?),
    ]);
  }

  static pw.Widget _buildEqualizationBarSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Potenzialausgleichsschiene', [
      PdfGeneratorBase.buildFieldRow('Erdung angeschlossen', data['eqEarthingConnected'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('UK angeschlossen', data['eqUkConnected'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('DC-Überspannungsschutz', data['eqDcOvervoltageConnected'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Wechselrichter WR angeschlossen', data['eqInverterConnected'] == true ? 'Ja' : 'Nein'),
    ]);
  }

  static pw.Widget _buildDistributionBoardSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Verteilerkasten', [
      PdfGeneratorBase.buildPhotoField('Verteilerkasten 1', data['photoDistBoard1'] as String?),
      PdfGeneratorBase.buildPhotoField('Verteilerkasten 2', data['photoDistBoard2'] as String?),
      PdfGeneratorBase.buildPhotoField('Verteilerkasten 3', data['photoDistBoard3'] as String?),
    ]);
  }

  static pw.Widget _buildMeterCabinetSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Zählerschrank', [
      PdfGeneratorBase.buildFieldRow('Neuer Schrank', data['newCabinetInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Alle Komponenten', data['allComponentsInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Berührungsschutz', data['touchProtection'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('APZ-Verdrahtung angeschlossen', data['apzWiringConnected'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('APZ installiert', data['apzInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Energrid', data['energridInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Keine Änderungen am Bestandssystem', data['noModificationsToExistingSystem'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Netzstabilität gewährleistet', data['gridStabilityEnsured'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildPhotoField('PV-Aufkleber', data['photoPvLabel'] as String?),
      PdfGeneratorBase.buildPhotoField('Neuer Schrank', data['photoNewCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('Alter Schrank', data['photoOldCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('SLS/NH', data['photoSlsOrNh'] as String?),
      PdfGeneratorBase.buildPhotoField('AC-Überspannungsschutz', data['photoAcOvervoltage'] as String?),
      PdfGeneratorBase.buildPhotoField('RCD', data['photoRcd'] as String?),
      PdfGeneratorBase.buildPhotoField('Kabelweg zum neuen Schrank', data['photoCableRouteToNewCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('APZ-Kabel innen', data['photoApzCableInside'] as String?),
      PdfGeneratorBase.buildPhotoField('APZ-Zähleranschlüsse', data['photoApzMeterConnections'] as String?),
    ]);
  }

  static pw.Widget _buildProtectionDevicesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Neue Schutzgeräte', [
      PdfGeneratorBase.buildPhotoField('Schutzgerät 1', data['photoProtectionDevice1'] as String?),
      PdfGeneratorBase.buildPhotoField('Schutzgerät 2', data['photoProtectionDevice2'] as String?),
      PdfGeneratorBase.buildPhotoField('Schutzgerät 3', data['photoProtectionDevice3'] as String?),
      PdfGeneratorBase.buildPhotoField('Schutzgerät 4', data['photoProtectionDevice4'] as String?),
    ]);
  }

  static pw.Widget _buildMeterInfoSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Zählerinformationen', [
      PdfGeneratorBase.buildFieldRow('Zählertyp', PdfGeneratorBase.safeString(data['meterType'])),
      PdfGeneratorBase.buildFieldRow('Ausbau erforderlich', data['meterRemovalNeeded'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Austausch erforderlich', data['meterReplacementNeeded'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Neuer Zählertyp', PdfGeneratorBase.safeString(data['newMeterType'])),
      PdfGeneratorBase.buildFieldRow('Fernsteuerung', data['remoteControl'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Zählerzusammenlegung', data['meterConsolidation'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Messkonzept', PdfGeneratorBase.safeString(data['measurementConcept'])),
      PdfGeneratorBase.buildPhotoField('Zähler', data['photoMeter'] as String?),
      PdfGeneratorBase.buildPhotoField('Zählerstände', data['photoMeterReadings'] as String?),
    ]);
  }

  static pw.Widget _buildSection14aSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('§14a Vorbereitung', [
      PdfGeneratorBase.buildPhotoField('§14a Vorbereitung', data['photoSection14a'] as String?),
    ]);
  }

  static pw.Widget _buildHeatPumpSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Wärmepumpenanfrage', [
      PdfGeneratorBase.buildFieldRow('Wärmepumpe bei BSH angefragt', data['heatPumpRequested'] == true ? 'Ja' : 'Nein'),
    ]);
  }

  static pw.Widget _buildCableRoutesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Kabelwege', [
      PdfGeneratorBase.buildFieldRow('Über 25m', data['routeOver25m'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Hinweise', PdfGeneratorBase.safeString(data['notes'])),
      PdfGeneratorBase.buildPhotoField('Kabel 1', data['photoCable1'] as String?),
      PdfGeneratorBase.buildPhotoField('Kabel 2', data['photoCable2'] as String?),
      PdfGeneratorBase.buildPhotoField('Kabel 3', data['photoCable3'] as String?),
      PdfGeneratorBase.buildPhotoField('Kabel 4', data['photoCable4'] as String?),
    ]);
  }

  static pw.Widget _buildFinalAcceptanceSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Endabnahme', [
      PdfGeneratorBase.buildFieldRow('System in Betrieb', data['systemOperational'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Kunde eingewiesen', data['customerInformed'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Rechnung genehmigt', data['invoiceApproved'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Aufräumen erledigt', data['cleanupDone'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Beigefügtes Messprotokoll', PdfGeneratorBase.safeString(data['measurementProtocol'])),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Bemerkungen', [
      PdfGeneratorBase.buildFieldRow('Bemerkungen', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Unterschriften', [
      PdfGeneratorBase.buildFieldRow('Ort', PdfGeneratorBase.safeString(data['signatureLocation'])),
      PdfGeneratorBase.buildSignatureField('Kunde', data['customerSignature'] as String?),
      PdfGeneratorBase.buildDisplayTextField(
        'Vom Anlagenbetreiber und Installationsbetrieb wird erklärt, dass die oben genannte Anlage technisch betriebsbereit i.S.d. § 3 Nr. 30 EEG (2021) ist, an dem das AC- und DC-Abnahmeprotokoll unterzeichnet vorliegen.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'Die Widerspruchsfrist beträgt 14 Tage, nach Ablauf der Frist gilt das Abnahmeprotokoll als bestätigt.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'Der ausführende Elektroinstallateur bestätigt mit seiner Unterschrift die elektrische Anlage nach den aktuell gültigen DIN-VDE Normen sowie TAB und TAR installiert, gemessen und abgenommen zu haben.',
      ),
      PdfGeneratorBase.buildSignatureField('Installateur', data['installerSignature'] as String?),
    ]);
  }
}