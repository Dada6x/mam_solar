// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProtocolModel _$ProtocolModelFromJson(Map<String, dynamic> json) =>
    _ProtocolModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String,
      customerName: json['customerName'] as String?,
      createdAt: (json['createdAt'] as num).toInt(),
      updatedAt: (json['updatedAt'] as num).toInt(),
      status: json['status'] as String? ?? 'draft',
      jsonData: json['jsonData'] as String? ?? '{}',
      pdfPath: json['pdfPath'] as String?,
    );

Map<String, dynamic> _$ProtocolModelToJson(_ProtocolModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'customerName': instance.customerName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'status': instance.status,
      'jsonData': instance.jsonData,
      'pdfPath': instance.pdfPath,
    };
