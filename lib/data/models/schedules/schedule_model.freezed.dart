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

 int? get id; bool get isSplitShift; DateTime get startFirstTurnTime; DateTime get finishFirstTurnTime; DateTime? get startSecondTurnTime; DateTime? get finishSecondTurnTime; List<String> get weekdays;@JsonKey(includeFromJson: false, includeToJson: false) List<EmployeeSelectionData> get employeeWeekAssignments; Color get color;
/// Create a copy of ScheduleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleModelCopyWith<ScheduleModel> get copyWith => _$ScheduleModelCopyWithImpl<ScheduleModel>(this as ScheduleModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ScheduleModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.isSplitShift, _this.isSplitShift) || other.isSplitShift == _this.isSplitShift)&&(identical(other.startFirstTurnTime, _this.startFirstTurnTime) || other.startFirstTurnTime == _this.startFirstTurnTime)&&(identical(other.finishFirstTurnTime, _this.finishFirstTurnTime) || other.finishFirstTurnTime == _this.finishFirstTurnTime)&&(identical(other.startSecondTurnTime, _this.startSecondTurnTime) || other.startSecondTurnTime == _this.startSecondTurnTime)&&(identical(other.finishSecondTurnTime, _this.finishSecondTurnTime) || other.finishSecondTurnTime == _this.finishSecondTurnTime)&&const DeepCollectionEquality().equals(other.weekdays, _this.weekdays)&&const DeepCollectionEquality().equals(other.employeeWeekAssignments, _this.employeeWeekAssignments)&&(identical(other.color, _this.color) || other.color == _this.color));
}


@override
int get hashCode {
  final _this = this as ScheduleModel;
  return Object.hash(runtimeType,_this.id,_this.isSplitShift,_this.startFirstTurnTime,_this.finishFirstTurnTime,_this.startSecondTurnTime,_this.finishSecondTurnTime,const DeepCollectionEquality().hash(_this.weekdays),const DeepCollectionEquality().hash(_this.employeeWeekAssignments),_this.color);
}

