// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductListModelAdapter extends TypeAdapter<ProductListModel> {
  @override
  final int typeId = 2;

  @override
  ProductListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductListModel(
      processedListProducts:
          (fields[0] as Map?)?.cast<String, ProductContentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.processedListProducts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListModel _$ProductListModelFromJson(Map<String, dynamic> json) =>
    ProductListModel(
      processedListProducts:
          (json['processedListProducts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, ProductContentModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ProductListModelToJson(ProductListModel instance) =>
    <String, dynamic>{
      'processedListProducts': instance.processedListProducts
          ?.map((k, e) => MapEntry(k, e.toJson())),
    };
