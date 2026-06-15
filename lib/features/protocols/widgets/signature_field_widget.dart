import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/features/protocols/widgets/dashed_box.dart';
import 'package:mam_solar/features/protocols/widgets/required_label.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class SignatureFieldWidget extends StatelessWidget {
  final String? signaturePath;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onClear;
  final bool isError;
  final bool required;

  const SignatureFieldWidget({
    super.key,
    this.signaturePath,
    required this.label,
    required this.onTap,
    this.onClear,
    this.isError = false,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredFieldLabel(text: label, required: required),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: signaturePath != null && File(signaturePath!).existsSync()
              ? Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isError ? AppColors.errorRed : AppColors.borderGrey,
                      width: isError ? 1.5 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(signaturePath!),
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                      if (onClear != null)
                        Positioned(
                          top: 2,
                          right: 2,
                          child: InkWell(
                            onTap: onClear,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 14, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : DashedBox(
                  radius: 10,
                  borderColor:
                      isError ? AppColors.errorRed : AppColors.dashedBorderGrey,
                  child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.draw_outlined,
                              size: 22, color: AppColors.primaryBlue),
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.signHere,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
