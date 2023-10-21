import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz/models/product_model/product_content_model.dart';

part 'product_list_model.g.dart';


@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class ProductListModel {
  @HiveField(0) final Map<String,ProductContentModel>? processedListProducts;
  ProductListModel({this.processedListProducts});
  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListModelToJson(this);
}
