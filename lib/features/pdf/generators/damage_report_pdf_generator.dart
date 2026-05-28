import 'package:pdf/widgets.dart' as pw;
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';

class DamageReportPdfGenerator {
  static const _expectedFlatKeys = [
    // damage_declaration
    'damageType', 'damageTypeOther',
    'causedByPartner', 'partnerCompanyName',
    'companyLiability', 'insurancePolicyNumber', 'claimNumber',
    // injured_party
    'injuredName', 'street', 'houseNumber', 'zipCode', 'city', 'phone', 'email',
    // second_party
    'secondPersonInvolved',
    'secondName',
    'secondStreet',
    'secondZipCity',
    'secondPhone',
    'secondEmail',
    // incident_details
    'incidentDate', 'incidentTime',
    'initialSituation', 'incidentSequence', 'affectedSummary',
    // damage_minimization
    'minimizationPossible',
    'minimizationActionsTaken',
    'minimizationNotPossibleReason',
    // remarks
    'remarks',
    // signatures
    'damagedPartySignature',
    'employeeSignature',
    'damagedPartyFullName',
    'employeeFullName',
  ];

  static const _expectedRepeatableKeys = {
    'witnesses': [
      'witnessName',
      'witnessPhone',
      'witnessEmail',
      'witnessStatement',
    ],
    'affected_devices': [
      'itemName',
      'brand',
      'model',
      'serialNumber',
      'purchaseDate',
      'estimatedValue',
      'damageDescription',
      'photoOverview',
      'photoDetail',
      'photoTypeLabel',
    ],
    'additional_info': ['note', 'image'],
  };

  static pw.Document generate({
    required int protocolId,
    required String customerName,
    required Map<String, dynamic> data,
    required Map<String, List<Map<String, dynamic>>> repeatableData,
  }) {
    PdfGeneratorBase.logExpectedFields(
      data,
      'DamageReportPdfGenerator',
      _expectedFlatKeys,
    );
    PdfGeneratorBase.logExpectedRepeatableFields(
      repeatableData,
      'DamageReportPdfGenerator',
      _expectedRepeatableKeys,
    );

    final date = DateFormatter.formatDate(DateTime.now());
    final protocolNumber = DateFormatter.protocolNumber(
      'DR',
      DateTime.now(),
      protocolId,
    );

    return PdfGeneratorBase.createDocument(
      title: 'Damage Report',
      protocolNumber: protocolNumber,
      customerName: customerName,
      date: date,
      sections: [
        _buildDamageDeclarationSection(data),
        _buildInjuredPartySection(data),
        _buildSecondPartySection(data),
        // _buildIncidentSection(data),
        _buildDamageDescriptionSection(data),
        _buildWitnessesSection(repeatableData),
        _buildAffectedDevicesSection(repeatableData),
        _buildMinimizationSection(data),
        _buildRemarksSection(data),
        _buildAdditionalInfoSection(repeatableData),
        _buildSignaturesSection(data),
      ],
    );
  }

