// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String?,
      company: json['company'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      professionalLinks:
          (json['professionalLinks'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'company': instance.company,
      'profilePictureUrl': instance.profilePictureUrl,
      'professionalLinks': instance.professionalLinks,
    };
