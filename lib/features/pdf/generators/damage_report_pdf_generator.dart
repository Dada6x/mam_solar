import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class DamageReportPdfGenerator {
  static const _expectedFlatKeys = [
    'damageType', 'causedByPartner', 'companyLiability',
    'injuredName', 'street', 'zipCode', 'city', 'phone', 'email',
    'incidentDate', 'incidentTime', 'secondPersonInvolved',
    'initialSituation', 'incidentSequence',
    'minimizationPossible', 'minimizationNotes',
    'insuranceNotes',
    'remarks', 'employeeName',
    'damagedPartySignature', 'employeeSignature',
  ];

  static const _expectedRepeatableKeys = {
    'affected_devices': ['deviceName', 'deviceBrand', 'devicePhoto', 'damageDescription'],
  };

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(data, 'DamageReportPdfGenerator', _expectedFlatKeys);
    PdfGeneratorBase.logExpectedRepeatableFields(repeatableData, 'DamageReportPdfGenerator', _expectedRepeatableKeys);

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'DR', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'Schadensbericht',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildDamageDeclarationSection(data),
        _buildCustomerSection(data),
        _buildIncidentSection(data),
        _buildDamageDescriptionSection(data),
        _buildAffectedDevicesSection(repeatableData),
        _buildMinimizationSection(data),
        _buildInsuranceSection(data),
        _buildRemarksSection(data),
        _buildEmployeeSection(data),
        _buildSignaturesSection(data),
      ],
    );
  }

  static pw.Widget _buildDamageDeclarationSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Schadensmeldung', [
      PdfGeneratorBase.buildFieldRow('Schadensart', PdfGeneratorBase.safeString(data['damageType'])),
      PdfGeneratorBase.buildFieldRow('Durch Partner verursacht', data['causedByPartner'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Unternehmenshaftung', data['companyLiability'] == true ? 'Ja' : 'Nein'),
    ]);
  }

  static pw.Widget _buildCustomerSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Kunde / Geschädigte Partei', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['injuredName'])),
      PdfGeneratorBase.buildFieldRow('Straße', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('PLZ', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('Ort', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('Telefon', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('E-Mail', PdfGeneratorBase.safeString(data['email'])),
    ]);
  }

  static pw.Widget _buildIncidentSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Vorfallsdetails', [
      PdfGeneratorBase.buildFieldRow('Datum', PdfGeneratorBase.safeString(data['incidentDate'])),
      PdfGeneratorBase.buildFieldRow('Uhrzeit', PdfGeneratorBase.safeString(data['incidentTime'])),
      PdfGeneratorBase.buildFieldRow('Zweite Person beteiligt', data['secondPersonInvolved'] == true ? 'Ja' : 'Nein'),
    ]);
  }

  static pw.Widget _buildDamageDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Schadensbeschreibung', [
      PdfGeneratorBase.buildFieldRow('Ausgangssituation', PdfGeneratorBase.safeString(data['initialSituation'])),
      PdfGeneratorBase.buildFieldRow('Ablauf des Vorfalls', PdfGeneratorBase.safeString(data['incidentSequence'])),
    ]);
  }

  static pw.Widget _buildAffectedDevicesSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final devices = repeatableData['affected_devices'] ?? [];
    final fields = <pw.Widget>[];

    if (devices.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Geräte', 'Keine'));
    } else {
      for (var i = 0; i < devices.length; i++) {
        final d = devices[i];
        fields.add(pw.Text(
          'Gerät #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(d['deviceName'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Marke', PdfGeneratorBase.safeString(d['deviceBrand'])));
        fields.add(PdfGeneratorBase.buildPhotoField('Foto', d['devicePhoto'] as String?));
        fields.add(PdfGeneratorBase.buildFieldRow('Schaden', PdfGeneratorBase.safeString(d['damageDescription'])));
        if (i < devices.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Betroffene Geräte', fields);
  }

  static pw.Widget _buildMinimizationSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Schadensminimierung', [
      PdfGeneratorBase.buildFieldRow('Schadensminimierung möglich', data['minimizationPossible'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Notizen', PdfGeneratorBase.safeString(data['minimizationNotes'])),
    ]);
  }

  static pw.Widget _buildInsuranceSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Versicherung', [
      PdfGeneratorBase.buildFieldRow('Notizen', PdfGeneratorBase.safeString(data['insuranceNotes'])),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Bemerkungen', [
      PdfGeneratorBase.buildFieldRow('Bemerkungen', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }

  static pw.Widget _buildEmployeeSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Mitarbeiterinformationen', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['employeeName'])),
    ]);
  }

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Unterschriften', [
      PdfGeneratorBase.buildSignatureField('Geschädigte Partei', data['damagedPartySignature'] as String?),
      PdfGeneratorBase.buildSignatureField('Mitarbeiter', data['employeeSignature'] as String?),
    ]);
  }
}