import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class WorkOrderPdfGenerator {
  static const _expectedFlatKeys = [
    'fullName', 'street','city', 'zipCity', 'email', 'phone',
    'description', 'workDetail',
    'workCompleted',
    'reason', 'nextAppointment', 'whatIsMissing',
    'completionDate',
    'photoMeter',
    'remarks',
    'note','image'
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
      title: 'Arbeitsauftrag',
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

  // ── Kundendaten ────────────────────────────────────────────────────────────

  static pw.Widget _buildCustomerDataSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Kundendaten', [
      PdfGeneratorBase.buildFieldRow('Name', PdfGeneratorBase.safeString(data['fullName'])),
      PdfGeneratorBase.buildFieldRow('Straße', PdfGeneratorBase.safeString(data['street'])),
      PdfGeneratorBase.buildFieldRow('Stadt', PdfGeneratorBase.safeString(data['city'])),
      PdfGeneratorBase.buildFieldRow('PLZ/Ort', PdfGeneratorBase.safeString(data['zipCity'])),
      PdfGeneratorBase.buildFieldRow('E-Mail', PdfGeneratorBase.safeString(data['email'])),
      PdfGeneratorBase.buildFieldRow('Telefon', PdfGeneratorBase.safeString(data['phone'])),
    ]);
  }

  // ── Arbeitsbeschreibung ────────────────────────────────────────────────────

  static pw.Widget _buildWorkDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Arbeitsbeschreibung', [
      PdfGeneratorBase.buildFieldRow('Beschreibung', PdfGeneratorBase.safeString(data['description'])),
      PdfGeneratorBase.buildFieldRow('Details', PdfGeneratorBase.safeString(data['workDetail'])),
    ]);
  }

  // ── Materialien ────────────────────────────────────────────────────────────

  static pw.Widget _buildMaterialsSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final materials = repeatableData['materials'] ?? [];
    final fields = <pw.Widget>[];

    if (materials.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Materialien', 'Keine'));
    } else {
      for (var i = 0; i < materials.length; i++) {
        final m = materials[i];
        final qty = PdfGeneratorBase.safeString(m['quantity']);
        final unit = PdfGeneratorBase.safeString(m['unit']);
        final qtyWithUnit = unit.isNotEmpty ? '$qty $unit' : qty;

        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Menge', qtyWithUnit));
        fields.add(PdfGeneratorBase.buildFieldRow('Material', PdfGeneratorBase.safeString(m['material'])));
        if (i < materials.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Materialien', fields);
  }

  // ── Fahrzeug / Fahrt ───────────────────────────────────────────────────────

  static pw.Widget _buildVehicleTravelSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final travels = repeatableData['travel'] ?? [];
    final fields = <pw.Widget>[];

    if (travels.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Fahrt', 'Keine'));
    } else {
      for (var i = 0; i < travels.length; i++) {
        final t = travels[i];
        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Kennzeichen', PdfGeneratorBase.safeString(t['licensePlate'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Abfahrt', PdfGeneratorBase.safeString(t['departure'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Ziel', PdfGeneratorBase.safeString(t['destination'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Kilometer', PdfGeneratorBase.safeString(t['kilometers'])));
        if (i < travels.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Fahrzeug / Fahrt', fields);
  }

  // ── Arbeitsstunden ─────────────────────────────────────────────────────────

  static pw.Widget _buildWorkingHoursSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final hours = repeatableData['working_hours'] ?? [];
    final fields = <pw.Widget>[];

    if (hours.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Stunden', 'Keine'));
    } else {
      for (var i = 0; i < hours.length; i++) {
        final h = hours[i];
        fields.add(pw.Text(
          'Tag #${i + 1}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        fields.add(PdfGeneratorBase.buildFieldRow('Datum', PdfGeneratorBase.safeString(h['date'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Techniker', PdfGeneratorBase.safeString(h['techName'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Beginn', PdfGeneratorBase.safeString(h['startTime'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Ende', PdfGeneratorBase.safeString(h['endTime'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Dauer', PdfGeneratorBase.safeString(h['duration'])));
        if (i < hours.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }
    return PdfGeneratorBase.buildSection('Arbeitsstunden', fields);
  }

  // ── Zählerstände ──────────────────────────────────────────────────────────

  static pw.Widget _buildMeterReadingsSection(
    Map<String, dynamic> data,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final readings = repeatableData['meter_readings'] ?? [];
    final fields = <pw.Widget>[];

    if (readings.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Ablesungen', 'Keine'));
    } else {
      for (var i = 0; i < readings.length; i++) {
        final r = readings[i];
        fields.add(PdfGeneratorBase.buildFieldRow('#${i + 1} Zählernr.', PdfGeneratorBase.safeString(r['meterNumber'])));
        fields.add(PdfGeneratorBase.buildFieldRow('Ablesung (kWh)', PdfGeneratorBase.safeString(r['reading'])));
        if (i < readings.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    fields.add(pw.SizedBox(height: 6));
    fields.add(PdfGeneratorBase.buildPhotoField('Zählerfoto', data['photoMeter']));

    return PdfGeneratorBase.buildSection('Zählerstände', fields);
  }

  // ── Arbeitsfotos ───────────────────────────────────────────────────────────

  static pw.Widget _buildWorkPhotosSection(Map<String, List<Map<String, dynamic>>> repeatableData) {
    final photos = repeatableData['work_photos'] ?? [];
    final fields = <pw.Widget>[];

    if (photos.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Fotos', 'Keine'));
    } else {
      for (var i = 0; i < photos.length; i++) {
        final p = photos[i];
        final category = PdfGeneratorBase.safeString(p['category']);
        final description = PdfGeneratorBase.safeString(p['description']);

        fields.add(pw.Text(
          'Foto #${i + 1}${category.isNotEmpty ? ' — $category' : ''}',
          style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
        ));
        if (description.isNotEmpty) {
          fields.add(PdfGeneratorBase.buildFieldRow('Beschreibung', description));
        }
        fields.add(PdfGeneratorBase.buildPhotoField('Foto', p['photo']));
        if (i < photos.length - 1) fields.add(pw.SizedBox(height: 6));
      }
    }
    return PdfGeneratorBase.buildSection('Arbeitsfotos', fields);
  }

  // ── Abschluss ──────────────────────────────────────────────────────────────

  static pw.Widget _buildCompletionSection(Map<String, dynamic> data) {
    final workCompleted = data['workCompleted']?.toString().toLowerCase();
    final isCompleted = workCompleted == 'yes';
    final fields = <pw.Widget>[
      PdfGeneratorBase.buildFieldRow('Arbeit abgeschlossen', isCompleted ? 'Ja' : 'Nein'),
      PdfGeneratorBase.buildFieldRow('Abschlussdatum', PdfGeneratorBase.safeString(data['completionDate'])),
    ];

    if (!isCompleted) {
      fields.addAll([
        PdfGeneratorBase.buildFieldRow('Grund (nicht abgeschlossen)', PdfGeneratorBase.safeString(data['reason'])),
        PdfGeneratorBase.buildFieldRow('Nächster Termin', PdfGeneratorBase.safeString(data['nextAppointment'])),
        PdfGeneratorBase.buildFieldRow('Was fehlt', PdfGeneratorBase.safeString(data['whatIsMissing'])),
      ]);
    }

    return PdfGeneratorBase.buildSection('Abschluss', fields);
  }

  // ── Bemerkungen ────────────────────────────────────────────────────────────

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Bemerkungen', [
      PdfGeneratorBase.buildFieldRow('Bemerkungen', PdfGeneratorBase.safeString(data['remarks'])),
    ]);
  }

  // ── Zusatzinformationen ────────────────────────────────────────────────────

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

  // ── Unterschriften ─────────────────────────────────────────────────────────

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Unterschriften', [
      PdfGeneratorBase.buildFieldRow('Vollständiger Name des Kunden', PdfGeneratorBase.safeString(data['customerFullName'])),
      PdfGeneratorBase.buildSignatureField('Kunde', data['customerSignature'] as String?),
      PdfGeneratorBase.buildSignatureField('MAM Solarbau', data['companySignature'] as String?),
      PdfGeneratorBase.buildFieldRow('Unterzeichnender Techniker', PdfGeneratorBase.safeString(data['signerName'])),
      PdfGeneratorBase.buildDisplayTextField(
        'Der Anlagenbetreiber und das Installationsunternehmen erklären, dass die oben genannte Anlage am Datum der Unterzeichnung der AC- und DC-Abnahmeprotokolle technisch betriebsbereit im Sinne von § 3 Nr. 30 EEG (2021) ist.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'Die Einspruchsfrist beträgt 14 Tage; nach Ablauf dieser Frist gilt das Abnahmeprotokoll als bestätigt.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'Der ausführende Elektroinstallateur bestätigt mit seiner Unterschrift, dass die Elektroanlage gemäß den aktuell geltenden DIN-VDE-Normen sowie TAB und TAR installiert, gemessen und abgenommen wurde.',
      ),
    ]);
  }
}