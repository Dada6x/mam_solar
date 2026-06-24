// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'protocol_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProtocolEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProtocolEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProtocolEvent()';
}


}

/// @nodoc
class $ProtocolEventCopyWith<$Res>  {
$ProtocolEventCopyWith(ProtocolEvent _, $Res Function(ProtocolEvent) __);
}


/// Adds pattern-matching-related methods to [ProtocolEvent].
extension ProtocolEventPatterns on ProtocolEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProtocol value)?  load,TResult Function( UpdateField value)?  updateField,TResult Function( UpdateRepeatableField value)?  updateRepeatableField,TResult Function( AddRepeatableItem value)?  addRepeatableItem,TResult Function( RemoveRepeatableItem value)?  removeRepeatableItem,TResult Function( SaveDraft value)?  saveDraft,TResult Function( GeneratePdf value)?  generatePdf,TResult Function( DeleteDraft value)?  deleteDraft,TResult Function( FinishProtocol value)?  finish,TResult Function( DuplicateAsDraft value)?  duplicateAsDraft,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProtocol() when load != null:
return load(_that);case UpdateField() when updateField != null:
return updateField(_that);case UpdateRepeatableField() when updateRepeatableField != null:
return updateRepeatableField(_that);case AddRepeatableItem() when addRepeatableItem != null:
return addRepeatableItem(_that);case RemoveRepeatableItem() when removeRepeatableItem != null:
return removeRepeatableItem(_that);case SaveDraft() when saveDraft != null:
return saveDraft(_that);case GeneratePdf() when generatePdf != null:
return generatePdf(_that);case DeleteDraft() when deleteDraft != null:
return deleteDraft(_that);case FinishProtocol() when finish != null:
return finish(_that);case DuplicateAsDraft() when duplicateAsDraft != null:
return duplicateAsDraft(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProtocol value)  load,required TResult Function( UpdateField value)  updateField,required TResult Function( UpdateRepeatableField value)  updateRepeatableField,required TResult Function( AddRepeatableItem value)  addRepeatableItem,required TResult Function( RemoveRepeatableItem value)  removeRepeatableItem,required TResult Function( SaveDraft value)  saveDraft,required TResult Function( GeneratePdf value)  generatePdf,required TResult Function( DeleteDraft value)  deleteDraft,required TResult Function( FinishProtocol value)  finish,required TResult Function( DuplicateAsDraft value)  duplicateAsDraft,}){
final _that = this;
switch (_that) {
case LoadProtocol():
return load(_that);case UpdateField():
return updateField(_that);case UpdateRepeatableField():
return updateRepeatableField(_that);case AddRepeatableItem():
return addRepeatableItem(_that);case RemoveRepeatableItem():
return removeRepeatableItem(_that);case SaveDraft():
return saveDraft(_that);case GeneratePdf():
return generatePdf(_that);case DeleteDraft():
return deleteDraft(_that);case FinishProtocol():
return finish(_that);case DuplicateAsDraft():
return duplicateAsDraft(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProtocol value)?  load,TResult? Function( UpdateField value)?  updateField,TResult? Function( UpdateRepeatableField value)?  updateRepeatableField,TResult? Function( AddRepeatableItem value)?  addRepeatableItem,TResult? Function( RemoveRepeatableItem value)?  removeRepeatableItem,TResult? Function( SaveDraft value)?  saveDraft,TResult? Function( GeneratePdf value)?  generatePdf,TResult? Function( DeleteDraft value)?  deleteDraft,TResult? Function( FinishProtocol value)?  finish,TResult? Function( DuplicateAsDraft value)?  duplicateAsDraft,}){
final _that = this;
switch (_that) {
case LoadProtocol() when load != null:
return load(_that);case UpdateField() when updateField != null:
return updateField(_that);case UpdateRepeatableField() when updateRepeatableField != null:
return updateRepeatableField(_that);case AddRepeatableItem() when addRepeatableItem != null:
return addRepeatableItem(_that);case RemoveRepeatableItem() when removeRepeatableItem != null:
return removeRepeatableItem(_that);case SaveDraft() when saveDraft != null:
return saveDraft(_that);case GeneratePdf() when generatePdf != null:
return generatePdf(_that);case DeleteDraft() when deleteDraft != null:
return deleteDraft(_that);case FinishProtocol() when finish != null:
return finish(_that);case DuplicateAsDraft() when duplicateAsDraft != null:
return duplicateAsDraft(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? protocolId,  String? protocolType)?  load,TResult Function( String key,  dynamic value)?  updateField,TResult Function( String sectionId,  int index,  String key,  dynamic value)?  updateRepeatableField,TResult Function( String sectionId)?  addRepeatableItem,TResult Function( String sectionId,  int index)?  removeRepeatableItem,TResult Function()?  saveDraft,TResult Function()?  generatePdf,TResult Function()?  deleteDraft,TResult Function()?  finish,TResult Function()?  duplicateAsDraft,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProtocol() when load != null:
return load(_that.protocolId,_that.protocolType);case UpdateField() when updateField != null:
return updateField(_that.key,_that.value);case UpdateRepeatableField() when updateRepeatableField != null:
return updateRepeatableField(_that.sectionId,_that.index,_that.key,_that.value);case AddRepeatableItem() when addRepeatableItem != null:
return addRepeatableItem(_that.sectionId);case RemoveRepeatableItem() when removeRepeatableItem != null:
return removeRepeatableItem(_that.sectionId,_that.index);case SaveDraft() when saveDraft != null:
return saveDraft();case GeneratePdf() when generatePdf != null:
return generatePdf();case DeleteDraft() when deleteDraft != null:
return deleteDraft();case FinishProtocol() when finish != null:
return finish();case DuplicateAsDraft() when duplicateAsDraft != null:
return duplicateAsDraft();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? protocolId,  String? protocolType)  load,required TResult Function( String key,  dynamic value)  updateField,required TResult Function( String sectionId,  int index,  String key,  dynamic value)  updateRepeatableField,required TResult Function( String sectionId)  addRepeatableItem,required TResult Function( String sectionId,  int index)  removeRepeatableItem,required TResult Function()  saveDraft,required TResult Function()  generatePdf,required TResult Function()  deleteDraft,required TResult Function()  finish,required TResult Function()  duplicateAsDraft,}) {final _that = this;
switch (_that) {
case LoadProtocol():
return load(_that.protocolId,_that.protocolType);case UpdateField():
return updateField(_that.key,_that.value);case UpdateRepeatableField():
return updateRepeatableField(_that.sectionId,_that.index,_that.key,_that.value);case AddRepeatableItem():
return addRepeatableItem(_that.sectionId);case RemoveRepeatableItem():
return removeRepeatableItem(_that.sectionId,_that.index);case SaveDraft():
return saveDraft();case GeneratePdf():
return generatePdf();case DeleteDraft():
return deleteDraft();case FinishProtocol():
return finish();case DuplicateAsDraft():
return duplicateAsDraft();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? protocolId,  String? protocolType)?  load,TResult? Function( String key,  dynamic value)?  updateField,TResult? Function( String sectionId,  int index,  String key,  dynamic value)?  updateRepeatableField,TResult? Function( String sectionId)?  addRepeatableItem,TResult? Function( String sectionId,  int index)?  removeRepeatableItem,TResult? Function()?  saveDraft,TResult? Function()?  generatePdf,TResult? Function()?  deleteDraft,TResult? Function()?  finish,TResult? Function()?  duplicateAsDraft,}) {final _that = this;
switch (_that) {
case LoadProtocol() when load != null:
return load(_that.protocolId,_that.protocolType);case UpdateField() when updateField != null:
return updateField(_that.key,_that.value);case UpdateRepeatableField() when updateRepeatableField != null:
return updateRepeatableField(_that.sectionId,_that.index,_that.key,_that.value);case AddRepeatableItem() when addRepeatableItem != null:
return addRepeatableItem(_that.sectionId);case RemoveRepeatableItem() when removeRepeatableItem != null:
return removeRepeatableItem(_that.sectionId,_that.index);case SaveDraft() when saveDraft != null:
return saveDraft();case GeneratePdf() when generatePdf != null:
return generatePdf();case DeleteDraft() when deleteDraft != null:
return deleteDraft();case FinishProtocol() when finish != null:
return finish();case DuplicateAsDraft() when duplicateAsDraft != null:
return duplicateAsDraft();case _:
  return null;

}
}

}

