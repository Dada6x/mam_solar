// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignatureModel _$SignatureModelFromJson(Map<String, dynamic> json) =>
    _SignatureModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      protocolId: (json['protocolId'] as num).toInt(),
      type: json['type'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$SignatureModelToJson(_SignatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'protocolId': instance.protocolId,
      'type': instance.type,
      'imagePath': instance.imagePath,
    };
