// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_layout_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenLayoutEntity _$ScreenLayoutEntityFromJson(Map<String, dynamic> json) =>
    ScreenLayoutEntity(
      type: json['type'] as String?,
      sectionIds: (json['section_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ScreenLayoutEntityToJson(ScreenLayoutEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'section_ids': instance.sectionIds,
    };
