import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mam_solar/data/models/protocol_model.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';
import 'package:mam_solar/features/protocols/forms/form_definition.dart';
import 'package:mam_solar/features/protocols/forms/ac_acceptance_form.dart';
import 'package:mam_solar/features/protocols/forms/work_order_form.dart';
import 'package:mam_solar/features/protocols/forms/damage_report_form.dart';
import 'package:mam_solar/features/protocols/forms/installation_report_form.dart';

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
  final SignatureRepository _signatureRepo;
  Timer? _autosaveTimer;

  ProtocolBloc(this._protocolRepo, this._signatureRepo) : super(const ProtocolState()) {
    on<LoadProtocol>(_onLoad);
    on<UpdateField>(_onUpdateField);
    on<UpdateRepeatableField>(_onUpdateRepeatableField);
    on<AddRepeatableItem>(_onAddRepeatableItem);
    on<RemoveRepeatableItem>(_onRemoveRepeatableItem);
    on<SaveDraft>(_onSaveDraft);
    on<GeneratePdf>(_onGeneratePdf);
    on<DeleteDraft>(_onDeleteDraft);
  }

  ProtocolFormDefinition _getFormDefinition(String type) {
    switch (type) {
      case 'ac_acceptance':
        return AcAcceptanceForm();
      case 'work_order':
        return WorkOrderForm();
      case 'damage_report':
        return DamageReportForm();
      case 'installation_report':
        return InstallationReportForm();
      default:
        return AcAcceptanceForm();
    }
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

      final formDef = _getFormDefinition(type);
      final sections = formDef.sections;

      if (existing == null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        final newProtocol = ProtocolModel(
          type: type,
          createdAt: now,
          updatedAt: now,
          status: 'draft',
          jsonData: '{}',
        );
        final id = await _protocolRepo.insertProtocol(newProtocol);
        emit(state.copyWith(
          isLoading: false,
          protocolType: type,
          protocolId: id,
          sections: sections,
          formData: formData,
          repeatableData: repeatableData,
        ));
      } else {
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
    final newData = Map<String, dynamic>.from(state.formData);
    newData[event.key] = event.value;
    emit(state.copyWith(formData: newData, isDirty: true, saveMessage: null));
    _scheduleAutosave();
  }

  void _onUpdateRepeatableField(UpdateRepeatableField event, Emitter<ProtocolState> emit) {
    final newRepeatable = Map<String, List<Map<String, dynamic>>>.from(state.repeatableData);
    final items = List<Map<String, dynamic>>.from(newRepeatable[event.sectionId] ?? []);
    if (event.index < items.length) {
      items[event.index] = Map<String, dynamic>.from(items[event.index])..[event.key] = event.value;
    }
    newRepeatable[event.sectionId] = items;
    emit(state.copyWith(repeatableData: newRepeatable, isDirty: true, saveMessage: null));
    _scheduleAutosave();
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

  void _scheduleAutosave() {
    _autosaveTimer?.cancel();
    _autosaveTimer = Timer(const Duration(milliseconds: 800), () {
      add(const SaveDraft());
    });
  }

  Future<void> _onSaveDraft(SaveDraft event, Emitter<ProtocolState> emit) async {
    if (state.protocolId == 0) return;
    emit(state.copyWith(isSaving: true, error: null));
    try {
      final data = Map<String, dynamic>.from(state.formData);
      if (state.repeatableData.isNotEmpty) {
        data['_repeatable'] = state.repeatableData.map(
          (k, v) => MapEntry(k, v.map((e) => Map<String, dynamic>.from(e)).toList()),
        );
      }
      await _protocolRepo.updateJsonData(state.protocolId, data);
      emit(state.copyWith(isSaving: false, isDirty: false, saveMessage: 'autosaved'));
    } catch (e) {
      emit(state.copyWith(isSaving: false, error: 'saveFailed'));
    }
  }

  Future<void> _onGeneratePdf(GeneratePdf event, Emitter<ProtocolState> emit) async {
    emit(state.copyWith(pdfGenerating: true, error: null));
    try {
      final protocol = await _protocolRepo.getProtocol(state.protocolId);
      if (protocol == null) {
        emit(state.copyWith(pdfGenerating: false, error: 'Protocol not found'));
        return;
      }
      // Generate PDF handled by PdfGenerator
      // The BLoC just triggers the navigation to PDF preview
      emit(state.copyWith(pdfGenerating: false, pdfPath: 'preview'));
    } catch (e) {
      emit(state.copyWith(pdfGenerating: false, error: e.toString()));
    }
  }

  Future<void> _onDeleteDraft(DeleteDraft event, Emitter<ProtocolState> emit) async {
    try {
      await _protocolRepo.deleteProtocol(state.protocolId);
    } catch (_) {}
  }

  bool areRequiredFieldsFilled() {
    for (final section in state.sections) {
      for (final field in section.fields) {
        if (field.required && field.type != FieldType.signature) {
          final val = state.formData[field.id];
          if (val == null || (val is String && val.trim().isEmpty)) {
            return false;
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
        if (field.required && field.type != FieldType.signature) {
          final val = state.formData[field.id];
          if (val == null || (val is String && val.trim().isEmpty)) {
            missing.add(field.labelKey);
          }
        }
      }
    }
    return missing;
  }

  @override
  Future<void> close() {
    _autosaveTimer?.cancel();
    return super.close();
  }
}
