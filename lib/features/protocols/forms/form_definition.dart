import 'package:flutter/material.dart';

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
  final FormFieldDef? repeatableField;

  const FormSection({
    required this.id,
    required this.labelKey,
    required this.fields,
    this.isRepeatable = false,
    this.repeatableField,
  });
}

class FormFieldDef {
  final String id;
  final String labelKey;
  final FieldType type;
  final bool required;
  final List<String>? dropdownOptions;

  const FormFieldDef({
    required this.id,
    required this.labelKey,
    required this.type,
    this.required = false,
    this.dropdownOptions,
  });
}

abstract class ProtocolFormDefinition {
  String get protocolType;
  List<FormSection> get sections;
}
