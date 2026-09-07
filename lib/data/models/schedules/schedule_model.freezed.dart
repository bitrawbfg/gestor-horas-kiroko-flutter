// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduleModel {

 int? get id; bool get isSplitShift; DateTime get startFirstTurnTime; DateTime get finishFirstTurnTime;
/// Create a copy of ScheduleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleModelCopyWith<ScheduleModel> get copyWith => _$ScheduleModelCopyWithImpl<ScheduleModel>(this as ScheduleModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScheduleModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.isSplitShift, _this.isSplitShift) || other.isSplitShift == _this.isSplitShift)&&(identical(other.startFirstTurnTime, _this.startFirstTurnTime) || other.startFirstTurnTime == _this.startFirstTurnTime)&&(identical(other.finishFirstTurnTime, _this.finishFirstTurnTime) || other.finishFirstTurnTime == _this.finishFirstTurnTime));
}


@override
int get hashCode {
  final _this = this as ScheduleModel;
  return Object.hash(runtimeType,_this.id,_this.isSplitShift,_this.startFirstTurnTime,_this.finishFirstTurnTime);
}

@override
String toString() {
  final _this = this as ScheduleModel;
  return 'ScheduleModel(id: ${_this.id}, isSplitShift: ${_this.isSplitShift}, startFirstTurnTime: ${_this.startFirstTurnTime}, finishFirstTurnTime: ${_this.finishFirstTurnTime})';
}


}

/// @nodoc
abstract mixin class $ScheduleModelCopyWith<$Res>  {
  factory $ScheduleModelCopyWith(ScheduleModel value, $Res Function(ScheduleModel) _then) = _$ScheduleModelCopyWithImpl;
@useResult
$Res call({
 int? id, bool isSplitShift, DateTime startFirstTurnTime, DateTime finishFirstTurnTime
});




}
/// @nodoc
class _$ScheduleModelCopyWithImpl<$Res>
    implements $ScheduleModelCopyWith<$Res> {
  _$ScheduleModelCopyWithImpl(this._self, this._then);

  final ScheduleModel _self;
  final $Res Function(ScheduleModel) _then;

/// Create a copy of ScheduleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? isSplitShift = null,Object? startFirstTurnTime = null,Object? finishFirstTurnTime = null,}) {
  return _then(ScheduleModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,isSplitShift: null == isSplitShift ? _self.isSplitShift : isSplitShift // ignore: cast_nullable_to_non_nullable
as bool,startFirstTurnTime: null == startFirstTurnTime ? _self.startFirstTurnTime : startFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,finishFirstTurnTime: null == finishFirstTurnTime ? _self.finishFirstTurnTime : finishFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleModel].
extension ScheduleModelPatterns on ScheduleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleModel value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  bool isSplitShift,  DateTime startFirstTurnTime,  DateTime finishFirstTurnTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleModel() when $default != null:
return $default(_that.id,_that.isSplitShift,_that.startFirstTurnTime,_that.finishFirstTurnTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  bool isSplitShift,  DateTime startFirstTurnTime,  DateTime finishFirstTurnTime)  $default,) {final _that = this;
switch (_that) {
case _ScheduleModel():
return $default(_that.id,_that.isSplitShift,_that.startFirstTurnTime,_that.finishFirstTurnTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  bool isSplitShift,  DateTime startFirstTurnTime,  DateTime finishFirstTurnTime)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleModel() when $default != null:
return $default(_that.id,_that.isSplitShift,_that.startFirstTurnTime,_that.finishFirstTurnTime);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleModel extends ScheduleModel {
  const _ScheduleModel({this.id, this.isSplitShift = false, required this.startFirstTurnTime, required this.finishFirstTurnTime}): super._();
  

@override final  int? id;
@override@JsonKey() final  bool isSplitShift;
@override final  DateTime startFirstTurnTime;
@override final  DateTime finishFirstTurnTime;

/// Create a copy of ScheduleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleModelCopyWith<_ScheduleModel> get copyWith => __$ScheduleModelCopyWithImpl<_ScheduleModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.isSplitShift, isSplitShift) || other.isSplitShift == isSplitShift)&&(identical(other.startFirstTurnTime, startFirstTurnTime) || other.startFirstTurnTime == startFirstTurnTime)&&(identical(other.finishFirstTurnTime, finishFirstTurnTime) || other.finishFirstTurnTime == finishFirstTurnTime));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,isSplitShift,startFirstTurnTime,finishFirstTurnTime);
}

@override
String toString() {
    return 'ScheduleModel(id: $id, isSplitShift: $isSplitShift, startFirstTurnTime: $startFirstTurnTime, finishFirstTurnTime: $finishFirstTurnTime)';
}


}

/// @nodoc
abstract mixin class _$ScheduleModelCopyWith<$Res> implements $ScheduleModelCopyWith<$Res> {
  factory _$ScheduleModelCopyWith(_ScheduleModel value, $Res Function(_ScheduleModel) _then) = __$ScheduleModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, bool isSplitShift, DateTime startFirstTurnTime, DateTime finishFirstTurnTime
});




}
/// @nodoc
class __$ScheduleModelCopyWithImpl<$Res>
    implements _$ScheduleModelCopyWith<$Res> {
  __$ScheduleModelCopyWithImpl(this._self, this._then);

  final _ScheduleModel _self;
  final $Res Function(_ScheduleModel) _then;

/// Create a copy of ScheduleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? isSplitShift = null,Object? startFirstTurnTime = null,Object? finishFirstTurnTime = null,}) {
  return _then(_ScheduleModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,isSplitShift: null == isSplitShift ? _self.isSplitShift : isSplitShift // ignore: cast_nullable_to_non_nullable
as bool,startFirstTurnTime: null == startFirstTurnTime ? _self.startFirstTurnTime : startFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,finishFirstTurnTime: null == finishFirstTurnTime ? _self.finishFirstTurnTime : finishFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
