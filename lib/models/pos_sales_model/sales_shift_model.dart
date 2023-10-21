import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz/models/product_model/product_list_model.dart';
import 'package:kenz/models/pos_sales_model/sales_product_model.dart';

part 'sales_shift_model.g.dart';
@HiveType(typeId: 7)

@JsonSerializable(explicitToJson: true)
class SalesShiftModel{
  @HiveField(0) final int? user;
  @HiveField(1) final String? check_in_time;
  @HiveField(2) final String? check_out_time;

  SalesShiftModel({
    this.user,
    this.check_in_time,
    this.check_out_time
  });
  factory SalesShiftModel.fromJson(Map<String, dynamic> json) => _$SalesShiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesShiftModelToJson(this);
}