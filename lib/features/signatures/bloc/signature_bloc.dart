import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';

part 'signature_bloc.freezed.dart';

@freezed
class SignatureEvent with _$SignatureEvent {
  const factory SignatureEvent.confirm(String bytesBase64) = ConfirmSignature;
  const factory SignatureEvent.clear() = ClearSignature;
}

@freezed
sealed class SignatureState with _$SignatureState {
  const factory SignatureState({
    @Default(false) bool isSaving,
    String? imagePath,
    String? error,
  }) = _SignatureState;
}

class SignatureBloc extends Bloc<SignatureEvent, SignatureState> {
  final SignatureRepository _repo;
  final int protocolId;
  final String signatureType;

  SignatureBloc(this._repo, this.protocolId, this.signatureType)
      : super(const SignatureState()) {
    on<ConfirmSignature>(_onConfirm);
    on<ClearSignature>(_onClear);
  }

  Future<void> _onConfirm(ConfirmSignature event, Emitter<SignatureState> emit) async {
    emit(state.copyWith(isSaving: true, error: null));
    try {
      final dir = await getApplicationDocumentsDirectory();
      final sigDir = Directory('${dir.path}/signatures');
      if (!sigDir.existsSync()) {
        sigDir.createSync(recursive: true);
      }

      final fileName = '${protocolId}_${signatureType}_${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${sigDir.path}/$fileName';
      final file = File(filePath);

      final bytes = base64Decode(event.bytesBase64);
      await file.writeAsBytes(bytes);

      await _repo.saveSignatureImage(protocolId, signatureType, filePath);
      emit(state.copyWith(isSaving: false, imagePath: filePath));
    } catch (e) {
      emit(state.copyWith(isSaving: false, error: e.toString()));
    }
  }

  void _onClear(ClearSignature event, Emitter<SignatureState> emit) {
    emit(state.copyWith(imagePath: null));
  }
}
