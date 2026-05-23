// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:mam_solar/core/constants/app_colors.dart';
// import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';
// import 'package:mam_solar/l10n/app_localizations.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: BlocProvider.of<SettingsBloc>(context),
//       child: const _OnboardingView(),
//     );
//   }
// }

// class _OnboardingView extends StatelessWidget {
//   const _OnboardingView();

//   void _onDone(BuildContext context) {
//     context.read<SettingsBloc>().add(const SetOnboardingComplete());
//     context.go('/');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//   }
// }

// class _LanguageButton extends StatelessWidget {
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;

//   const _LanguageButton({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton(
//         onPressed: onTap,
//         style: OutlinedButton.styleFrom(
//           backgroundColor: selected ? AppColors.primaryGreen : null,
//           foregroundColor: selected ? Colors.white : AppColors.primaryGreen,
//           side: BorderSide(
//             color: selected ? AppColors.primaryGreen : AppColors.primaryGreen,
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 16),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: selected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }
// }
