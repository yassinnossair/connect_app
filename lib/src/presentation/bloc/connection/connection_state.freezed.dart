// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ConnectionState {
  ConnectionStatus get status => throw _privateConstructorUsedError;
  List<ConnectionRequest> get incomingRequests =>
      throw _privateConstructorUsedError;
  List<Connection> get connections => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionStateCopyWith<ConnectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionStateCopyWith<$Res> {
  factory $ConnectionStateCopyWith(
    ConnectionState value,
    $Res Function(ConnectionState) then,
  ) = _$ConnectionStateCopyWithImpl<$Res, ConnectionState>;
  @useResult
  $Res call({
    ConnectionStatus status,
    List<ConnectionRequest> incomingRequests,
    List<Connection> connections,
    String? errorMessage,
  });
}

/// @nodoc
class _$ConnectionStateCopyWithImpl<$Res, $Val extends ConnectionState>
    implements $ConnectionStateCopyWith<$Res> {
  _$ConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? incomingRequests = null,
    Object? connections = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ConnectionStatus,
            incomingRequests: null == incomingRequests
                ? _value.incomingRequests
                : incomingRequests // ignore: cast_nullable_to_non_nullable
                      as List<ConnectionRequest>,
            connections: null == connections
                ? _value.connections
                : connections // ignore: cast_nullable_to_non_nullable
                      as List<Connection>,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConnectionStateImplCopyWith<$Res>
    implements $ConnectionStateCopyWith<$Res> {
  factory _$$ConnectionStateImplCopyWith(
    _$ConnectionStateImpl value,
    $Res Function(_$ConnectionStateImpl) then,
  ) = __$$ConnectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ConnectionStatus status,
    List<ConnectionRequest> incomingRequests,
    List<Connection> connections,
    String? errorMessage,
  });
}

/// @nodoc
class __$$ConnectionStateImplCopyWithImpl<$Res>
    extends _$ConnectionStateCopyWithImpl<$Res, _$ConnectionStateImpl>
    implements _$$ConnectionStateImplCopyWith<$Res> {
  __$$ConnectionStateImplCopyWithImpl(
    _$ConnectionStateImpl _value,
    $Res Function(_$ConnectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? incomingRequests = null,
    Object? connections = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ConnectionStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ConnectionStatus,
        incomingRequests: null == incomingRequests
            ? _value._incomingRequests
            : incomingRequests // ignore: cast_nullable_to_non_nullable
                  as List<ConnectionRequest>,
        connections: null == connections
            ? _value._connections
            : connections // ignore: cast_nullable_to_non_nullable
                  as List<Connection>,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ConnectionStateImpl implements _ConnectionState {
  const _$ConnectionStateImpl({
    this.status = ConnectionStatus.initial,
    final List<ConnectionRequest> incomingRequests = const [],
    final List<Connection> connections = const [],
    this.errorMessage,
  }) : _incomingRequests = incomingRequests,
       _connections = connections;

  @override
  @JsonKey()
  final ConnectionStatus status;
  final List<ConnectionRequest> _incomingRequests;
  @override
  @JsonKey()
  List<ConnectionRequest> get incomingRequests {
    if (_incomingRequests is EqualUnmodifiableListView)
      return _incomingRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomingRequests);
  }

  final List<Connection> _connections;
  @override
  @JsonKey()
  List<Connection> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ConnectionState(status: $status, incomingRequests: $incomingRequests, connections: $connections, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._incomingRequests,
              _incomingRequests,
            ) &&
            const DeepCollectionEquality().equals(
              other._connections,
              _connections,
            ) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_incomingRequests),
    const DeepCollectionEquality().hash(_connections),
    errorMessage,
  );

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionStateImplCopyWith<_$ConnectionStateImpl> get copyWith =>
      __$$ConnectionStateImplCopyWithImpl<_$ConnectionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ConnectionState implements ConnectionState {
  const factory _ConnectionState({
    final ConnectionStatus status,
    final List<ConnectionRequest> incomingRequests,
    final List<Connection> connections,
    final String? errorMessage,
  }) = _$ConnectionStateImpl;

  @override
  ConnectionStatus get status;
  @override
  List<ConnectionRequest> get incomingRequests;
  @override
  List<Connection> get connections;
  @override
  String? get errorMessage;

  /// Create a copy of ConnectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionStateImplCopyWith<_$ConnectionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
