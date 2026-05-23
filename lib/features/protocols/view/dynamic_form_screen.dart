import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';
import 'package:mam_solar/features/protocols/bloc/protocol_bloc.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/widgets/form_field_renderer.dart';
import 'package:mam_solar/features/protocols/widgets/photo_capture_field_widget.dart';
import 'package:mam_solar/features/protocols/widgets/repeatable_section_widget.dart';
import 'package:mam_solar/features/protocols/widgets/signature_field_widget.dart';
import 'package:mam_solar/l10n/app_localizations.dart';
import 'package:sized_context/sized_context.dart';

class DynamicFormScreen extends StatefulWidget {
  final String protocolType;
  final int? protocolId;

  const DynamicFormScreen({
    super.key,
    required this.protocolType,
    this.protocolId,
  });

  @override
  State<DynamicFormScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProtocolBloc(
        sl<ProtocolRepository>(),
        sl<SignatureRepository>(),
      )..add(LoadProtocol(protocolId: widget.protocolId, protocolType: widget.protocolType)),
      child: _DynamicFormView(protocolType: widget.protocolType),
    );
  }
}

class _DynamicFormView extends StatelessWidget {
  final String protocolType;

  const _DynamicFormView({required this.protocolType});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProtocolBloc, ProtocolState>(
      listener: (context, state) {
        if (state.saveMessage == 'autosaved' && context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check, size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(AppLocalizations.of(context)!.autosaved),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              backgroundColor: AppColors.primaryGreen,
            ),
          );
        }
        if (state.error == 'saveFailed' && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.saveFailed),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Retry',
                onPressed: () => context.read<ProtocolBloc>().add(const SaveDraft()),
              ),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
        if (state.pdfPath == 'preview' && context.mounted) {
          context.push('/pdf-preview/${state.protocolId}');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('Loading...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null && state.sections.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text(state.error!),
            ),
          );
        }

        final isTablet = context.widthPx >= 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(protocolType.replaceAll('_', ' ').toUpperCase()),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => context.read<ProtocolBloc>().add(const SaveDraft()),
                tooltip: 'Save',
              ),
              PopupMenuButton<String>(
                onSelected: (val) {
                  if (val == 'delete') {
                    _confirmDelete(context);
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline, size: 18, color: AppColors.errorRed),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.deleteDraft,
                          style: const TextStyle(color: AppColors.errorRed),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    ...state.sections.asMap().entries.map((entry) {
                      return _FormSectionWidget(
                        section: entry.value,
                        index: entry.key,
                        formData: state.formData,
                        repeatableData: state.repeatableData,
                        protocolId: state.protocolId,
                        isTablet: isTablet,
                      );
                    }),
                  ],
                ),
              ),
              _buildBottomBar(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, ProtocolState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              final bloc = context.read<ProtocolBloc>();
              final missing = bloc.getMissingRequiredFields();
              if (missing.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${AppLocalizations.of(context)!.fieldRequired}: ${missing.join(', ')}'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.errorRed,
                  ),
                );
                return;
              }
              bloc.add(const GeneratePdf());
            },
            icon: state.pdfGenerating
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.picture_as_pdf),
            label: Text(AppLocalizations.of(context)!.generatePdf),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(ctx)!.deleteDraftConfirm),
        content: Text(AppLocalizations.of(ctx)!.deleteDraftMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppLocalizations.of(ctx)!.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<ProtocolBloc>().add(const DeleteDraft());
              Navigator.of(ctx).pop();
              context.go('/');
            },
            child: Text(
              AppLocalizations.of(ctx)!.delete,
              style: const TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormSectionWidget extends StatefulWidget {
  final FormSection section;
  final int index;
  final Map<String, dynamic> formData;
  final Map<String, List<Map<String, dynamic>>> repeatableData;
  final int protocolId;
  final bool isTablet;

  const _FormSectionWidget({
    required this.section,
    required this.index,
    required this.formData,
    required this.repeatableData,
    required this.protocolId,
    required this.isTablet,
  });

  @override
  State<_FormSectionWidget> createState() => _FormSectionWidgetState();
}

class _FormSectionWidgetState extends State<_FormSectionWidget> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.index == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          widget.section.labelKey,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() => _isExpanded = expanded);
        },
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          if (widget.section.isRepeatable)
            _buildRepeatableSection()
          else
            _buildRegularFields(),
        ],
      ),
    );
  }

  Widget _buildRegularFields() {
    return Column(
      children: widget.section.fields.map((field) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 12,
            left: widget.isTablet ? 8 : 0,
            right: widget.isTablet ? 8 : 0,
          ),
          child: field.type == FieldType.signature
              ? _buildSignatureField(field)
              : field.type == FieldType.photo
                  ? _buildPhotoField(field)
                  : FormFieldRenderer(
                      field: field,
                      value: widget.formData[field.id],
                      onChanged: (v) {
                        context.read<ProtocolBloc>().add(UpdateField(field.id, v));
                      },
                      protocolId: widget.protocolId,
                      label: field.labelKey,
                    ),
        );
      }).toList(),
    );
  }

  Widget _buildSignatureField(FormFieldDef field) {
    return SignatureFieldWidget(
      label: field.labelKey,
      signaturePath: widget.formData[field.id] as String?,
      onTap: () async {
        final result = await context.push<String>(
          '/signature/${widget.protocolId}/${field.id}',
        );
        if (result != null) {
          if (context.mounted) {
            context.read<ProtocolBloc>().add(UpdateField(field.id, result));
          }
        }
      },
      onClear: () {
        context.read<ProtocolBloc>().add(UpdateField(field.id, null));
      },
    );
  }

  Widget _buildPhotoField(FormFieldDef field) {
    return PhotoCaptureFieldWidget(
      label: field.labelKey,
      imagePath: widget.formData[field.id] as String?,
      onChanged: (v) {
        context.read<ProtocolBloc>().add(UpdateField(field.id, v));
      },
    );
  }

  Widget _buildRepeatableSection() {
    final items = widget.repeatableData[widget.section.id] ?? [{}];
    return RepeatableSectionWidget(
      section: widget.section,
      items: items,
      onFieldChanged: (index, key, value) {
        context.read<ProtocolBloc>().add(
          UpdateRepeatableField(widget.section.id, index, key, value),
        );
      },
      onAdd: () {
        context.read<ProtocolBloc>().add(
          AddRepeatableItem(widget.section.id),
        );
      },
      onRemove: (index) {
        context.read<ProtocolBloc>().add(
          RemoveRepeatableItem(widget.section.id, index),
        );
      },
    );
  }
}
