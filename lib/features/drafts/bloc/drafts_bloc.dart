import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mam_solar/data/models/protocol_model.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';

part 'drafts_bloc.freezed.dart';

@freezed
class DraftsEvent with _$DraftsEvent {
  const factory DraftsEvent.load() = LoadDrafts;
  const factory DraftsEvent.delete(int id) = DeleteDraft;
}

@freezed
abstract class DraftsState with _$DraftsState {
  const factory DraftsState({
    @Default(false) bool isLoading,
    @Default([]) List<ProtocolModel> drafts,
    String? error,
  }) = _DraftsState;
}

class DraftsBloc extends Bloc<DraftsEvent, DraftsState> {
  final ProtocolRepository _protocolRepo;

  DraftsBloc(this._protocolRepo) : super(const DraftsState()) {
    on<LoadDrafts>(_onLoad);
    on<DeleteDraft>(_onDelete);
  }

  Future<void> _onLoad(LoadDrafts event, Emitter<DraftsState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final drafts = await _protocolRepo.getDrafts();
      emit(state.copyWith(isLoading: false, drafts: drafts));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onDelete(DeleteDraft event, Emitter<DraftsState> emit) async {
    try {
      await _protocolRepo.deleteProtocol(event.id);
      final drafts = await _protocolRepo.getDrafts();
      emit(state.copyWith(drafts: drafts));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