/// @nodoc


class LoadProtocol implements ProtocolEvent {
  const LoadProtocol({this.protocolId, this.protocolType});
  

 final  int? protocolId;
 final  String? protocolType;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProtocolCopyWith<LoadProtocol> get copyWith => _$LoadProtocolCopyWithImpl<LoadProtocol>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProtocol&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId)&&(identical(other.protocolType, protocolType) || other.protocolType == protocolType));
}


@override
int get hashCode => Object.hash(runtimeType,protocolId,protocolType);

@override
String toString() {
  return 'ProtocolEvent.load(protocolId: $protocolId, protocolType: $protocolType)';
}


}

/// @nodoc
abstract mixin class $LoadProtocolCopyWith<$Res> implements $ProtocolEventCopyWith<$Res> {
  factory $LoadProtocolCopyWith(LoadProtocol value, $Res Function(LoadProtocol) _then) = _$LoadProtocolCopyWithImpl;
@useResult
$Res call({
 int? protocolId, String? protocolType
});




}
/// @nodoc
class _$LoadProtocolCopyWithImpl<$Res>
    implements $LoadProtocolCopyWith<$Res> {
  _$LoadProtocolCopyWithImpl(this._self, this._then);

  final LoadProtocol _self;
  final $Res Function(LoadProtocol) _then;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? protocolId = freezed,Object? protocolType = freezed,}) {
  return _then(LoadProtocol(
protocolId: freezed == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int?,protocolType: freezed == protocolType ? _self.protocolType : protocolType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UpdateField implements ProtocolEvent {
  const UpdateField(this.key, this.value);
  

 final  String key;
 final  dynamic value;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateFieldCopyWith<UpdateField> get copyWith => _$UpdateFieldCopyWithImpl<UpdateField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateField&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,key,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'ProtocolEvent.updateField(key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class $UpdateFieldCopyWith<$Res> implements $ProtocolEventCopyWith<$Res> {
  factory $UpdateFieldCopyWith(UpdateField value, $Res Function(UpdateField) _then) = _$UpdateFieldCopyWithImpl;
@useResult
$Res call({
 String key, dynamic value
});




}
/// @nodoc
class _$UpdateFieldCopyWithImpl<$Res>
    implements $UpdateFieldCopyWith<$Res> {
  _$UpdateFieldCopyWithImpl(this._self, this._then);

  final UpdateField _self;
  final $Res Function(UpdateField) _then;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = freezed,}) {
  return _then(UpdateField(
null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class UpdateRepeatableField implements ProtocolEvent {
  const UpdateRepeatableField(this.sectionId, this.index, this.key, this.value);
  

 final  String sectionId;
 final  int index;
 final  String key;
 final  dynamic value;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateRepeatableFieldCopyWith<UpdateRepeatableField> get copyWith => _$UpdateRepeatableFieldCopyWithImpl<UpdateRepeatableField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateRepeatableField&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.index, index) || other.index == index)&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,sectionId,index,key,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'ProtocolEvent.updateRepeatableField(sectionId: $sectionId, index: $index, key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class $UpdateRepeatableFieldCopyWith<$Res> implements $ProtocolEventCopyWith<$Res> {
  factory $UpdateRepeatableFieldCopyWith(UpdateRepeatableField value, $Res Function(UpdateRepeatableField) _then) = _$UpdateRepeatableFieldCopyWithImpl;
@useResult
$Res call({
 String sectionId, int index, String key, dynamic value
});




}
/// @nodoc
class _$UpdateRepeatableFieldCopyWithImpl<$Res>
    implements $UpdateRepeatableFieldCopyWith<$Res> {
  _$UpdateRepeatableFieldCopyWithImpl(this._self, this._then);

  final UpdateRepeatableField _self;
  final $Res Function(UpdateRepeatableField) _then;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sectionId = null,Object? index = null,Object? key = null,Object? value = freezed,}) {
  return _then(UpdateRepeatableField(
null == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class AddRepeatableItem implements ProtocolEvent {
  const AddRepeatableItem(this.sectionId);
  

 final  String sectionId;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddRepeatableItemCopyWith<AddRepeatableItem> get copyWith => _$AddRepeatableItemCopyWithImpl<AddRepeatableItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddRepeatableItem&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId));
}


@override
int get hashCode => Object.hash(runtimeType,sectionId);

@override
String toString() {
  return 'ProtocolEvent.addRepeatableItem(sectionId: $sectionId)';
}


}

/// @nodoc
abstract mixin class $AddRepeatableItemCopyWith<$Res> implements $ProtocolEventCopyWith<$Res> {
  factory $AddRepeatableItemCopyWith(AddRepeatableItem value, $Res Function(AddRepeatableItem) _then) = _$AddRepeatableItemCopyWithImpl;
@useResult
$Res call({
 String sectionId
});




}
/// @nodoc
class _$AddRepeatableItemCopyWithImpl<$Res>
    implements $AddRepeatableItemCopyWith<$Res> {
  _$AddRepeatableItemCopyWithImpl(this._self, this._then);

  final AddRepeatableItem _self;
  final $Res Function(AddRepeatableItem) _then;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sectionId = null,}) {
  return _then(AddRepeatableItem(
null == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RemoveRepeatableItem implements ProtocolEvent {
  const RemoveRepeatableItem(this.sectionId, this.index);
  

 final  String sectionId;
 final  int index;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveRepeatableItemCopyWith<RemoveRepeatableItem> get copyWith => _$RemoveRepeatableItemCopyWithImpl<RemoveRepeatableItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveRepeatableItem&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId)&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,sectionId,index);

@override
String toString() {
  return 'ProtocolEvent.removeRepeatableItem(sectionId: $sectionId, index: $index)';
}


}

/// @nodoc
abstract mixin class $RemoveRepeatableItemCopyWith<$Res> implements $ProtocolEventCopyWith<$Res> {
  factory $RemoveRepeatableItemCopyWith(RemoveRepeatableItem value, $Res Function(RemoveRepeatableItem) _then) = _$RemoveRepeatableItemCopyWithImpl;
@useResult
$Res call({
 String sectionId, int index
});




}
/// @nodoc
class _$RemoveRepeatableItemCopyWithImpl<$Res>
    implements $RemoveRepeatableItemCopyWith<$Res> {
  _$RemoveRepeatableItemCopyWithImpl(this._self, this._then);

  final RemoveRepeatableItem _self;
  final $Res Function(RemoveRepeatableItem) _then;

/// Create a copy of ProtocolEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sectionId = null,Object? index = null,}) {
  return _then(RemoveRepeatableItem(
null == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String,null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SaveDraft implements ProtocolEvent {
  const SaveDraft();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveDraft);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProtocolEvent.saveDraft()';
}


}




/// @nodoc


class GeneratePdf implements ProtocolEvent {
  const GeneratePdf();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratePdf);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProtocolEvent.generatePdf()';
}


}




/// @nodoc


class DeleteDraft implements ProtocolEvent {
  const DeleteDraft();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteDraft);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProtocolEvent.deleteDraft()';
}


}




