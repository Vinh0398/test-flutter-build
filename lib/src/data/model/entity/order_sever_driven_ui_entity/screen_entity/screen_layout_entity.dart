import 'package:json_annotation/json_annotation.dart';

part 'screen_layout_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ScreenLayoutEntity {
  String? type;
  List<String>? sectionIds;

  ScreenLayoutEntity({
    this.type,
    this.sectionIds,
  });

  factory ScreenLayoutEntity.fromJson(Map<String, dynamic> json) =>
      _$ScreenLayoutEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenLayoutEntityToJson(this);
}
