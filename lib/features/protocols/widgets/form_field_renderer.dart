import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/widgets/file_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/multi_photo_capture_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/photo_capture_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/signature_field_widget.dart';

class FormFieldRenderer extends StatelessWidget {
  final FormFieldDef field;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final int protocolId;
  final String label;
  final Map<String, dynamic>? formData;
  final String? languageCode;
  final bool isError;

  const FormFieldRenderer({
    super.key,
    required this.field,
    this.value,
    required this.onChanged,
    required this.protocolId,
    required this.label,
    this.formData,
    this.languageCode,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    if (field.showIfField != null) {
      if (!_evaluateShowIf()) {
        return const SizedBox.shrink();
      }
    }

    final lang = languageCode ?? 'en';
    final effectiveLabel = field.localizedLabel(lang);
    final labelText = effectiveLabel;
    final requiredMark = field.required ? ' *' : '';

    InputDecoration dec(String label, {Widget? suffixIcon, bool alignLabel = false}) {
      return InputDecoration(
        labelText: '$label$requiredMark',
        labelStyle: const TextStyle(fontSize: 13),
        suffixIcon: suffixIcon,
        alignLabelWithHint: alignLabel,
        errorText: isError ? '' : null,
      );
    }

    switch (field.type) {
      case FieldType.text:
        return TextFormField(
          initialValue: value as String? ?? '',
          decoration: dec(labelText),
          onChanged: onChanged,
        );

      case FieldType.datetime:
        final displayValue = value as String? ?? '';
        return TextFormField(
          readOnly: true,
          controller: TextEditingController(text: displayValue),
          decoration: dec(labelText, suffixIcon: const Icon(Icons.calendar_month, size: 18)),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date == null) return;
            if (!context.mounted) return;
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time == null) return;
            final formatted =
                '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}'
                ' ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
            onChanged(formatted);
          },
        );

      case FieldType.number:
        return TextFormField(
          initialValue: value as String? ?? '',
          keyboardType: TextInputType.number,
          decoration: dec(labelText),
          onChanged: onChanged,
        );

      case FieldType.date:
        final displayValue = value as String? ?? '';
        return TextFormField(
          readOnly: true,
          controller: TextEditingController(text: displayValue),
          decoration: dec(labelText, suffixIcon: const Icon(Icons.calendar_today, size: 18)),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final formatted =
                  '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
              onChanged(formatted);
            }
          },
        );

      case FieldType.time:
        final displayValue = value as String? ?? '';
        return TextFormField(
          readOnly: true,
          controller: TextEditingController(text: displayValue),
          decoration: dec(labelText, suffixIcon: const Icon(Icons.access_time, size: 18)),
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              final formatted =
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
              onChanged(formatted);
            }
          },
        );

      case FieldType.checkbox:
        return CheckboxListTile(
          title: Text(labelText, style: const TextStyle(fontSize: 14)),
          value: value == true,
          activeColor: AppColors.primaryGreen,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          onChanged: (v) => onChanged(v),
        );

      case FieldType.radio:
        {
          final options = field.dropdownOptions ?? [];
          final selected = value as String?;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$labelText$requiredMark',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.labelGrey,
                ),
              ),
              ...options.map((opt) {
                return RadioListTile<String>(
                  title: Text(
                    opt.replaceAll('_', ' '),
                    style: const TextStyle(fontSize: 13),
                  ),
                  value: opt,
                  groupValue: selected,
                  activeColor: AppColors.primaryGreen,
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  onChanged: (v) => onChanged(v),
                );
              }),
            ],
          );
        }

      case FieldType.dropdown:
        final options = field.dropdownOptions ?? [];
        return DropdownButtonFormField<String>(
          initialValue: value as String?,
          decoration: dec(labelText),
          items: options.map((opt) {
            return DropdownMenuItem(
              value: opt,
              child: Text(
                opt.replaceAll('_', ' '),
                style: const TextStyle(fontSize: 13),
              ),
            );
          }).toList(),
          onChanged: (v) => onChanged(v),
        );

      case FieldType.photo:
        return PhotoCaptureFieldWidget(
          label: labelText,
          imagePath: value as String?,
          onChanged: onChanged,
        );

      case FieldType.multiphoto:
        return MultiPhotoCaptureFieldWidget(
          label: labelText,
          imagePaths: toPhotoList(value),
          onChanged: (v) => onChanged(v),
        );

      case FieldType.signature:
        return SignatureFieldWidget(
          label: labelText,
          signaturePath: value as String?,
          onTap: () {},
          onClear: () => onChanged(null),
        );

      case FieldType.textarea:
        return TextFormField(
          initialValue: value as String? ?? '',
          maxLines: 5,
          decoration: dec(labelText, alignLabel: true),
          onChanged: onChanged,
        );

      case FieldType.file:
        return FileFieldWidget(
          label: '$labelText$requiredMark',
          filePath: value as String?,
          onChanged: onChanged,
          acceptedFormats: field.acceptedFormats,
        );

      case FieldType.displayText:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.labelGrey,
              fontStyle: FontStyle.italic,
            ),
          ),
        );

      case FieldType.repeatable:
        return const SizedBox.shrink();
    }
  }

  bool _evaluateShowIf() {
    if (field.showIfField == null ||
        field.showIfOperator == null ||
        field.showIfValue == null) {
      return true;
    }

    final currentValue = formData?[field.showIfField];

    bool evaluateSingle(String operator, String compareValue) {
      if (compareValue == 'unchecked') {
        final isChecked = currentValue == true || currentValue == 'true';
        return operator == '==' ? !isChecked : isChecked;
      }
      final currentStr = currentValue?.toString() ?? '';
      if (operator == '==') return currentStr == compareValue;
      if (operator == '!=') return currentStr != compareValue;
      return true;
    }

    // OR conditions: if showIfValues is set, any match is sufficient
    if (field.showIfValues != null && field.showIfValues!.isNotEmpty) {
      return field.showIfValues!.any(
        (v) => evaluateSingle(field.showIfOperator!, v),
      );
    }

    return evaluateSingle(field.showIfOperator!, field.showIfValue!);
  }

  static List<String> toPhotoList(dynamic value) {
    if (value is List) return value.cast<String>().toList();
    if (value is String && value.isNotEmpty) return [value];
    return [];
  }
}
