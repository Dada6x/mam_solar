import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'protocol_model.freezed.dart';
part 'protocol_model.g.dart';

@freezed
abstract class ProtocolModel with _$ProtocolModel {
  const factory ProtocolModel({
    @Default(0) int id,
    required String type,
    String? customerName,
    required int createdAt,
    required int updatedAt,
    @Default('draft') String status,
    @Default('{}') String jsonData,
    String? pdfPath,
  }) = _ProtocolModel;

  factory ProtocolModel.fromJson(Map<String, dynamic> json) =>
      _$ProtocolModelFromJson(json);
}
