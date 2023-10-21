import 'package:json_annotation/json_annotation.dart';
import 'package:kenz/models/profile_model/profile_result_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


part 'profile_model.g.dart';
@HiveType(typeId: 11)

@JsonSerializable(explicitToJson: true)
class ProfileModel {
  @HiveField(0) final int? status;
  @HiveField(1) final List<ProfileResultModel>? result;
  ProfileModel({this.result, this.status});


  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
