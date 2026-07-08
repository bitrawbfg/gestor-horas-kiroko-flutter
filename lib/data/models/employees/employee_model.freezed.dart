// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) {
  return _EmployeeModel.fromJson(json);
}

/// @nodoc
mixin _$EmployeeModel {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  EmployeeTimeTrackModel? get timeTrack => throw _privateConstructorUsedError;

  /// Serializes this EmployeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmployeeModelCopyWith<EmployeeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeModelCopyWith<$Res> {
  factory $EmployeeModelCopyWith(
    EmployeeModel value,
    $Res Function(EmployeeModel) then,
  ) = _$EmployeeModelCopyWithImpl<$Res, EmployeeModel>;
  @useResult
  $Res call({
    int? id,
    String name,
    @JsonKey(includeToJson: false, includeFromJson: false)
    EmployeeTimeTrackModel? timeTrack,
  });

  $EmployeeTimeTrackModelCopyWith<$Res>? get timeTrack;
}

/// @nodoc
class _$EmployeeModelCopyWithImpl<$Res, $Val extends EmployeeModel>
    implements $EmployeeModelCopyWith<$Res> {
  _$EmployeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? timeTrack = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            timeTrack: freezed == timeTrack
                ? _value.timeTrack
                : timeTrack // ignore: cast_nullable_to_non_nullable
                      as EmployeeTimeTrackModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EmployeeTimeTrackModelCopyWith<$Res>? get timeTrack {
    if (_value.timeTrack == null) {
      return null;
    }

    return $EmployeeTimeTrackModelCopyWith<$Res>(_value.timeTrack!, (value) {
      return _then(_value.copyWith(timeTrack: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmployeeModelImplCopyWith<$Res>
    implements $EmployeeModelCopyWith<$Res> {
  factory _$$EmployeeModelImplCopyWith(
    _$EmployeeModelImpl value,
    $Res Function(_$EmployeeModelImpl) then,
  ) = __$$EmployeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    String name,
    @JsonKey(includeToJson: false, includeFromJson: false)
    EmployeeTimeTrackModel? timeTrack,
  });

  @override
  $EmployeeTimeTrackModelCopyWith<$Res>? get timeTrack;
}

/// @nodoc
class __$$EmployeeModelImplCopyWithImpl<$Res>
    extends _$EmployeeModelCopyWithImpl<$Res, _$EmployeeModelImpl>
    implements _$$EmployeeModelImplCopyWith<$Res> {
  __$$EmployeeModelImplCopyWithImpl(
    _$EmployeeModelImpl _value,
    $Res Function(_$EmployeeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? timeTrack = freezed,
  }) {
    return _then(
      _$EmployeeModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        timeTrack: freezed == timeTrack
            ? _value.timeTrack
            : timeTrack // ignore: cast_nullable_to_non_nullable
                  as EmployeeTimeTrackModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeModelImpl implements _EmployeeModel {
  const _$EmployeeModelImpl({
    this.id,
    required this.name,
    @JsonKey(includeToJson: false, includeFromJson: false) this.timeTrack,
  });

  factory _$EmployeeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final EmployeeTimeTrackModel? timeTrack;

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, timeTrack: $timeTrack)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.timeTrack, timeTrack) ||
                other.timeTrack == timeTrack));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, timeTrack);

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeModelImplCopyWith<_$EmployeeModelImpl> get copyWith =>
      __$$EmployeeModelImplCopyWithImpl<_$EmployeeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeModelImplToJson(this);
  }
}

abstract class _EmployeeModel implements EmployeeModel {
  const factory _EmployeeModel({
    final int? id,
    required final String name,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final EmployeeTimeTrackModel? timeTrack,
  }) = _$EmployeeModelImpl;

  factory _EmployeeModel.fromJson(Map<String, dynamic> json) =
      _$EmployeeModelImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  EmployeeTimeTrackModel? get timeTrack;

  /// Create a copy of EmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeModelImplCopyWith<_$EmployeeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
