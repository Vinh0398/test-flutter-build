import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/section_entity/section_data_style_entity.dart';

part 'section_data_entity.g.dart';

@JsonSerializable()
class SectionDataEntity {
  @JsonKey(name: "_id") String? id;
  String? type;
  String? value;
  List<SectionDataStyleEntity>? styles;
  List<String>? param;

  SectionDataEntity({
    this.id,
    this.type,
    this.value,
    this.styles,
    this.param,
  });

  factory SectionDataEntity.fromJson(Map<String, dynamic> json) =>
      _$SectionDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SectionDataEntityToJson(this);
}
