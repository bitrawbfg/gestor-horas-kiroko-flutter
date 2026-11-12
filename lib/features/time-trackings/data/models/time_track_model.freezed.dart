// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_track_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimeTrackModel {

 int? get id; int get idEmployee; DateTime get startTime; DateTime? get finishTime;
/// Create a copy of TimeTrackModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeTrackModelCopyWith<TimeTrackModel> get copyWith => _$TimeTrackModelCopyWithImpl<TimeTrackModel>(this as TimeTrackModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TimeTrackModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeTrackModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.idEmployee, _this.idEmployee) || other.idEmployee == _this.idEmployee)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.finishTime, _this.finishTime) || other.finishTime == _this.finishTime));
}


@override
int get hashCode {
  final _this = this as TimeTrackModel;
  return Object.hash(runtimeType,_this.id,_this.idEmployee,_this.startTime,_this.finishTime);
}

@override
String toString() {
  final _this = this as TimeTrackModel;
  return 'TimeTrackModel(id: ${_this.id}, idEmployee: ${_this.idEmployee}, startTime: ${_this.startTime}, finishTime: ${_this.finishTime})';
}


}

/// @nodoc
abstract mixin class $TimeTrackModelCopyWith<$Res>  {
  factory $TimeTrackModelCopyWith(TimeTrackModel value, $Res Function(TimeTrackModel) _then) = _$TimeTrackModelCopyWithImpl;
@useResult
$Res call({
 int? id, int idEmployee, DateTime startTime, DateTime? finishTime
});




}
/// @nodoc
class _$TimeTrackModelCopyWithImpl<$Res>
    implements $TimeTrackModelCopyWith<$Res> {
  _$TimeTrackModelCopyWithImpl(this._self, this._then);

  final TimeTrackModel _self;
  final $Res Function(TimeTrackModel) _then;

/// Create a copy of TimeTrackModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? idEmployee = null,Object? startTime = null,Object? finishTime = freezed,}) {
  return _then(TimeTrackModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,idEmployee: null == idEmployee ? _self.idEmployee : idEmployee // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,finishTime: freezed == finishTime ? _self.finishTime : finishTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeTrackModel].
extension TimeTrackModelPatterns on TimeTrackModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeTrackModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeTrackModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeTrackModel value)  $default,){
final _that = this;
switch (_that) {
case _TimeTrackModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeTrackModel value)?  $default,){
final _that = this;
switch (_that) {
case _TimeTrackModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int idEmployee,  DateTime startTime,  DateTime? finishTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeTrackModel() when $default != null:
return $default(_that.id,_that.idEmployee,_that.startTime,_that.finishTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int idEmployee,  DateTime startTime,  DateTime? finishTime)  $default,) {final _that = this;
switch (_that) {
case _TimeTrackModel():
return $default(_that.id,_that.idEmployee,_that.startTime,_that.finishTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int idEmployee,  DateTime startTime,  DateTime? finishTime)?  $default,) {final _that = this;
switch (_that) {
case _TimeTrackModel() when $default != null:
return $default(_that.id,_that.idEmployee,_that.startTime,_that.finishTime);case _:
  return null;

}
}

}

/// @nodoc


class _TimeTrackModel extends TimeTrackModel {
  const _TimeTrackModel({this.id, required this.idEmployee, required this.startTime, this.finishTime}): super._();
  

@override final  int? id;
@override final  int idEmployee;
@override final  DateTime startTime;
@override final  DateTime? finishTime;

/// Create a copy of TimeTrackModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeTrackModelCopyWith<_TimeTrackModel> get copyWith => __$TimeTrackModelCopyWithImpl<_TimeTrackModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeTrackModel&&(identical(other.id, id) || other.id == id)&&(identical(other.idEmployee, idEmployee) || other.idEmployee == idEmployee)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.finishTime, finishTime) || other.finishTime == finishTime));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,idEmployee,startTime,finishTime);
}

@override
String toString() {
    return 'TimeTrackModel(id: $id, idEmployee: $idEmployee, startTime: $startTime, finishTime: $finishTime)';
}


}

/// @nodoc
abstract mixin class _$TimeTrackModelCopyWith<$Res> implements $TimeTrackModelCopyWith<$Res> {
  factory _$TimeTrackModelCopyWith(_TimeTrackModel value, $Res Function(_TimeTrackModel) _then) = __$TimeTrackModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, int idEmployee, DateTime startTime, DateTime? finishTime
});




}
/// @nodoc
class __$TimeTrackModelCopyWithImpl<$Res>
    implements _$TimeTrackModelCopyWith<$Res> {
  __$TimeTrackModelCopyWithImpl(this._self, this._then);

  final _TimeTrackModel _self;
  final $Res Function(_TimeTrackModel) _then;

/// Create a copy of TimeTrackModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? idEmployee = null,Object? startTime = null,Object? finishTime = freezed,}) {
  return _then(_TimeTrackModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,idEmployee: null == idEmployee ? _self.idEmployee : idEmployee // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,finishTime: freezed == finishTime ? _self.finishTime : finishTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
