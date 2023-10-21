import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz/models/product_model/product_list_model.dart';

part 'check_in_model.g.dart';
@HiveType(typeId: 4)

@JsonSerializable(explicitToJson: true)
class CheckInModel{
  @HiveField(0) final bool? isCheckIN;
  @HiveField(1) final DateTime? checkIn;
  @HiveField(2) final DateTime? checkOut;
  @HiveField(3) final String? user;
  CheckInModel({this.isCheckIN, this.checkIn, this.checkOut, this.user,
  });
  factory CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInModelToJson(this);
}