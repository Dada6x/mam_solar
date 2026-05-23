import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/protocols/bloc/protocol_bloc.dart';
import 'package:mam_solar/features/protocols/widgets/question_wizard_widget.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

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

        if (state.protocolId == 0) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Protocol not initialized')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              protocolType.replaceAll('_', ' ').toUpperCase(),
              style: const TextStyle(fontSize: 14),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (state.isDirty) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(ctx)!.unsavedChanges),
                      content: Text(AppLocalizations.of(ctx)!.leaveWithoutSaving),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.read<ProtocolBloc>().add(const SaveDraft());
                            Navigator.of(ctx).pop();
                            context.pop();
                          },
                          child: Text(AppLocalizations.of(ctx)!.saveAndLeave),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            context.pop();
                          },
                          child: Text(
                            AppLocalizations.of(ctx)!.exit,
                            style: const TextStyle(color: AppColors.errorRed),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  context.pop();
                }
              },
            ),
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
          body: QuestionWizardWidget(
            protocolType: protocolType,
            protocolId: state.protocolId,
          ),
        );
      },
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
