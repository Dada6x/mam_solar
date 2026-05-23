// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drafts_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DraftsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DraftsEvent()';
}


}

/// @nodoc
class $DraftsEventCopyWith<$Res>  {
$DraftsEventCopyWith(DraftsEvent _, $Res Function(DraftsEvent) __);
}


/// Adds pattern-matching-related methods to [DraftsEvent].
extension DraftsEventPatterns on DraftsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadDrafts value)?  load,TResult Function( DeleteDraft value)?  delete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadDrafts() when load != null:
return load(_that);case DeleteDraft() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadDrafts value)  load,required TResult Function( DeleteDraft value)  delete,}){
final _that = this;
switch (_that) {
case LoadDrafts():
return load(_that);case DeleteDraft():
return delete(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadDrafts value)?  load,TResult? Function( DeleteDraft value)?  delete,}){
final _that = this;
switch (_that) {
case LoadDrafts() when load != null:
return load(_that);case DeleteDraft() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( int id)?  delete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadDrafts() when load != null:
return load();case DeleteDraft() when delete != null:
return delete(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( int id)  delete,}) {final _that = this;
switch (_that) {
case LoadDrafts():
return load();case DeleteDraft():
return delete(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( int id)?  delete,}) {final _that = this;
switch (_that) {
case LoadDrafts() when load != null:
return load();case DeleteDraft() when delete != null:
return delete(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class LoadDrafts implements DraftsEvent {
  const LoadDrafts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadDrafts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DraftsEvent.load()';
}


}




/// @nodoc


class DeleteDraft implements DraftsEvent {
  const DeleteDraft(this.id);
  

 final  int id;

/// Create a copy of DraftsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteDraftCopyWith<DeleteDraft> get copyWith => _$DeleteDraftCopyWithImpl<DeleteDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteDraft&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'DraftsEvent.delete(id: $id)';
}


}

/// @nodoc
abstract mixin class $DeleteDraftCopyWith<$Res> implements $DraftsEventCopyWith<$Res> {
  factory $DeleteDraftCopyWith(DeleteDraft value, $Res Function(DeleteDraft) _then) = _$DeleteDraftCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$DeleteDraftCopyWithImpl<$Res>
    implements $DeleteDraftCopyWith<$Res> {
  _$DeleteDraftCopyWithImpl(this._self, this._then);

  final DeleteDraft _self;
  final $Res Function(DeleteDraft) _then;

/// Create a copy of DraftsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(DeleteDraft(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DraftsState {

 bool get isLoading; List<ProtocolModel> get drafts; String? get error;
/// Create a copy of DraftsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftsStateCopyWith<DraftsState> get copyWith => _$DraftsStateCopyWithImpl<DraftsState>(this as DraftsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.drafts, drafts)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(drafts),error);

@override
String toString() {
  return 'DraftsState(isLoading: $isLoading, drafts: $drafts, error: $error)';
}


}

/// @nodoc
abstract mixin class $DraftsStateCopyWith<$Res>  {
  factory $DraftsStateCopyWith(DraftsState value, $Res Function(DraftsState) _then) = _$DraftsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ProtocolModel> drafts, String? error
});




}
/// @nodoc
class _$DraftsStateCopyWithImpl<$Res>
    implements $DraftsStateCopyWith<$Res> {
  _$DraftsStateCopyWithImpl(this._self, this._then);

  final DraftsState _self;
  final $Res Function(DraftsState) _then;

/// Create a copy of DraftsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? drafts = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,drafts: null == drafts ? _self.drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<ProtocolModel>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftsState].
extension DraftsStatePatterns on DraftsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftsState value)  $default,){
final _that = this;
switch (_that) {
case _DraftsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftsState value)?  $default,){
final _that = this;
switch (_that) {
case _DraftsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ProtocolModel> drafts,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftsState() when $default != null:
return $default(_that.isLoading,_that.drafts,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ProtocolModel> drafts,  String? error)  $default,) {final _that = this;
switch (_that) {
case _DraftsState():
return $default(_that.isLoading,_that.drafts,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ProtocolModel> drafts,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _DraftsState() when $default != null:
return $default(_that.isLoading,_that.drafts,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _DraftsState implements DraftsState {
  const _DraftsState({this.isLoading = false, final  List<ProtocolModel> drafts = const [], this.error}): _drafts = drafts;
  

@override@JsonKey() final  bool isLoading;
 final  List<ProtocolModel> _drafts;
@override@JsonKey() List<ProtocolModel> get drafts {
  if (_drafts is EqualUnmodifiableListView) return _drafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drafts);
}

@override final  String? error;

/// Create a copy of DraftsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftsStateCopyWith<_DraftsState> get copyWith => __$DraftsStateCopyWithImpl<_DraftsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._drafts, _drafts)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_drafts),error);

@override
String toString() {
  return 'DraftsState(isLoading: $isLoading, drafts: $drafts, error: $error)';
}


}

/// @nodoc
abstract mixin class _$DraftsStateCopyWith<$Res> implements $DraftsStateCopyWith<$Res> {
  factory _$DraftsStateCopyWith(_DraftsState value, $Res Function(_DraftsState) _then) = __$DraftsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ProtocolModel> drafts, String? error
});




}
/// @nodoc
class __$DraftsStateCopyWithImpl<$Res>
    implements _$DraftsStateCopyWith<$Res> {
  __$DraftsStateCopyWithImpl(this._self, this._then);

  final _DraftsState _self;
  final $Res Function(_DraftsState) _then;

/// Create a copy of DraftsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? drafts = null,Object? error = freezed,}) {
  return _then(_DraftsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,drafts: null == drafts ? _self._drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<ProtocolModel>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
