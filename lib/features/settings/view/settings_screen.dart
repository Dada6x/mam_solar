import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';
import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';
import 'package:mam_solar/features/settings/widgets/import_protocol_button.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<SettingsBloc>(context),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionTitle(
            title: AppLocalizations.of(context)!.language,
          ),
          const SizedBox(height: 8),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Card(
                child: Column(
                  children: [
                    _LanguageTile(
                      label: AppLocalizations.of(context)!.english,
                      code: 'en',
                      selected: state.languageCode == 'en',
                      onTap: () => context.read<SettingsBloc>().add(
                        const SetLanguage('en'),
                      ),
                    ),
                    const Divider(height: 1),
                    _LanguageTile(
                      label: AppLocalizations.of(context)!.german,
                      code: 'de',
                      selected: state.languageCode == 'de',
                      onTap: () => context.read<SettingsBloc>().add(
                        const SetLanguage('de'),
                      ),
                    ),
                    const Divider(height: 1),
                    _LanguageTile(
                      label: AppLocalizations.of(context)!.arabic,
                      code: 'ar',
                      selected: state.languageCode == 'ar',
                      onTap: () => context.read<SettingsBloc>().add(
                        const SetLanguage('ar'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            title: AppLocalizations.of(context)!.about,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    label: AppLocalizations.of(context)!.appTitle,
                    value: 'mam-solarbau',
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    label: AppLocalizations.of(context)!.version,
                    value: AppLocalizations.of(context)!.appVersion,
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    label: AppLocalizations.of(context)!.companyName,
                    value: AppLocalizations.of(context)!.companyName,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            title: AppLocalizations.of(context)!.clearAllData,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showClearDataDialog(context),
              icon: const Icon(Icons.delete_forever),
              label: Text(AppLocalizations.of(context)!.clearAllData),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorRed,
                foregroundColor: AppColors.white,
              ),
            ),
          ),
          const ImportProtocolButton(),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(ctx)!.clearDataConfirm),
        content: Text(AppLocalizations.of(ctx)!.clearDataMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppLocalizations.of(ctx)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _clearAllData(context);
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

  void _clearAllData(BuildContext context) async {
    final protocolRepo = sl<ProtocolRepository>();
    final sigRepo = sl<SignatureRepository>();
    await protocolRepo.clearAll();
    await sigRepo.clearAll();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('All data cleared'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryGreen,
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String label;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.label,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.primaryGreen)
          : null,
      onTap: onTap,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.labelGrey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
