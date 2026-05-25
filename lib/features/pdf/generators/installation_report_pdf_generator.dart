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
      title: 'Installationsbericht',
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
    return PdfGeneratorBase.buildSection('Kundendaten', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['customerName'])),
      PdfGeneratorBase.buildFieldRow('Straße', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('Ort', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('PLZ', PdfGeneratorBase.safeString(data['zipCode'])),
      PdfGeneratorBase.buildFieldRow('E-Mail', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Telefon', PdfGeneratorBase.safeString(data['phone'])),
      PdfGeneratorBase.buildFieldRow('Installationsdatum', PdfGeneratorBase.safeString(data['installationDate'])),
      PdfGeneratorBase.buildFieldRow('Installateur', PdfGeneratorBase.safeString(data['installerName'])),
      PdfGeneratorBase.buildFieldRow('Partnerunternehmen', PdfGeneratorBase.safeString(data['partnerCompany'])),
    ]);
  }

  static pw.Widget _buildInstallationDetailsSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Installationsdetails', [
      PdfGeneratorBase.buildFieldRow('Typ', PdfGeneratorBase.safeString(data['installationType'])),
      PdfGeneratorBase.buildFieldRow('Speicherhersteller', PdfGeneratorBase.safeString(data['storageManufacturer'])),
      PdfGeneratorBase.buildFieldRow('Wallbox installiert', data['wallboxInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Backup installiert', data['backupInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Erdungsstab installiert', data['groundRodInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Privater Zähler', data['privateMeterInstalled'] == true ? 'Ja' : 'Nein'),
    ]);
  }

  static pw.Widget _buildMeterCabinetSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Zählerschrank', [
      PdfGeneratorBase.buildFieldRow('Neuer Schrank', data['newCabinetInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Alle Komponenten installiert', data['allComponentsInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Berührungsschutz', data['touchProtection'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('APZ', data['apzInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Energrid', data['energridInstalled'] == true ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildPhotoField('Neuer Schrank', data['photoNewCabinet'] as String?),
      PdfGeneratorBase.buildPhotoField('Alter Schrank', data['photoOldCabinet'] as String?),
    ]);
  }

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Bemerkungen', [
      PdfGeneratorBase.buildFieldRow('Bemerkungen', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Unterschriften', [
      PdfGeneratorBase.buildSignatureField('Kunde', data['customerSignature'] as String?),
      PdfGeneratorBase.buildSignatureField('Installateur', data['installerSignature'] as String?),
    ]);
  }
}