import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:mam_solar/core/parsers/protocol_md_parser.dart';
import 'package:mam_solar/data/models/protocol_model.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';

part 'protocol_bloc.freezed.dart';

@freezed
class ProtocolEvent with _$ProtocolEvent {
  const factory ProtocolEvent.load({int? protocolId, String? protocolType}) = LoadProtocol;
  const factory ProtocolEvent.updateField(String key, dynamic value) = UpdateField;
  const factory ProtocolEvent.updateRepeatableField(String sectionId, int index, String key, dynamic value) = UpdateRepeatableField;
  const factory ProtocolEvent.addRepeatableItem(String sectionId) = AddRepeatableItem;
  const factory ProtocolEvent.removeRepeatableItem(String sectionId, int index) = RemoveRepeatableItem;
  const factory ProtocolEvent.saveDraft() = SaveDraft;
  const factory ProtocolEvent.generatePdf() = GeneratePdf;
  const factory ProtocolEvent.deleteDraft() = DeleteDraft;
}

@freezed
sealed class ProtocolState with _$ProtocolState {
  const factory ProtocolState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isDirty,
    @Default(false) bool pdfGenerating,
    String? protocolType,
    @Default(0) int protocolId,
    @Default({}) Map<String, dynamic> formData,
    @Default({}) Map<String, List<Map<String, dynamic>>> repeatableData,
    @Default([]) List<FormSection> sections,
    String? error,
    String? pdfPath,
    String? saveMessage,
  }) = _ProtocolState;
}

class ProtocolBloc extends Bloc<ProtocolEvent, ProtocolState> {
  final ProtocolRepository _protocolRepo;
  final Logger _log = Logger();

  ProtocolBloc(this._protocolRepo) : super(const ProtocolState()) {
    on<LoadProtocol>(_onLoad);
    on<UpdateField>(_onUpdateField);
    on<UpdateRepeatableField>(_onUpdateRepeatableField);
    on<AddRepeatableItem>(_onAddRepeatableItem);
    on<RemoveRepeatableItem>(_onRemoveRepeatableItem);
    on<SaveDraft>(_onSaveDraft);
    on<GeneratePdf>(_onGeneratePdf);
    on<DeleteDraft>(_onDeleteDraft);
  }

