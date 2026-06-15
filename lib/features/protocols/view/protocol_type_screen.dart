import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class ProtocolTypeScreen extends StatelessWidget {
  const ProtocolTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.protocolType)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _ProtocolTypeCard(
              icon: Icons.solar_power,
              title: AppLocalizations.of(context)!.acAcceptanceProtocol,
              subtitle: AppLocalizations.of(context)!.acAcceptanceSubtitle,
              color: AppColors.primaryBlue,
              onTap: () => context.push('/form/ac_acceptance'),
            ),
            const SizedBox(height: 12),
            _ProtocolTypeCard(
              icon: Icons.bolt,
              title: AppLocalizations.of(context)!.dcAcceptanceProtocol,
              subtitle: AppLocalizations.of(context)!.dcAcceptanceSubtitle,
              color: AppColors.primaryBlueDark,
              onTap: () => context.push('/form/dc_acceptance'),
            ),
            const SizedBox(height: 12),
            _ProtocolTypeCard(
              icon: Icons.build,
              title: AppLocalizations.of(context)!.workOrder,
              subtitle: AppLocalizations.of(context)!.workOrderSubtitle,
              color: Colors.blue.shade700,
              onTap: () => context.push('/form/work_order'),
            ),
            const SizedBox(height: 12),
            _ProtocolTypeCard(
              icon: Icons.warning_amber,
              title: AppLocalizations.of(context)!.damageReport,
              subtitle: AppLocalizations.of(context)!.damageReportSubtitle,
              color: Colors.orange.shade800,
              onTap: () => context.push('/form/damage_report'),
            ),
            const SizedBox(height: 12),
            _ProtocolTypeCard(
              icon: Icons.checklist,
              title: AppLocalizations.of(context)!.installationReport,
              subtitle: AppLocalizations.of(
                context,
              )!.installationReportSubtitle,
              color: Colors.teal.shade700,
              onTap: () => context.push('/form/installation_report'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProtocolTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ProtocolTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.labelGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
