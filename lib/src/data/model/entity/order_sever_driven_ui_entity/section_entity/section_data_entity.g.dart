// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionDataEntity _$SectionDataEntityFromJson(Map<String, dynamic> json) =>
    SectionDataEntity(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      value: json['value'] as String?,
      styles: (json['styles'] as List<dynamic>?)
          ?.map(
              (e) => SectionDataStyleEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      param:
          (json['param'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SectionDataEntityToJson(SectionDataEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'styles': instance.styles,
      'param': instance.param,
    };
