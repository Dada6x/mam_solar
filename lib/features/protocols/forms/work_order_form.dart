import 'package:mam_solar/features/protocols/forms/form_definition.dart';

class WorkOrderForm implements ProtocolFormDefinition {
  @override
  String get protocolType => 'work_order';

  @override
  List<FormSection> get sections => [
    FormSection(
      id: 'customer_data',
      labelKey: 'customerData',
      fields: [
        const FormFieldDef(id: 'fullName', labelKey: 'fullName', type: FieldType.text, required: true),
        const FormFieldDef(id: 'street', labelKey: 'street', type: FieldType.text),
        const FormFieldDef(id: 'zipCity', labelKey: 'zipCity', type: FieldType.text),
        const FormFieldDef(id: 'email', labelKey: 'email', type: FieldType.text),
      ],
    ),
    FormSection(
      id: 'work_description',
      labelKey: 'workDescription',
      fields: [
        const FormFieldDef(id: 'description', labelKey: 'description', type: FieldType.textarea, required: true),
        const FormFieldDef(id: 'workDetail', labelKey: 'workDetail', type: FieldType.textarea),
      ],
    ),
    FormSection(
      id: 'materials',
      labelKey: 'materials',
      isRepeatable: true,
      fields: [
        const FormFieldDef(id: 'quantity', labelKey: 'quantity', type: FieldType.text),
        const FormFieldDef(id: 'material', labelKey: 'material', type: FieldType.text),
      ],
    ),
    FormSection(
      id: 'vehicle_travel',
      labelKey: 'vehicleTravel',
      isRepeatable: true,
      fields: [
        const FormFieldDef(id: 'departure', labelKey: 'departure', type: FieldType.text),
        const FormFieldDef(id: 'destination', labelKey: 'destination', type: FieldType.text),
      ],
    ),
    FormSection(
      id: 'working_hours',
      labelKey: 'workingHours',
      isRepeatable: true,
      fields: [
        const FormFieldDef(id: 'date', labelKey: 'date', type: FieldType.date, required: true),
        const FormFieldDef(id: 'techName', labelKey: 'techName', type: FieldType.text, required: true),
        const FormFieldDef(id: 'startTime', labelKey: 'startTime', type: FieldType.time, required: true),
        const FormFieldDef(id: 'endTime', labelKey: 'endTime', type: FieldType.time, required: true),
      ],
    ),
    FormSection(
      id: 'completion',
      labelKey: 'completion',
      fields: [
        const FormFieldDef(id: 'workCompleted', labelKey: 'workCompleted', type: FieldType.checkbox),
        const FormFieldDef(id: 'photoWork1', labelKey: 'photoWork1', type: FieldType.photo),
        const FormFieldDef(id: 'photoWork2', labelKey: 'photoWork2', type: FieldType.photo),
        const FormFieldDef(id: 'completionDate', labelKey: 'completionDate', type: FieldType.date),
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
        const FormFieldDef(id: 'technicianSignature', labelKey: 'signatureTechnician', type: FieldType.signature, required: true),
      ],
    ),
  ];
}
