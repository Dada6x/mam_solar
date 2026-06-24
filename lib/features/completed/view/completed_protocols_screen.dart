import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/data/models/protocol_model.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/completed/bloc/completed_cubit.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

/// List of finished (locked) protocols with a search-by-customer field.
class CompletedProtocolsScreen extends StatelessWidget {
  const CompletedProtocolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompletedCubit(sl<ProtocolRepository>())..load(),
      child: const _CompletedView(),
    );
  }
}

class _CompletedView extends StatelessWidget {
  const _CompletedView();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.completedProtocols)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              onChanged: (v) => context.read<CompletedCubit>().search(v),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: l.searchByCustomer,
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CompletedCubit, CompletedState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.task_alt,
                            size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        Text(
                          state.query.isEmpty
                              ? l.noCompletedYet
                              : l.noSearchResults,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => context.read<CompletedCubit>().load(),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final p = state.items[index];
                      return _CompletedListItem(
                        protocol: p,
                        // Opens the form read-only (status == completed).
                        onTap: () => context.push('/form/${p.type}/${p.id}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedListItem extends StatelessWidget {
  final ProtocolModel protocol;
  final VoidCallback onTap;

  const _CompletedListItem({required this.protocol, required this.onTap});

  IconData _iconForType(String type) {
    switch (type) {
      case 'ac_acceptance':
        return Icons.solar_power;
      case 'dc_acceptance':
        return Icons.bolt;
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
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
          child: Icon(_iconForType(protocol.type),
              color: AppColors.primaryBlue, size: 20),
        ),
        title: Text(
          protocol.customerName ?? '-',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${protocol.type.replaceAll('_', ' ')} - ${DateFormatter.formatDateTime(DateTime.fromMillisecondsSinceEpoch(protocol.updatedAt))}',
          style: const TextStyle(fontSize: 11),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'FERTIG',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
