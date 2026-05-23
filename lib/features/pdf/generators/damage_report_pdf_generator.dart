import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class DamageReportPdfGenerator {
  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'DR', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'Damage Report',
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
    return PdfGeneratorBase.buildSection('Damage Declaration', [
      PdfGeneratorBase.buildFieldRow('Damage Type', PdfGeneratorBase.safeString(data['damageType'])),
      PdfGeneratorBase.buildFieldRow('Caused by Partner', data['causedByPartner'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Company Liability', data['companyLiability'] == true ? 'Yes' : 'No'),
    ]);
  }

  static pw.Widget _buildCustomerSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Customer / Injured Party', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['injuredName'])),
      PdfGeneratorBase.buildFieldRow('Street', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('ZIP', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('City', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('Phone', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('Email', PdfGeneratorBase.safeString(data['email'])),
    ]);
  }

  static pw.Widget _buildIncidentSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Incident Details', [
      PdfGeneratorBase.buildFieldRow('Date', PdfGeneratorBase.safeString(data['incidentDateTime'])),
      PdfGeneratorBase.buildFieldRow('Time', PdfGeneratorBase.safeString(data['incidentTime'])),
      PdfGeneratorBase.buildFieldRow('Second Person', data['secondPersonInvolved'] == true ? 'Yes' : 'No'),
    ]);
  }

  static pw.Widget _buildDamageDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Damage Description', [
      PdfGeneratorBase.buildFieldRow('Initial Situation', PdfGeneratorBase.safeString(data['initialSituation'])),
      PdfGeneratorBase.buildFieldRow('Incident Sequence', PdfGeneratorBase.safeString(data['incidentSequence'])),
    ]);
  }

  static pw.Widget _buildAffectedDevicesSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final devices = repeatableData['affected_devices'] ?? [];
    final fields = <pw.Widget>[];
    if (devices.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Devices', 'None'));
    } else {
      for (var i = 0; i < devices.length; i++) {
        final d = devices[i];
        fields.add(pw.Text(
          'Device #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(d['deviceName'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Brand', PdfGeneratorBase.safeString(d['deviceBrand'])));
        fields.add(PdfGeneratorBase.buildPhotoField('Photo', d['devicePhoto'] as String?));
        fields.add(PdfGeneratorBase.buildFieldRow('Damage', PdfGeneratorBase.safeString(d['damageDescription'])));
        if (i < devices.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Affected Devices', fields);
  }

  static pw.Widget _buildMinimizationSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Damage Minimization', [
      PdfGeneratorBase.buildFieldRow('Minimization Possible', data['minimizationPossible'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Notes', PdfGeneratorBase.safeString(data['minimizationNotes'])),
    ]);
  }

  static pw.Widget _buildInsuranceSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Insurance', [
      PdfGeneratorBase.buildFieldRow('Notes', PdfGeneratorBase.safeString(data['insuranceNotes'])),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Remarks', [
      PdfGeneratorBase.buildFieldRow('Remarks', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }

  static pw.Widget _buildEmployeeSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Employee Info', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['employeeName'])),
    ]);
  }

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Signatures', [
      PdfGeneratorBase.buildSignatureField('Damaged Party', data['damagedPartySignature'] as String?),
      PdfGeneratorBase.buildSignatureField('Employee', data['employeeSignature'] as String?),
    ]);
  }
}
