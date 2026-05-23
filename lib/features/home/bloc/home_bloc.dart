import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mam_solar/data/models/protocol_model.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';

part 'home_bloc.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.load() = LoadHome;
}

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(0) int draftCount,
    @Default([]) List<ProtocolModel> recentDrafts,
    String? error,
  }) = _HomeState;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProtocolRepository _protocolRepo;

  HomeBloc(this._protocolRepo) : super(const HomeState()) {
    on<LoadHome>(_onLoad);
  }

  Future<void> _onLoad(LoadHome event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final count = await _protocolRepo.getDraftCount();
      final drafts = await _protocolRepo.getDrafts();
      emit(state.copyWith(
        isLoading: false,
        draftCount: count,
        recentDrafts: drafts.take(3).toList(),
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
