// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionRequestImpl _$$ConnectionRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ConnectionRequestImpl(
  id: json['id'] as String,
  fromUserId: json['fromUserId'] as String,
  toUserId: json['toUserId'] as String,
  fromUserName: json['fromUserName'] as String,
  fromUserProfilePictureUrl: json['fromUserProfilePictureUrl'] as String?,
  status: $enumDecode(_$ConnectionRequestStatusEnumMap, json['status']),
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$$ConnectionRequestImplToJson(
  _$ConnectionRequestImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'fromUserName': instance.fromUserName,
  'fromUserProfilePictureUrl': instance.fromUserProfilePictureUrl,
  'status': _$ConnectionRequestStatusEnumMap[instance.status]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
};

const _$ConnectionRequestStatusEnumMap = {
  ConnectionRequestStatus.pending: 'pending',
  ConnectionRequestStatus.accepted: 'accepted',
  ConnectionRequestStatus.declined: 'declined',
};
