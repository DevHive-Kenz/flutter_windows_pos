import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kenz/models/pos_sales_model/payment_type_model.dart';
import 'package:kenz/models/pos_sales_model/sales_product_model.dart';
import 'package:kenz/models/pos_sales_model/sales_shift_model.dart';
import 'package:kenz/models/product_model/product_list_model.dart';


part 'sales_model.g.dart';
@HiveType(typeId: 5)

@JsonSerializable(explicitToJson: true)
class PosSalesModel{
  @HiveField(0) final int? user_id;
  @HiveField(1) final String? order_id;
  @HiveField(2) final String? invoice_id;
  @HiveField(3) final int? shift;
  @HiveField(4) final String? total;
  @HiveField(5) final String? sub_total;
  @HiveField(6) final String? vat_total;
  @HiveField(7) final String? vat_percentage;
  @HiveField(8) final String? payment_type;
  @HiveField(9) final String? given_amount;
  @HiveField(10) final String? balance;
  @HiveField(11) final String? discount_price;
  @HiveField(12) final String? is_parcel;
  @HiveField(13) final String? created;
  @HiveField(14) final List<SalesProductModel>? items;
  @HiveField(16) final String? customerName;
  @HiveField(17) final PaymentTypeModel? multi;
  PosSalesModel({this.customerName,this.multi,
    this.user_id, this.order_id, this.invoice_id, this.shift, this.total, this.sub_total, this.vat_total, this.vat_percentage, this.payment_type, this.given_amount, this.balance, this.discount_price, this.is_parcel, this.created, this.items,


  });
  factory PosSalesModel.fromJson(Map<String, dynamic> json) => _$PosSalesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PosSalesModelToJson(this);
}