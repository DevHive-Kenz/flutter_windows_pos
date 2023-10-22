import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz/models/product_model/product_list_model.dart';

import '../../provider/product_management_notifier.dart';

part 'payment_type_model.g.dart';
@HiveType(typeId: 8)

@JsonSerializable(explicitToJson: true)
class PaymentTypeModel{
  @HiveField(0) final String? paymentMethod;
  @HiveField(1) final String? amount;


  PaymentTypeModel({this.amount, this.paymentMethod,

  });
  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) => _$PaymentTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTypeModelToJson(this);
}