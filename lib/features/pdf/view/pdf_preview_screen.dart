import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/pdf/bloc/pdf_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  final int protocolId;

  const PdfPreviewScreen({super.key, required this.protocolId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PdfBloc(sl<ProtocolRepository>())..add(PreviewPdf(protocolId)),
      child: _PdfPreviewView(protocolId: protocolId),
    );
  }
}

class _PdfPreviewView extends StatelessWidget {
  final int protocolId;

  const _PdfPreviewView({required this.protocolId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PdfBloc, PdfState>(
      listener: (context, state) {
        if (state.error != null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.pdfGenerationFailed),
              content: Text(state.error!),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.pdfPreview),
            actions: [
              if (state.pdfPath != null)
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => _openFile(context, state.pdfPath!),
                  tooltip: AppLocalizations.of(context)!.openFile,
                ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.pdfPath != null && File(state.pdfPath!).existsSync()
              ? PdfPreview(
                  canChangePageFormat: false,
                  canDebug: false,
                  build: (PdfPageFormat format) async {
                    return await File(state.pdfPath!).readAsBytes();
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          context.read<PdfBloc>().add(GeneratePdf(protocolId));
                        },
                        child: Text(AppLocalizations.of(context)!.generatePdf),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _openFile(BuildContext context, String path) {
    OpenFilex.open(path);
  }
}
