// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignatureEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignatureEvent()';
}


}

/// @nodoc
class $SignatureEventCopyWith<$Res>  {
$SignatureEventCopyWith(SignatureEvent _, $Res Function(SignatureEvent) __);
}


/// Adds pattern-matching-related methods to [SignatureEvent].
extension SignatureEventPatterns on SignatureEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ConfirmSignature value)?  confirm,TResult Function( ClearSignature value)?  clear,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ConfirmSignature() when confirm != null:
return confirm(_that);case ClearSignature() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ConfirmSignature value)  confirm,required TResult Function( ClearSignature value)  clear,}){
final _that = this;
switch (_that) {
case ConfirmSignature():
return confirm(_that);case ClearSignature():
return clear(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ConfirmSignature value)?  confirm,TResult? Function( ClearSignature value)?  clear,}){
final _that = this;
switch (_that) {
case ConfirmSignature() when confirm != null:
return confirm(_that);case ClearSignature() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String bytesBase64)?  confirm,TResult Function()?  clear,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ConfirmSignature() when confirm != null:
return confirm(_that.bytesBase64);case ClearSignature() when clear != null:
return clear();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String bytesBase64)  confirm,required TResult Function()  clear,}) {final _that = this;
switch (_that) {
case ConfirmSignature():
return confirm(_that.bytesBase64);case ClearSignature():
return clear();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String bytesBase64)?  confirm,TResult? Function()?  clear,}) {final _that = this;
switch (_that) {
case ConfirmSignature() when confirm != null:
return confirm(_that.bytesBase64);case ClearSignature() when clear != null:
return clear();case _:
  return null;

}
}

}

/// @nodoc


class ConfirmSignature implements SignatureEvent {
  const ConfirmSignature(this.bytesBase64);
  

 final  String bytesBase64;

/// Create a copy of SignatureEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmSignatureCopyWith<ConfirmSignature> get copyWith => _$ConfirmSignatureCopyWithImpl<ConfirmSignature>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmSignature&&(identical(other.bytesBase64, bytesBase64) || other.bytesBase64 == bytesBase64));
}


@override
int get hashCode => Object.hash(runtimeType,bytesBase64);

@override
String toString() {
  return 'SignatureEvent.confirm(bytesBase64: $bytesBase64)';
}


}

/// @nodoc
abstract mixin class $ConfirmSignatureCopyWith<$Res> implements $SignatureEventCopyWith<$Res> {
  factory $ConfirmSignatureCopyWith(ConfirmSignature value, $Res Function(ConfirmSignature) _then) = _$ConfirmSignatureCopyWithImpl;
@useResult
$Res call({
 String bytesBase64
});




}
/// @nodoc
class _$ConfirmSignatureCopyWithImpl<$Res>
    implements $ConfirmSignatureCopyWith<$Res> {
  _$ConfirmSignatureCopyWithImpl(this._self, this._then);

  final ConfirmSignature _self;
  final $Res Function(ConfirmSignature) _then;

/// Create a copy of SignatureEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytesBase64 = null,}) {
  return _then(ConfirmSignature(
null == bytesBase64 ? _self.bytesBase64 : bytesBase64 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClearSignature implements SignatureEvent {
  const ClearSignature();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearSignature);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignatureEvent.clear()';
}


}




/// @nodoc
mixin _$SignatureState {

 bool get isSaving; String? get imagePath; String? get error;
/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureStateCopyWith<SignatureState> get copyWith => _$SignatureStateCopyWithImpl<SignatureState>(this as SignatureState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureState&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isSaving,imagePath,error);

@override
String toString() {
  return 'SignatureState(isSaving: $isSaving, imagePath: $imagePath, error: $error)';
}


}

/// @nodoc
abstract mixin class $SignatureStateCopyWith<$Res>  {
  factory $SignatureStateCopyWith(SignatureState value, $Res Function(SignatureState) _then) = _$SignatureStateCopyWithImpl;
@useResult
$Res call({
 bool isSaving, String? imagePath, String? error
});




}
/// @nodoc
class _$SignatureStateCopyWithImpl<$Res>
    implements $SignatureStateCopyWith<$Res> {
  _$SignatureStateCopyWithImpl(this._self, this._then);

  final SignatureState _self;
  final $Res Function(SignatureState) _then;

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSaving = null,Object? imagePath = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignatureState].
extension SignatureStatePatterns on SignatureState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureState value)  $default,){
final _that = this;
switch (_that) {
case _SignatureState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureState value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSaving,  String? imagePath,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
return $default(_that.isSaving,_that.imagePath,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSaving,  String? imagePath,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SignatureState():
return $default(_that.isSaving,_that.imagePath,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSaving,  String? imagePath,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SignatureState() when $default != null:
return $default(_that.isSaving,_that.imagePath,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _SignatureState implements SignatureState {
  const _SignatureState({this.isSaving = false, this.imagePath, this.error});
  

@override@JsonKey() final  bool isSaving;
@override final  String? imagePath;
@override final  String? error;

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureStateCopyWith<_SignatureState> get copyWith => __$SignatureStateCopyWithImpl<_SignatureState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureState&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isSaving,imagePath,error);

@override
String toString() {
  return 'SignatureState(isSaving: $isSaving, imagePath: $imagePath, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SignatureStateCopyWith<$Res> implements $SignatureStateCopyWith<$Res> {
  factory _$SignatureStateCopyWith(_SignatureState value, $Res Function(_SignatureState) _then) = __$SignatureStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSaving, String? imagePath, String? error
});




}
/// @nodoc
class __$SignatureStateCopyWithImpl<$Res>
    implements _$SignatureStateCopyWith<$Res> {
  __$SignatureStateCopyWithImpl(this._self, this._then);

  final _SignatureState _self;
  final $Res Function(_SignatureState) _then;

/// Create a copy of SignatureState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSaving = null,Object? imagePath = freezed,Object? error = freezed,}) {
  return _then(_SignatureState(
isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
