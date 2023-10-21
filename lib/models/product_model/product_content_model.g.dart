// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_content_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductContentModelAdapter extends TypeAdapter<ProductContentModel> {
  @override
  final int typeId = 3;

  @override
  ProductContentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductContentModel(
      id: fields[0] as int?,
      qty: fields[11] as int?,
      user_id: fields[1] as int?,
      name: fields[2] as String?,
      name_arabic: fields[3] as String?,
      image: fields[4] as String?,
      category_id: fields[5] as int?,
      discount_type: fields[6] as String?,
      discount: fields[7] as num?,
      discounted_price: fields[8] as num?,
      price: fields[9] as num?,
      added: fields[10] as DateTime?,
      priceWithoutVat: fields[12] as double?,
      vat: fields[13] as double?,
      total: fields[14] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductContentModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.user_id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.name_arabic)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.category_id)
      ..writeByte(6)
      ..write(obj.discount_type)
      ..writeByte(7)
      ..write(obj.discount)
      ..writeByte(8)
      ..write(obj.discounted_price)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(10)
      ..write(obj.added)
      ..writeByte(11)
      ..write(obj.qty)
      ..writeByte(12)
      ..write(obj.priceWithoutVat)
      ..writeByte(13)
      ..write(obj.vat)
      ..writeByte(14)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductContentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductContentModel _$ProductContentModelFromJson(Map<String, dynamic> json) =>
    ProductContentModel(
      id: json['id'] as int?,
      qty: json['qty'] as int?,
      user_id: json['user_id'] as int?,
      name: json['name'] as String?,
      name_arabic: json['name_arabic'] as String?,
      image: json['image'] as String?,
      category_id: json['category_id'] as int?,
      discount_type: json['discount_type'] as String?,
      discount: json['discount'] as num?,
      discounted_price: json['discounted_price'] as num?,
      price: json['price'] as num?,
      added: json['added'] == null
          ? null
          : DateTime.parse(json['added'] as String),
      priceWithoutVat: (json['priceWithoutVat'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductContentModelToJson(
        ProductContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'name': instance.name,
      'name_arabic': instance.name_arabic,
      'image': instance.image,
      'category_id': instance.category_id,
      'discount_type': instance.discount_type,
      'discount': instance.discount,
      'discounted_price': instance.discounted_price,
      'price': instance.price,
      'added': instance.added?.toIso8601String(),
      'qty': instance.qty,
      'priceWithoutVat': instance.priceWithoutVat,
      'vat': instance.vat,
      'total': instance.total,
    };
