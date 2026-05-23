enum FieldType {
  text,
  number,
  date,
  time,
  checkbox,
  dropdown,
  photo,
  signature,
  textarea,
  repeatable,
}

class FormSection {
  final String id;
  final String labelKey;
  final List<FormFieldDef> fields;
  final bool isRepeatable;
  final int minRepeat;
  final int maxRepeat;
  final FormFieldDef? repeatableField;
  final bool merged;
  final List<List<FormFieldDef>> fieldPages;
  final String? labelDe;
  final String? labelAr;

  const FormSection({
    required this.id,
    required this.labelKey,
    required this.fields,
    this.isRepeatable = false,
    this.minRepeat = 1,
    this.maxRepeat = 10,
    this.repeatableField,
    this.merged = false,
    this.fieldPages = const [],
    this.labelDe,
    this.labelAr,
  });

  String localizedLabel(String languageCode) {
    if (languageCode == 'de' && labelDe != null) return labelDe!;
    if (languageCode == 'ar' && labelAr != null) return labelAr!;
    return labelKey;
  }
}

class FormFieldDef {
  final String id;
  final String labelKey;
  final FieldType type;
  final bool required;
  final List<String>? dropdownOptions;
  final String? showIfField;
  final String? showIfOperator;
  final String? showIfValue;
  final String? labelDe;
  final String? labelAr;

  const FormFieldDef({
    required this.id,
    required this.labelKey,
    required this.type,
    this.required = false,
    this.dropdownOptions,
    this.showIfField,
    this.showIfOperator,
    this.showIfValue,
    this.labelDe,
    this.labelAr,
  });

  String localizedLabel(String languageCode) {
    if (languageCode == 'de' && labelDe != null) return labelDe!;
    if (languageCode == 'ar' && labelAr != null) return labelAr!;
    return labelKey;
  }
}