  // ── Damage Declaration ────────────────────────────────────────────────────

static pw.Widget _buildDamageDeclarationSection(Map<String, dynamic> data) {
  final causedByPartner = data['causedByPartner'] == true || data['causedByPartner'] == 'yes';
  final companyLiability = data['companyLiability'] == true || data['companyLiability'] == 'yes';

  return PdfGeneratorBase.buildSection('Damage Declaration', [
    PdfGeneratorBase.buildFieldRow(
      'Damage Type',
      PdfGeneratorBase.safeString(data['damageType']),
    ),
    if (data['damageTypeOther'] != null && (data['damageTypeOther'] as String).isNotEmpty)
      PdfGeneratorBase.buildFieldRow(
        'Other (Damage Type)',
        PdfGeneratorBase.safeString(data['damageTypeOther']),
      ),
    PdfGeneratorBase.buildFieldRow(
      'Caused by Partner',
      causedByPartner ? 'Yes' : 'No',
    ),
    if (causedByPartner)
      PdfGeneratorBase.buildFieldRow(
        'Partner Company Name',
        PdfGeneratorBase.safeString(data['partnerCompanyName']),
      ),
    PdfGeneratorBase.buildFieldRow(
      'Company Liability',
      companyLiability ? 'Yes' : 'No',
    ),
    if (companyLiability) ...[
      PdfGeneratorBase.buildFieldRow(
        'Insurance Policy Number',
        PdfGeneratorBase.safeString(data['insurancePolicyNumber']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Claim Number',
        PdfGeneratorBase.safeString(data['claimNumber']),
      ),
    ],
  ]);
}


  // ── Injured Party ─────────────────────────────────────────────────────────

  static pw.Widget _buildInjuredPartySection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Injured Party', [
      PdfGeneratorBase.buildFieldRow(
        'Name',
        PdfGeneratorBase.safeString(data['injuredName']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Address',
        '${PdfGeneratorBase.safeString(data['street'])} ${PdfGeneratorBase.safeString(data['houseNumber'])}'
            .trim(),
      ),
      PdfGeneratorBase.buildFieldRow(
        'ZIP Code',
        PdfGeneratorBase.safeString(data['zipCode']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'City',
        PdfGeneratorBase.safeString(data['city']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Phone',
        PdfGeneratorBase.safeString(data['phone']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Email',
        PdfGeneratorBase.safeString(data['email']),
      ),
    ]);
  }

  // ── Second Injured Party ──────────────────────────────────────────────────

  static pw.Widget _buildSecondPartySection(Map<String, dynamic> data) {
    final involved =
        data['secondPersonInvolved'] == true ||
        data['secondPersonInvolved'] == 'yes';

    return PdfGeneratorBase.buildSection('Second Injured Party', [
      PdfGeneratorBase.buildFieldRow(
        'Second Person Involved',
        involved ? 'Yes' : 'No',
      ),
      if (involved) ...[
        PdfGeneratorBase.buildFieldRow(
          'Name',
          PdfGeneratorBase.safeString(data['secondName']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Street',
          PdfGeneratorBase.safeString(data['secondStreet']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'ZIP / City',
          PdfGeneratorBase.safeString(data['secondZipCity']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Phone',
          PdfGeneratorBase.safeString(data['secondPhone']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Email',
          PdfGeneratorBase.safeString(data['secondEmail']),
        ),
      ],
    ]);
  }

  // ── Damage Description ────────────────────────────────────────────────────

  static pw.Widget _buildDamageDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Damage Description', [
      PdfGeneratorBase.buildFieldRow(
        'Date',
        PdfGeneratorBase.safeString(data['incidentDate']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Time',
        PdfGeneratorBase.safeString(data['incidentTime']),
      ),

      PdfGeneratorBase.buildFieldRow(
        'Initial Situation',
        PdfGeneratorBase.safeString(data['initialSituation']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Incident Sequence',
        PdfGeneratorBase.safeString(data['incidentSequence']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Affected Items / People (Summary)',
        PdfGeneratorBase.safeString(data['affectedSummary']),
      ),
    ]);
  }

  // ── Witnesses ─────────────────────────────────────────────────────────────

  static pw.Widget _buildWitnessesSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final witnesses = repeatableData['witnesses'] ?? [];
    final fields = <pw.Widget>[];

    if (witnesses.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Witnesses', 'None'));
    } else {
      for (var i = 0; i < witnesses.length; i++) {
        final w = witnesses[i];
        fields.add(
          pw.Text(
            'Witness #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Name',
            PdfGeneratorBase.safeString(w['witnessName']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Phone',
            PdfGeneratorBase.safeString(w['witnessPhone']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Email',
            PdfGeneratorBase.safeString(w['witnessEmail']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Statement',
            PdfGeneratorBase.safeString(w['witnessStatement']),
          ),
        );
        if (i < witnesses.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Witnesses', fields);
  }

  // ── Affected Devices ──────────────────────────────────────────────────────

  static pw.Widget _buildAffectedDevicesSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final devices = repeatableData['affected_devices'] ?? [];
    final fields = <pw.Widget>[];

    if (devices.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Devices', 'None'));
    } else {
      for (var i = 0; i < devices.length; i++) {
        final d = devices[i];
        fields.add(
          pw.Text(
            'Device #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Name',
            PdfGeneratorBase.safeString(d['itemName']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Brand',
            PdfGeneratorBase.safeString(d['brand']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Model',
            PdfGeneratorBase.safeString(d['model']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Serial Number',
            PdfGeneratorBase.safeString(d['serialNumber']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Purchase Date',
            PdfGeneratorBase.safeString(d['purchaseDate']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Estimated Value (EUR)',
            PdfGeneratorBase.safeString(d['estimatedValue']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Damage Description',
            PdfGeneratorBase.safeString(d['damageDescription']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField(
            'Overview Photo',
            d['photoOverview'] as String?,
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField(
            'Detail Photo',
            d['photoDetail'] as String?,
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField(
            'Type Label / Serial Number',
            d['photoTypeLabel'] as String?,
          ),
        );
        if (i < devices.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Affected Devices', fields);
  }

  // ── Damage Minimization ───────────────────────────────────────────────────

  static pw.Widget _buildMinimizationSection(Map<String, dynamic> data) {
    final possible =
        data['minimizationPossible'] == true ||
        data['minimizationPossible'] == 'yes';

    return PdfGeneratorBase.buildSection('Damage Minimization', [
      PdfGeneratorBase.buildFieldRow(
        'Minimization Possible',
        possible ? 'Yes' : 'No',
      ),
      if (possible)
        PdfGeneratorBase.buildFieldRow(
          'Actions Taken',
          PdfGeneratorBase.safeString(data['minimizationActionsTaken']),
        )
      else
        PdfGeneratorBase.buildFieldRow(
          'Reason Not Possible',
          PdfGeneratorBase.safeString(data['minimizationNotPossibleReason']),
        ),
    ]);
  }

  // ── Remarks ───────────────────────────────────────────────────────────────

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Remarks', [
      PdfGeneratorBase.buildFieldRow(
        'Remarks',
        PdfGeneratorBase.safeString(data['remarks']),
      ),
    ]);
  }

  // ── Additional Info ───────────────────────────────────────────────────────

  static pw.Widget _buildAdditionalInfoSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final entries = repeatableData['additional_info'] ?? [];
    final fields = <pw.Widget>[];

    if (entries.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Additional Info', 'None'));
    } else {
      for (var i = 0; i < entries.length; i++) {
        final e = entries[i];
        fields.add(
          pw.Text(
            'Entry #${i + 1}',
            style: pw.TextStyle(font: pw.Font.helveticaBold(), fontSize: 10),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Note',
            PdfGeneratorBase.safeString(e['note']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField('Image', e['image']),
        );
        if (i < entries.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Additional Information', fields);
  }

  // ── Signatures ────────────────────────────────────────────────────────────

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Signatures', [
      PdfGeneratorBase.buildFieldRow(
        'Damaged Party Full Name',
        PdfGeneratorBase.safeString(data['damagedPartyFullName']),
      ),
      PdfGeneratorBase.buildSignatureField(
        'Damaged Party Signature',
        data['damagedPartySignature'] as String?,
      ),
      PdfGeneratorBase.buildFieldRow(
        'Employee Full Name',
        PdfGeneratorBase.safeString(data['employeeFullName']),
      ),
      PdfGeneratorBase.buildSignatureField(
        'MAM Solarbau Employee Signature',
        data['employeeSignature'] as String?,
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The plant operator and installation company declare that the above-mentioned system is technically ready for operation within the meaning of § 3 No. 30 EEG (2021) on the date on which the AC and DC acceptance protocols are signed.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The objection period is 14 days; after this period the acceptance protocol is considered confirmed.',
      ),
      PdfGeneratorBase.buildDisplayTextField(
        'The executing electrical installer confirms with their signature that the electrical system has been installed, measured and accepted in accordance with the currently applicable DIN-VDE standards as well as TAB and TAR.',
      ),
    ]);
  }
}