/// @nodoc


class FinishProtocol implements ProtocolEvent {
  const FinishProtocol();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinishProtocol);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProtocolEvent.finish()';
}


}




/// @nodoc


class DuplicateAsDraft implements ProtocolEvent {
  const DuplicateAsDraft();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DuplicateAsDraft);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProtocolEvent.duplicateAsDraft()';
}


}




/// @nodoc
mixin _$ProtocolState {

 bool get isLoading; bool get isSaving; bool get isDirty; bool get pdfGenerating; String? get protocolType; int get protocolId; String get status; Map<String, dynamic> get formData; Map<String, List<Map<String, dynamic>>> get repeatableData; List<FormSection> get sections; String? get error; String? get pdfPath; String? get saveMessage; int? get duplicatedDraftId;
/// Create a copy of ProtocolState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProtocolStateCopyWith<ProtocolState> get copyWith => _$ProtocolStateCopyWithImpl<ProtocolState>(this as ProtocolState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProtocolState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.pdfGenerating, pdfGenerating) || other.pdfGenerating == pdfGenerating)&&(identical(other.protocolType, protocolType) || other.protocolType == protocolType)&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.formData, formData)&&const DeepCollectionEquality().equals(other.repeatableData, repeatableData)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.error, error) || other.error == error)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.saveMessage, saveMessage) || other.saveMessage == saveMessage)&&(identical(other.duplicatedDraftId, duplicatedDraftId) || other.duplicatedDraftId == duplicatedDraftId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,isDirty,pdfGenerating,protocolType,protocolId,status,const DeepCollectionEquality().hash(formData),const DeepCollectionEquality().hash(repeatableData),const DeepCollectionEquality().hash(sections),error,pdfPath,saveMessage,duplicatedDraftId);

@override
String toString() {
  return 'ProtocolState(isLoading: $isLoading, isSaving: $isSaving, isDirty: $isDirty, pdfGenerating: $pdfGenerating, protocolType: $protocolType, protocolId: $protocolId, status: $status, formData: $formData, repeatableData: $repeatableData, sections: $sections, error: $error, pdfPath: $pdfPath, saveMessage: $saveMessage, duplicatedDraftId: $duplicatedDraftId)';
}


}

