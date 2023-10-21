import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product_content_model.g.dart';
@HiveType(typeId: 3)

@JsonSerializable(explicitToJson: true)
class ProductContentModel{
  @HiveField(0) final int? id;
  @HiveField(1) final int? user_id;
  @HiveField(2) final String? name;
  @HiveField(3) final String? name_arabic;
  @HiveField(4) final String? image;
  @HiveField(5) final int? category_id;
  @HiveField(6) final String? discount_type;
  @HiveField(7) final num? discount;
  @HiveField(8) final num? discounted_price;
  @HiveField(9) final num? price;
  @HiveField(10) final DateTime? added;
  @HiveField(11)  int? qty;
  @HiveField(12)  double? priceWithoutVat;
  @HiveField(13)  double? vat;
  @HiveField(14)  double? total;
  ProductContentModel( {
    this.id,
    this.qty,
    this.user_id,
    this.name,
    this.name_arabic,
    this.image,
    this.category_id,
    this.discount_type,
    this.discount,
    this.discounted_price,
    this.price,
    this.added,
    this.priceWithoutVat,
    this.vat,
    this.total,
  });
  factory ProductContentModel.fromJson(Map<String, dynamic> json) => _$ProductContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductContentModelToJson(this);
}