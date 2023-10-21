import 'package:json_annotation/json_annotation.dart';
import 'package:kenz/models/profile_model/profile_result_model.dart';

import 'category_result_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'category_model.g.dart';
@HiveType(typeId: 9)

@JsonSerializable(explicitToJson: true)
class CategoryModel {
 @HiveField(0) final int? status;
 @HiveField(1) @JsonKey(name: "lst_data") final List<CategoryResultModel>? result;
  CategoryModel({this.result, this.status});


  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