/// @nodoc
abstract mixin class $ProtocolStateCopyWith<$Res>  {
  factory $ProtocolStateCopyWith(ProtocolState value, $Res Function(ProtocolState) _then) = _$ProtocolStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSaving, bool isDirty, bool pdfGenerating, String? protocolType, int protocolId, String status, Map<String, dynamic> formData, Map<String, List<Map<String, dynamic>>> repeatableData, List<FormSection> sections, String? error, String? pdfPath, String? saveMessage, int? duplicatedDraftId
});




}
/// @nodoc
class _$ProtocolStateCopyWithImpl<$Res>
    implements $ProtocolStateCopyWith<$Res> {
  _$ProtocolStateCopyWithImpl(this._self, this._then);

  final ProtocolState _self;
  final $Res Function(ProtocolState) _then;

/// Create a copy of ProtocolState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSaving = null,Object? isDirty = null,Object? pdfGenerating = null,Object? protocolType = freezed,Object? protocolId = null,Object? status = null,Object? formData = null,Object? repeatableData = null,Object? sections = null,Object? error = freezed,Object? pdfPath = freezed,Object? saveMessage = freezed,Object? duplicatedDraftId = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,pdfGenerating: null == pdfGenerating ? _self.pdfGenerating : pdfGenerating // ignore: cast_nullable_to_non_nullable
as bool,protocolType: freezed == protocolType ? _self.protocolType : protocolType // ignore: cast_nullable_to_non_nullable
as String?,protocolId: null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,formData: null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,repeatableData: null == repeatableData ? _self.repeatableData : repeatableData // ignore: cast_nullable_to_non_nullable
as Map<String, List<Map<String, dynamic>>>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<FormSection>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,saveMessage: freezed == saveMessage ? _self.saveMessage : saveMessage // ignore: cast_nullable_to_non_nullable
as String?,duplicatedDraftId: freezed == duplicatedDraftId ? _self.duplicatedDraftId : duplicatedDraftId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProtocolState].
extension ProtocolStatePatterns on ProtocolState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProtocolState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProtocolState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProtocolState value)  $default,){
final _that = this;
switch (_that) {
case _ProtocolState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProtocolState value)?  $default,){
final _that = this;
switch (_that) {
case _ProtocolState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  bool isDirty,  bool pdfGenerating,  String? protocolType,  int protocolId,  String status,  Map<String, dynamic> formData,  Map<String, List<Map<String, dynamic>>> repeatableData,  List<FormSection> sections,  String? error,  String? pdfPath,  String? saveMessage,  int? duplicatedDraftId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProtocolState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.isDirty,_that.pdfGenerating,_that.protocolType,_that.protocolId,_that.status,_that.formData,_that.repeatableData,_that.sections,_that.error,_that.pdfPath,_that.saveMessage,_that.duplicatedDraftId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  bool isDirty,  bool pdfGenerating,  String? protocolType,  int protocolId,  String status,  Map<String, dynamic> formData,  Map<String, List<Map<String, dynamic>>> repeatableData,  List<FormSection> sections,  String? error,  String? pdfPath,  String? saveMessage,  int? duplicatedDraftId)  $default,) {final _that = this;
switch (_that) {
case _ProtocolState():
return $default(_that.isLoading,_that.isSaving,_that.isDirty,_that.pdfGenerating,_that.protocolType,_that.protocolId,_that.status,_that.formData,_that.repeatableData,_that.sections,_that.error,_that.pdfPath,_that.saveMessage,_that.duplicatedDraftId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSaving,  bool isDirty,  bool pdfGenerating,  String? protocolType,  int protocolId,  String status,  Map<String, dynamic> formData,  Map<String, List<Map<String, dynamic>>> repeatableData,  List<FormSection> sections,  String? error,  String? pdfPath,  String? saveMessage,  int? duplicatedDraftId)?  $default,) {final _that = this;
switch (_that) {
case _ProtocolState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.isDirty,_that.pdfGenerating,_that.protocolType,_that.protocolId,_that.status,_that.formData,_that.repeatableData,_that.sections,_that.error,_that.pdfPath,_that.saveMessage,_that.duplicatedDraftId);case _:
  return null;

}
}

}

