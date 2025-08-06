// lib/src/domain/models/connection_request.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect/src/core/timestamp_converter.dart';

part 'connection_request.freezed.dart';
part 'connection_request.g.dart';

// Enum to represent the status of a connection request.
enum ConnectionRequestStatus {
  pending,
  accepted,
  declined,
}

@freezed
class ConnectionRequest with _$ConnectionRequest {
  const factory ConnectionRequest({
    required String id,
    required String fromUserId,
    required String toUserId,
    // We store the sender's name and picture to avoid extra database lookups
    // when displaying the request in the UI. This is a common optimization.
    required String fromUserName,
    String? fromUserProfilePictureUrl,
    required ConnectionRequestStatus status,
    // Use our custom converter to handle the timestamp.
    @TimestampConverter() required DateTime createdAt,
  }) = _ConnectionRequest;

  factory ConnectionRequest.fromJson(Map<String, dynamic> json) =>
      _$ConnectionRequestFromJson(json);
}