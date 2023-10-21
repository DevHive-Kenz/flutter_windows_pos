import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'category_result_model.g.dart';
@HiveType(typeId: 10)

@JsonSerializable(explicitToJson: true)
class CategoryResultModel {
 @HiveField(0) final int? id;
 @HiveField(1) @JsonKey(name: "user_id") final int? userId;
 @HiveField(2) @JsonKey(name: "image") final String? image;
 @HiveField(3) @JsonKey(name: "discount_type") final String? discountType;
 @HiveField(4) @JsonKey(name: "discount") final num? discount;
 @HiveField(5) @JsonKey(name: "name") final String? name;

  CategoryResultModel(
      {
        this.id,
        this.userId,
        this.image,
        this.name,
        this.discount,
        this.discountType
      });


  factory CategoryResultModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResultModelToJson(this);
}