/// @nodoc


class _ProtocolState extends ProtocolState {
  const _ProtocolState({this.isLoading = false, this.isSaving = false, this.isDirty = false, this.pdfGenerating = false, this.protocolType, this.protocolId = 0, this.status = 'draft', final  Map<String, dynamic> formData = const {}, final  Map<String, List<Map<String, dynamic>>> repeatableData = const {}, final  List<FormSection> sections = const [], this.error, this.pdfPath, this.saveMessage, this.duplicatedDraftId}): _formData = formData,_repeatableData = repeatableData,_sections = sections,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isDirty;
@override@JsonKey() final  bool pdfGenerating;
@override final  String? protocolType;
@override@JsonKey() final  int protocolId;
@override@JsonKey() final  String status;
 final  Map<String, dynamic> _formData;
@override@JsonKey() Map<String, dynamic> get formData {
  if (_formData is EqualUnmodifiableMapView) return _formData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_formData);
}

 final  Map<String, List<Map<String, dynamic>>> _repeatableData;
@override@JsonKey() Map<String, List<Map<String, dynamic>>> get repeatableData {
  if (_repeatableData is EqualUnmodifiableMapView) return _repeatableData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_repeatableData);
}

 final  List<FormSection> _sections;
@override@JsonKey() List<FormSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  String? error;
@override final  String? pdfPath;
@override final  String? saveMessage;
@override final  int? duplicatedDraftId;

