// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'protocol_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProtocolModel {

 int get id; String get type; String? get customerName; int get createdAt; int get updatedAt; String get status; String get jsonData; String? get pdfPath;
/// Create a copy of ProtocolModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProtocolModelCopyWith<ProtocolModel> get copyWith => _$ProtocolModelCopyWithImpl<ProtocolModel>(this as ProtocolModel, _$identity);

  /// Serializes this ProtocolModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProtocolModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.jsonData, jsonData) || other.jsonData == jsonData)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,customerName,createdAt,updatedAt,status,jsonData,pdfPath);

@override
String toString() {
  return 'ProtocolModel(id: $id, type: $type, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, jsonData: $jsonData, pdfPath: $pdfPath)';
}


}

/// @nodoc
abstract mixin class $ProtocolModelCopyWith<$Res>  {
  factory $ProtocolModelCopyWith(ProtocolModel value, $Res Function(ProtocolModel) _then) = _$ProtocolModelCopyWithImpl;
@useResult
$Res call({
 int id, String type, String? customerName, int createdAt, int updatedAt, String status, String jsonData, String? pdfPath
});




}
/// @nodoc
class _$ProtocolModelCopyWithImpl<$Res>
    implements $ProtocolModelCopyWith<$Res> {
  _$ProtocolModelCopyWithImpl(this._self, this._then);

  final ProtocolModel _self;
  final $Res Function(ProtocolModel) _then;

/// Create a copy of ProtocolModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? customerName = freezed,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? jsonData = null,Object? pdfPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,jsonData: null == jsonData ? _self.jsonData : jsonData // ignore: cast_nullable_to_non_nullable
as String,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProtocolModel].
extension ProtocolModelPatterns on ProtocolModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProtocolModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProtocolModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProtocolModel value)  $default,){
final _that = this;
switch (_that) {
case _ProtocolModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProtocolModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProtocolModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String? customerName,  int createdAt,  int updatedAt,  String status,  String jsonData,  String? pdfPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProtocolModel() when $default != null:
return $default(_that.id,_that.type,_that.customerName,_that.createdAt,_that.updatedAt,_that.status,_that.jsonData,_that.pdfPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String? customerName,  int createdAt,  int updatedAt,  String status,  String jsonData,  String? pdfPath)  $default,) {final _that = this;
switch (_that) {
case _ProtocolModel():
return $default(_that.id,_that.type,_that.customerName,_that.createdAt,_that.updatedAt,_that.status,_that.jsonData,_that.pdfPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String? customerName,  int createdAt,  int updatedAt,  String status,  String jsonData,  String? pdfPath)?  $default,) {final _that = this;
switch (_that) {
case _ProtocolModel() when $default != null:
return $default(_that.id,_that.type,_that.customerName,_that.createdAt,_that.updatedAt,_that.status,_that.jsonData,_that.pdfPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProtocolModel implements ProtocolModel {
  const _ProtocolModel({this.id = 0, required this.type, this.customerName, required this.createdAt, required this.updatedAt, this.status = 'draft', this.jsonData = '{}', this.pdfPath});
  factory _ProtocolModel.fromJson(Map<String, dynamic> json) => _$ProtocolModelFromJson(json);

@override@JsonKey() final  int id;
@override final  String type;
@override final  String? customerName;
@override final  int createdAt;
@override final  int updatedAt;
@override@JsonKey() final  String status;
@override@JsonKey() final  String jsonData;
@override final  String? pdfPath;

/// Create a copy of ProtocolModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProtocolModelCopyWith<_ProtocolModel> get copyWith => __$ProtocolModelCopyWithImpl<_ProtocolModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProtocolModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProtocolModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.jsonData, jsonData) || other.jsonData == jsonData)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,customerName,createdAt,updatedAt,status,jsonData,pdfPath);

@override
String toString() {
  return 'ProtocolModel(id: $id, type: $type, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, jsonData: $jsonData, pdfPath: $pdfPath)';
}


}

/// @nodoc
abstract mixin class _$ProtocolModelCopyWith<$Res> implements $ProtocolModelCopyWith<$Res> {
  factory _$ProtocolModelCopyWith(_ProtocolModel value, $Res Function(_ProtocolModel) _then) = __$ProtocolModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String? customerName, int createdAt, int updatedAt, String status, String jsonData, String? pdfPath
});




}
/// @nodoc
class __$ProtocolModelCopyWithImpl<$Res>
    implements _$ProtocolModelCopyWith<$Res> {
  __$ProtocolModelCopyWithImpl(this._self, this._then);

  final _ProtocolModel _self;
  final $Res Function(_ProtocolModel) _then;

/// Create a copy of ProtocolModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? customerName = freezed,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? jsonData = null,Object? pdfPath = freezed,}) {
  return _then(_ProtocolModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,jsonData: null == jsonData ? _self.jsonData : jsonData // ignore: cast_nullable_to_non_nullable
as String,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
