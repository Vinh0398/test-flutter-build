import 'package:json_annotation/json_annotation.dart';

part 'section_data_style_entity.g.dart';

@JsonSerializable()
class SectionDataStyleEntity {
  String? Key;
  String? Value;

  SectionDataStyleEntity({
    this.Key,
    this.Value,
  });

  factory SectionDataStyleEntity.fromJson(Map<String, dynamic> json) =>
      _$SectionDataStyleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SectionDataStyleEntityToJson(this);
}
