// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConnectionImpl _$$ConnectionImplFromJson(Map<String, dynamic> json) =>
    _$ConnectionImpl(
      id: json['id'] as String,
      userIds: (json['userIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      otherUserId: json['otherUserId'] as String,
      otherUserName: json['otherUserName'] as String,
      otherUserProfilePictureUrl: json['otherUserProfilePictureUrl'] as String?,
      connectedAt: const TimestampConverter().fromJson(
        json['connectedAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$$ConnectionImplToJson(_$ConnectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userIds': instance.userIds,
      'otherUserId': instance.otherUserId,
      'otherUserName': instance.otherUserName,
      'otherUserProfilePictureUrl': instance.otherUserProfilePictureUrl,
      'connectedAt': const TimestampConverter().toJson(instance.connectedAt),
    };