/// Create a copy of ProtocolState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProtocolStateCopyWith<_ProtocolState> get copyWith => __$ProtocolStateCopyWithImpl<_ProtocolState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProtocolState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isDirty, isDirty) || other.isDirty == isDirty)&&(identical(other.pdfGenerating, pdfGenerating) || other.pdfGenerating == pdfGenerating)&&(identical(other.protocolType, protocolType) || other.protocolType == protocolType)&&(identical(other.protocolId, protocolId) || other.protocolId == protocolId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._formData, _formData)&&const DeepCollectionEquality().equals(other._repeatableData, _repeatableData)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.error, error) || other.error == error)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.saveMessage, saveMessage) || other.saveMessage == saveMessage)&&(identical(other.duplicatedDraftId, duplicatedDraftId) || other.duplicatedDraftId == duplicatedDraftId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,isDirty,pdfGenerating,protocolType,protocolId,status,const DeepCollectionEquality().hash(_formData),const DeepCollectionEquality().hash(_repeatableData),const DeepCollectionEquality().hash(_sections),error,pdfPath,saveMessage,duplicatedDraftId);

@override
String toString() {
  return 'ProtocolState(isLoading: $isLoading, isSaving: $isSaving, isDirty: $isDirty, pdfGenerating: $pdfGenerating, protocolType: $protocolType, protocolId: $protocolId, status: $status, formData: $formData, repeatableData: $repeatableData, sections: $sections, error: $error, pdfPath: $pdfPath, saveMessage: $saveMessage, duplicatedDraftId: $duplicatedDraftId)';
}


}

