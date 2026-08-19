// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) {
  return _ScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleModel {
  int? get id => throw _privateConstructorUsedError;
  bool get isSplitShift => throw _privateConstructorUsedError;
  DateTime get startFirstTurnTime => throw _privateConstructorUsedError;
  DateTime get finishFirstTurnTime => throw _privateConstructorUsedError;
  DateTime? get startSecondTurnTime => throw _privateConstructorUsedError;
  DateTime? get finishSecondTurnTime => throw _privateConstructorUsedError;

  /// Serializes this ScheduleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleModelCopyWith<ScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleModelCopyWith<$Res> {
  factory $ScheduleModelCopyWith(
    ScheduleModel value,
    $Res Function(ScheduleModel) then,
  ) = _$ScheduleModelCopyWithImpl<$Res, ScheduleModel>;
  @useResult
  $Res call({
    int? id,
    bool isSplitShift,
    DateTime startFirstTurnTime,
    DateTime finishFirstTurnTime,
    DateTime? startSecondTurnTime,
    DateTime? finishSecondTurnTime,
  });
}

/// @nodoc
class _$ScheduleModelCopyWithImpl<$Res, $Val extends ScheduleModel>
    implements $ScheduleModelCopyWith<$Res> {
  _$ScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isSplitShift = null,
    Object? startFirstTurnTime = null,
    Object? finishFirstTurnTime = null,
    Object? startSecondTurnTime = freezed,
    Object? finishSecondTurnTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            isSplitShift: null == isSplitShift
                ? _value.isSplitShift
                : isSplitShift // ignore: cast_nullable_to_non_nullable
                      as bool,
            startFirstTurnTime: null == startFirstTurnTime
                ? _value.startFirstTurnTime
                : startFirstTurnTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            finishFirstTurnTime: null == finishFirstTurnTime
                ? _value.finishFirstTurnTime
                : finishFirstTurnTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            startSecondTurnTime: freezed == startSecondTurnTime
                ? _value.startSecondTurnTime
                : startSecondTurnTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            finishSecondTurnTime: freezed == finishSecondTurnTime
                ? _value.finishSecondTurnTime
                : finishSecondTurnTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleModelImplCopyWith<$Res>
    implements $ScheduleModelCopyWith<$Res> {
  factory _$$ScheduleModelImplCopyWith(
    _$ScheduleModelImpl value,
    $Res Function(_$ScheduleModelImpl) then,
  ) = __$$ScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    bool isSplitShift,
    DateTime startFirstTurnTime,
    DateTime finishFirstTurnTime,
    DateTime? startSecondTurnTime,
    DateTime? finishSecondTurnTime,
  });
}

/// @nodoc
class __$$ScheduleModelImplCopyWithImpl<$Res>
    extends _$ScheduleModelCopyWithImpl<$Res, _$ScheduleModelImpl>
    implements _$$ScheduleModelImplCopyWith<$Res> {
  __$$ScheduleModelImplCopyWithImpl(
    _$ScheduleModelImpl _value,
    $Res Function(_$ScheduleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? isSplitShift = null,
    Object? startFirstTurnTime = null,
    Object? finishFirstTurnTime = null,
    Object? startSecondTurnTime = freezed,
    Object? finishSecondTurnTime = freezed,
  }) {
    return _then(
      _$ScheduleModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        isSplitShift: null == isSplitShift
            ? _value.isSplitShift
            : isSplitShift // ignore: cast_nullable_to_non_nullable
                  as bool,
        startFirstTurnTime: null == startFirstTurnTime
            ? _value.startFirstTurnTime
            : startFirstTurnTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        finishFirstTurnTime: null == finishFirstTurnTime
            ? _value.finishFirstTurnTime
            : finishFirstTurnTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        startSecondTurnTime: freezed == startSecondTurnTime
            ? _value.startSecondTurnTime
            : startSecondTurnTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        finishSecondTurnTime: freezed == finishSecondTurnTime
            ? _value.finishSecondTurnTime
            : finishSecondTurnTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleModelImpl extends _ScheduleModel {
  const _$ScheduleModelImpl({
    this.id,
    this.isSplitShift = false,
    required this.startFirstTurnTime,
    required this.finishFirstTurnTime,
    this.startSecondTurnTime,
    this.finishSecondTurnTime,
  }) : super._();

  factory _$ScheduleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey()
  final bool isSplitShift;
  @override
  final DateTime startFirstTurnTime;
  @override
  final DateTime finishFirstTurnTime;
  @override
  final DateTime? startSecondTurnTime;
  @override
  final DateTime? finishSecondTurnTime;

  @override
  String toString() {
    return 'ScheduleModel(id: $id, isSplitShift: $isSplitShift, startFirstTurnTime: $startFirstTurnTime, finishFirstTurnTime: $finishFirstTurnTime, startSecondTurnTime: $startSecondTurnTime, finishSecondTurnTime: $finishSecondTurnTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isSplitShift, isSplitShift) ||
                other.isSplitShift == isSplitShift) &&
            (identical(other.startFirstTurnTime, startFirstTurnTime) ||
                other.startFirstTurnTime == startFirstTurnTime) &&
            (identical(other.finishFirstTurnTime, finishFirstTurnTime) ||
                other.finishFirstTurnTime == finishFirstTurnTime) &&
            (identical(other.startSecondTurnTime, startSecondTurnTime) ||
                other.startSecondTurnTime == startSecondTurnTime) &&
            (identical(other.finishSecondTurnTime, finishSecondTurnTime) ||
                other.finishSecondTurnTime == finishSecondTurnTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    isSplitShift,
    startFirstTurnTime,
    finishFirstTurnTime,
    startSecondTurnTime,
    finishSecondTurnTime,
  );

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleModelImplCopyWith<_$ScheduleModelImpl> get copyWith =>
      __$$ScheduleModelImplCopyWithImpl<_$ScheduleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleModelImplToJson(this);
  }
}

abstract class _ScheduleModel extends ScheduleModel {
  const factory _ScheduleModel({
    final int? id,
    final bool isSplitShift,
    required final DateTime startFirstTurnTime,
    required final DateTime finishFirstTurnTime,
    final DateTime? startSecondTurnTime,
    final DateTime? finishSecondTurnTime,
  }) = _$ScheduleModelImpl;
  const _ScheduleModel._() : super._();

  factory _ScheduleModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleModelImpl.fromJson;

  @override
  int? get id;
  @override
  bool get isSplitShift;
  @override
  DateTime get startFirstTurnTime;
  @override
  DateTime get finishFirstTurnTime;
  @override
  DateTime? get startSecondTurnTime;
  @override
  DateTime? get finishSecondTurnTime;

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleModelImplCopyWith<_$ScheduleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
