import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/features/protocols/bloc/protocol_bloc.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/widgets/form_field_renderer.dart';
import 'package:mam_solar/features/protocols/widgets/section_card.dart';
import 'package:mam_solar/features/protocols/widgets/multi_photo_capture_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/photo_capture_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/signature_field_widget.dart';
import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class QuestionWizardWidget extends StatefulWidget {
  final String protocolType;
  final int protocolId;

  const QuestionWizardWidget({
    super.key,
    required this.protocolType,
    required this.protocolId,
  });

  @override
  State<QuestionWizardWidget> createState() => _QuestionWizardWidgetState();
}

class _QuestionWizardWidgetState extends State<QuestionWizardWidget> {
  String? _validationError;
  final _scrollController = ScrollController();
  final _fieldKeys = <String, GlobalKey>{};
  final _missingFieldPaths = <String>{};

  bool _evaluateShowIf(FormFieldDef field, Map<String, dynamic> formData) {
    // Delegate to FormFieldDef.isVisible (single source of truth — supports
    // OR lists and the 'unchecked' checkbox gate, unlike the old inline check).
    return field.isVisible(formData);
  }

  bool _isValueFilled(dynamic val) {
    if (val == null) return false;
    if (val is String && val.trim().isEmpty) return false;
    if (val is List && val.isEmpty) return false;
    return true;
  }

  void _scrollToFirstMissing() {
    final state = context.read<ProtocolBloc>().state;
    for (final section in state.sections) {
      for (final field in section.fields) {
        if (field.required && field.type != FieldType.displayText) {
          if (section.isRepeatable) {
            final items = state.repeatableData[section.id] ?? [];
            for (int ri = 0; ri < items.length; ri++) {
              // Skip fields hidden by show_if in this item.
              if (!field.isVisible(items[ri])) continue;
              if (!_isValueFilled(items[ri][field.id])) {
                final key = _fieldKeys['${section.id}:$ri:${field.id}'];
                if (key?.currentContext != null) {
                  Scrollable.ensureVisible(key!.currentContext!,
                      duration: const Duration(milliseconds: 300));
                  return;
                }
              }
            }
          } else {
            // Skip fields hidden by show_if.
            if (!field.isVisible(state.formData)) continue;
            if (!_isValueFilled(state.formData[field.id])) {
              final key = _fieldKeys['${section.id}:${field.id}'];
              if (key?.currentContext != null) {
                Scrollable.ensureVisible(key!.currentContext!,
                    duration: const Duration(milliseconds: 300));
                return;
              }
            }
          }
        }
      }
    }
  }

  void _populateMissingFieldPaths() {
    _missingFieldPaths.clear();
    final state = context.read<ProtocolBloc>().state;
    for (final section in state.sections) {
      for (final field in section.fields) {
        if (field.required && field.type != FieldType.displayText) {
          if (section.isRepeatable) {
            final items = state.repeatableData[section.id] ?? [];
            for (int ri = 0; ri < items.length; ri++) {
              if (!field.isVisible(items[ri])) continue;
              if (!_isValueFilled(items[ri][field.id])) {
                _missingFieldPaths.add('${section.id}:$ri:${field.id}');
              }
            }
          } else {
            if (!field.isVisible(state.formData)) continue;
            if (!_isValueFilled(state.formData[field.id])) {
              _missingFieldPaths.add('${section.id}:${field.id}');
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProtocolBloc>().state;
    final bloc = context.read<ProtocolBloc>();
    final languageCode = context.watch<SettingsBloc>().state.languageCode;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildContent(state, languageCode, bloc),
            ),
          ),
        ),
        _BottomBar(
          validationError: _validationError,
          pdfGenerating: state.pdfGenerating,
          onGeneratePdf: () {
            final missing = bloc.getMissingRequiredFields(languageCode);
            if (missing.isNotEmpty) {
              _populateMissingFieldPaths();
              setState(
                () => _validationError =
                    '${AppLocalizations.of(context)!.fieldRequired}: ${missing.join(', ')}',
              );
              _scrollToFirstMissing();
              return;
            }
            setState(() {
              _validationError = null;
              _missingFieldPaths.clear();
            });
            bloc.add(const GeneratePdf());
          },
        ),
      ],
    );
  }

  List<Widget> _buildContent(
    ProtocolState state,
    String languageCode,
    ProtocolBloc bloc,
  ) {
    final widgets = <Widget>[];
    for (final section in state.sections) {
      final inner = section.isRepeatable
          ? _buildRepeatableSection(state, section, languageCode, bloc)
          : _buildNonRepeatableSection(section, state.formData, languageCode);
      // Skip sections whose fields are all hidden (showIf) so no empty card shows.
      if (inner.isEmpty) continue;
      widgets.add(
        SectionCard(
          title: section.localizedLabel(languageCode),
          children: inner,
        ),
      );
      widgets.add(const SizedBox(height: 16));
    }
    return widgets;
  }

