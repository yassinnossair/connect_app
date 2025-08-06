// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConnectionRequest _$ConnectionRequestFromJson(Map<String, dynamic> json) {
  return _ConnectionRequest.fromJson(json);
}

/// @nodoc
mixin _$ConnectionRequest {
  String get id => throw _privateConstructorUsedError;
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserId =>
      throw _privateConstructorUsedError; // We store the sender's name and picture to avoid extra database lookups
  // when displaying the request in the UI. This is a common optimization.
  String get fromUserName => throw _privateConstructorUsedError;
  String? get fromUserProfilePictureUrl => throw _privateConstructorUsedError;
  ConnectionRequestStatus get status =>
      throw _privateConstructorUsedError; // Use our custom converter to handle the timestamp.
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ConnectionRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionRequestCopyWith<ConnectionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionRequestCopyWith<$Res> {
  factory $ConnectionRequestCopyWith(
    ConnectionRequest value,
    $Res Function(ConnectionRequest) then,
  ) = _$ConnectionRequestCopyWithImpl<$Res, ConnectionRequest>;
  @useResult
  $Res call({
    String id,
    String fromUserId,
    String toUserId,
    String fromUserName,
    String? fromUserProfilePictureUrl,
    ConnectionRequestStatus status,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$ConnectionRequestCopyWithImpl<$Res, $Val extends ConnectionRequest>
    implements $ConnectionRequestCopyWith<$Res> {
  _$ConnectionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? fromUserName = null,
    Object? fromUserProfilePictureUrl = freezed,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fromUserId: null == fromUserId
                ? _value.fromUserId
                : fromUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            toUserId: null == toUserId
                ? _value.toUserId
                : toUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            fromUserName: null == fromUserName
                ? _value.fromUserName
                : fromUserName // ignore: cast_nullable_to_non_nullable
                      as String,
            fromUserProfilePictureUrl: freezed == fromUserProfilePictureUrl
                ? _value.fromUserProfilePictureUrl
                : fromUserProfilePictureUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ConnectionRequestStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionRequestImplCopyWith<$Res>
    implements $ConnectionRequestCopyWith<$Res> {
  factory _$$ConnectionRequestImplCopyWith(
    _$ConnectionRequestImpl value,
    $Res Function(_$ConnectionRequestImpl) then,
  ) = __$$ConnectionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fromUserId,
    String toUserId,
    String fromUserName,
    String? fromUserProfilePictureUrl,
    ConnectionRequestStatus status,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$ConnectionRequestImplCopyWithImpl<$Res>
    extends _$ConnectionRequestCopyWithImpl<$Res, _$ConnectionRequestImpl>
    implements _$$ConnectionRequestImplCopyWith<$Res> {
  __$$ConnectionRequestImplCopyWithImpl(
    _$ConnectionRequestImpl _value,
    $Res Function(_$ConnectionRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? fromUserName = null,
    Object? fromUserProfilePictureUrl = freezed,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ConnectionRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fromUserId: null == fromUserId
            ? _value.fromUserId
            : fromUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        toUserId: null == toUserId
            ? _value.toUserId
            : toUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        fromUserName: null == fromUserName
            ? _value.fromUserName
            : fromUserName // ignore: cast_nullable_to_non_nullable
                  as String,
        fromUserProfilePictureUrl: freezed == fromUserProfilePictureUrl
            ? _value.fromUserProfilePictureUrl
            : fromUserProfilePictureUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ConnectionRequestStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionRequestImpl implements _ConnectionRequest {
  const _$ConnectionRequestImpl({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.fromUserName,
    this.fromUserProfilePictureUrl,
    required this.status,
    @TimestampConverter() required this.createdAt,
  });

  factory _$ConnectionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionRequestImplFromJson(json);

  @override
  final String id;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  // We store the sender's name and picture to avoid extra database lookups
  // when displaying the request in the UI. This is a common optimization.
  @override
  final String fromUserName;
  @override
  final String? fromUserProfilePictureUrl;
  @override
  final ConnectionRequestStatus status;
  // Use our custom converter to handle the timestamp.
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'ConnectionRequest(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, fromUserName: $fromUserName, fromUserProfilePictureUrl: $fromUserProfilePictureUrl, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.fromUserName, fromUserName) ||
                other.fromUserName == fromUserName) &&
            (identical(
                  other.fromUserProfilePictureUrl,
                  fromUserProfilePictureUrl,
                ) ||
                other.fromUserProfilePictureUrl == fromUserProfilePictureUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fromUserId,
    toUserId,
    fromUserName,
    fromUserProfilePictureUrl,
    status,
    createdAt,
  );

  /// Create a copy of ConnectionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionRequestImplCopyWith<_$ConnectionRequestImpl> get copyWith =>
      __$$ConnectionRequestImplCopyWithImpl<_$ConnectionRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionRequestImplToJson(this);
  }
}

abstract class _ConnectionRequest implements ConnectionRequest {
  const factory _ConnectionRequest({
    required final String id,
    required final String fromUserId,
    required final String toUserId,
    required final String fromUserName,
    final String? fromUserProfilePictureUrl,
    required final ConnectionRequestStatus status,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$ConnectionRequestImpl;

  factory _ConnectionRequest.fromJson(Map<String, dynamic> json) =
      _$ConnectionRequestImpl.fromJson;

  @override
  String get id;
  @override
  String get fromUserId;
  @override
  String get toUserId; // We store the sender's name and picture to avoid extra database lookups
  // when displaying the request in the UI. This is a common optimization.
  @override
  String get fromUserName;
  @override
  String? get fromUserProfilePictureUrl;
  @override
  ConnectionRequestStatus get status; // Use our custom converter to handle the timestamp.
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of ConnectionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionRequestImplCopyWith<_$ConnectionRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
