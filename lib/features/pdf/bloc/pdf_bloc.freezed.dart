// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pdf_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PdfEvent {

 int get protocolId;
/// Create a copy of PdfEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PdfEventCopyWith<PdfEvent> get copyWith => _$PdfEventCopyWithImpl<PdfEvent>(this as PdfEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PdfEvent&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId));
}


@override
int get hashCode => Object.hash(runtimeType,protocolId);

@override
String toString() {
  return 'PdfEvent(protocolId: $protocolId)';
}


}

/// @nodoc
abstract mixin class $PdfEventCopyWith<$Res>  {
  factory $PdfEventCopyWith(PdfEvent value, $Res Function(PdfEvent) _then) = _$PdfEventCopyWithImpl;
@useResult
$Res call({
 int protocolId
});




}
/// @nodoc
class _$PdfEventCopyWithImpl<$Res>
    implements $PdfEventCopyWith<$Res> {
  _$PdfEventCopyWithImpl(this._self, this._then);

  final PdfEvent _self;
  final $Res Function(PdfEvent) _then;

/// Create a copy of PdfEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? protocolId = null,}) {
  return _then(_self.copyWith(
protocolId: null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PdfEvent].
extension PdfEventPatterns on PdfEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GeneratePdf value)?  generate,TResult Function( PreviewPdf value)?  preview,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GeneratePdf() when generate != null:
return generate(_that);case PreviewPdf() when preview != null:
return preview(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GeneratePdf value)  generate,required TResult Function( PreviewPdf value)  preview,}){
final _that = this;
switch (_that) {
case GeneratePdf():
return generate(_that);case PreviewPdf():
return preview(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GeneratePdf value)?  generate,TResult? Function( PreviewPdf value)?  preview,}){
final _that = this;
switch (_that) {
case GeneratePdf() when generate != null:
return generate(_that);case PreviewPdf() when preview != null:
return preview(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int protocolId)?  generate,TResult Function( int protocolId)?  preview,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GeneratePdf() when generate != null:
return generate(_that.protocolId);case PreviewPdf() when preview != null:
return preview(_that.protocolId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int protocolId)  generate,required TResult Function( int protocolId)  preview,}) {final _that = this;
switch (_that) {
case GeneratePdf():
return generate(_that.protocolId);case PreviewPdf():
return preview(_that.protocolId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int protocolId)?  generate,TResult? Function( int protocolId)?  preview,}) {final _that = this;
switch (_that) {
case GeneratePdf() when generate != null:
return generate(_that.protocolId);case PreviewPdf() when preview != null:
return preview(_that.protocolId);case _:
  return null;

}
}

}

/// @nodoc


class GeneratePdf implements PdfEvent {
  const GeneratePdf(this.protocolId);
  

@override final  int protocolId;

/// Create a copy of PdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratePdfCopyWith<GeneratePdf> get copyWith => _$GeneratePdfCopyWithImpl<GeneratePdf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratePdf&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId));
}


@override
int get hashCode => Object.hash(runtimeType,protocolId);

@override
String toString() {
  return 'PdfEvent.generate(protocolId: $protocolId)';
}


}

