import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';
import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: l10n.language),
            const SizedBox(height: 8),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Card(
                  elevation: 2,
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _LanguageTile(
                        label: l10n.english,
                        code: 'en',
                        selected: state.languageCode == 'en',
                        onTap: () => context.read<SettingsBloc>().add(
                          const SetLanguage('en'),
                        ),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _LanguageTile(
                        label: l10n.german,
                        code: 'de',
                        selected: state.languageCode == 'de',
                        onTap: () => context.read<SettingsBloc>().add(
                          const SetLanguage('de'),
                        ),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      _LanguageTile(
                        label: l10n.arabic,
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
            _SectionTitle(title: l10n.about),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text("MAM Solarbau v1.0.0"),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Updates'),
            const SizedBox(height: 8),
            const _UpdateStatusCard(),
            const SizedBox(height: 24),
            _SectionTitle(title: l10n.clearAllData),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _showClearDataDialog(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.errorRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.delete_forever,
                          color: AppColors.errorRed,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          l10n.clearAllData,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.errorRed,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.errorRed),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Image.asset(
                "assets/logo.png",
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
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
          content: Text(AppLocalizations.of(context)!.allDataCleared),
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
      style: const TextStyle(
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
      tileColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? AppColors.primaryGreen : null,
        ),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.primaryGreen)
          : const Icon(
              Icons.radio_button_unchecked,
              color: AppColors.labelGrey,
            ),
      onTap: onTap,
    );
  }
}

class _UpdateStatusCard extends StatefulWidget {
  const _UpdateStatusCard();

  @override
  State<_UpdateStatusCard> createState() => _UpdateStatusCardState();
}

class _UpdateStatusCardState extends State<_UpdateStatusCard> {
  final _updater = ShorebirdUpdater();
  Patch? _currentPatch;
  UpdateStatus? _status;
  bool _loading = true;
  bool _downloading = false;

  @override
  void initState() {
    super.initState();
    if (_updater.isAvailable) {
      _checkForUpdates();
    } else {
      _loading = false;
    }
  }

  Future<void> _checkForUpdates() async {
    setState(() => _loading = true);
    await Future.wait([
      _updater.readCurrentPatch().then((patch) {
        if (mounted) setState(() => _currentPatch = patch);
      }),
      _updater.checkForUpdate().then((status) {
        if (mounted) setState(() => _status = status);
      }),
    ]);
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _downloadUpdate() async {
    setState(() => _downloading = true);
    try {
      await _updater.update();
      await _checkForUpdates();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Update failed'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
    if (mounted) setState(() => _downloading = false);
  }

  @override
  Widget build(BuildContext context) {
    final canUpdate = _status == UpdateStatus.outdated && !_downloading;

    return Card(
      elevation: 2,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: canUpdate ? _downloadUpdate : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.system_update,
                    size: 20,
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Patch ${_currentPatch?.number ?? '—'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  if (_downloading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else if (_loading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else if (!_updater.isAvailable)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Unavailable',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  else if (canUpdate)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download,
                            size: 14,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Update available',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Up to date',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                ],
              ),
              if (_downloading)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Downloading update…',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.labelGrey,
                        ),
                      ),
                    ],
                  ),
                )
              else if (!_updater.isAvailable)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Code push is not available on this build.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.labelGrey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}