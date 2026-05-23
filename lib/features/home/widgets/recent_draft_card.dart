import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/utils/date_formatter.dart';
import 'package:mam_solar/data/models/protocol_model.dart';

class RecentDraftCard extends StatelessWidget {
  final ProtocolModel protocol;
  final VoidCallback onTap;

  const RecentDraftCard({
    super.key,
    required this.protocol,
    required this.onTap,
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _iconForType(protocol.type),
                    size: 18,
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      protocol.type.replaceAll('_', ' '),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                protocol.customerName ?? '-',
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                DateFormatter.formatDateTime(
                  DateTime.fromMillisecondsSinceEpoch(protocol.updatedAt),
                ),
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.labelGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
