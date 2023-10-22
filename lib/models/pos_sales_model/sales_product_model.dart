import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'sales_product_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable(explicitToJson: true)
class SalesProductModel{
  @HiveField(0) final String? name;
  @HiveField(1) final String? name_arabic;
  @HiveField(2) final  String? quantity;
  @HiveField(3) final String? discount;
  @HiveField(4) final String? discounted_price;
  @HiveField(5) final String? discount_type;
  @HiveField(6) final String? total_amount;
  @HiveField(7) final String? gross_total;
  @HiveField(8) final String? vat_amount;
  @HiveField(9) final String? product_id;

  SalesProductModel({this.product_id,
    this.name,
    this.name_arabic,
    this.quantity,
    this.discount,
    this.discounted_price,
    this.discount_type,
    this.total_amount,
    this.gross_total,
    this.vat_amount,
  });
  factory SalesProductModel.fromJson(Map<String, dynamic> json) => _$SalesProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesProductModelToJson(this);
}