@override
String toString() {
  final _this = this as ScheduleModel;
  return 'ScheduleModel(id: ${_this.id}, isSplitShift: ${_this.isSplitShift}, startFirstTurnTime: ${_this.startFirstTurnTime}, finishFirstTurnTime: ${_this.finishFirstTurnTime}, startSecondTurnTime: ${_this.startSecondTurnTime}, finishSecondTurnTime: ${_this.finishSecondTurnTime}, weekdays: ${_this.weekdays}, employeeWeekAssignments: ${_this.employeeWeekAssignments}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $ScheduleModelCopyWith<$Res>  {
  factory $ScheduleModelCopyWith(ScheduleModel value, $Res Function(ScheduleModel) _then) = _$ScheduleModelCopyWithImpl;
@useResult
$Res call({
 int? id, bool isSplitShift, DateTime startFirstTurnTime, DateTime finishFirstTurnTime, DateTime? startSecondTurnTime, DateTime? finishSecondTurnTime, List<String> weekdays,@JsonKey(includeFromJson: false, includeToJson: false) List<EmployeeSelectionData> employeeWeekAssignments, Color color
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? isSplitShift = null,Object? startFirstTurnTime = null,Object? finishFirstTurnTime = null,Object? startSecondTurnTime = freezed,Object? finishSecondTurnTime = freezed,Object? weekdays = null,Object? employeeWeekAssignments = null,Object? color = null,}) {
  return _then(ScheduleModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,isSplitShift: null == isSplitShift ? _self.isSplitShift : isSplitShift // ignore: cast_nullable_to_non_nullable
as bool,startFirstTurnTime: null == startFirstTurnTime ? _self.startFirstTurnTime : startFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,finishFirstTurnTime: null == finishFirstTurnTime ? _self.finishFirstTurnTime : finishFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,startSecondTurnTime: freezed == startSecondTurnTime ? _self.startSecondTurnTime : startSecondTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime?,finishSecondTurnTime: freezed == finishSecondTurnTime ? _self.finishSecondTurnTime : finishSecondTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime?,weekdays: null == weekdays ? _self.weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<String>,employeeWeekAssignments: null == employeeWeekAssignments ? _self.employeeWeekAssignments : employeeWeekAssignments // ignore: cast_nullable_to_non_nullable
as List<EmployeeSelectionData>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  bool isSplitShift,  DateTime startFirstTurnTime,  DateTime finishFirstTurnTime,  DateTime? startSecondTurnTime,  DateTime? finishSecondTurnTime,  List<String> weekdays, @JsonKey(includeFromJson: false, includeToJson: false)  List<EmployeeSelectionData> employeeWeekAssignments,  Color color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleModel() when $default != null:
return $default(_that.id,_that.isSplitShift,_that.startFirstTurnTime,_that.finishFirstTurnTime,_that.startSecondTurnTime,_that.finishSecondTurnTime,_that.weekdays,_that.employeeWeekAssignments,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  bool isSplitShift,  DateTime startFirstTurnTime,  DateTime finishFirstTurnTime,  DateTime? startSecondTurnTime,  DateTime? finishSecondTurnTime,  List<String> weekdays, @JsonKey(includeFromJson: false, includeToJson: false)  List<EmployeeSelectionData> employeeWeekAssignments,  Color color)  $default,) {final _that = this;
switch (_that) {
case _ScheduleModel():
return $default(_that.id,_that.isSplitShift,_that.startFirstTurnTime,_that.finishFirstTurnTime,_that.startSecondTurnTime,_that.finishSecondTurnTime,_that.weekdays,_that.employeeWeekAssignments,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  bool isSplitShift,  DateTime startFirstTurnTime,  DateTime finishFirstTurnTime,  DateTime? startSecondTurnTime,  DateTime? finishSecondTurnTime,  List<String> weekdays, @JsonKey(includeFromJson: false, includeToJson: false)  List<EmployeeSelectionData> employeeWeekAssignments,  Color color)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleModel() when $default != null:
return $default(_that.id,_that.isSplitShift,_that.startFirstTurnTime,_that.finishFirstTurnTime,_that.startSecondTurnTime,_that.finishSecondTurnTime,_that.weekdays,_that.employeeWeekAssignments,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleModel extends ScheduleModel {
  const _ScheduleModel({this.id, this.isSplitShift = false, required this.startFirstTurnTime, required this.finishFirstTurnTime, this.startSecondTurnTime, this.finishSecondTurnTime, required  List<String> weekdays, @JsonKey(includeFromJson: false, includeToJson: false)  List<EmployeeSelectionData> employeeWeekAssignments = const [], this.color = const Color(0xFFFF9000)}): _weekdays = weekdays,_employeeWeekAssignments = employeeWeekAssignments,super._();
  

@override final  int? id;
@override@JsonKey() final  bool isSplitShift;
@override final  DateTime startFirstTurnTime;
@override final  DateTime finishFirstTurnTime;
@override final  DateTime? startSecondTurnTime;
@override final  DateTime? finishSecondTurnTime;
 final  List<String> _weekdays;
@override List<String> get weekdays {
  if (_weekdays is EqualUnmodifiableListView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekdays);
}

 final  List<EmployeeSelectionData> _employeeWeekAssignments;
@override@JsonKey(includeFromJson: false, includeToJson: false) List<EmployeeSelectionData> get employeeWeekAssignments {
  if (_employeeWeekAssignments is EqualUnmodifiableListView) return _employeeWeekAssignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_employeeWeekAssignments);
}

@override@JsonKey() final  Color color;

/// Create a copy of ScheduleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleModelCopyWith<_ScheduleModel> get copyWith => __$ScheduleModelCopyWithImpl<_ScheduleModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.isSplitShift, isSplitShift) || other.isSplitShift == isSplitShift)&&(identical(other.startFirstTurnTime, startFirstTurnTime) || other.startFirstTurnTime == startFirstTurnTime)&&(identical(other.finishFirstTurnTime, finishFirstTurnTime) || other.finishFirstTurnTime == finishFirstTurnTime)&&(identical(other.startSecondTurnTime, startSecondTurnTime) || other.startSecondTurnTime == startSecondTurnTime)&&(identical(other.finishSecondTurnTime, finishSecondTurnTime) || other.finishSecondTurnTime == finishSecondTurnTime)&&const DeepCollectionEquality().equals(other.weekdays, _weekdays)&&const DeepCollectionEquality().equals(other.employeeWeekAssignments, _employeeWeekAssignments)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,isSplitShift,startFirstTurnTime,finishFirstTurnTime,startSecondTurnTime,finishSecondTurnTime,const DeepCollectionEquality().hash(_weekdays),const DeepCollectionEquality().hash(_employeeWeekAssignments),color);
}

@override
String toString() {
    return 'ScheduleModel(id: $id, isSplitShift: $isSplitShift, startFirstTurnTime: $startFirstTurnTime, finishFirstTurnTime: $finishFirstTurnTime, startSecondTurnTime: $startSecondTurnTime, finishSecondTurnTime: $finishSecondTurnTime, weekdays: $weekdays, employeeWeekAssignments: $employeeWeekAssignments, color: $color)';
}


}

/// @nodoc
abstract mixin class _$ScheduleModelCopyWith<$Res> implements $ScheduleModelCopyWith<$Res> {
  factory _$ScheduleModelCopyWith(_ScheduleModel value, $Res Function(_ScheduleModel) _then) = __$ScheduleModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, bool isSplitShift, DateTime startFirstTurnTime, DateTime finishFirstTurnTime, DateTime? startSecondTurnTime, DateTime? finishSecondTurnTime, List<String> weekdays,@JsonKey(includeFromJson: false, includeToJson: false) List<EmployeeSelectionData> employeeWeekAssignments, Color color
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? isSplitShift = null,Object? startFirstTurnTime = null,Object? finishFirstTurnTime = null,Object? startSecondTurnTime = freezed,Object? finishSecondTurnTime = freezed,Object? weekdays = null,Object? employeeWeekAssignments = null,Object? color = null,}) {
  return _then(_ScheduleModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,isSplitShift: null == isSplitShift ? _self.isSplitShift : isSplitShift // ignore: cast_nullable_to_non_nullable
as bool,startFirstTurnTime: null == startFirstTurnTime ? _self.startFirstTurnTime : startFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,finishFirstTurnTime: null == finishFirstTurnTime ? _self.finishFirstTurnTime : finishFirstTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime,startSecondTurnTime: freezed == startSecondTurnTime ? _self.startSecondTurnTime : startSecondTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime?,finishSecondTurnTime: freezed == finishSecondTurnTime ? _self.finishSecondTurnTime : finishSecondTurnTime // ignore: cast_nullable_to_non_nullable
as DateTime?,weekdays: null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as List<String>,employeeWeekAssignments: null == employeeWeekAssignments ? _self._employeeWeekAssignments : employeeWeekAssignments // ignore: cast_nullable_to_non_nullable
as List<EmployeeSelectionData>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
