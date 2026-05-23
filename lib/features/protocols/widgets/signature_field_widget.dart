import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';

class SignatureFieldWidget extends StatelessWidget {
  final String? signaturePath;
  final String label;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const SignatureFieldWidget({
    super.key,
    this.signaturePath,
    required this.label,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.labelGrey),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade50,
            ),
            child: signaturePath != null && File(signaturePath!).existsSync()
                ? Stack(
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
                  )
                : Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.draw, size: 20, color: AppColors.labelGrey),
                        const SizedBox(width: 8),
                        Text(
                          'Tap to sign',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.labelGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
