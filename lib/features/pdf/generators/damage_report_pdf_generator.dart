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
    'protocolDateTime',
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
      title: 'Schadensprotokoll',
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

  // ── Schadensmeldung ───────────────────────────────────────────────────────

  static pw.Widget _buildDamageDeclarationSection(Map<String, dynamic> data) {
    final causedByPartner = data['causedByPartner'] == true || data['causedByPartner'] == 'yes';
    final companyLiability = data['companyLiability'] == true || data['companyLiability'] == 'yes';

    return PdfGeneratorBase.buildSection('Schadensmeldung', [
      PdfGeneratorBase.buildFieldRow(
        'Schadensart',
        PdfGeneratorBase.safeString(data['damageType']),
      ),
      if (data['damageTypeOther'] != null && (data['damageTypeOther'] as String).isNotEmpty)
        PdfGeneratorBase.buildFieldRow(
          'Sonstige (Schadensart)',
          PdfGeneratorBase.safeString(data['damageTypeOther']),
        ),
      PdfGeneratorBase.buildFieldRow(
        'Durch Partner verursacht',
        causedByPartner ? 'Ja' : 'Nein',
      ),
      if (causedByPartner)
        PdfGeneratorBase.buildFieldRow(
          'Name des Partnerunternehmens',
          PdfGeneratorBase.safeString(data['partnerCompanyName']),
        ),
      PdfGeneratorBase.buildFieldRow(
        'Unternehmenshaftung',
        companyLiability ? 'Ja' : 'Nein',
      ),
      if (companyLiability) ...[
        PdfGeneratorBase.buildFieldRow(
          'Versicherungsscheinnummer',
          PdfGeneratorBase.safeString(data['insurancePolicyNumber']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Schadennummer',
          PdfGeneratorBase.safeString(data['claimNumber']),
        ),
      ],
    ]);
  }

  // ── Geschädigte Person ────────────────────────────────────────────────────

  static pw.Widget _buildInjuredPartySection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Geschädigte Person', [
      PdfGeneratorBase.buildFieldRow(
        'Name',
        PdfGeneratorBase.safeString(data['injuredName']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Adresse',
        '${PdfGeneratorBase.safeString(data['street'])} ${PdfGeneratorBase.safeString(data['houseNumber'])}'
            .trim(),
      ),
      PdfGeneratorBase.buildFieldRow(
        'PLZ',
        PdfGeneratorBase.safeString(data['zipCode']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Stadt',
        PdfGeneratorBase.safeString(data['city']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Telefon',
        PdfGeneratorBase.safeString(data['phone']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'E-Mail',
        PdfGeneratorBase.safeString(data['email']),
      ),
    ]);
  }

  // ── Zweite geschädigte Person ─────────────────────────────────────────────

  static pw.Widget _buildSecondPartySection(Map<String, dynamic> data) {
    final involved =
        data['secondPersonInvolved'] == true ||
        data['secondPersonInvolved'] == 'yes';

    return PdfGeneratorBase.buildSection('Zweite geschädigte Person', [
      PdfGeneratorBase.buildFieldRow(
        'Zweite Person beteiligt',
        involved ? 'Ja' : 'Nein',
      ),
      if (involved) ...[
        PdfGeneratorBase.buildFieldRow(
          'Name',
          PdfGeneratorBase.safeString(data['secondName']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Straße',
          PdfGeneratorBase.safeString(data['secondStreet']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'PLZ / Ort',
          PdfGeneratorBase.safeString(data['secondZipCity']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'Telefon',
          PdfGeneratorBase.safeString(data['secondPhone']),
        ),
        PdfGeneratorBase.buildFieldRow(
          'E-Mail',
          PdfGeneratorBase.safeString(data['secondEmail']),
        ),
      ],
    ]);
  }

  // ── Schadensbeschreibung ──────────────────────────────────────────────────

  static pw.Widget _buildDamageDescriptionSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Schadensbeschreibung', [
      PdfGeneratorBase.buildFieldRow(
        'Datum',
        PdfGeneratorBase.safeString(data['incidentDate']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Uhrzeit',
        PdfGeneratorBase.safeString(data['incidentTime']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Ausgangssituation',
        PdfGeneratorBase.safeString(data['initialSituation']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Schadenshergang',
        PdfGeneratorBase.safeString(data['incidentSequence']),
      ),
      PdfGeneratorBase.buildFieldRow(
        'Betroffene Gegenstände / Personen (Zusammenfassung)',
        PdfGeneratorBase.safeString(data['affectedSummary']),
      ),
    ]);
  }

  // ── Zeugen ────────────────────────────────────────────────────────────────

  static pw.Widget _buildWitnessesSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final witnesses = repeatableData['witnesses'] ?? [];
    final fields = <pw.Widget>[];

    if (witnesses.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Zeugen', 'Keine'));
    } else {
      for (var i = 0; i < witnesses.length; i++) {
        final w = witnesses[i];
        fields.add(
          pw.Text(
            'Zeuge #${i + 1}',
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
            'Telefon',
            PdfGeneratorBase.safeString(w['witnessPhone']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'E-Mail',
            PdfGeneratorBase.safeString(w['witnessEmail']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Aussage',
            PdfGeneratorBase.safeString(w['witnessStatement']),
          ),
        );
        if (i < witnesses.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Zeugen', fields);
  }

  // ── Betroffene Geräte ─────────────────────────────────────────────────────

  static pw.Widget _buildAffectedDevicesSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final devices = repeatableData['affected_devices'] ?? [];
    final fields = <pw.Widget>[];

    if (devices.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Geräte', 'Keine'));
    } else {
      for (var i = 0; i < devices.length; i++) {
        final d = devices[i];
        fields.add(
          pw.Text(
            'Gerät #${i + 1}',
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
            'Marke',
            PdfGeneratorBase.safeString(d['brand']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Modell',
            PdfGeneratorBase.safeString(d['model']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Seriennummer',
            PdfGeneratorBase.safeString(d['serialNumber']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Kaufdatum',
            PdfGeneratorBase.safeString(d['purchaseDate']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Geschätzter Wert (EUR)',
            PdfGeneratorBase.safeString(d['estimatedValue']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildFieldRow(
            'Schadensbeschreibung',
            PdfGeneratorBase.safeString(d['damageDescription']),
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField(
            'Übersichtsfoto',
            d['photoOverview'] as String?,
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField(
            'Detailfoto',
            d['photoDetail'] as String?,
          ),
        );
        fields.add(
          PdfGeneratorBase.buildPhotoField(
            'Typenschild / Seriennummer',
            d['photoTypeLabel'] as String?,
          ),
        );
        if (i < devices.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Betroffene Geräte', fields);
  }

  // ── Schadensminimierung ───────────────────────────────────────────────────

  static pw.Widget _buildMinimizationSection(Map<String, dynamic> data) {
    final possible =
        data['minimizationPossible'] == true ||
        data['minimizationPossible'] == 'yes';

    return PdfGeneratorBase.buildSection('Schadensminimierung', [
      PdfGeneratorBase.buildFieldRow(
        'Minimierung möglich',
        possible ? 'Ja' : 'Nein',
      ),
      if (possible)
        PdfGeneratorBase.buildFieldRow(
          'Ergriffene Maßnahmen',
          PdfGeneratorBase.safeString(data['minimizationActionsTaken']),
        )
      else
        PdfGeneratorBase.buildFieldRow(
          'Grund nicht möglich',
          PdfGeneratorBase.safeString(data['minimizationNotPossibleReason']),
        ),
    ]);
  }

  // ── Bemerkungen ───────────────────────────────────────────────────────────

  static pw.Widget _buildRemarksSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Bemerkungen', [
      PdfGeneratorBase.buildFieldRow(
        'Bemerkungen',
        PdfGeneratorBase.safeString(data['remarks']),
      ),
    ]);
  }

  // ── Zusatzinformationen ───────────────────────────────────────────────────

  static pw.Widget _buildAdditionalInfoSection(
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final entries = repeatableData['additional_info'] ?? [];
    final fields = <pw.Widget>[];

    if (entries.isEmpty) {
      fields.add(PdfGeneratorBase.buildFieldRow('Zusatzinformationen', 'Keine'));
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
        fields.add(
          PdfGeneratorBase.buildPhotoField('Bild', e['image']),
        );
        if (i < entries.length - 1) fields.add(pw.SizedBox(height: 4));
      }
    }

    return PdfGeneratorBase.buildSection('Zusatzinformationen', fields);
  }

  // ── Unterschriften ────────────────────────────────────────────────────────

  static pw.Widget _buildSignaturesSection(Map<String, dynamic> data) {
    return PdfGeneratorBase.buildSection('Unterschriften', [
      PdfGeneratorBase.buildFieldRow(
        'Vollständiger Name der geschädigten Partei',
        PdfGeneratorBase.safeString(data['damagedPartyFullName']),
      ),
      PdfGeneratorBase.buildSignatureField(
        'Unterschrift der geschädigten Partei',
        data['damagedPartySignature'] as String?,
      ),
      PdfGeneratorBase.buildFieldRow(
        'Vollständiger Name des Mitarbeiters',
        PdfGeneratorBase.safeString(data['employeeFullName']),
      ),
      PdfGeneratorBase.buildSignatureField(
        'Unterschrift MAM Solarbau Mitarbeiter',
        data['employeeSignature'] as String?,
      ),
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