/// @nodoc
abstract mixin class _$ProtocolStateCopyWith<$Res> implements $ProtocolStateCopyWith<$Res> {
  factory _$ProtocolStateCopyWith(_ProtocolState value, $Res Function(_ProtocolState) _then) = __$ProtocolStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSaving, bool isDirty, bool pdfGenerating, String? protocolType, int protocolId, String status, Map<String, dynamic> formData, Map<String, List<Map<String, dynamic>>> repeatableData, List<FormSection> sections, String? error, String? pdfPath, String? saveMessage, int? duplicatedDraftId
});




}
/// @nodoc
class __$ProtocolStateCopyWithImpl<$Res>
    implements _$ProtocolStateCopyWith<$Res> {
  __$ProtocolStateCopyWithImpl(this._self, this._then);

  final _ProtocolState _self;
  final $Res Function(_ProtocolState) _then;

/// Create a copy of ProtocolState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSaving = null,Object? isDirty = null,Object? pdfGenerating = null,Object? protocolType = freezed,Object? protocolId = null,Object? status = null,Object? formData = null,Object? repeatableData = null,Object? sections = null,Object? error = freezed,Object? pdfPath = freezed,Object? saveMessage = freezed,Object? duplicatedDraftId = freezed,}) {
  return _then(_ProtocolState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isDirty: null == isDirty ? _self.isDirty : isDirty // ignore: cast_nullable_to_non_nullable
as bool,pdfGenerating: null == pdfGenerating ? _self.pdfGenerating : pdfGenerating // ignore: cast_nullable_to_non_nullable
as bool,protocolType: freezed == protocolType ? _self.protocolType : protocolType // ignore: cast_nullable_to_non_nullable
as String?,protocolId: null == protocolId ? _self.protocolId : protocolId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,formData: null == formData ? _self._formData : formData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,repeatableData: null == repeatableData ? _self._repeatableData : repeatableData // ignore: cast_nullable_to_non_nullable
as Map<String, List<Map<String, dynamic>>>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<FormSection>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,saveMessage: freezed == saveMessage ? _self.saveMessage : saveMessage // ignore: cast_nullable_to_non_nullable
as String?,duplicatedDraftId: freezed == duplicatedDraftId ? _self.duplicatedDraftId : duplicatedDraftId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
