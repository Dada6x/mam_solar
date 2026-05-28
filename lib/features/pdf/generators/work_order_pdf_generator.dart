import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class WorkOrderPdfGenerator {
  static const _expectedFlatKeys = [
    // Customer Data
    'fullName', 'street','city', 'zipCity', 'email', 'phone',
    // Work Description
    'description', 'workDetail',
    // Completion
    'workCompleted',
    'reason', 'nextAppointment', 'whatIsMissing', // show_if: workCompleted == no
    'completionDate',
    // Meter Readings (flat photo)
    'photoMeter',
    // Remarks
    'remarks',
    'note','image'
    // Signatures
    'customerFullName','customerSignature', 'companySignature', 'signerName', 'emailSentTo',
  ];

  static const _expectedRepeatableKeys = {
    'materials': ['quantity', 'unit', 'material'],
    'travel': ['licensePlate', 'departure', 'destination', 'kilometers'],
    'working_hours': ['date', 'techName', 'startTime', 'endTime', 'duration'],
    'meter_readings': ['meterNumber', 'reading'],
    'work_photos': ['category', 'photo', 'description'],
    'additional_info': ['note', 'image'],
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
        _buildMeterReadingsSection(data, repeatableData),
        _buildWorkPhotosSection(repeatableData),
        _buildCompletionSection(data),
        _buildRemarksSection(data),
        _buildAdditionalInfoSection(repeatableData),
        _buildSignaturesSection(data),
      ],
    );
  }

  // ── Customer Data ──────────────────────────────────────────────────────────

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Customer Data', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['fullName'])),
      PdfGeneratorBase.buildFieldRow('Street', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('City', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('ZIP/City', PdfGeneratorBase.safeString(data['zipCity'])),
      PdfGeneratorBase.buildFieldRow('Email', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Phone', PdfGeneratorBase.safeString(data['phone'])),
    ]);
  }

  // ── Work Description ───────────────────────────────────────────────────────

  static pw.Widget _buildWorkDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Work Description', [
      PdfGeneratorBase.buildFieldRow('Description', PdfGeneratorBase.safeString(data['description'])),
      PdfGeneratorBase.buildFieldRow('Detail', PdfGeneratorBase.safeString(data['workDetail'])),
    ]);
  }

  // ── Materials ──────────────────────────────────────────────────────────────

  static pw.Widget _buildMaterialsSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final materials = repeatableData['materials'] ?? [];
    final fields = <pw.Widget>[];

    if (materials.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Materials', 'None'));
    } else {
      for (var i = 0; i < materials.length; i++) {
        final m = materials[i];
        final qty = PdfGeneratorBase.safeString(m['quantity']);
        final unit = PdfGeneratorBase.safeString(m['unit']);
        final qtyWithUnit = unit.isNotEmpty ? '$qty $unit' : qty;

        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Qty', qtyWithUnit));
        fields.add(PdfGeneratorBase.buildFieldRow('Material', PdfGeneratorBase.safeString(m['material'])));
        if (i < materials.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Materials', fields);
  }

  // ── Vehicle / Travel ───────────────────────────────────────────────────────

  static pw.Widget _buildVehicleTravelSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final travels = repeatableData['travel'] ?? [];
    final fields = <pw.Widget>[];

    if (travels.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Travel', 'None'));
    } else {
      for (var i = 0; i < travels.length; i++) {
        final t = travels[i];
        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} License Plate', PdfGeneratorBase.safeString(t['licensePlate'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Departure', PdfGeneratorBase.safeString(t['departure'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Destination', PdfGeneratorBase.safeString(t['destination'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Kilometers', PdfGeneratorBase.safeString(t['kilometers'])));
        if (i < travels.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Vehicle / Travel', fields);
  }

  // ── Working Hours ──────────────────────────────────────────────────────────

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
        fields.add(PdfGeneratorBase.buildFieldRow('Duration', PdfGeneratorBase.safeString(h['duration']))); 
        if (i < hours.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Working Hours', fields);
  }

  // ── Meter Readings ─────────────────────────────────────────────────────────

  static pw.Widget _buildMeterReadingsSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final readings = repeatableData['meter_readings'] ?? [];
    final fields = <pw.Widget>[];

    if (readings.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Readings', 'None'));
    } else {
      for (var i = 0; i < readings.length; i++) {
        final r = readings[i];
        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Meter No.', PdfGeneratorBase.safeString(r['meterNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Reading (kWh)', PdfGeneratorBase.safeString(r['reading'])));
        if (i < readings.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    // Flat meter photo (outside the repeatable block in the MD)
    fields.add(pw.SizedBox(height: 6));
    fields.add(PdfGeneratorBase.buildPhotoField('Meter Photo', data['photoMeter']));

    return PdfGeneratorBase.buildSection('Meter Readings', fields);
  }

  // ── Work Photos ────────────────────────────────────────────────────────────

  static pw.Widget _buildWorkPhotosSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final photos = repeatableData['work_photos'] ?? [];
    final fields = <pw.Widget>[];

    if (photos.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Photos', 'None'));
    } else {
      for (var i = 0; i < photos.length; i++) {
        final p = photos[i];
        final category = PdfGeneratorBase.safeString(p['category']);
        final description = PdfGeneratorBase.safeString(p['description']);

        fields.add(pw.Text(
          'Photo #${i + 1}${category.isNotEmpty ? ' — $category' : ''}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        if (description.isNotEmpty) {
          fields.add(PdfGeneratorBase.buildFieldRow('Description', description));
        }
        fields.add(PdfGeneratorBase.buildPhotoField('Photo', p['photo']));
        if (i < photos.length - 1) fields.add(pw.SizedBox(height: 6));
      }
    }
    return PdfGeneratorBase.buildSection('Work Photos', fields);
  }

  // ── Completion ─────────────────────────────────────────────────────────────

  static pw.Widget _buildCompletionSection(Map<String, dynamic> data) {
    // MD uses 'yes'/'no' strings (radio), not booleans
    final workCompleted = data['workCompleted']?.toString().toLowerCase();
    final isCompleted = workCompleted == 'yes';
    final fields = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow('Work Completed', isCompleted ? 'Yes' : 'No'),
      PdfGeneratorBase.buildFieldRow('Completion Date', PdfGeneratorBase.safeString(data['completionDate'])),
    ];

    // show_if: workCompleted == no
    if (!isCompleted) {
      fields.addAll([
        PdfGeneratorBase.buildFieldRow('Reason (not completed)', PdfGeneratorBase.safeString(data['reason'])),
        PdfGeneratorBase.buildFieldRow('Next Appointment', PdfGeneratorBase.safeString(data['nextAppointment'])),
        PdfGeneratorBase.buildFieldRow('What is missing', PdfGeneratorBase.safeString(data['whatIsMissing'])),
      ]);
    }

    return PdfGeneratorBase.buildSection('Completion', fields);
  }

  // ── Remarks ────────────────────────────────────────────────────────────────

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Remarks', [
      PdfGeneratorBase.buildFieldRow('Remarks', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }


static pw.Widget _buildAdditionalInfoSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
  final infoList = repeatableData['additional_info'] ?? [];
  final fields = <pw.Widget>[];

  if (infoList.isEmpty) {
    fields.add(PdfGeneratorBase.buildFieldRow('Additional Info', 'No data'));
  } else {
    for (var i = 0; i < infoList.length; i++) {
      final item = infoList[i];
      fields.add(pw.Text(
        'Additional Info #${i + 1}',
        style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
      ));
      
      fields.add(PdfGeneratorBase.buildFieldRow('Note', PdfGeneratorBase.safeString(item['note'])));
      fields.add(PdfGeneratorBase.buildPhotoField('Image', item['image']));
      
      if (i < infoList.length - 1) {
        fields.add(pw.SizedBox(height: 6));
      }
    }
  }
  return PdfGeneratorBase.buildSection('Additional Info', fields);
}



  // ── Signatures ─────────────────────────────────────────────────────────────

static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
  return PdfGeneratorBase.buildSection('Signatures', [
    PdfGeneratorBase.buildFieldRow('Customer Full Name', PdfGeneratorBase.safeString(data['customerFullName'])),
    PdfGeneratorBase.buildSignatureField('Customer', data['customerSignature'] as String?),
    PdfGeneratorBase.buildSignatureField('MAM Solarbau', data['companySignature'] as String?),
    PdfGeneratorBase.buildFieldRow('Signing Technician', PdfGeneratorBase.safeString(data['signerName'])),
    PdfGeneratorBase.buildDisplayTextField('The plant operator and installation company declare that the above-mentioned system is technically ready for operation within the meaning of § 3 No. 30 EEG (2021) on the date on which the AC and DC acceptance protocols are signed.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The objection period is 14 days; after this period the acceptance protocol is considered confirmed.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The executing electrical installer confirms with their signature that the electrical system has been installed, measured and accepted in accordance with the currently applicable DIN-VDE standards as well as TAB and TAR.',
      ),
    // PdfGeneratorBase.buildFieldRow('Email Sent To', PdfGeneratorBase.safeString(data['emailSentTo'])),
  ]);
}
}