  Future<void> _onLoad(LoadProtocol event, Emitter<ProtocolState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      ProtocolModel? existing;
      String? type = event.protocolType;
      Map<String, dynamic> formData = {};
      Map<String, List<Map<String, dynamic>>> repeatableData = {};

      if (event.protocolId != null && event.protocolId! > 0) {
        existing = await _protocolRepo.getProtocol(event.protocolId!);
        if (existing != null) {
          type = existing.type;
          final rawData = existing.jsonData;
          if (rawData.isNotEmpty) {
            try {
              final decoded = json.decode(rawData) as Map<String, dynamic>;
              if (decoded.containsKey('_repeatable')) {
                repeatableData = Map<String, List<Map<String, dynamic>>>.from(
                  (decoded['_repeatable'] as Map).map(
                    (k, v) => MapEntry(k as String, (v as List).map((e) => Map<String, dynamic>.from(e)).toList()),
                  ),
                );
              }
              formData = Map<String, dynamic>.from(
                decoded..remove('_repeatable'),
              );
            } catch (_) {}
          }
        }
      }

      if (type == null) {
        emit(state.copyWith(isLoading: false, error: 'Protocol type required'));
        return;
      }

      final parsed = await ProtocolMdParser.parse(type);
      final sections = parsed.sections;

      if (existing == null) {
        _log.i('New protocol (type: $type) — no DB insert until first save');
        emit(state.copyWith(
          isLoading: false,
          protocolType: type,
          protocolId: 0,
          sections: sections,
          formData: formData,
          repeatableData: repeatableData,
        ));
      } else {
        _log.i('Loaded existing protocol #${existing.id} (type: $type): ${formData.length} fields loaded');
        emit(state.copyWith(
          isLoading: false,
          protocolType: type,
          protocolId: existing.id,
          sections: sections,
          formData: formData,
          repeatableData: repeatableData,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void _onUpdateField(UpdateField event, Emitter<ProtocolState> emit) {
    _log.i('Field updated: ${event.key} = ${event.value}');
    final newData = Map<String, dynamic>.from(state.formData);
    newData[event.key] = event.value;
    emit(state.copyWith(formData: newData, isDirty: true, saveMessage: null));
  }

  void _onUpdateRepeatableField(UpdateRepeatableField event, Emitter<ProtocolState> emit) {
    _log.i('Repeatable field updated: ${event.sectionId}[${event.index}].${event.key} = ${event.value}');
    final newRepeatable = Map<String, List<Map<String, dynamic>>>.from(state.repeatableData);
    var items = List<Map<String, dynamic>>.from(newRepeatable[event.sectionId] ?? []);
    while (items.length <= event.index) {
      items.add({});
    }
    items[event.index] = Map<String, dynamic>.from(items[event.index])..[event.key] = event.value;
    newRepeatable[event.sectionId] = items;
    emit(state.copyWith(repeatableData: newRepeatable, isDirty: true, saveMessage: null));
  }

  void _onAddRepeatableItem(AddRepeatableItem event, Emitter<ProtocolState> emit) {
    final newRepeatable = Map<String, List<Map<String, dynamic>>>.from(state.repeatableData);
    final items = List<Map<String, dynamic>>.from(newRepeatable[event.sectionId] ?? []);
    items.add({});
    newRepeatable[event.sectionId] = items;
    emit(state.copyWith(repeatableData: newRepeatable, isDirty: true));
  }

  void _onRemoveRepeatableItem(RemoveRepeatableItem event, Emitter<ProtocolState> emit) {
    final newRepeatable = Map<String, List<Map<String, dynamic>>>.from(state.repeatableData);
    final items = List<Map<String, dynamic>>.from(newRepeatable[event.sectionId] ?? []);
    if (items.length > 1) {
      items.removeAt(event.index);
    }
    newRepeatable[event.sectionId] = items;
    emit(state.copyWith(repeatableData: newRepeatable, isDirty: true));
  }

  Future<void> _onSaveDraft(SaveDraft event, Emitter<ProtocolState> emit) async {
    emit(state.copyWith(isSaving: true, error: null));
    try {
      int protocolId = state.protocolId;

      // First save — insert a new row
      if (protocolId == 0) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final newProtocol = ProtocolModel(
          type: state.protocolType ?? '',
          createdAt: now,
          updatedAt: now,
          status: 'draft',
          jsonData: '{}',
        );
        protocolId = await _protocolRepo.insertProtocol(newProtocol);
        _log.i('Inserted new protocol #$protocolId');
      }

      _log.i('Saving draft protocol #$protocolId: ${state.formData.length} fields');
      final data = Map<String, dynamic>.from(state.formData);
      if (state.repeatableData.isNotEmpty) {
        data['_repeatable'] = state.repeatableData.map(
          (k, v) => MapEntry(k, v.map((e) => Map<String, dynamic>.from(e)).toList()),
        );
      }
      await _protocolRepo.updateJsonData(protocolId, data);
      emit(state.copyWith(
        isSaving: false,
        isDirty: false,
        protocolId: protocolId,
        saveMessage: 'autosaved',
      ));
    } catch (e) {
      _log.e('Save draft failed', error: e);
      emit(state.copyWith(isSaving: false, error: 'saveFailed'));
    }
  }

  Future<void> _onGeneratePdf(GeneratePdf event, Emitter<ProtocolState> emit) async {
    emit(state.copyWith(pdfGenerating: true, error: null));
    try {
      int protocolId = state.protocolId;

      // First save — insert a new row if never saved
      if (protocolId == 0) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final newProtocol = ProtocolModel(
          type: state.protocolType ?? '',
          createdAt: now,
          updatedAt: now,
          status: 'draft',
          jsonData: '{}',
        );
        protocolId = await _protocolRepo.insertProtocol(newProtocol);
        _log.i('Inserted new protocol #$protocolId before PDF generation');
      }

      _log.i('=== PDF Generation Start for protocol #$protocolId ===');
      _log.i('Form fields present: ${state.formData.length}');
      for (final entry in state.formData.entries) {
        _log.i('  $entry.key = ${entry.value}');
      }
      _log.i('Repeatable sections present: ${state.repeatableData.length}');
      for (final entry in state.repeatableData.entries) {
        _log.i('  ${entry.key}: ${entry.value.length} items');
      }

      // save current form data to DB first so PdfBloc reads fresh data
      final data = Map<String, dynamic>.from(state.formData);
      if (state.repeatableData.isNotEmpty) {
        data['_repeatable'] = state.repeatableData.map(
          (k, v) => MapEntry(k, v.map((e) => Map<String, dynamic>.from(e)).toList()),
        );
      }
      await _protocolRepo.updateJsonData(protocolId, data);

      // Invalidate cached pdfPath so PdfBloc regenerates instead of showing stale PDF
      final existing = await _protocolRepo.getProtocol(protocolId);
      if (existing != null && existing.pdfPath != null) {
        await _protocolRepo.updateProtocol(existing.copyWith(pdfPath: null));
      }

      emit(state.copyWith(
        pdfGenerating: false,
        isDirty: false,
        protocolId: protocolId,
        pdfPath: 'preview',
      ));
    } catch (e) {
      _log.e('PDF generation failed', error: e);
      emit(state.copyWith(pdfGenerating: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteDraft(DeleteDraft event, Emitter<ProtocolState> emit) async {
    try {
      await _protocolRepo.deleteProtocol(state.protocolId);
    } catch (_) {}
  }

  bool _isValueFilled(dynamic val) {
    if (val == null) return false;
    if (val is String && val.trim().isEmpty) return false;
    if (val is List && val.isEmpty) return false;
    return true;
  }

  bool areRequiredFieldsFilled() {
    for (final section in state.sections) {
      for (final field in section.fields) {
        if (field.required && field.type != FieldType.signature && field.type != FieldType.displayText) {
          if (section.isRepeatable) {
            final items = state.repeatableData[section.id] ?? [];
            final allFilled = items.isNotEmpty && items.every((item) {
              return _isValueFilled(item[field.id]);
            });
            if (!allFilled) return false;
          } else {
            if (!_isValueFilled(state.formData[field.id])) {
              return false;
            }
          }
        }
      }
    }
    return true;
  }

  List<String> getMissingRequiredFields() {
    final missing = <String>[];
    for (final section in state.sections) {
      for (final field in section.fields) {
        if (field.required && field.type != FieldType.signature && field.type != FieldType.displayText) {
          if (section.isRepeatable) {
            final items = state.repeatableData[section.id] ?? [];
            final allFilled = items.isNotEmpty && items.every((item) {
              return _isValueFilled(item[field.id]);
            });
            if (!allFilled) missing.add(field.labelKey);
          } else {
            if (!_isValueFilled(state.formData[field.id])) {
              missing.add(field.labelKey);
            }
          }
        }
      }
    }
    return missing;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
