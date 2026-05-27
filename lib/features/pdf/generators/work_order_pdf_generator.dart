import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class WorkOrderPdfGenerator {
  static const _expectedFlatKeys = [
    'fullName', 'street', 'zipCity', 'email',
    'description', 'workDetail',
    'workCompleted', 'photoWork1', 'photoWork2', 'completionDate',
    'remarks',
    'customerSignature', 'technicianSignature',
  ];

  static const _expectedRepeatableKeys = {
    'materials': ['quantity', 'material'],
    'travel': ['departure', 'destination'],
    'working_hours': ['date', 'techName', 'startTime', 'endTime'],
  };

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(data, 'WorkOrderPdfGenerator', _expectedFlatKeys);
    PdfGeneratorBase.logExpectedRepeatableFields(repeatableData, 'WorkOrderPdfGenerator', _expectedRepeatableKeys);

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'WO', DateTime.now(), protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'Work Order',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildCustomerDataSection(data),
        _buildWorkDescriptionSection(data),
        _buildMaterialsSection(repeatableData),
        _buildVehicleTravelSection(repeatableData),
        _buildWorkingHoursSection(repeatableData),
        _buildCompletionSection(data),
        _buildRemarksSection(data),
        _buildSignaturesSection(data),
      ],
    );
  }

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Customer Data', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['fullName'])),
      PdfGeneratorBase.buildFieldRow('Street', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('ZIP/City', PdfGeneratorBase.safeString(data['zipCity'])),
      PdfGeneratorBase.buildFieldRow('Email', PdfGeneratorBase.safeString(data['email'])),
    ]);
  }

  static pw.Widget _buildWorkDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Work Description', [
      PdfGeneratorBase.buildFieldRow('Description', PdfGeneratorBase.safeString(data['description'])),
      PdfGeneratorBase.buildFieldRow('Detail', PdfGeneratorBase.safeString(data['workDetail'])),
    ]);
  }

  static pw.Widget _buildMaterialsSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final materials = repeatableData['materials'] ?? [];
    final fields = <pw.Widget>[];
    if (materials.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Materials', 'None'));
    } else {
      for (var i = 0; i < materials.length; i++) {
        final m = materials[i];
        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Qty', PdfGeneratorBase.safeString(m['quantity'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Material', PdfGeneratorBase.safeString(m['material'])));
        if (i < materials.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Materials', fields);
  }

  static pw.Widget _buildVehicleTravelSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final travels = repeatableData['travel'] ?? [];
    final fields = <pw.Widget>[];
    if (travels.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Travel', 'None'));
    } else {
      for (var i = 0; i < travels.length; i++) {
        final t = travels[i];
        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Departure', PdfGeneratorBase.safeString(t['departure'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Destination', PdfGeneratorBase.safeString(t['destination'])));
        if (i < travels.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Vehicle / Travel', fields);
  }

  static pw.Widget _buildWorkingHoursSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final hours = repeatableData['working_hours'] ?? [];
    final fields = <pw.Widget>[];
    if (hours.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Hours', 'None'));
    } else {
      for (var i = 0; i < hours.length; i++) {
        final h = hours[i];
        fields.add(pw.Text(
          'Day #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Date', PdfGeneratorBase.safeString(h['date'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Technician', PdfGeneratorBase.safeString(h['techName'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Start', PdfGeneratorBase.safeString(h['startTime'])));
        fields.add(PdfGeneratorBase.buildFieldRow('End', PdfGeneratorBase.safeString(h['endTime'])));
        if (i < hours.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Working Hours', fields);
  }

  static pw.Widget _buildCompletionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Completion', [
      PdfGeneratorBase.buildFieldRow('Work Completed', data['workCompleted'] == true ? 'Yes' : 'No'),
      PdfGeneratorBase.buildPhotoField('Photo 1', data['photoWork1'] as String?),
      PdfGeneratorBase.buildPhotoField('Photo 2', data['photoWork2'] as String?),
      PdfGeneratorBase.buildFieldRow('Completion Date', PdfGeneratorBase.safeString(data['completionDate'])),
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
      PdfGeneratorBase.buildSignatureField('Technician', data['technicianSignature'] as String?),
    ]);
  }
}
