// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_time_track_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmployeeTimeTrackModel _$EmployeeTimeTrackModelFromJson(
  Map<String, dynamic> json,
) {
  return _EmployeeTimeTrackModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeTimeTrackModel {
  int? get id => throw _privateConstructorUsedError;
  int get employee_id => throw _privateConstructorUsedError;
  DateTime? get start_time => throw _privateConstructorUsedError;
  DateTime? get finish_time => throw _privateConstructorUsedError;
  DateTime? get registered_date => throw _privateConstructorUsedError;
  int? get difference => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? get isTurnOnGoing => throw _privateConstructorUsedError;

  /// Serializes this EmployeeTimeTrackModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeTimeTrackModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeTimeTrackModelCopyWith<EmployeeTimeTrackModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeTimeTrackModelCopyWith<$Res> {
  factory $EmployeeTimeTrackModelCopyWith(
    EmployeeTimeTrackModel value,
    $Res Function(EmployeeTimeTrackModel) then,
  ) = _$EmployeeTimeTrackModelCopyWithImpl<$Res, EmployeeTimeTrackModel>;
  @useResult
  $Res call({
    int? id,
    int employee_id,
    DateTime? start_time,
    DateTime? finish_time,
    DateTime? registered_date,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  });
}

/// @nodoc
class _$EmployeeTimeTrackModelCopyWithImpl<
  $Res,
  $Val extends EmployeeTimeTrackModel
>
    implements $EmployeeTimeTrackModelCopyWith<$Res> {
  _$EmployeeTimeTrackModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeTimeTrackModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? employee_id = null,
    Object? start_time = freezed,
    Object? finish_time = freezed,
    Object? registered_date = freezed,
    Object? difference = freezed,
    Object? isTurnOnGoing = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            employee_id: null == employee_id
                ? _value.employee_id
                : employee_id // ignore: cast_nullable_to_non_nullable
                      as int,
            start_time: freezed == start_time
                ? _value.start_time
                : start_time // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            finish_time: freezed == finish_time
                ? _value.finish_time
                : finish_time // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            registered_date: freezed == registered_date
                ? _value.registered_date
                : registered_date // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            difference: freezed == difference
                ? _value.difference
                : difference // ignore: cast_nullable_to_non_nullable
                      as int?,
            isTurnOnGoing: freezed == isTurnOnGoing
                ? _value.isTurnOnGoing
                : isTurnOnGoing // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmployeeTimeTrackModelImplCopyWith<$Res>
    implements $EmployeeTimeTrackModelCopyWith<$Res> {
  factory _$$EmployeeTimeTrackModelImplCopyWith(
    _$EmployeeTimeTrackModelImpl value,
    $Res Function(_$EmployeeTimeTrackModelImpl) then,
  ) = __$$EmployeeTimeTrackModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    int employee_id,
    DateTime? start_time,
    DateTime? finish_time,
    DateTime? registered_date,
    int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false) bool? isTurnOnGoing,
  });
}

/// @nodoc
class __$$EmployeeTimeTrackModelImplCopyWithImpl<$Res>
    extends
        _$EmployeeTimeTrackModelCopyWithImpl<$Res, _$EmployeeTimeTrackModelImpl>
    implements _$$EmployeeTimeTrackModelImplCopyWith<$Res> {
  __$$EmployeeTimeTrackModelImplCopyWithImpl(
    _$EmployeeTimeTrackModelImpl _value,
    $Res Function(_$EmployeeTimeTrackModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeTimeTrackModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? employee_id = null,
    Object? start_time = freezed,
    Object? finish_time = freezed,
    Object? registered_date = freezed,
    Object? difference = freezed,
    Object? isTurnOnGoing = freezed,
  }) {
    return _then(
      _$EmployeeTimeTrackModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        employee_id: null == employee_id
            ? _value.employee_id
            : employee_id // ignore: cast_nullable_to_non_nullable
                  as int,
        start_time: freezed == start_time
            ? _value.start_time
            : start_time // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        finish_time: freezed == finish_time
            ? _value.finish_time
            : finish_time // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        registered_date: freezed == registered_date
            ? _value.registered_date
            : registered_date // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        difference: freezed == difference
            ? _value.difference
            : difference // ignore: cast_nullable_to_non_nullable
                  as int?,
        isTurnOnGoing: freezed == isTurnOnGoing
            ? _value.isTurnOnGoing
            : isTurnOnGoing // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeTimeTrackModelImpl implements _EmployeeTimeTrackModel {
  const _$EmployeeTimeTrackModelImpl({
    this.id,
    required this.employee_id,
    this.start_time,
    this.finish_time,
    this.registered_date,
    this.difference,
    @JsonKey(includeToJson: false, includeFromJson: false) this.isTurnOnGoing,
  });

  factory _$EmployeeTimeTrackModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeTimeTrackModelImplFromJson(json);

  @override
  final int? id;
  @override
  final int employee_id;
  @override
  final DateTime? start_time;
  @override
  final DateTime? finish_time;
  @override
  final DateTime? registered_date;
  @override
  final int? difference;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final bool? isTurnOnGoing;

  @override
  String toString() {
    return 'EmployeeTimeTrackModel(id: $id, employee_id: $employee_id, start_time: $start_time, finish_time: $finish_time, registered_date: $registered_date, difference: $difference, isTurnOnGoing: $isTurnOnGoing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeTimeTrackModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employee_id, employee_id) ||
                other.employee_id == employee_id) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.finish_time, finish_time) ||
                other.finish_time == finish_time) &&
            (identical(other.registered_date, registered_date) ||
                other.registered_date == registered_date) &&
            (identical(other.difference, difference) ||
                other.difference == difference) &&
            (identical(other.isTurnOnGoing, isTurnOnGoing) ||
                other.isTurnOnGoing == isTurnOnGoing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    employee_id,
    start_time,
    finish_time,
    registered_date,
    difference,
    isTurnOnGoing,
  );

  /// Create a copy of EmployeeTimeTrackModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeTimeTrackModelImplCopyWith<_$EmployeeTimeTrackModelImpl>
  get copyWith =>
      __$$EmployeeTimeTrackModelImplCopyWithImpl<_$EmployeeTimeTrackModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeTimeTrackModelImplToJson(this);
  }
}

abstract class _EmployeeTimeTrackModel implements EmployeeTimeTrackModel {
  const factory _EmployeeTimeTrackModel({
    final int? id,
    required final int employee_id,
    final DateTime? start_time,
    final DateTime? finish_time,
    final DateTime? registered_date,
    final int? difference,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final bool? isTurnOnGoing,
  }) = _$EmployeeTimeTrackModelImpl;

  factory _EmployeeTimeTrackModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeTimeTrackModelImpl.fromJson;

  @override
  int? get id;
  @override
  int get employee_id;
  @override
  DateTime? get start_time;
  @override
  DateTime? get finish_time;
  @override
  DateTime? get registered_date;
  @override
  int? get difference;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool? get isTurnOnGoing;

  /// Create a copy of EmployeeTimeTrackModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeTimeTrackModelImplCopyWith<_$EmployeeTimeTrackModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
