// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmployeeModel {

 int? get id; String get name; bool get hasContract; int get hoursInContract; List<ScheduleModel>? get schedules;@JsonKey(includeToJson: false, includeFromJson: false) TimeTrackModel? get currentTimeTrack;
/// Create a copy of EmployeeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeModelCopyWith<EmployeeModel> get copyWith => _$EmployeeModelCopyWithImpl<EmployeeModel>(this as EmployeeModel, _$identity);





@override
String toString() {
  final _this = this as EmployeeModel;
  return 'EmployeeModel(id: ${_this.id}, name: ${_this.name}, hasContract: ${_this.hasContract}, hoursInContract: ${_this.hoursInContract}, schedules: ${_this.schedules}, currentTimeTrack: ${_this.currentTimeTrack})';
}


}

/// @nodoc
abstract mixin class $EmployeeModelCopyWith<$Res>  {
  factory $EmployeeModelCopyWith(EmployeeModel value, $Res Function(EmployeeModel) _then) = _$EmployeeModelCopyWithImpl;
@useResult
$Res call({
 int? id, String name, bool hasContract, int hoursInContract, List<ScheduleModel>? schedules,@JsonKey(includeToJson: false, includeFromJson: false) TimeTrackModel? currentTimeTrack
});


$TimeTrackModelCopyWith<$Res>? get currentTimeTrack;

}
/// @nodoc
class _$EmployeeModelCopyWithImpl<$Res>
    implements $EmployeeModelCopyWith<$Res> {
  _$EmployeeModelCopyWithImpl(this._self, this._then);

  final EmployeeModel _self;
  final $Res Function(EmployeeModel) _then;

/// Create a copy of EmployeeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? hasContract = null,Object? hoursInContract = null,Object? schedules = freezed,Object? currentTimeTrack = freezed,}) {
  return _then(EmployeeModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasContract: null == hasContract ? _self.hasContract : hasContract // ignore: cast_nullable_to_non_nullable
as bool,hoursInContract: null == hoursInContract ? _self.hoursInContract : hoursInContract // ignore: cast_nullable_to_non_nullable
as int,schedules: freezed == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<ScheduleModel>?,currentTimeTrack: freezed == currentTimeTrack ? _self.currentTimeTrack : currentTimeTrack // ignore: cast_nullable_to_non_nullable
as TimeTrackModel?,
  ));
}
/// Create a copy of EmployeeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeTrackModelCopyWith<$Res>? get currentTimeTrack {
    if (_self.currentTimeTrack == null) {
    return null;
  }

  return $TimeTrackModelCopyWith<$Res>(_self.currentTimeTrack!, (value) {
    return _then(_self.copyWith(currentTimeTrack: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmployeeModel].
extension EmployeeModelPatterns on EmployeeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeModel value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String name,  bool hasContract,  int hoursInContract,  List<ScheduleModel>? schedules, @JsonKey(includeToJson: false, includeFromJson: false)  TimeTrackModel? currentTimeTrack)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeModel() when $default != null:
return $default(_that.id,_that.name,_that.hasContract,_that.hoursInContract,_that.schedules,_that.currentTimeTrack);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String name,  bool hasContract,  int hoursInContract,  List<ScheduleModel>? schedules, @JsonKey(includeToJson: false, includeFromJson: false)  TimeTrackModel? currentTimeTrack)  $default,) {final _that = this;
switch (_that) {
case _EmployeeModel():
return $default(_that.id,_that.name,_that.hasContract,_that.hoursInContract,_that.schedules,_that.currentTimeTrack);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String name,  bool hasContract,  int hoursInContract,  List<ScheduleModel>? schedules, @JsonKey(includeToJson: false, includeFromJson: false)  TimeTrackModel? currentTimeTrack)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeModel() when $default != null:
return $default(_that.id,_that.name,_that.hasContract,_that.hoursInContract,_that.schedules,_that.currentTimeTrack);case _:
  return null;

}
}

}

/// @nodoc


class _EmployeeModel extends EmployeeModel {
  const _EmployeeModel({this.id, required this.name, this.hasContract = false, this.hoursInContract = 0,  List<ScheduleModel>? schedules, @JsonKey(includeToJson: false, includeFromJson: false) this.currentTimeTrack}): _schedules = schedules,super._();
  

@override final  int? id;
@override final  String name;
@override@JsonKey() final  bool hasContract;
@override@JsonKey() final  int hoursInContract;
 final  List<ScheduleModel>? _schedules;
@override List<ScheduleModel>? get schedules {
  final value = _schedules;
  if (value == null) return null;
  if (_schedules is EqualUnmodifiableListView) return _schedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeToJson: false, includeFromJson: false) final  TimeTrackModel? currentTimeTrack;

/// Create a copy of EmployeeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeModelCopyWith<_EmployeeModel> get copyWith => __$EmployeeModelCopyWithImpl<_EmployeeModel>(this, _$identity);





@override
String toString() {
    return 'EmployeeModel(id: $id, name: $name, hasContract: $hasContract, hoursInContract: $hoursInContract, schedules: $schedules, currentTimeTrack: $currentTimeTrack)';
}


}

/// @nodoc
abstract mixin class _$EmployeeModelCopyWith<$Res> implements $EmployeeModelCopyWith<$Res> {
  factory _$EmployeeModelCopyWith(_EmployeeModel value, $Res Function(_EmployeeModel) _then) = __$EmployeeModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, bool hasContract, int hoursInContract, List<ScheduleModel>? schedules,@JsonKey(includeToJson: false, includeFromJson: false) TimeTrackModel? currentTimeTrack
});


@override $TimeTrackModelCopyWith<$Res>? get currentTimeTrack;

}
/// @nodoc
class __$EmployeeModelCopyWithImpl<$Res>
    implements _$EmployeeModelCopyWith<$Res> {
  __$EmployeeModelCopyWithImpl(this._self, this._then);

  final _EmployeeModel _self;
  final $Res Function(_EmployeeModel) _then;

/// Create a copy of EmployeeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? hasContract = null,Object? hoursInContract = null,Object? schedules = freezed,Object? currentTimeTrack = freezed,}) {
  return _then(_EmployeeModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hasContract: null == hasContract ? _self.hasContract : hasContract // ignore: cast_nullable_to_non_nullable
as bool,hoursInContract: null == hoursInContract ? _self.hoursInContract : hoursInContract // ignore: cast_nullable_to_non_nullable
as int,schedules: freezed == schedules ? _self._schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<ScheduleModel>?,currentTimeTrack: freezed == currentTimeTrack ? _self.currentTimeTrack : currentTimeTrack // ignore: cast_nullable_to_non_nullable
as TimeTrackModel?,
  ));
}

/// Create a copy of EmployeeModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TimeTrackModelCopyWith<$Res>? get currentTimeTrack {
    if (_self.currentTimeTrack == null) {
    return null;
  }

  return $TimeTrackModelCopyWith<$Res>(_self.currentTimeTrack!, (value) {
    return _then(_self.copyWith(currentTimeTrack: value));
  });
}
}

// dart format on
