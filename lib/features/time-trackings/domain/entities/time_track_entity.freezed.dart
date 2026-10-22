// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_track_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimeTrackEntity {

 int? get id; int get idEmployee; DateTime? get startTime; DateTime? get finishTime; DateTime? get registeredDate; int? get difference;@JsonKey(includeToJson: false, includeFromJson: false) bool? get isTurnOnGoing;
/// Create a copy of TimeTrackEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeTrackEntityCopyWith<TimeTrackEntity> get copyWith => _$TimeTrackEntityCopyWithImpl<TimeTrackEntity>(this as TimeTrackEntity, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TimeTrackEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeTrackEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.idEmployee, _this.idEmployee) || other.idEmployee == _this.idEmployee)&&(identical(other.startTime, _this.startTime) || other.startTime == _this.startTime)&&(identical(other.finishTime, _this.finishTime) || other.finishTime == _this.finishTime)&&(identical(other.registeredDate, _this.registeredDate) || other.registeredDate == _this.registeredDate)&&(identical(other.difference, _this.difference) || other.difference == _this.difference)&&(identical(other.isTurnOnGoing, _this.isTurnOnGoing) || other.isTurnOnGoing == _this.isTurnOnGoing));
}


@override
int get hashCode {
  final _this = this as TimeTrackEntity;
  return Object.hash(runtimeType,_this.id,_this.idEmployee,_this.startTime,_this.finishTime,_this.registeredDate,_this.difference,_this.isTurnOnGoing);
}

@override
String toString() {
  final _this = this as TimeTrackEntity;
  return 'TimeTrackEntity(id: ${_this.id}, idEmployee: ${_this.idEmployee}, startTime: ${_this.startTime}, finishTime: ${_this.finishTime}, registeredDate: ${_this.registeredDate}, difference: ${_this.difference}, isTurnOnGoing: ${_this.isTurnOnGoing})';
}


}

