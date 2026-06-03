import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class AcProtocolPdfGenerator {
  // ─── Expected keys for audit/logging ──────────────────────────────────────

  static const _expectedFlatKeys = [
    // Customer Data
    'customerName', 'street', 'houseNumber', 'zipCode', 'city', 'email',

    // Installation Details
    'installationType', 'storageManufacturer',
    'wallboxAvailable', 'backupAvailable', 'testPerformed',
    'installationDate', 'installerName',

    // Storage (flat)
    'storageModel', 'storageCount',

    // Inverter (flat)
    'inverterCount',

    // Meter Cabinet
    'photoCabinet',
    'cabinetClean', 'cabinetLabeled', 'vdeTested', 'plumbed',

    // Meter IBN
    'counterType', 'photoMeter', 'meterReplaced',

    // Diploma
    'remarks', 'completionDate',

    // Signatures
    'location', 'sigCustomerFullName', 'customerEmail',
    'customerSignature', 'electricianSignature',
  ];

  static const _expectedRepeatableKeys = {
    'storage_details': [
      'serialNumberStorage',
      'photoQrCode',
      'photoConnections',
    ],
    'inverter_details': ['serialNumberInverter', 'photoDataplate'],
    'cable_routes': ['photoCableRoute', 'cableLength'],
  };

  // ─── Entry point ──────────────────────────────────────────────────────────

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(
      data,
      'AcProtocolPdfGenerator',
      _expectedFlatKeys,
    );
    PdfGeneratorBase.logExpectedRepeatableFields(
      repeatableData,
      'AcProtocolPdfGenerator',
      _expectedRepeatableKeys,
    );

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'AC',
      DateTime.now(),
      protocolId,
    );

    // Build each section — null means nothing was filled, skip it entirely
    final sections = [
      _buildCustomerDataSection(data),
      _buildInstallationDetailsSection(data),
      _buildStorageSection(data, repeatableData),
      _buildInverterSection(data, repeatableData),
      _buildMeterCabinetSection(data),
      _buildMeterIbnSection(data),
      _buildCableRoutesSection(repeatableData),
      _buildDiplomaSection(data),
      _buildAdditionalInfoSection(repeatableData),
      _buildSignaturesSection(data),
    ].whereType<pw.Widget>().toList();

    return PdfGeneratorBase.createDocument(
      title: 'AC Acceptance Protocol',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: sections,
    );
  }

  // ─── Sections — return null if nothing to show ────────────────────────────

  static pw.Widget? _buildCustomerDataSection(Map<String, dynamic> data) {
    final fields = [
      ..._field('Name', data['customerName']),
      ..._field('Street', data['street']),
      ..._field('House Number', data['houseNumber']),
      ..._field('ZIP Code', data['zipCode']),
      ..._field('City', data['city']),
      ..._field('Email', data['email']),
    ];
    return _section('Customer Data', fields);
  }

  static pw.Widget? _buildInstallationDetailsSection(
    Map<String, dynamic> data,
  ) {
    final fields = [
      ..._fieldMapped(
        'Installation Type',
        data['installationType'],
        _installationType,
      ),
      ..._field('Storage Manufacturer', data['storageManufacturer']),
      ..._checkbox('Wallbox Available', data['wallboxAvailable']),
      ..._checkbox('Backup Available', data['backupAvailable']),
      ..._checkbox('Test Performed', data['testPerformed']),
      ..._field('Installation Date', data['installationDate']),
      ..._field('Installer Name', data['installerName']),
    ];
    return _section('Installation Details', fields);
  }

  static pw.Widget? _buildStorageSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[
      ..._field('Storage Model', data['storageModel']),
      ..._field('Number of Storage Units', data['storageCount']),
    ];

    final details = repeatableData['storage_details'] ?? [];
    for (var i = 0; i < details.length; i++) {
      final item = details[i];
      final itemFields = [
        ..._field('Serial Number', item['serialNumberStorage']),
        ..._photo('QR Code', item['photoQrCode']),
        ..._photo('Connections', item['photoConnections']),
      ];
      if (itemFields.isNotEmpty) {
        fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'Storage Unit #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('Storage', fields);
  }

  static pw.Widget? _buildInverterSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final fields = <pw.Widget>[
      ..._field('Number of Inverters', data['inverterCount']),
    ];

    final details = repeatableData['inverter_details'] ?? [];
    for (var i = 0; i < details.length; i++) {
      final item = details[i];
      final itemFields = [
        ..._field('Serial Number', item['serialNumberInverter']),
        ..._photo('Nameplate', item['photoDataplate']),
      ];
      if (itemFields.isNotEmpty) {
        fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'Inverter #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('Inverter', fields);
  }

  static pw.Widget? _buildMeterCabinetSection(Map<String, dynamic> data) {
    final fields = [
      ..._photo('Cabinet Photos', data['photoCabinet']),
      ..._checkbox('Cabinet Clean?', data['cabinetClean']),
      ..._checkbox('Cabinet Labeled?', data['cabinetLabeled']),
      ..._checkbox('VDE Tested?', data['vdeTested']),
      ..._checkbox('Plumbed?', data['plumbed']),
    ];
    return _section('Meter Cabinet', fields);
  }

  static pw.Widget? _buildMeterIbnSection(Map<String, dynamic> data) {
    final fields = [
      ..._fieldMapped('Counter Type', data['counterType'], _counterType),
      ..._photo('Meter Photo', data['photoMeter']),
      ..._checkbox('Meter Replaced?', data['meterReplaced']),
    ];
    return _section('Meter IBN', fields);
  }

  static pw.Widget? _buildCableRoutesSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final routes = repeatableData['cable_routes'] ?? [];
    final fields = <pw.Widget>[];

    for (var i = 0; i < routes.length; i++) {
      final route = routes[i];
      final itemFields = [
        ..._photo('Cable Route Photo', route['photoCableRoute']),
        ..._field('Cable Length (m)', route['cableLength']),
      ];
      if (itemFields.isNotEmpty) {
        if (fields.isNotEmpty) fields.add(pw.SizedBox(height: 6));
        fields.add(
          pw.Text(
            'Cable Route #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.addAll(itemFields);
      }
    }

    return _section('Cable Routes', fields);
  }

  static pw.Widget? _buildDiplomaSection(Map<String, dynamic> data) {
    final fields = [
      ..._field('Remarks', data['remarks']),
      ..._field('Completion Date', data['completionDate']),
    ];
    return _section('Diploma', fields);
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

    return PdfGeneratorBase.buildSection('Zusatzinformationen', fields);
  }

  static pw.Widget? _buildSignaturesSection(Map<String, dynamic> data) {
    final fields = [
      ..._field('Location', data['location']),
      ..._field('Customer Full Name', data['sigCustomerFullName']),
      ..._field('Customer Email', data['customerEmail']),
      ..._signature('Customer Signature', data['customerSignature']),
      ..._signature('Electrician Signature', data['electricianSignature']),
    ];
    return _section('Signatures', fields);
  }

  // ─── Section builder — returns null if fields list is empty ───────────────

  static pw.Widget? _section(String title, List<pw.Widget> fields) {
    if (fields.isEmpty) return null;
    return PdfGeneratorBase.buildSection(title, fields);
  }

  // ─── Conditional field helpers ────────────────────────────────────────────

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

  // ─── Value helpers ────────────────────────────────────────────────────────

  static String _yesNo(dynamic value) {
    if (value == true || value == 'yes') return 'Yes';
    if (value == false || value == 'no') return 'No';
    return '-';
  }

  static String _installationType(dynamic value) {
    switch (value) {
      case 'pv_with_storage':
        return 'Photovoltaic System with Storage';
      case 'pv_without_storage':
        return 'Photovoltaic System without Storage';
      case 'pv_storage_expansion':
        return 'Photovoltaic System with Storage Expansion';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }

  static String _counterType(dynamic value) {
    switch (value) {
      case 'single_rate':
        return 'Single Rate';
      case 'two_rate':
        return 'Two Rate';
      case 'smart_meter':
        return 'Smart Meter';
      case 'miscellaneous':
        return 'Miscellaneous';
      default:
        return PdfGeneratorBase.safeString(value);
    }
  }
}
