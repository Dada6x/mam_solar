import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/widgets/file_field_widget.dart';
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

  const FormFieldRenderer({
    super.key,
    required this.field,
    this.value,
    required this.onChanged,
    required this.protocolId,
    required this.label,
    this.formData,
    this.languageCode,
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

    switch (field.type) {
      case FieldType.text:
        return TextFormField(
          initialValue: value as String? ?? '',
          decoration: InputDecoration(
            labelText: '$labelText$requiredMark',
            labelStyle: const TextStyle(fontSize: 13),
          ),
          onChanged: onChanged,
        );

      case FieldType.number:
        return TextFormField(
          initialValue: value as String? ?? '',
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: '$labelText$requiredMark',
            labelStyle: const TextStyle(fontSize: 13),
          ),
          onChanged: onChanged,
        );

      case FieldType.date:
        final displayValue = value as String? ?? '';
        return TextFormField(
          readOnly: true,
          controller: TextEditingController(text: displayValue),
          decoration: InputDecoration(
            labelText: '$labelText$requiredMark',
            labelStyle: const TextStyle(fontSize: 13),
            suffixIcon: const Icon(Icons.calendar_today, size: 18),
          ),
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
          decoration: InputDecoration(
            labelText: '$labelText$requiredMark',
            labelStyle: const TextStyle(fontSize: 13),
            suffixIcon: const Icon(Icons.access_time, size: 18),
          ),
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
          title: Text(
            labelText,
            style: const TextStyle(fontSize: 14),
          ),
          value: value == true,
          activeColor: AppColors.primaryGreen,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          onChanged: (v) => onChanged(v),
        );

      case FieldType.dropdown:
        final options = field.dropdownOptions ?? [];
        return DropdownButtonFormField<String>(
          initialValue: value as String?,
          decoration: InputDecoration(
            labelText: '$labelText$requiredMark',
            labelStyle: const TextStyle(fontSize: 13),
          ),
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
          decoration: InputDecoration(
            labelText: '$labelText$requiredMark',
            labelStyle: const TextStyle(fontSize: 13),
            alignLabelWithHint: true,
          ),
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
            style: const TextStyle(fontSize: 13, color: AppColors.labelGrey, fontStyle: FontStyle.italic),
          ),
        );

      case FieldType.repeatable:
        return const SizedBox.shrink();
    }
  }

  bool _evaluateShowIf() {
    if (field.showIfField == null || field.showIfOperator == null || field.showIfValue == null) {
      return true;
    }

    final currentValue = formData?[field.showIfField];

    if (field.showIfValue == 'unchecked') {
      final isChecked = currentValue == true || currentValue == 'true';
      return field.showIfOperator == '==' ? !isChecked : isChecked;
    }

    final currentStr = currentValue?.toString() ?? '';

    if (field.showIfOperator == '==') {
      return currentStr == field.showIfValue;
    } else if (field.showIfOperator == '!=') {
      return currentStr != field.showIfValue;
    }

    return true;
  }
}
