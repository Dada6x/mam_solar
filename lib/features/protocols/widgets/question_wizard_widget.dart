import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/features/protocols/bloc/protocol_bloc.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/widgets/form_field_renderer.dart';
import 'package:mam_solar/features/protocols/widgets/photo_capture_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/signature_field_widget.dart';
import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

enum _WizardPageType { fieldGroup, review }

class _WizardPage {
  final String id;
  final _WizardPageType type;
  final FormSection section;
  final List<FormFieldDef> fields;
  final bool hasAnyRequired;

  const _WizardPage({
    required this.id,
    required this.type,
    required this.section,
    this.fields = const [],
    this.hasAnyRequired = false,
  });
}

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
  int _currentIndex = 0;
  String _currentPageId = '';
  String? _validationError;

  bool _evaluateShowIf(FormFieldDef field, Map<String, dynamic> formData) {
    if (field.showIfField == null ||
        field.showIfOperator == null ||
        field.showIfValue == null) {
      return true;
    }
    final currentValue = formData[field.showIfField];
    final currentStr = currentValue?.toString() ?? '';
    if (field.showIfOperator == '==') return currentStr == field.showIfValue;
    if (field.showIfOperator == '!=') return currentStr != field.showIfValue;
    return true;
  }

  List<_WizardPage> _buildPages(
    List<FormSection> sections,
    Map<String, dynamic> formData,
    Map<String, List<Map<String, dynamic>>> repeatableData,
  ) {
    final pages = <_WizardPage>[];

    for (final section in sections) {
      if (section.isRepeatable) {
        pages.add(
          _WizardPage(
            id: 'repeat_${section.id}',
            type: _WizardPageType.fieldGroup,
            section: section,
            fields: section.fields,
            hasAnyRequired: section.fields.any((f) => f.required),
          ),
        );
      } else {
        final fieldGroups = _getFieldGroups(section, formData);
        for (int gi = 0; gi < fieldGroups.length; gi++) {
          final group = fieldGroups[gi];
          final visible =
              group.where((f) => _evaluateShowIf(f, formData)).toList();
          if (visible.isEmpty) continue;
          pages.add(
            _WizardPage(
              id: '${section.id}_g$gi',
              type: _WizardPageType.fieldGroup,
              section: section,
              fields: visible,
              hasAnyRequired: visible.any((f) => f.required),
            ),
          );
        }
      }
    }

    pages.add(
      _WizardPage(
        id: 'review',
        type: _WizardPageType.review,
        section: sections.isNotEmpty
            ? sections.first
            : FormSection(id: '', labelKey: '', fields: []),
      ),
    );

    return pages;
  }

  List<List<FormFieldDef>> _getFieldGroups(
    FormSection section,
    Map<String, dynamic> formData,
  ) {
    if (section.fieldPages.isNotEmpty) {
      return section.fieldPages;
    }
    return [section.fields];
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProtocolBloc>().state;
    final bloc = context.read<ProtocolBloc>();
    final languageCode = context.watch<SettingsBloc>().state.languageCode;

    final pages = _buildPages(
      state.sections,
      state.formData,
      state.repeatableData,
    );

    if (_currentPageId.isNotEmpty) {
      final newIdx = pages.indexWhere((p) => p.id == _currentPageId);
      if (newIdx >= 0) {
        _currentIndex = newIdx;
      } else {
        _currentIndex = _currentIndex.clamp(0, pages.length - 1);
      }
    } else if (pages.isNotEmpty) {
      _currentPageId = pages[0].id;
    }

    if (pages.isEmpty || _currentIndex >= pages.length) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noQuestions,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    final currentPage = pages[_currentIndex];
    final isLastPage = _currentIndex == pages.length - 1;
    final totalPages = pages.length;

    return Column(
      children: [
        _ProgressBar(
          current: _currentIndex,
          total: totalPages,
          protocolType: widget.protocolType,
          languageCode: languageCode,
          sections: state.sections,
          currentPage: currentPage,
        ),
        Expanded(
          child: _buildPage(context, currentPage, state, bloc, languageCode),
        ),
        _NavigationBar(
          currentPage: currentPage,
          currentIndex: _currentIndex,
          totalPages: totalPages,
          isLastPage: isLastPage,
          formData: state.formData,
          repeatableData: state.repeatableData,
          pdfGenerating: state.pdfGenerating,
          validationError: _validationError,
          onBack: () {
            setState(() {
              _validationError = null;
              _currentIndex--;
              _currentPageId = pages[_currentIndex].id;
            });
          },
          onNext: () {
            if (currentPage.section.isRepeatable) {
              final items =
                  state.repeatableData[currentPage.section.id] ?? [];
              for (int ri = 0; ri < items.length; ri++) {
                for (final field in currentPage.fields) {
                  if (!field.required) continue;
                  final val = items[ri][field.id];
                  if (val == null || (val is String && val.trim().isEmpty)) {
                    final label = field.localizedLabel(languageCode);
                    setState(
                      () => _validationError =
                          '$label ${AppLocalizations.of(context)!.fieldRequiredSingle}',
                    );
                    return;
                  }
                }
              }
            } else {
              final emptyRequired = currentPage.fields.where((f) {
                if (!f.required) return false;
                final val = state.formData[f.id];
                return val == null || (val is String && val.trim().isEmpty);
              }).toList();
              if (emptyRequired.isNotEmpty) {
                final firstLabel =
                    emptyRequired.first.localizedLabel(languageCode);
                setState(
                  () => _validationError =
                      '$firstLabel ${AppLocalizations.of(context)!.fieldRequiredSingle}',
                );
                return;
              }
            }
            setState(() {
              _validationError = null;
              _currentIndex++;
              _currentPageId = pages[_currentIndex].id;
            });
          },
          onSkip: () {
            for (final field in currentPage.fields) {
              if (!field.required) {
                bloc.add(UpdateField(field.id, null));
              }
            }
            setState(() {
              _validationError = null;
              _currentIndex++;
              _currentPageId = pages[_currentIndex].id;
            });
          },
          onAddRepeat: () {
            bloc.add(AddRepeatableItem(currentPage.section.id));
          },
          onRemoveRepeat: (int index) {
            bloc.add(RemoveRepeatableItem(currentPage.section.id, index));
          },
          onGeneratePdf: () {
            final missing = bloc.getMissingRequiredFields();
            if (missing.isNotEmpty) {
              setState(
                () => _validationError =
                    '${AppLocalizations.of(context)!.fieldRequired}: ${missing.join(', ')}',
              );
              return;
            }
            bloc.add(const GeneratePdf());
          },
        ),
      ],
    );
  }

  Widget _buildPage(
    BuildContext context,
    _WizardPage page,
    ProtocolState state,
    ProtocolBloc bloc,
    String languageCode,
  ) {
    switch (page.type) {
      case _WizardPageType.fieldGroup:
        if (page.section.isRepeatable) {
          return _RepeatableSectionPage(
            key: ValueKey(page.id),
            section: page.section,
            fields: page.fields,
            repeatableData: state.repeatableData,
            protocolId: widget.protocolId,
            languageCode: languageCode,
            onFieldChanged: (ri, fieldId, value) {
              bloc.add(
                UpdateRepeatableField(page.section.id, ri, fieldId, value),
              );
            },
          );
        }
        return _FieldGroupPage(
          key: ValueKey(page.id),
          section: page.section,
          fields: page.fields,
          formData: state.formData,
          protocolId: widget.protocolId,
          languageCode: languageCode,
          onFieldChanged: (fieldId, value) {
            bloc.add(UpdateField(fieldId, value));
          },
        );

      case _WizardPageType.review:
        return _ReviewPage(
          key: ValueKey(page.id),
          protocolType: widget.protocolType,
          languageCode: languageCode,
        );
    }
  }
}

