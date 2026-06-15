import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';

/// A smapOne-style section container: a white rounded card with a centered,
/// bold title and a chevron that collapses/expands the section content.
///
/// Used to wrap every protocol section so a long form reads as a stack of
/// tidy, foldable cards (familiar to users coming from smapOne).
class SectionCard extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const SectionCard({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = true,
  });

  @override
  State<SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<SectionCard> {
  late bool _expanded = widget.initiallyExpanded;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header: centered title + chevron ──
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // left spacer balances the chevron so the title stays centered
                  const SizedBox(width: 24),
                  Expanded(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ── Collapsible content ──
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.children,
              ),
            ),
        ],
      ),
    );
  }
}
