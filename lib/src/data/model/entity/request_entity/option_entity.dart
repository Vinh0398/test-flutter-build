import 'package:json_annotation/json_annotation.dart';

part 'option_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OptionEntity {
  String? code;
  String? nameVi;
  String? nameEn;
  num? price;
  String? descriptionViVn;
  String? descriptionEnUs;
  String? priceDescriptionViVn;
  String? priceDescriptionEnUs;
  String? imgUrl;
  bool selectable;
  String? warningMessage;

  OptionEntity({
    this.code,
    this.nameVi,
    this.nameEn,
    this.price,
    this.descriptionViVn,
    this.descriptionEnUs,
    this.priceDescriptionViVn,
    this.priceDescriptionEnUs,
    this.imgUrl,
    required this.selectable,
    this.warningMessage,
  });

  factory OptionEntity.fromJson(Map<String, dynamic> json) =>
      _$OptionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OptionEntityToJson(this);
}
