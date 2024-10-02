// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oder_sever_driven_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSeverDrivenUIModel _$OrderSeverDrivenUIModelFromJson(
        Map<String, dynamic> json) =>
    OrderSeverDrivenUIModel(
      screens: (json['screens'] as List<dynamic>?)
          ?.map((e) => ScreenEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => SectionsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..actions = (json['actions'] as List<dynamic>?)
        ?.map((e) => ActionDataEntity.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$OrderSeverDrivenUIModelToJson(
        OrderSeverDrivenUIModel instance) =>
    <String, dynamic>{
      'screens': instance.screens,
      'sections': instance.sections,
      'actions': instance.actions,
    };
