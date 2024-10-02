import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/screen_entity/screen_layout_entity.dart';


part 'screen_entity.g.dart';

@JsonSerializable()
class ScreenEntity {
  String? id;
  List<ScreenLayoutEntity>? layout;

  ScreenEntity({
    this.id,
    this.layout,
  });

  factory ScreenEntity.fromJson(Map<String, dynamic> json) =>
      _$ScreenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenEntityToJson(this);
}
