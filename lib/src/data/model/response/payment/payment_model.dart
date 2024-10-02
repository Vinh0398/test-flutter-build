import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_build/src/data/model/entity/payment_entity/payment_entity.dart';

part 'payment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentModel {
  List<PaymentEntity> data;

  PaymentModel({required this.data});

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}