// ─── Progress Bar ────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final String protocolType;
  final String languageCode;
  final List<FormSection> sections;
  final _WizardPage currentPage;

  const _ProgressBar({
    required this.current,
    required this.total,
    required this.protocolType,
    required this.languageCode,
    required this.sections,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 1 ? current / (total - 1) : 0.0;
    final sectionLabel =
        currentPage.section.localizedLabel(languageCode);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Fixed-width counter so it never shrinks
              Text(
                '${current + 1} / $total',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGreen,
                ),
              ),
              const SizedBox(width: 8),
              // Section label gets all remaining space and ellipsises
              if (sectionLabel.isNotEmpty)
                Expanded(
                  child: Text(
                    sectionLabel,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.labelGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryGreen,
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// ─── Repeatable Section Page ──────────────────────────────────

class _RepeatableSectionPage extends StatelessWidget {
  final FormSection section;
  final List<FormFieldDef> fields;
  final Map<String, List<Map<String, dynamic>>> repeatableData;
  final int protocolId;
  final String languageCode;
  final void Function(int repeatIndex, String fieldId, dynamic value)
  onFieldChanged;

  const _RepeatableSectionPage({
    super.key,
    required this.section,
    required this.fields,
    required this.repeatableData,
    required this.protocolId,
    required this.languageCode,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = repeatableData[section.id] ?? [{}];
    final atMax = items.length >= section.maxRepeat;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.localizedLabel(languageCode),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a1a2e),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          ...List.generate(items.length, (ri) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _RepeatItemCard(
                section: section,
                fields: fields,
                itemIndex: ri,
                itemData: items[ri],
                protocolId: protocolId,
                languageCode: languageCode,
                onFieldChanged: (fieldId, value) =>
                    onFieldChanged(ri, fieldId, value),
                canRemove: items.length > section.minRepeat,
              ),
            );
          }),
          if (atMax)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Text(
                  'Maximum ${section.maxRepeat} items',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.labelGrey,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RepeatItemCard extends StatelessWidget {
  final FormSection section;
  final List<FormFieldDef> fields;
  final int itemIndex;
  final Map<String, dynamic> itemData;
  final int protocolId;
  final String languageCode;
  final void Function(String fieldId, dynamic value) onFieldChanged;
  final bool canRemove;

  const _RepeatItemCard({
    required this.section,
    required this.fields,
    required this.itemIndex,
    required this.itemData,
    required this.protocolId,
    required this.languageCode,
    required this.onFieldChanged,
    required this.canRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
            child: Row(
              children: [
                // Label takes available space, never pushes remove button off
                Expanded(
                  child: Text(
                    '${section.localizedLabel(languageCode)} #${itemIndex + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryGreen.withValues(alpha: 0.8),
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
                      label: const Text(
                        'Remove',
                        style: TextStyle(
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
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildField(field, value, label, context),
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
    BuildContext context,
  ) {
    switch (field.type) {
      case FieldType.signature:
        return _buildSignatureField(field, value as String?, context);
      case FieldType.photo:
        return PhotoCaptureFieldWidget(
          label: labelText,
          imagePath: value as String?,
          onChanged: (v) => onFieldChanged(field.id, v),
        );
      default:
        return FormFieldRenderer(
          field: field,
          value: value,
          onChanged: (v) => onFieldChanged(field.id, v),
          protocolId: protocolId,
          label: labelText,
          formData: itemData,
          languageCode: languageCode,
        );
    }
  }

  Widget _buildSignatureField(
    FormFieldDef field,
    String? currentPath,
    BuildContext context,
  ) {
    return SignatureFieldWidget(
      label: field.localizedLabel(languageCode),
      signaturePath: currentPath,
      onTap: () async {
        final result = await context.push<String>(
          '/signature/$protocolId/${field.id}',
        );
        if (result != null) {
          onFieldChanged(field.id, result);
        }
      },
      onClear: () => onFieldChanged(field.id, null),
    );
  }
}

// ─── Field Group Page ─────────────────────────────────────────

class _FieldGroupPage extends StatelessWidget {
  final FormSection section;
  final List<FormFieldDef> fields;
  final Map<String, dynamic> formData;
  final int protocolId;
  final String languageCode;
  final void Function(String fieldId, dynamic value) onFieldChanged;

  const _FieldGroupPage({
    super.key,
    required this.section,
    required this.fields,
    required this.formData,
    required this.protocolId,
    required this.languageCode,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fields.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                section.localizedLabel(languageCode),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1a1a2e),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ...fields.asMap().entries.map((entry) {
            final idx = entry.key;
            final field = entry.value;
            final value = formData[field.id];
            final label = field.localizedLabel(languageCode);
            return Padding(
              padding: EdgeInsets.only(top: idx > 0 ? 20 : 0),
              child: _buildFieldWidget(context, field, value, label),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFieldWidget(
    BuildContext context,
    FormFieldDef field,
    dynamic value,
    String labelText,
  ) {
    switch (field.type) {
      case FieldType.signature:
        return _buildSignatureField(context, field, value as String?);
      case FieldType.photo:
        return PhotoCaptureFieldWidget(
          label: labelText,
          imagePath: value as String?,
          onChanged: (v) => onFieldChanged(field.id, v),
        );
      default:
        return FormFieldRenderer(
          field: field,
          value: value,
          onChanged: (v) => onFieldChanged(field.id, v),
          protocolId: protocolId,
          label: labelText,
          formData: formData,
          languageCode: languageCode,
        );
    }
  }

  Widget _buildSignatureField(
    BuildContext context,
    FormFieldDef field,
    String? currentPath,
  ) {
    return SignatureFieldWidget(
      label: field.localizedLabel(languageCode),
      signaturePath: currentPath,
      onTap: () async {
        final result = await context.push<String>(
          '/signature/$protocolId/${field.id}',
        );
        if (result != null) {
          onFieldChanged(field.id, result);
        }
      },
      onClear: () => onFieldChanged(field.id, null),
    );
  }
}

// ─── Review Page ──────────────────────────────────────────────

class _ReviewPage extends StatelessWidget {
  final String protocolType;
  final String languageCode;

  const _ReviewPage({
    super.key,
    required this.protocolType,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                size: 44,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.allQuestionsAnswered,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1a1a2e),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.reviewAndGenerate,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.labelGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Navigation Bar ───────────────────────────────────────────

class _NavigationBar extends StatelessWidget {
  final _WizardPage currentPage;
  final int currentIndex;
  final int totalPages;
  final bool isLastPage;
  final Map<String, dynamic> formData;
  final Map<String, List<Map<String, dynamic>>> repeatableData;
  final bool pdfGenerating;
  final String? validationError;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onAddRepeat;
  final void Function(int index) onRemoveRepeat;
  final VoidCallback onGeneratePdf;

  const _NavigationBar({
    required this.currentPage,
    required this.currentIndex,
    required this.totalPages,
    required this.isLastPage,
    required this.formData,
    required this.repeatableData,
    required this.pdfGenerating,
    this.validationError,
    required this.onBack,
    required this.onNext,
    required this.onSkip,
    required this.onAddRepeat,
    required this.onRemoveRepeat,
    required this.onGeneratePdf,
  });

  @override
  Widget build(BuildContext context) {
    final canGoBack = currentIndex > 0;
    final isRepeatPage = currentPage.section.isRepeatable;

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
            // Validation error — wraps onto multiple lines, never overflows
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
            if (isLastPage)
              _buildGeneratePdfButton(context)
            else
              Row(
                children: [
                  // Back button — fixed minimum width, never grows
                  if (canGoBack)
                    _BackButton(onBack: onBack)
                  else
                    const SizedBox(width: 72),
                  const Spacer(),
                  // Right-side actions are wrapped so they can shrink if needed
                  if (isRepeatPage)
                    _buildRepeatNavigation(context)
                  else
                    _buildFieldNavigation(context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepeatNavigation(BuildContext context) {
    final items = repeatableData[currentPage.section.id] ?? [{}];
    final atMax = items.length >= currentPage.section.maxRepeat;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!atMax) ...[
          _NavButton(
            onPressed: onAddRepeat,
            icon: Icons.add,
            label: AppLocalizations.of(context)!.addItem,
          ),
          const SizedBox(width: 8),
        ],
        _NavButton(
          onPressed: onNext,
          icon: Icons.arrow_forward,
          label: AppLocalizations.of(context)!.next,
        ),
      ],
    );
  }

  Widget _buildFieldNavigation(BuildContext context) {
    final allOptional = !currentPage.hasAnyRequired;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (allOptional) ...[
          TextButton(
            onPressed: onSkip,
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            ),
            child: Text(
              AppLocalizations.of(context)!.skip,
              style: const TextStyle(color: AppColors.labelGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
        ],
        _NavButton(
          onPressed: onNext,
          icon: Icons.arrow_forward,
          label: AppLocalizations.of(context)!.next,
        ),
      ],
    );
  }

  Widget _buildGeneratePdfButton(BuildContext context) {
    return SizedBox(
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
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}

// ─── Shared small widgets ─────────────────────────────────────

/// Back button with a stable min-width so the spacer calculation is reliable.
class _BackButton extends StatelessWidget {
  final VoidCallback onBack;
  const _BackButton({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 72),
      child: TextButton.icon(
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back, size: 18),
        label: Text(
          AppLocalizations.of(context)!.back,
          overflow: TextOverflow.ellipsis,
        ),
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        ),
      ),
    );
  }
}

/// Reusable green elevated button used for Next / Add in the nav bar.
/// Uses [FittedBox] so its label scales down instead of overflowing on
/// very narrow screens.
class _NavButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const _NavButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // Never narrower than 80 dp, never wider than 160 dp
      constraints: const BoxConstraints(minWidth: 80, maxWidth: 160),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}