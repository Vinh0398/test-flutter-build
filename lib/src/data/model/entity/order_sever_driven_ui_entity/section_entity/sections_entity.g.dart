// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sections_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionsEntity _$SectionsEntityFromJson(Map<String, dynamic> json) =>
    SectionsEntity(
      id: json['id'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SectionDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      action: json['action'] == null
          ? null
          : ActionDataEntity.fromJson(json['action'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionsEntityToJson(SectionsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data,
      'action': instance.action,
    };
