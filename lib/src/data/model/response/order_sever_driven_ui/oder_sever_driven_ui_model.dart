import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/screen_entity/screen_entity.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/section_entity/sections_entity.dart';
import '../../entity/order_sever_driven_ui_entity/section_entity/action_data_entity.dart';

part 'oder_sever_driven_ui_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderSeverDrivenUIModel {
  List<ScreenEntity>? screens;
  List<SectionsEntity>? sections;
  List<ActionDataEntity>? actions;

  OrderSeverDrivenUIModel({
    this.screens,
    this.sections,
  });

  factory OrderSeverDrivenUIModel.fromJson(Map<String, dynamic> json) =>
      _$OrderSeverDrivenUIModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSeverDrivenUIModelToJson(this);
}
