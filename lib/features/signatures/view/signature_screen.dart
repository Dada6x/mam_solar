import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';
import 'package:mam_solar/features/signatures/bloc/signature_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';
import 'package:sized_context/sized_context.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureScreen extends StatelessWidget {
  final int protocolId;
  final String signatureType;

  const SignatureScreen({
    super.key,
    required this.protocolId,
    required this.signatureType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SignatureBloc(sl<SignatureRepository>(), protocolId, signatureType),
      child: _SignatureView(signatureType: signatureType),
    );
  }
}

class _SignatureView extends StatefulWidget {
  final String signatureType;

  const _SignatureView({required this.signatureType});

  @override
  State<_SignatureView> createState() => _SignatureViewState();
}

class _SignatureViewState extends State<_SignatureView> {
  final _signaturePadKey = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
    final isTablet = context.widthPx >= 600;

    return BlocListener<SignatureBloc, SignatureState>(
      listener: (context, state) {
        if (state.imagePath != null) {
          context.pop(state.imagePath);
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppLocalizations.of(context)!.errorGeneric}: ${state.error}'),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.signatureType
                .replaceAll(RegExp(r'([A-Z])'), ' ${1}')
                .trim(), //TODO figure out what ive did here
          ),
          actions: [
            TextButton(
              onPressed: () => _signaturePadKey.currentState?.clear(),
              child: Text(
                AppLocalizations.of(context)!.clearSignature,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            width: isTablet ? 600 : double.infinity,
            constraints: const BoxConstraints(maxHeight: 600),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
            child: SfSignaturePad(

              key: _signaturePadKey,
              minimumStrokeWidth: 2,
              maximumStrokeWidth: 4,
              strokeColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: _onConfirm,
              icon: const Icon(Icons.check),
              label: Text(AppLocalizations.of(context)!.confirmSignature),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onConfirm() async {
    try {
      final data = await _signaturePadKey.currentState?.toImage();
      if (data == null) return;

      final byteData = await data.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final bytes = byteData.buffer.asUint8List();
      final base64Str = base64.encode(bytes);

      if (context.mounted) {
        context.read<SignatureBloc>().add(ConfirmSignature(base64Str));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.failedToSaveSignature}: $e'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }
}
