// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignatureModel {

 int get id; int get protocolId; String get type; String get imagePath;
/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureModelCopyWith<SignatureModel> get copyWith => _$SignatureModelCopyWithImpl<SignatureModel>(this as SignatureModel, _$identity);

  /// Serializes this SignatureModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureModel&&(identical(other.id, id) || other.id == id)&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId)&&(identical(other.type, type) || other.type == type)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,protocolId,type,imagePath);

@override
String toString() {
  return 'SignatureModel(id: $id, protocolId: $protocolId, type: $type, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $SignatureModelCopyWith<$Res>  {
  factory $SignatureModelCopyWith(SignatureModel value, $Res Function(SignatureModel) _then) = _$SignatureModelCopyWithImpl;
@useResult
$Res call({
 int id, int protocolId, String type, String imagePath
});




}
/// @nodoc
class _$SignatureModelCopyWithImpl<$Res>
    implements $SignatureModelCopyWith<$Res> {
  _$SignatureModelCopyWithImpl(this._self, this._then);

  final SignatureModel _self;
  final $Res Function(SignatureModel) _then;

/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? protocolId = null,Object? type = null,Object? imagePath = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,protocolId: null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignatureModel].
extension SignatureModelPatterns on SignatureModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureModel value)  $default,){
final _that = this;
switch (_that) {
case _SignatureModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureModel value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int protocolId,  String type,  String imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
return $default(_that.id,_that.protocolId,_that.type,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int protocolId,  String type,  String imagePath)  $default,) {final _that = this;
switch (_that) {
case _SignatureModel():
return $default(_that.id,_that.protocolId,_that.type,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int protocolId,  String type,  String imagePath)?  $default,) {final _that = this;
switch (_that) {
case _SignatureModel() when $default != null:
return $default(_that.id,_that.protocolId,_that.type,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignatureModel implements SignatureModel {
  const _SignatureModel({this.id = 0, required this.protocolId, required this.type, required this.imagePath});
  factory _SignatureModel.fromJson(Map<String, dynamic> json) => _$SignatureModelFromJson(json);

@override@JsonKey() final  int id;
@override final  int protocolId;
@override final  String type;
@override final  String imagePath;

/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureModelCopyWith<_SignatureModel> get copyWith => __$SignatureModelCopyWithImpl<_SignatureModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureModel&&(identical(other.id, id) || other.id == id)&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId)&&(identical(other.type, type) || other.type == type)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,protocolId,type,imagePath);

@override
String toString() {
  return 'SignatureModel(id: $id, protocolId: $protocolId, type: $type, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$SignatureModelCopyWith<$Res> implements $SignatureModelCopyWith<$Res> {
  factory _$SignatureModelCopyWith(_SignatureModel value, $Res Function(_SignatureModel) _then) = __$SignatureModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int protocolId, String type, String imagePath
});




}
/// @nodoc
class __$SignatureModelCopyWithImpl<$Res>
    implements _$SignatureModelCopyWith<$Res> {
  __$SignatureModelCopyWithImpl(this._self, this._then);

  final _SignatureModel _self;
  final $Res Function(_SignatureModel) _then;

/// Create a copy of SignatureModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? protocolId = null,Object? type = null,Object? imagePath = null,}) {
  return _then(_SignatureModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,protocolId: null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
