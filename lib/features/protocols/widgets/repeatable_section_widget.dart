import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/widgets/form_field_renderer.dart';

class RepeatableSectionWidget extends StatefulWidget {
  final FormSection section;
  final List<Map<String, dynamic>> items;
  final void Function(int index, String key, dynamic value) onFieldChanged;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final String languageCode;

  const RepeatableSectionWidget({
    super.key,
    required this.section,
    required this.items,
    required this.onFieldChanged,
    required this.onAdd,
    required this.onRemove,
    required this.languageCode,
  });

  @override
  State<RepeatableSectionWidget> createState() => _RepeatableSectionWidgetState();
}

class _RepeatableSectionWidgetState extends State<RepeatableSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(widget.items.length, (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.items.length > 1)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.section.labelKey} #${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, size: 20, color: AppColors.errorRed),
                          onPressed: () => widget.onRemove(index),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: widget.section.fields.map((field) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: FormFieldRenderer(
                          field: field,
                          value: widget.items[index][field.id],
                          onChanged: (value) {
                            widget.onFieldChanged(index, field.id, value);
                          },
                          protocolId: 0,
                          label: field.localizedLabel(widget.languageCode),
                          formData: widget.items[index],
                          languageCode: widget.languageCode,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }),
        Center(
          child: TextButton.icon(
            onPressed: widget.onAdd,
            icon: const Icon(Icons.add_circle_outline, size: 18),
            label: const Text('Add item'),
          ),
        ),
      ],
    );
  }
}
