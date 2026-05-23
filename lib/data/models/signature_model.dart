import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signature_model.freezed.dart';
part 'signature_model.g.dart';

@freezed
abstract class SignatureModel with _$SignatureModel {
  const factory SignatureModel({
    @Default(0) int id,
    required int protocolId,
    required String type,
    required String imagePath,
  }) = _SignatureModel;

  factory SignatureModel.fromJson(Map<String, dynamic> json) =>
      _$SignatureModelFromJson(json);
}
