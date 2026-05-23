import 'package:mam_solar/features/protocols/forms/form_definition.dart';

class InstallationReportForm implements ProtocolFormDefinition {
  @override
  String get protocolType => 'installation_report';

  @override
  List<FormSection> get sections => [
    FormSection(
      id: 'customer_data',
      labelKey: 'customerData',
      fields: [
        const FormFieldDef(id: 'customerName', labelKey: 'customerName', type: FieldType.text, required: true),
        const FormFieldDef(id: 'street', labelKey: 'street', type: FieldType.text),
        const FormFieldDef(id: 'city', labelKey: 'city', type: FieldType.text),
        const FormFieldDef(id: 'zipCode', labelKey: 'zipCode', type: FieldType.text),
        const FormFieldDef(id: 'email', labelKey: 'email', type: FieldType.text),
        const FormFieldDef(id: 'phone', labelKey: 'phone', type: FieldType.text),
        const FormFieldDef(id: 'installationDate', labelKey: 'installationDate', type: FieldType.date, required: true),
        const FormFieldDef(id: 'installerName', labelKey: 'installerName', type: FieldType.text, required: true),
        const FormFieldDef(id: 'partnerCompany', labelKey: 'partnerCompany', type: FieldType.text),
      ],
    ),
    FormSection(
      id: 'installation_details',
      labelKey: 'installationDetails',
      fields: [
        const FormFieldDef(
          id: 'installationType',
          labelKey: 'installationType',
          type: FieldType.dropdown,
          dropdownOptions: ['solarPv', 'solarPvBattery', 'solarPvWallbox'],
        ),
        const FormFieldDef(id: 'storageManufacturer', labelKey: 'storageManufacturer', type: FieldType.text),
        const FormFieldDef(id: 'wallboxInstalled', labelKey: 'wallboxInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'backupInstalled', labelKey: 'backupInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'groundRodInstalled', labelKey: 'groundRodInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'privateMeterInstalled', labelKey: 'privateMeterInstalled', type: FieldType.checkbox),
      ],
    ),
    FormSection(
      id: 'meter_cabinet',
      labelKey: 'meterCabinet',
      fields: [
        const FormFieldDef(id: 'newCabinetInstalled', labelKey: 'newCabinetInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'allComponentsInstalled', labelKey: 'allComponentsInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'touchProtection', labelKey: 'touchProtection', type: FieldType.checkbox),
        const FormFieldDef(id: 'apzInstalled', labelKey: 'apzInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'energridInstalled', labelKey: 'energridInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'photoNewCabinet', labelKey: 'photoNewCabinet', type: FieldType.photo),
        const FormFieldDef(id: 'photoOldCabinet', labelKey: 'photoOldCabinet', type: FieldType.photo),
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
      id: 'signatures',
      labelKey: 'signatures',
      fields: [
        const FormFieldDef(id: 'customerSignature', labelKey: 'signatureCustomer', type: FieldType.signature, required: true),
        const FormFieldDef(id: 'installerSignature', labelKey: 'signatureInstaller', type: FieldType.signature, required: true),
      ],
    ),
  ];
}
