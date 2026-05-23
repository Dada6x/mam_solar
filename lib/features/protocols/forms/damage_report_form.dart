import 'package:mam_solar/features/protocols/forms/form_definition.dart';

class DamageReportForm implements ProtocolFormDefinition {
  @override
  String get protocolType => 'damage_report';

  @override
  List<FormSection> get sections => [
    FormSection(
      id: 'damage_declaration',
      labelKey: 'damageDeclaration',
      fields: [
        const FormFieldDef(
          id: 'damageType',
          labelKey: 'damageType',
          type: FieldType.dropdown,
          dropdownOptions: ['atCustomerProperty', 'atThirdParty', 'materialDamage'],
        ),
        const FormFieldDef(id: 'causedByPartner', labelKey: 'causedByPartner', type: FieldType.checkbox),
        const FormFieldDef(id: 'companyLiability', labelKey: 'companyLiability', type: FieldType.checkbox),
      ],
    ),
    FormSection(
      id: 'customer_injured_party',
      labelKey: 'customerInjuredParty',
      fields: [
        const FormFieldDef(id: 'injuredName', labelKey: 'injuredName', type: FieldType.text, required: true),
        const FormFieldDef(id: 'street', labelKey: 'street', type: FieldType.text),
        const FormFieldDef(id: 'zipCode', labelKey: 'zipCode', type: FieldType.text),
        const FormFieldDef(id: 'city', labelKey: 'city', type: FieldType.text),
        const FormFieldDef(id: 'phone', labelKey: 'phone', type: FieldType.text),
        const FormFieldDef(id: 'email', labelKey: 'email', type: FieldType.text),
      ],
    ),
    FormSection(
      id: 'incident_details',
      labelKey: 'incidentDetails',
      fields: [
        const FormFieldDef(id: 'incidentDateTime', labelKey: 'incidentDateTime', type: FieldType.date, required: true),
        const FormFieldDef(id: 'incidentTime', labelKey: 'incidentTime', type: FieldType.time),
        const FormFieldDef(id: 'secondPersonInvolved', labelKey: 'secondPersonInvolved', type: FieldType.checkbox),
      ],
    ),
    FormSection(
      id: 'damage_description',
      labelKey: 'damageDescription',
      fields: [
        const FormFieldDef(id: 'initialSituation', labelKey: 'initialSituation', type: FieldType.textarea, required: true),
        const FormFieldDef(id: 'incidentSequence', labelKey: 'incidentSequence', type: FieldType.textarea, required: true),
      ],
    ),
    FormSection(
      id: 'affected_devices',
      labelKey: 'affectedDevices',
      isRepeatable: true,
      fields: [
        const FormFieldDef(id: 'deviceName', labelKey: 'deviceName', type: FieldType.text),
        const FormFieldDef(id: 'deviceBrand', labelKey: 'deviceBrand', type: FieldType.text),
        const FormFieldDef(id: 'devicePhoto', labelKey: 'devicePhoto', type: FieldType.photo),
        const FormFieldDef(id: 'damageDescription', labelKey: 'damageDescription', type: FieldType.textarea),
      ],
    ),
    FormSection(
      id: 'damage_minimization',
      labelKey: 'damageMinimization',
      fields: [
        const FormFieldDef(id: 'minimizationPossible', labelKey: 'minimizationPossible', type: FieldType.checkbox),
        const FormFieldDef(id: 'minimizationNotes', labelKey: 'minimizationNotes', type: FieldType.textarea),
      ],
    ),
    FormSection(
      id: 'insurance',
      labelKey: 'insurance',
      fields: [
        const FormFieldDef(id: 'insuranceNotes', labelKey: 'insuranceNotes', type: FieldType.textarea),
      ],
    ),
    FormSection(
      id: 'remarks',
      labelKey: 'remarks',
      fields: [
        const FormFieldDef(id: 'remarks', labelKey: 'remarks', type: FieldType.textarea),
      ],
    ),
    FormSection(
      id: 'employee_info',
      labelKey: 'employeeInfo',
      fields: [
        const FormFieldDef(id: 'employeeName', labelKey: 'employeeName', type: FieldType.text, required: true),
      ],
    ),
    FormSection(
      id: 'signatures',
      labelKey: 'signatures',
      fields: [
        const FormFieldDef(id: 'damagedPartySignature', labelKey: 'signatureDamagedParty', type: FieldType.signature, required: true),
        const FormFieldDef(id: 'employeeSignature', labelKey: 'signatureEmployee', type: FieldType.signature, required: true),
      ],
    ),
  ];
}
