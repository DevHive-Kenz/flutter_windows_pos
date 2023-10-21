// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PosSalesModelAdapter extends TypeAdapter<PosSalesModel> {
  @override
  final int typeId = 5;

  @override
  PosSalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosSalesModel(
      customerName: fields[16] as String?,
      multi: fields[17] as PaymentTypeModel?,
      user_id: fields[0] as int?,
      order_id: fields[1] as String?,
      invoice_id: fields[2] as String?,
      shift: fields[3] as int?,
      total: fields[4] as String?,
      sub_total: fields[5] as String?,
      vat_total: fields[6] as String?,
      vat_percentage: fields[7] as String?,
      payment_type: fields[8] as String?,
      given_amount: fields[9] as String?,
      balance: fields[10] as String?,
      discount_price: fields[11] as String?,
      is_parcel: fields[12] as String?,
      created: fields[13] as String?,
      items: (fields[14] as List?)?.cast<SalesProductModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PosSalesModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.user_id)
      ..writeByte(1)
      ..write(obj.order_id)
      ..writeByte(2)
      ..write(obj.invoice_id)
      ..writeByte(3)
      ..write(obj.shift)
      ..writeByte(4)
      ..write(obj.total)
      ..writeByte(5)
      ..write(obj.sub_total)
      ..writeByte(6)
      ..write(obj.vat_total)
      ..writeByte(7)
      ..write(obj.vat_percentage)
      ..writeByte(8)
      ..write(obj.payment_type)
      ..writeByte(9)
      ..write(obj.given_amount)
      ..writeByte(10)
      ..write(obj.balance)
      ..writeByte(11)
      ..write(obj.discount_price)
      ..writeByte(12)
      ..write(obj.is_parcel)
      ..writeByte(13)
      ..write(obj.created)
      ..writeByte(14)
      ..write(obj.items)
      ..writeByte(16)
      ..write(obj.customerName)
      ..writeByte(17)
      ..write(obj.multi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosSalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosSalesModel _$PosSalesModelFromJson(Map<String, dynamic> json) =>
    PosSalesModel(
      customerName: json['customerName'] as String?,
      multi: json['multi'] == null
          ? null
          : PaymentTypeModel.fromJson(json['multi'] as Map<String, dynamic>),
      user_id: json['user_id'] as int?,
      order_id: json['order_id'] as String?,
      invoice_id: json['invoice_id'] as String?,
      shift: json['shift'] as int?,
      total: json['total'] as String?,
      sub_total: json['sub_total'] as String?,
      vat_total: json['vat_total'] as String?,
      vat_percentage: json['vat_percentage'] as String?,
      payment_type: json['payment_type'] as String?,
      given_amount: json['given_amount'] as String?,
      balance: json['balance'] as String?,
      discount_price: json['discount_price'] as String?,
      is_parcel: json['is_parcel'] as String?,
      created: json['created'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SalesProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosSalesModelToJson(PosSalesModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'order_id': instance.order_id,
      'invoice_id': instance.invoice_id,
      'shift': instance.shift,
      'total': instance.total,
      'sub_total': instance.sub_total,
      'vat_total': instance.vat_total,
      'vat_percentage': instance.vat_percentage,
      'payment_type': instance.payment_type,
      'given_amount': instance.given_amount,
      'balance': instance.balance,
      'discount_price': instance.discount_price,
      'is_parcel': instance.is_parcel,
      'created': instance.created,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'customerName': instance.customerName,
      'multi': instance.multi?.toJson(),
    };