/// @nodoc
abstract mixin class $TimeTrackEntityCopyWith<$Res>  {
  factory $TimeTrackEntityCopyWith(TimeTrackEntity value, $Res Function(TimeTrackEntity) _then) = _$TimeTrackEntityCopyWithImpl;
@useResult
$Res call({
 int? id, int idEmployee, DateTime? startTime, DateTime? finishTime, DateTime? registeredDate, int? difference,@JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing
});




}
/// @nodoc
class _$TimeTrackEntityCopyWithImpl<$Res>
    implements $TimeTrackEntityCopyWith<$Res> {
  _$TimeTrackEntityCopyWithImpl(this._self, this._then);

  final TimeTrackEntity _self;
  final $Res Function(TimeTrackEntity) _then;

/// Create a copy of TimeTrackEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? idEmployee = null,Object? startTime = freezed,Object? finishTime = freezed,Object? registeredDate = freezed,Object? difference = freezed,Object? isTurnOnGoing = freezed,}) {
  return _then(TimeTrackEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,idEmployee: null == idEmployee ? _self.idEmployee : idEmployee // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,finishTime: freezed == finishTime ? _self.finishTime : finishTime // ignore: cast_nullable_to_non_nullable
as DateTime?,registeredDate: freezed == registeredDate ? _self.registeredDate : registeredDate // ignore: cast_nullable_to_non_nullable
as DateTime?,difference: freezed == difference ? _self.difference : difference // ignore: cast_nullable_to_non_nullable
as int?,isTurnOnGoing: freezed == isTurnOnGoing ? _self.isTurnOnGoing : isTurnOnGoing // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeTrackEntity].
extension TimeTrackEntityPatterns on TimeTrackEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeTrackEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeTrackEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeTrackEntity value)  $default,){
final _that = this;
switch (_that) {
case _TimeTrackEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeTrackEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TimeTrackEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int idEmployee,  DateTime? startTime,  DateTime? finishTime,  DateTime? registeredDate,  int? difference, @JsonKey(includeToJson: false, includeFromJson: false)  bool? isTurnOnGoing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeTrackEntity() when $default != null:
return $default(_that.id,_that.idEmployee,_that.startTime,_that.finishTime,_that.registeredDate,_that.difference,_that.isTurnOnGoing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int idEmployee,  DateTime? startTime,  DateTime? finishTime,  DateTime? registeredDate,  int? difference, @JsonKey(includeToJson: false, includeFromJson: false)  bool? isTurnOnGoing)  $default,) {final _that = this;
switch (_that) {
case _TimeTrackEntity():
return $default(_that.id,_that.idEmployee,_that.startTime,_that.finishTime,_that.registeredDate,_that.difference,_that.isTurnOnGoing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int idEmployee,  DateTime? startTime,  DateTime? finishTime,  DateTime? registeredDate,  int? difference, @JsonKey(includeToJson: false, includeFromJson: false)  bool? isTurnOnGoing)?  $default,) {final _that = this;
switch (_that) {
case _TimeTrackEntity() when $default != null:
return $default(_that.id,_that.idEmployee,_that.startTime,_that.finishTime,_that.registeredDate,_that.difference,_that.isTurnOnGoing);case _:
  return null;

}
}

}

/// @nodoc


class _TimeTrackEntity extends TimeTrackEntity {
  const _TimeTrackEntity({this.id, required this.idEmployee, this.startTime, this.finishTime, this.registeredDate, this.difference, @JsonKey(includeToJson: false, includeFromJson: false) this.isTurnOnGoing}): super._();
  

@override final  int? id;
@override final  int idEmployee;
@override final  DateTime? startTime;
@override final  DateTime? finishTime;
@override final  DateTime? registeredDate;
@override final  int? difference;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  bool? isTurnOnGoing;

/// Create a copy of TimeTrackEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeTrackEntityCopyWith<_TimeTrackEntity> get copyWith => __$TimeTrackEntityCopyWithImpl<_TimeTrackEntity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeTrackEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.idEmployee, idEmployee) || other.idEmployee == idEmployee)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.finishTime, finishTime) || other.finishTime == finishTime)&&(identical(other.registeredDate, registeredDate) || other.registeredDate == registeredDate)&&(identical(other.difference, difference) || other.difference == difference)&&(identical(other.isTurnOnGoing, isTurnOnGoing) || other.isTurnOnGoing == isTurnOnGoing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,idEmployee,startTime,finishTime,registeredDate,difference,isTurnOnGoing);
}

@override
String toString() {
    return 'TimeTrackEntity(id: $id, idEmployee: $idEmployee, startTime: $startTime, finishTime: $finishTime, registeredDate: $registeredDate, difference: $difference, isTurnOnGoing: $isTurnOnGoing)';
}


}

/// @nodoc
abstract mixin class _$TimeTrackEntityCopyWith<$Res> implements $TimeTrackEntityCopyWith<$Res> {
  factory _$TimeTrackEntityCopyWith(_TimeTrackEntity value, $Res Function(_TimeTrackEntity) _then) = __$TimeTrackEntityCopyWithImpl;
@override @useResult
$Res call({
 int? id, int idEmployee, DateTime? startTime, DateTime? finishTime, DateTime? registeredDate, int? difference,@JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing
});




}
/// @nodoc
class __$TimeTrackEntityCopyWithImpl<$Res>
    implements _$TimeTrackEntityCopyWith<$Res> {
  __$TimeTrackEntityCopyWithImpl(this._self, this._then);

  final _TimeTrackEntity _self;
  final $Res Function(_TimeTrackEntity) _then;

/// Create a copy of TimeTrackEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? idEmployee = null,Object? startTime = freezed,Object? finishTime = freezed,Object? registeredDate = freezed,Object? difference = freezed,Object? isTurnOnGoing = freezed,}) {
  return _then(_TimeTrackEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,idEmployee: null == idEmployee ? _self.idEmployee : idEmployee // ignore: cast_nullable_to_non_nullable
as int,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,finishTime: freezed == finishTime ? _self.finishTime : finishTime // ignore: cast_nullable_to_non_nullable
as DateTime?,registeredDate: freezed == registeredDate ? _self.registeredDate : registeredDate // ignore: cast_nullable_to_non_nullable
as DateTime?,difference: freezed == difference ? _self.difference : difference // ignore: cast_nullable_to_non_nullable
as int?,isTurnOnGoing: freezed == isTurnOnGoing ? _self.isTurnOnGoing : isTurnOnGoing // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
