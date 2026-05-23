import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/l10n/app_localizations.dart';
import 'package:sized_context/sized_context.dart';

class ProtocolTypeScreen extends StatelessWidget {
  const ProtocolTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = context.widthPx >= 600;
    final crossAxisCount = isTablet ? 4 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.protocolType),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
          children: [
            _ProtocolTypeCard(
              icon: Icons.solar_power,
              title: AppLocalizations.of(context)!.acAcceptanceProtocol,
              subtitle: AppLocalizations.of(context)!.acAcceptanceSubtitle,
              color: AppColors.primaryGreen,
              onTap: () => context.push('/form/ac_acceptance'),
            ),
            _ProtocolTypeCard(
              icon: Icons.build,
              title: AppLocalizations.of(context)!.workOrder,
              subtitle: AppLocalizations.of(context)!.workOrderSubtitle,
              color: Colors.blue.shade700,
              onTap: () => context.push('/form/work_order'),
            ),
            _ProtocolTypeCard(
              icon: Icons.warning_amber,
              title: AppLocalizations.of(context)!.damageReport,
              subtitle: AppLocalizations.of(context)!.damageReportSubtitle,
              color: Colors.orange.shade800,
              onTap: () => context.push('/form/damage_report'),
            ),
            _ProtocolTypeCard(
              icon: Icons.checklist,
              title: AppLocalizations.of(context)!.installationReport,
              subtitle: AppLocalizations.of(context)!.installationReportSubtitle,
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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.labelGrey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
