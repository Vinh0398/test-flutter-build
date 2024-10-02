import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/section_entity/section_data_entity.dart';

import 'action_data_entity.dart';

part 'sections_entity.g.dart';

@JsonSerializable()
class SectionsEntity {
  String? id;
  List<SectionDataEntity>? data;
  ActionDataEntity? action;

  SectionsEntity({
    this.id,
    this.data,
    this.action,
  });

  factory SectionsEntity.fromJson(Map<String, dynamic> json) =>
      _$SectionsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SectionsEntityToJson(this);
}
