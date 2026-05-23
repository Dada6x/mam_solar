import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class InstallationReportPdfGenerator {
  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'IR', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'Installation Report',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildCustomerDataSection(data),
        _buildInstallationDetailsSection(data),
        _buildMeterCabinetSection(data),
        _buildRemarksSection(data),
        _buildSignaturesSection(data),
      ],
    );
  }

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Customer Data', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['customerName'])),
      PdfGeneratorBase.buildFieldRow('Street', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('City', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('ZIP', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('Email', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Phone', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('Installation Date', PdfGeneratorBase.safeString(data['installationDate'])),
      PdfGeneratorBase.buildFieldRow('Installer', PdfGeneratorBase.safeString(data['installerName'])),
      PdfGeneratorBase.buildFieldRow('Partner Company', PdfGeneratorBase.safeString(data['partnerCompany'])),
    ]);
  }

  static pw.Widget _buildInstallationDetailsSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Installation Details', [
      PdfGeneratorBase.buildFieldRow('Type', PdfGeneratorBase.safeString(data['installationType'])),
      PdfGeneratorBase.buildFieldRow('Storage Manufacturer', PdfGeneratorBase.safeString(data['storageManufacturer'])),
      PdfGeneratorBase.buildFieldRow('Wallbox', data['wallboxInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Backup', data['backupInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Ground Rod', data['groundRodInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Private Meter', data['privateMeterInstalled'] == true ? 'Yes' : 'No'),
    ]);
  }

  static pw.Widget _buildMeterCabinetSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Meter Cabinet', [
      PdfGeneratorBase.buildFieldRow('New Cabinet', data['newCabinetInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('All Components', data['allComponentsInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Touch Protection', data['touchProtection'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('APZ', data['apzInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Energrid', data['energridInstalled'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildPhotoField('New Cabinet', data['photoNewCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('Old Cabinet', data['photoOldCabinet'] as String?),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Remarks', [
      PdfGeneratorBase.buildFieldRow('Remarks', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Signatures', [
      PdfGeneratorBase.buildSignatureField('Customer', data['customerSignature'] as String?),
      PdfGeneratorBase.buildSignatureField('Installer', data['installerSignature'] as String?),
    ]);
  }
}