  List<Widget> _buildRepeatableSection(
    ProtocolState state,
    FormSection section,
    String languageCode,
    ProtocolBloc bloc,
  ) {
    // Section title is rendered by the surrounding SectionCard header.
    final widgets = <Widget>[];
    final items = state.repeatableData[section.id] ?? [{}];
    for (int ri = 0; ri < items.length; ri++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _RepeatItemCard(
            section: section,
            fields: section.fields,
            itemIndex: ri,
            itemData: items[ri],
            protocolId: widget.protocolId,
            languageCode: languageCode,
            onFieldChanged: (fieldId, value) {
              bloc.add(
                UpdateRepeatableField(section.id, ri, fieldId, value),
              );
            },
            canRemove: items.length > section.minRepeat,
            fieldKeys: _fieldKeys,
            missingFieldPaths: _missingFieldPaths,
            onClearError: (keyPath) =>
                setState(() => _missingFieldPaths.remove(keyPath)),
          ),
        ),
      );
    }
    if (items.length < section.maxRepeat) {
      widgets.add(
        Center(
          child: OutlinedButton.icon(
            onPressed: () => bloc.add(AddRepeatableItem(section.id)),
            icon: const Icon(Icons.add, size: 18),
            label: Text(AppLocalizations.of(context)!.addItem),
          ),
        ),
      );
    } else {
      widgets.add(
        Center(
          child: Text(
            'Maximum ${section.maxRepeat} items',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.labelGrey,
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _buildNonRepeatableSection(
    FormSection section,
    Map<String, dynamic> formData,
    String languageCode,
  ) {
    final widgets = <Widget>[];
    final fieldGroups = section.fieldPages.isNotEmpty
        ? section.fieldPages
        : [section.fields];
    for (int gi = 0; gi < fieldGroups.length; gi++) {
      final group = fieldGroups[gi];
      final visible = group.where(
        (f) => _evaluateShowIf(f, formData),
      ).toList();
      if (visible.isEmpty) continue;
      // Section title is rendered by the surrounding SectionCard header.
      if (fieldGroups.length > 1 && gi > 0) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              section.localizedLabel(languageCode),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.labelGrey,
              ),
            ),
          ),
        );
      }
      widgets.addAll(
        visible.asMap().entries.map((entry) {
          final idx = entry.key;
          final field = entry.value;
          final value = formData[field.id];
          final keyString = '${section.id}:${field.id}';
          final fieldKey =
              _fieldKeys.putIfAbsent(keyString, () => GlobalKey());
          return Padding(
            key: fieldKey,
            padding: EdgeInsets.only(top: idx > 0 ? 20 : 16),
            child: _buildFieldWidget(
              field,
              value,
              languageCode,
              formData,
              isError: _missingFieldPaths.contains(keyString),
              fieldKeyPath: keyString,
            ),
          );
        }),
      );
    }
    return widgets;
  }

  Widget _buildFieldWidget(
    FormFieldDef field,
    dynamic value,
    String languageCode,
    Map<String, dynamic> formData, {
    bool isError = false,
    String fieldKeyPath = '',
  }) {
    final label = field.localizedLabel(languageCode);
    void clearAndUpdate(dynamic v) {
      if (fieldKeyPath.isNotEmpty) {
        setState(() => _missingFieldPaths.remove(fieldKeyPath));
      }
      context.read<ProtocolBloc>().add(UpdateField(field.id, v));
    }

    switch (field.type) {
      case FieldType.signature:
        final bloc = context.read<ProtocolBloc>();
        return SignatureFieldWidget(
          label: label,
          required: field.required,
          signaturePath: value as String?,
          isError: isError,
          onTap: () async {
            final result = await context.push<String>(
              '/signature/${widget.protocolId}/${field.id}',
            );
            if (result != null) {
              if (fieldKeyPath.isNotEmpty) {
                setState(() => _missingFieldPaths.remove(fieldKeyPath));
              }
              bloc.add(UpdateField(field.id, result));
            }
          },
          onClear: () {
            if (fieldKeyPath.isNotEmpty) {
              setState(() => _missingFieldPaths.remove(fieldKeyPath));
            }
            bloc.add(UpdateField(field.id, null));
          },
        );
      case FieldType.photo:
        return PhotoCaptureFieldWidget(
          label: label,
          required: field.required,
          imagePath: value as String?,
          onChanged: (v) => clearAndUpdate(v),
        );
      case FieldType.multiphoto:
        return MultiPhotoCaptureFieldWidget(
          label: label,
          required: field.required,
          imagePaths: FormFieldRenderer.toPhotoList(value),
          onChanged: (v) => clearAndUpdate(v),
        );
      default:
        return FormFieldRenderer(
          field: field,
          value: value,
          onChanged: (v) => clearAndUpdate(v),
          protocolId: widget.protocolId,
          label: label,
          formData: formData,
          languageCode: languageCode,
          isError: isError,
        );
    }
  }
}

