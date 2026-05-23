import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/drafts/bloc/drafts_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class SavedDraftsScreen extends StatelessWidget {
  const SavedDraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DraftsBloc(sl<ProtocolRepository>())..add(const LoadDrafts()),
      child: const _SavedDraftsView(),
    );
  }
}

class _SavedDraftsView extends StatelessWidget {
  const _SavedDraftsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.savedDrafts),
        actions: [
          if (context.watch<DraftsBloc>().state.drafts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Delete all',
              onPressed: () {
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
                        onPressed: () async {
                          await sl<ProtocolRepository>().clearAll();
                          if (ctx.mounted) Navigator.of(ctx).pop();
                          if (context.mounted) {
                            context.read<DraftsBloc>().add(const LoadDrafts());
                          }
                        },
                        child: Text(
                          AppLocalizations.of(ctx)!.delete,
                          style: const TextStyle(color: AppColors.errorRed),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: BlocBuilder<DraftsBloc, DraftsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.drafts.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.description_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.noDraftsYet,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.noDraftsYetDesc,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<DraftsBloc>().add(const LoadDrafts());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.drafts.length,
              itemBuilder: (context, index) {
                final draft = state.drafts[index];
                return _DraftListItem(
                  draft: draft,
                  onTap: () {
                    context.push('/form/${draft.type}/${draft.id}');
                  },
                  onDelete: () {
                    _confirmDelete(context, draft.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, int id) {
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
              context.read<DraftsBloc>().add(DeleteDraft(id));
              Navigator.of(ctx).pop();
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

class _DraftListItem extends StatelessWidget {
  final dynamic draft;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _DraftListItem({
    required this.draft,
    required this.onTap,
    required this.onDelete,
  });

  IconData _iconForType(String type) {
    switch (type) {
      case 'ac_acceptance':
        return Icons.solar_power;
      case 'work_order':
        return Icons.build;
      case 'damage_report':
        return Icons.warning_amber;
      case 'installation_report':
        return Icons.checklist;
      default:
        return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(draft.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return true;
      },
      onDismissed: (direction) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: AppColors.errorRed,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.1),
            child: Icon(
              _iconForType(draft.type),
              color: AppColors.primaryGreen,
              size: 20,
            ),
          ),
          title: Text(
            draft.customerName ?? '-',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${draft.type.replaceAll('_', ' ')} - ${DateFormatter.formatDateTime(DateTime.fromMillisecondsSinceEpoch(draft.updatedAt))}',
            style: const TextStyle(fontSize: 11),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.amber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'DRAFT',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
