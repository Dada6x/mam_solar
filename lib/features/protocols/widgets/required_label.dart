import 'package:flutter/material.dart';
import 'package:mam_solar/core/constants/app_colors.dart';

/// A field caption that renders the optional required marker as a **blue `*`**
/// (smapOne style). Use wherever a field label is shown so required fields are
/// signalled consistently across the form.
class RequiredFieldLabel extends StatelessWidget {
  final String text;
  final bool required;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;

  const RequiredFieldLabel({
    super.key,
    required this.text,
    this.required = false,
    this.fontSize = 13,
    this.color = AppColors.labelGrey,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
        children: required
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: AppColors.requiredBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}
