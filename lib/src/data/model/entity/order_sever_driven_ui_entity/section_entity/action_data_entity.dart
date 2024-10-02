import 'package:json_annotation/json_annotation.dart';

part 'action_data_entity.g.dart';

@JsonSerializable()
class ActionDataEntity {
  String? type;
  String? target;

  ActionDataEntity({
    this.type,
    this.target,
  });

  factory ActionDataEntity.fromJson(Map<String, dynamic> json) =>
      _$ActionDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActionDataEntityToJson(this);
}