// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenEntity _$ScreenEntityFromJson(Map<String, dynamic> json) => ScreenEntity(
      id: json['id'] as String?,
      layout: (json['layout'] as List<dynamic>?)
          ?.map((e) => ScreenLayoutEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScreenEntityToJson(ScreenEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'layout': instance.layout,
    };
