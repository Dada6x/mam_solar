import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mam_solar/core/parsers/protocol_md_parser.dart';
import 'package:mam_solar/core/utils/pdf_naming_util.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/pdf/generators/pdf_generator_base.dart';
import 'package:mam_solar/features/pdf/generators/generic_protocol_pdf_generator.dart';

part 'pdf_bloc.freezed.dart';

@freezed
sealed class PdfEvent with _$PdfEvent {
  const factory PdfEvent.generate(int protocolId) = GeneratePdf;
  const factory PdfEvent.preview(int protocolId) = PreviewPdf;
}

@freezed
sealed class PdfState with _$PdfState {
  const factory PdfState({
    @Default(false) bool isLoading,
    String? pdfPath,
    String? error,
    @Default(false) bool ready,
  }) = _PdfState;
}

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final ProtocolRepository _protocolRepo;

  PdfBloc(this._protocolRepo) : super(const PdfState()) {
    on<GeneratePdf>(_onGenerate);
    on<PreviewPdf>(_onPreview);
  }

  Future<void> _onGenerate(GeneratePdf event, Emitter<PdfState> emit) async {
    emit(state.copyWith(isLoading: true, error: null, ready: false));
    try {
      final protocol = await _protocolRepo.getProtocol(event.protocolId);
      if (protocol == null) {
        emit(state.copyWith(isLoading: false, error: 'Protocol not found'));
        return;
      }

      final rawData = protocol.jsonData;
      Map<String, dynamic> data = {};
      Map<String, List<Map<String, dynamic>>> repeatableData = {};

      if (rawData.isNotEmpty) {
        try {
          final decoded = json.decode(rawData) as Map<String, dynamic>;
          if (decoded.containsKey('_repeatable')) {
            repeatableData = Map<String, List<Map<String, dynamic>>>.from(
              (decoded['_repeatable'] as Map).map(
                (k, v) => MapEntry(
                  k as String,
                  (v as List).map((e) => Map<String, dynamic>.from(e)).toList(),
                ),
              ),
            );
          }
          data = Map<String, dynamic>.from(decoded..remove('_repeatable'));
        } catch (_) {}
      }

      await PdfGeneratorBase.loadLogo();
      final parsed = await ProtocolMdParser.parse(protocol.type);
      final doc = GenericProtocolPdfGenerator.generate(
        protocolId: protocol.id,
        title: parsed.titleDe ?? parsed.title,
        typeCode: _typeCode(protocol.type),
        customerName: data['customerName'] as String? ??
            data['fullName'] as String? ??
            'Unknown',
        sections: parsed.sections,
        data: data,
        repeatableData: repeatableData,
      );

      final dir = await getApplicationDocumentsDirectory();
      final pdfDir = Directory('${dir.path}/pdfs');
      if (!pdfDir.existsSync()) {
        pdfDir.createSync(recursive: true);
      }

      final customerName =
          data['customerName'] as String? ??
          data['fullName'] as String? ??
          'Unknown';
      final fileName = PdfNamingUtil.generateFileName(
        protocol.type,
        customerName,
        DateTime.now(),
      );
      final filePath = '${pdfDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(await doc.save());

      await _protocolRepo.updateProtocol(
        protocol.copyWith(
          pdfPath: filePath,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      emit(state.copyWith(isLoading: false, pdfPath: filePath, ready: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onPreview(PreviewPdf event, Emitter<PdfState> emit) async {
    final protocol = await _protocolRepo.getProtocol(event.protocolId);
    if (protocol != null &&
        protocol.pdfPath != null &&
        File(protocol.pdfPath!).existsSync()) {
      emit(state.copyWith(pdfPath: protocol.pdfPath, ready: true));
    } else {
      add(GeneratePdf(event.protocolId));
    }
  }

  /// Short prefix for the protocol number per type (e.g. "AC 20260624-0001").
  String _typeCode(String type) {
    switch (type) {
      case 'ac_acceptance':
        return 'AC';
      case 'dc_acceptance':
        return 'DC';
      case 'work_order':
        return 'AB';
      case 'damage_report':
        return 'SCH';
      case 'installation_report':
        return 'AUF';
      default:
        return 'PR';
    }
  }
}
