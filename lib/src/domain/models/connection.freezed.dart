// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Connection _$ConnectionFromJson(Map<String, dynamic> json) {
  return _Connection.fromJson(json);
}

/// @nodoc
mixin _$Connection {
  String get id =>
      throw _privateConstructorUsedError; // A list containing the IDs of both users in the connection.
  List<String> get userIds =>
      throw _privateConstructorUsedError; // We store the other user's details directly in the connection document.
  // This makes loading the 'My Connections' list very fast, as we don't
  // have to fetch each user's profile individually.
  String get otherUserId => throw _privateConstructorUsedError;
  String get otherUserName => throw _privateConstructorUsedError;
  String? get otherUserProfilePictureUrl => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get connectedAt => throw _privateConstructorUsedError;

  /// Serializes this Connection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionCopyWith<Connection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionCopyWith<$Res> {
  factory $ConnectionCopyWith(
    Connection value,
    $Res Function(Connection) then,
  ) = _$ConnectionCopyWithImpl<$Res, Connection>;
  @useResult
  $Res call({
    String id,
    List<String> userIds,
    String otherUserId,
    String otherUserName,
    String? otherUserProfilePictureUrl,
    @TimestampConverter() DateTime connectedAt,
  });
}

/// @nodoc
class _$ConnectionCopyWithImpl<$Res, $Val extends Connection>
    implements $ConnectionCopyWith<$Res> {
  _$ConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userIds = null,
    Object? otherUserId = null,
    Object? otherUserName = null,
    Object? otherUserProfilePictureUrl = freezed,
    Object? connectedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userIds: null == userIds
                ? _value.userIds
                : userIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            otherUserId: null == otherUserId
                ? _value.otherUserId
                : otherUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            otherUserName: null == otherUserName
                ? _value.otherUserName
                : otherUserName // ignore: cast_nullable_to_non_nullable
                      as String,
            otherUserProfilePictureUrl: freezed == otherUserProfilePictureUrl
                ? _value.otherUserProfilePictureUrl
                : otherUserProfilePictureUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            connectedAt: null == connectedAt
                ? _value.connectedAt
                : connectedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionImplCopyWith<$Res>
    implements $ConnectionCopyWith<$Res> {
  factory _$$ConnectionImplCopyWith(
    _$ConnectionImpl value,
    $Res Function(_$ConnectionImpl) then,
  ) = __$$ConnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<String> userIds,
    String otherUserId,
    String otherUserName,
    String? otherUserProfilePictureUrl,
    @TimestampConverter() DateTime connectedAt,
  });
}

/// @nodoc
class __$$ConnectionImplCopyWithImpl<$Res>
    extends _$ConnectionCopyWithImpl<$Res, _$ConnectionImpl>
    implements _$$ConnectionImplCopyWith<$Res> {
  __$$ConnectionImplCopyWithImpl(
    _$ConnectionImpl _value,
    $Res Function(_$ConnectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userIds = null,
    Object? otherUserId = null,
    Object? otherUserName = null,
    Object? otherUserProfilePictureUrl = freezed,
    Object? connectedAt = null,
  }) {
    return _then(
      _$ConnectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userIds: null == userIds
            ? _value._userIds
            : userIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        otherUserId: null == otherUserId
            ? _value.otherUserId
            : otherUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        otherUserName: null == otherUserName
            ? _value.otherUserName
            : otherUserName // ignore: cast_nullable_to_non_nullable
                  as String,
        otherUserProfilePictureUrl: freezed == otherUserProfilePictureUrl
            ? _value.otherUserProfilePictureUrl
            : otherUserProfilePictureUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        connectedAt: null == connectedAt
            ? _value.connectedAt
            : connectedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionImpl implements _Connection {
  const _$ConnectionImpl({
    required this.id,
    required final List<String> userIds,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserProfilePictureUrl,
    @TimestampConverter() required this.connectedAt,
  }) : _userIds = userIds;

  factory _$ConnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionImplFromJson(json);

  @override
  final String id;
  // A list containing the IDs of both users in the connection.
  final List<String> _userIds;
  // A list containing the IDs of both users in the connection.
  @override
  List<String> get userIds {
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

  // We store the other user's details directly in the connection document.
  // This makes loading the 'My Connections' list very fast, as we don't
  // have to fetch each user's profile individually.
  @override
  final String otherUserId;
  @override
  final String otherUserName;
  @override
  final String? otherUserProfilePictureUrl;
  @override
  @TimestampConverter()
  final DateTime connectedAt;

  @override
  String toString() {
    return 'Connection(id: $id, userIds: $userIds, otherUserId: $otherUserId, otherUserName: $otherUserName, otherUserProfilePictureUrl: $otherUserProfilePictureUrl, connectedAt: $connectedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            (identical(other.otherUserId, otherUserId) ||
                other.otherUserId == otherUserId) &&
            (identical(other.otherUserName, otherUserName) ||
                other.otherUserName == otherUserName) &&
            (identical(
                  other.otherUserProfilePictureUrl,
                  otherUserProfilePictureUrl,
                ) ||
                other.otherUserProfilePictureUrl ==
                    otherUserProfilePictureUrl) &&
            (identical(other.connectedAt, connectedAt) ||
                other.connectedAt == connectedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_userIds),
    otherUserId,
    otherUserName,
    otherUserProfilePictureUrl,
    connectedAt,
  );

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionImplCopyWith<_$ConnectionImpl> get copyWith =>
      __$$ConnectionImplCopyWithImpl<_$ConnectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionImplToJson(this);
  }
}

abstract class _Connection implements Connection {
  const factory _Connection({
    required final String id,
    required final List<String> userIds,
    required final String otherUserId,
    required final String otherUserName,
    final String? otherUserProfilePictureUrl,
    @TimestampConverter() required final DateTime connectedAt,
  }) = _$ConnectionImpl;

  factory _Connection.fromJson(Map<String, dynamic> json) =
      _$ConnectionImpl.fromJson;

  @override
  String get id; // A list containing the IDs of both users in the connection.
  @override
  List<String> get userIds; // We store the other user's details directly in the connection document.
  // This makes loading the 'My Connections' list very fast, as we don't
  // have to fetch each user's profile individually.
  @override
  String get otherUserId;
  @override
  String get otherUserName;
  @override
  String? get otherUserProfilePictureUrl;
  @override
  @TimestampConverter()
  DateTime get connectedAt;

  /// Create a copy of Connection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionImplCopyWith<_$ConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