/// @nodoc
abstract mixin class $GeneratePdfCopyWith<$Res> implements $PdfEventCopyWith<$Res> {
  factory $GeneratePdfCopyWith(GeneratePdf value, $Res Function(GeneratePdf) _then) = _$GeneratePdfCopyWithImpl;
@override @useResult
$Res call({
 int protocolId
});




}
/// @nodoc
class _$GeneratePdfCopyWithImpl<$Res>
    implements $GeneratePdfCopyWith<$Res> {
  _$GeneratePdfCopyWithImpl(this._self, this._then);

  final GeneratePdf _self;
  final $Res Function(GeneratePdf) _then;

/// Create a copy of PdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? protocolId = null,}) {
  return _then(GeneratePdf(
null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PreviewPdf implements PdfEvent {
  const PreviewPdf(this.protocolId);
  

@override final  int protocolId;

/// Create a copy of PdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviewPdfCopyWith<PreviewPdf> get copyWith => _$PreviewPdfCopyWithImpl<PreviewPdf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviewPdf&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId));
}


@override
int get hashCode => Object.hash(runtimeType,protocolId);

@override
String toString() {
  return 'PdfEvent.preview(protocolId: $protocolId)';
}


}

/// @nodoc
abstract mixin class $PreviewPdfCopyWith<$Res> implements $PdfEventCopyWith<$Res> {
  factory $PreviewPdfCopyWith(PreviewPdf value, $Res Function(PreviewPdf) _then) = _$PreviewPdfCopyWithImpl;
@override @useResult
$Res call({
 int protocolId
});




}
/// @nodoc
class _$PreviewPdfCopyWithImpl<$Res>
    implements $PreviewPdfCopyWith<$Res> {
  _$PreviewPdfCopyWithImpl(this._self, this._then);

  final PreviewPdf _self;
  final $Res Function(PreviewPdf) _then;

/// Create a copy of PdfEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? protocolId = null,}) {
  return _then(PreviewPdf(
null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$PdfState {

 bool get isLoading; String? get pdfPath; String? get error; bool get ready;
/// Create a copy of PdfState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PdfStateCopyWith<PdfState> get copyWith => _$PdfStateCopyWithImpl<PdfState>(this as PdfState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PdfState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.error, error) || other.error == error)&&(identical(other.ready, ready) || other.ready == ready));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,pdfPath,error,ready);

@override
String toString() {
  return 'PdfState(isLoading: $isLoading, pdfPath: $pdfPath, error: $error, ready: $ready)';
}


}

/// @nodoc
abstract mixin class $PdfStateCopyWith<$Res>  {
  factory $PdfStateCopyWith(PdfState value, $Res Function(PdfState) _then) = _$PdfStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? pdfPath, String? error, bool ready
});




}
/// @nodoc
class _$PdfStateCopyWithImpl<$Res>
    implements $PdfStateCopyWith<$Res> {
  _$PdfStateCopyWithImpl(this._self, this._then);

  final PdfState _self;
  final $Res Function(PdfState) _then;

/// Create a copy of PdfState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? pdfPath = freezed,Object? error = freezed,Object? ready = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PdfState].
extension PdfStatePatterns on PdfState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PdfState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PdfState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PdfState value)  $default,){
final _that = this;
switch (_that) {
case _PdfState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PdfState value)?  $default,){
final _that = this;
switch (_that) {
case _PdfState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? pdfPath,  String? error,  bool ready)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PdfState() when $default != null:
return $default(_that.isLoading,_that.pdfPath,_that.error,_that.ready);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? pdfPath,  String? error,  bool ready)  $default,) {final _that = this;
switch (_that) {
case _PdfState():
return $default(_that.isLoading,_that.pdfPath,_that.error,_that.ready);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? pdfPath,  String? error,  bool ready)?  $default,) {final _that = this;
switch (_that) {
case _PdfState() when $default != null:
return $default(_that.isLoading,_that.pdfPath,_that.error,_that.ready);case _:
  return null;

}
}

}

/// @nodoc


class _PdfState implements PdfState {
  const _PdfState({this.isLoading = false, this.pdfPath, this.error, this.ready = false});
  

@override@JsonKey() final  bool isLoading;
@override final  String? pdfPath;
@override final  String? error;
@override@JsonKey() final  bool ready;

/// Create a copy of PdfState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PdfStateCopyWith<_PdfState> get copyWith => __$PdfStateCopyWithImpl<_PdfState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PdfState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.error, error) || other.error == error)&&(identical(other.ready, ready) || other.ready == ready));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,pdfPath,error,ready);

@override
String toString() {
  return 'PdfState(isLoading: $isLoading, pdfPath: $pdfPath, error: $error, ready: $ready)';
}


}

/// @nodoc
abstract mixin class _$PdfStateCopyWith<$Res> implements $PdfStateCopyWith<$Res> {
  factory _$PdfStateCopyWith(_PdfState value, $Res Function(_PdfState) _then) = __$PdfStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? pdfPath, String? error, bool ready
});




}
/// @nodoc
class __$PdfStateCopyWithImpl<$Res>
    implements _$PdfStateCopyWith<$Res> {
  __$PdfStateCopyWithImpl(this._self, this._then);

  final _PdfState _self;
  final $Res Function(_PdfState) _then;

/// Create a copy of PdfState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? pdfPath = freezed,Object? error = freezed,Object? ready = null,}) {
  return _then(_PdfState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
