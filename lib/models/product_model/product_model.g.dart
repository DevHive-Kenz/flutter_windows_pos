// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      status: fields[0] as int?,
      message: fields[1] as String?,
      result: fields[2] as ProductListModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ProductListModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result?.toJson(),
    };
