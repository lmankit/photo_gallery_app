// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoImpl _$$PhotoImplFromJson(Map<String, dynamic> json) => _$PhotoImpl(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      createdBy: json['createdBy'] as String,
      takenAt: json['takenAt'] as String,
    );

Map<String, dynamic> _$$PhotoImplToJson(_$PhotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'url': instance.url,
      'description': instance.description,
      'location': instance.location,
      'createdBy': instance.createdBy,
      'takenAt': instance.takenAt,
    };
