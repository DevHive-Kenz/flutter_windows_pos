import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz/models/product_model/product_list_model.dart';

part 'product_model.g.dart';
@HiveType(typeId: 1)

@JsonSerializable(explicitToJson: true)
class ProductModel{
  @HiveField(0) final int? status;
  @HiveField(1) final String? message;
  @HiveField(2) final ProductListModel? result;
  ProductModel({
    this.status,
    this.message,
    this.result,

  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}