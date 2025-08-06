// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileState {
  // REFACTORED: We now hold a list of all profiles.
  List<UserProfile> get profiles =>
      throw _privateConstructorUsedError; // NEW: We keep track of the selected profile's ID.
  String? get selectedProfileId =>
      throw _privateConstructorUsedError; // The status of the page.
  ProfileStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
    ProfileState value,
    $Res Function(ProfileState) then,
  ) = _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call({
    List<UserProfile> profiles,
    String? selectedProfileId,
    ProfileStatus status,
  });
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profiles = null,
    Object? selectedProfileId = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            profiles: null == profiles
                ? _value.profiles
                : profiles // ignore: cast_nullable_to_non_nullable
                      as List<UserProfile>,
            selectedProfileId: freezed == selectedProfileId
                ? _value.selectedProfileId
                : selectedProfileId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ProfileStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileStateImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ProfileStateImplCopyWith(
    _$ProfileStateImpl value,
    $Res Function(_$ProfileStateImpl) then,
  ) = __$$ProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<UserProfile> profiles,
    String? selectedProfileId,
    ProfileStatus status,
  });
}

/// @nodoc
class __$$ProfileStateImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ProfileStateImpl>
    implements _$$ProfileStateImplCopyWith<$Res> {
  __$$ProfileStateImplCopyWithImpl(
    _$ProfileStateImpl _value,
    $Res Function(_$ProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profiles = null,
    Object? selectedProfileId = freezed,
    Object? status = null,
  }) {
    return _then(
      _$ProfileStateImpl(
        profiles: null == profiles
            ? _value._profiles
            : profiles // ignore: cast_nullable_to_non_nullable
                  as List<UserProfile>,
        selectedProfileId: freezed == selectedProfileId
            ? _value.selectedProfileId
            : selectedProfileId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ProfileStatus,
      ),
    );
  }
}

/// @nodoc

class _$ProfileStateImpl extends _ProfileState {
  const _$ProfileStateImpl({
    final List<UserProfile> profiles = const [],
    this.selectedProfileId,
    this.status = ProfileStatus.initial,
  }) : _profiles = profiles,
       super._();

  // REFACTORED: We now hold a list of all profiles.
  final List<UserProfile> _profiles;
  // REFACTORED: We now hold a list of all profiles.
  @override
  @JsonKey()
  List<UserProfile> get profiles {
    if (_profiles is EqualUnmodifiableListView) return _profiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profiles);
  }

  // NEW: We keep track of the selected profile's ID.
  @override
  final String? selectedProfileId;
  // The status of the page.
  @override
  @JsonKey()
  final ProfileStatus status;

  @override
  String toString() {
    return 'ProfileState(profiles: $profiles, selectedProfileId: $selectedProfileId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileStateImpl &&
            const DeepCollectionEquality().equals(other._profiles, _profiles) &&
            (identical(other.selectedProfileId, selectedProfileId) ||
                other.selectedProfileId == selectedProfileId) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_profiles),
    selectedProfileId,
    status,
  );

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      __$$ProfileStateImplCopyWithImpl<_$ProfileStateImpl>(this, _$identity);
}

abstract class _ProfileState extends ProfileState {
  const factory _ProfileState({
    final List<UserProfile> profiles,
    final String? selectedProfileId,
    final ProfileStatus status,
  }) = _$ProfileStateImpl;
  const _ProfileState._() : super._();

  // REFACTORED: We now hold a list of all profiles.
  @override
  List<UserProfile> get profiles; // NEW: We keep track of the selected profile's ID.
  @override
  String? get selectedProfileId; // The status of the page.
  @override
  ProfileStatus get status;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileStateImplCopyWith<_$ProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
