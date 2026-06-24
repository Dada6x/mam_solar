import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mam_solar/data/models/protocol_model.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';

/// State for the finished (completed) protocols list + customer search.
class CompletedState {
  final bool isLoading;
  final List<ProtocolModel> items;
  final String query;

  const CompletedState({
    this.isLoading = false,
    this.items = const [],
    this.query = '',
  });

  CompletedState copyWith({
    bool? isLoading,
    List<ProtocolModel>? items,
    String? query,
  }) {
    return CompletedState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      query: query ?? this.query,
    );
  }
}

/// Lists finished protocols, with optional case-insensitive customer search.
class CompletedCubit extends Cubit<CompletedState> {
  final ProtocolRepository _repo;

  CompletedCubit(this._repo) : super(const CompletedState());

  Future<void> load() => search(state.query);

  Future<void> search(String query) async {
    emit(state.copyWith(query: query, isLoading: true));
    final items = query.trim().isEmpty
        ? await _repo.getCompleted()
        : await _repo.searchCompletedByCustomer(query);
    emit(state.copyWith(isLoading: false, items: items));
  }
}
