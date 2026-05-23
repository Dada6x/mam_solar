import 'package:mam_solar/features/protocols/forms/form_definition.dart';

class AcAcceptanceForm implements ProtocolFormDefinition {
  @override
  String get protocolType => 'ac_acceptance';

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
        const FormFieldDef(id: 'inspectionCompleted', labelKey: 'inspectionCompleted', type: FieldType.checkbox),
        const FormFieldDef(id: 'inspectionReason', labelKey: 'inspectionReason', type: FieldType.textarea),
        const FormFieldDef(id: 'groundRodInstalled', labelKey: 'groundRodInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'privateMeterInstalled', labelKey: 'privateMeterInstalled', type: FieldType.checkbox),
        const FormFieldDef(id: 'supervisorIntroduced', labelKey: 'supervisorIntroduced', type: FieldType.checkbox),
        const FormFieldDef(id: 'shoeCoversWorn', labelKey: 'shoeCoversWorn', type: FieldType.checkbox),
      ],
    ),
    FormSection(
      id: 'inverter',
      labelKey: 'inverter',
      isRepeatable: true,
      fields: [
        const FormFieldDef(id: 'brand', labelKey: 'brand', type: FieldType.text, required: true),
        const FormFieldDef(id: 'model', labelKey: 'model', type: FieldType.text),
        const FormFieldDef(id: 'serialNumber', labelKey: 'serialNumber', type: FieldType.text, required: true),
        const FormFieldDef(
          id: 'networkType',
          labelKey: 'networkType',
          type: FieldType.dropdown,
          dropdownOptions: ['wlan', 'powerline', 'ethernet'],
        ),
        const FormFieldDef(id: 'installedCorrectly', labelKey: 'installedCorrectly', type: FieldType.checkbox),
        const FormFieldDef(id: 'photoDataplate', labelKey: 'photoDataplate', type: FieldType.photo),
        const FormFieldDef(id: 'photoAcConnection', labelKey: 'photoAcConnection', type: FieldType.photo),
        const FormFieldDef(id: 'photoFinalInstall', labelKey: 'photoFinalInstall', type: FieldType.photo),
      ],
    ),
    FormSection(
      id: 'battery_storage',
      labelKey: 'batteryStorage',
      fields: [
        const FormFieldDef(id: 'batteryBrand', labelKey: 'batteryBrand', type: FieldType.text),
        const FormFieldDef(id: 'batteryModel', labelKey: 'batteryModel', type: FieldType.text),
        const FormFieldDef(id: 'batteryTowers', labelKey: 'batteryTowers', type: FieldType.number),
        const FormFieldDef(id: 'batteryModules', labelKey: 'batteryModules', type: FieldType.number),
        const FormFieldDef(id: 'serialNumbers', labelKey: 'serialNumbers', type: FieldType.textarea),
        const FormFieldDef(id: 'photoBattery', labelKey: 'photoBattery', type: FieldType.photo),
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
      id: 'meter_info',
      labelKey: 'meterInfo',
      fields: [
        const FormFieldDef(
          id: 'meterType',
          labelKey: 'meterType',
          type: FieldType.dropdown,
          dropdownOptions: ['singleDirection', 'bidirectional', 'threePoint'],
        ),
        const FormFieldDef(id: 'meterReplacementNeeded', labelKey: 'meterReplacementNeeded', type: FieldType.checkbox),
        const FormFieldDef(id: 'meterRemovalNeeded', labelKey: 'meterRemovalNeeded', type: FieldType.checkbox),
        const FormFieldDef(
          id: 'measurementConcept',
          labelKey: 'measurementConcept',
          type: FieldType.dropdown,
          dropdownOptions: ['excessFeedIn', 'fullFeedIn', 'selfConsumption'],
        ),
        const FormFieldDef(id: 'photoMeter', labelKey: 'photoMeter', type: FieldType.photo),
      ],
    ),
    FormSection(
      id: 'cable_routes',
      labelKey: 'cableRoutes',
      fields: [
        const FormFieldDef(id: 'routeOver25m', labelKey: 'routeOver25m', type: FieldType.checkbox),
        const FormFieldDef(id: 'notes', labelKey: 'notes', type: FieldType.textarea),
        const FormFieldDef(id: 'photoCable1', labelKey: 'photoCable1', type: FieldType.photo),
        const FormFieldDef(id: 'photoCable2', labelKey: 'photoCable2', type: FieldType.photo),
        const FormFieldDef(id: 'photoCable3', labelKey: 'photoCable3', type: FieldType.photo),
      ],
    ),
    FormSection(
      id: 'final_acceptance',
      labelKey: 'finalAcceptance',
      fields: [
        const FormFieldDef(id: 'systemOperational', labelKey: 'systemOperational', type: FieldType.checkbox, required: true),
        const FormFieldDef(id: 'customerInformed', labelKey: 'customerInformed', type: FieldType.checkbox, required: true),
        const FormFieldDef(id: 'invoiceApproved', labelKey: 'invoiceApproved', type: FieldType.checkbox, required: true),
        const FormFieldDef(id: 'cleanupDone', labelKey: 'cleanupDone', type: FieldType.checkbox),
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
