import 'package:json_annotation/json_annotation.dart';

part 'tier_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TierEntity {
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

  TierEntity({
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

  factory TierEntity.fromJson(Map<String, dynamic> json) =>
      _$TierEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TierEntityToJson(this);
}
