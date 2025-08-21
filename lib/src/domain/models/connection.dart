// lib/src/domain/models/connection.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:connect/src/core/timestamp_converter.dart';

part 'connection.freezed.dart';
part 'connection.g.dart';

@freezed
class Connection with _$Connection {
  const factory Connection({
    required String id,

    required List<String> userIds,

    required String otherUserId,

    required String otherUserName,

    String? otherUserProfilePictureUrl,

    @TimestampConverter() required DateTime connectedAt,
  }) = _Connection;

  factory Connection.fromJson(Map<String, dynamic> json) =>
      _$ConnectionFromJson(json);
}
