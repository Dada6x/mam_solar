import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_bloc.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadLanguage() = LoadLanguage;
  const factory SettingsEvent.setLanguage(String languageCode) = SetLanguage;
}

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default('en') String languageCode,
  }) = _SettingsState;
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<SetLanguage>(_onSetLanguage);
  }

  Future<void> _onLoadLanguage(
    LoadLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('language_code') ?? 'en';
    emit(state.copyWith(languageCode: lang));
  }

  Future<void> _onSetLanguage(
    SetLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', event.languageCode);
    emit(state.copyWith(languageCode: event.languageCode));
  }
}
