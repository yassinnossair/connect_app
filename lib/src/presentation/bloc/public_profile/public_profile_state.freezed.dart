// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PublicProfileState {
  PublicProfileStatus get status => throw _privateConstructorUsedError;
  List<UserProfile> get profiles => throw _privateConstructorUsedError;

  /// Create a copy of PublicProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublicProfileStateCopyWith<PublicProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicProfileStateCopyWith<$Res> {
  factory $PublicProfileStateCopyWith(
    PublicProfileState value,
    $Res Function(PublicProfileState) then,
  ) = _$PublicProfileStateCopyWithImpl<$Res, PublicProfileState>;
  @useResult
  $Res call({PublicProfileStatus status, List<UserProfile> profiles});
}

/// @nodoc
class _$PublicProfileStateCopyWithImpl<$Res, $Val extends PublicProfileState>
    implements $PublicProfileStateCopyWith<$Res> {
  _$PublicProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublicProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? profiles = null}) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PublicProfileStatus,
            profiles: null == profiles
                ? _value.profiles
                : profiles // ignore: cast_nullable_to_non_nullable
                      as List<UserProfile>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PublicProfileStateImplCopyWith<$Res>
    implements $PublicProfileStateCopyWith<$Res> {
  factory _$$PublicProfileStateImplCopyWith(
    _$PublicProfileStateImpl value,
    $Res Function(_$PublicProfileStateImpl) then,
  ) = __$$PublicProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PublicProfileStatus status, List<UserProfile> profiles});
}

/// @nodoc
class __$$PublicProfileStateImplCopyWithImpl<$Res>
    extends _$PublicProfileStateCopyWithImpl<$Res, _$PublicProfileStateImpl>
    implements _$$PublicProfileStateImplCopyWith<$Res> {
  __$$PublicProfileStateImplCopyWithImpl(
    _$PublicProfileStateImpl _value,
    $Res Function(_$PublicProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PublicProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? profiles = null}) {
    return _then(
      _$PublicProfileStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PublicProfileStatus,
        profiles: null == profiles
            ? _value._profiles
            : profiles // ignore: cast_nullable_to_non_nullable
                  as List<UserProfile>,
      ),
    );
  }
}

/// @nodoc

class _$PublicProfileStateImpl implements _PublicProfileState {
  const _$PublicProfileStateImpl({
    this.status = PublicProfileStatus.initial,
    final List<UserProfile> profiles = const [],
  }) : _profiles = profiles;

  @override
  @JsonKey()
  final PublicProfileStatus status;
  final List<UserProfile> _profiles;
  @override
  @JsonKey()
  List<UserProfile> get profiles {
    if (_profiles is EqualUnmodifiableListView) return _profiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profiles);
  }

  @override
  String toString() {
    return 'PublicProfileState(status: $status, profiles: $profiles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublicProfileStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._profiles, _profiles));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_profiles),
  );

  /// Create a copy of PublicProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublicProfileStateImplCopyWith<_$PublicProfileStateImpl> get copyWith =>
      __$$PublicProfileStateImplCopyWithImpl<_$PublicProfileStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PublicProfileState implements PublicProfileState {
  const factory _PublicProfileState({
    final PublicProfileStatus status,
    final List<UserProfile> profiles,
  }) = _$PublicProfileStateImpl;

  @override
  PublicProfileStatus get status;
  @override
  List<UserProfile> get profiles;

  /// Create a copy of PublicProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublicProfileStateImplCopyWith<_$PublicProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
