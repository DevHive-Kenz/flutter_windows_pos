// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesProductModelAdapter extends TypeAdapter<SalesProductModel> {
  @override
  final int typeId = 6;

  @override
  SalesProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesProductModel(
      id: fields[10] as String?,
      name: fields[0] as String?,
      name_arabic: fields[1] as String?,
      quantity: fields[2] as String?,
      discount: fields[3] as String?,
      discounted_price: fields[4] as String?,
      discount_type: fields[5] as String?,
      total_amount: fields[6] as String?,
      gross_total: fields[7] as String?,
      vat_amount: fields[8] as String?,
      added: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SalesProductModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.name_arabic)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.discount)
      ..writeByte(4)
      ..write(obj.discounted_price)
      ..writeByte(5)
      ..write(obj.discount_type)
      ..writeByte(6)
      ..write(obj.total_amount)
      ..writeByte(7)
      ..write(obj.gross_total)
      ..writeByte(8)
      ..write(obj.vat_amount)
      ..writeByte(9)
      ..write(obj.added)
      ..writeByte(10)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesProductModel _$SalesProductModelFromJson(Map<String, dynamic> json) =>
    SalesProductModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      name_arabic: json['name_arabic'] as String?,
      quantity: json['quantity'] as String?,
      discount: json['discount'] as String?,
      discounted_price: json['discounted_price'] as String?,
      discount_type: json['discount_type'] as String?,
      total_amount: json['total_amount'] as String?,
      gross_total: json['gross_total'] as String?,
      vat_amount: json['vat_amount'] as String?,
      added: json['added'] as String?,
    );

Map<String, dynamic> _$SalesProductModelToJson(SalesProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_arabic': instance.name_arabic,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'discounted_price': instance.discounted_price,
      'discount_type': instance.discount_type,
      'total_amount': instance.total_amount,
      'gross_total': instance.gross_total,
      'vat_amount': instance.vat_amount,
      'added': instance.added,
      'id': instance.id,
    };