// ─── Bottom Bar ────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  final String? validationError;
  final bool pdfGenerating;
  final VoidCallback onGeneratePdf;

  const _BottomBar({
    this.validationError,
    required this.pdfGenerating,
    required this.onGeneratePdf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (validationError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  validationError!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.errorRed,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: pdfGenerating ? null : onGeneratePdf,
                icon: pdfGenerating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.picture_as_pdf, size: 20),
                label: Text(
                  AppLocalizations.of(context)!.generatePdf,
                  overflow: TextOverflow.ellipsis,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Repeat Item Card ──────────────────────────────────────

class _RepeatItemCard extends StatelessWidget {
  final FormSection section;
  final List<FormFieldDef> fields;
  final int itemIndex;
  final Map<String, dynamic> itemData;
  final int protocolId;
  final String languageCode;
  final void Function(String fieldId, dynamic value) onFieldChanged;
  final bool canRemove;
  final Map<String, GlobalKey> fieldKeys;
  final Set<String> missingFieldPaths;
  final void Function(String fieldKeyPath)? onClearError;

  const _RepeatItemCard({
    required this.section,
    required this.fields,
    required this.itemIndex,
    required this.itemData,
    required this.protocolId,
    required this.languageCode,
    required this.onFieldChanged,
    required this.canRemove,
    required this.fieldKeys,
    required this.missingFieldPaths,
    this.onClearError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        border: Border.all(color: AppColors.borderGrey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${section.localizedLabel(languageCode)} #${itemIndex + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryBlue.withValues(alpha: 0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (canRemove)
                  SizedBox(
                    height: 28,
                    child: TextButton.icon(
                      onPressed: () {
                        context.read<ProtocolBloc>().add(
                          RemoveRepeatableItem(section.id, itemIndex),
                        );
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        size: 16,
                        color: AppColors.errorRed,
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.removeItem,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.errorRed,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: fields.map((field) {
                final value = itemData[field.id];
                final label = field.localizedLabel(languageCode);
                final keyString =
                    '${section.id}:$itemIndex:${field.id}';
                final fieldKey =
                    fieldKeys.putIfAbsent(keyString, () => GlobalKey());
                final isError = missingFieldPaths.contains(keyString);
                return Padding(
                  key: fieldKey,
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildField(
                    field, value, label, context,
                    isError: isError,
                    fieldKeyPath: keyString,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    FormFieldDef field,
    dynamic value,
    String labelText,
    BuildContext context, {
    bool isError = false,
    String fieldKeyPath = '',
  }) {
    void clearAndUpdate(dynamic v) {
      if (fieldKeyPath.isNotEmpty) {
        onClearError?.call(fieldKeyPath);
      }
      onFieldChanged(field.id, v);
    }

    switch (field.type) {
      case FieldType.signature:
        return _buildSignatureField(
          field, value as String?, context,
          isError: isError,
          fieldKeyPath: fieldKeyPath,
        );
      case FieldType.photo:
        return PhotoCaptureFieldWidget(
          label: labelText,
          required: field.required,
          imagePath: value as String?,
          onChanged: (v) => clearAndUpdate(v),
        );
      case FieldType.multiphoto:
        return MultiPhotoCaptureFieldWidget(
          label: labelText,
          required: field.required,
          imagePaths: FormFieldRenderer.toPhotoList(value),
          onChanged: (v) => clearAndUpdate(v),
        );
      default:
        return FormFieldRenderer(
          field: field,
          value: value,
          onChanged: (v) => clearAndUpdate(v),
          protocolId: protocolId,
          label: labelText,
          formData: itemData,
          languageCode: languageCode,
          isError: isError,
        );
    }
  }

  Widget _buildSignatureField(
    FormFieldDef field,
    String? currentPath,
    BuildContext context, {
    bool isError = false,
    String fieldKeyPath = '',
  }) {
    void clearError() {
      if (fieldKeyPath.isNotEmpty) {
        onClearError?.call(fieldKeyPath);
      }
    }

    return SignatureFieldWidget(
      label: field.localizedLabel(languageCode),
      required: field.required,
      signaturePath: currentPath,
      isError: isError,
      onTap: () async {
        final result = await context.push<String>(
          '/signature/$protocolId/${field.id}',
        );
        if (result != null && context.mounted) {
          clearError();
          onFieldChanged(field.id, result);
        }
      },
      onClear: () {
        clearError();
        onFieldChanged(field.id, null);
      },
    );
  }
}
