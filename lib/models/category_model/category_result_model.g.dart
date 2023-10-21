// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryResultModelAdapter extends TypeAdapter<CategoryResultModel> {
  @override
  final int typeId = 10;

  @override
  CategoryResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryResultModel(
      id: fields[0] as int?,
      userId: fields[1] as int?,
      image: fields[2] as String?,
      name: fields[5] as String?,
      discount: fields[4] as num?,
      discountType: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryResultModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.discountType)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResultModel _$CategoryResultModelFromJson(Map<String, dynamic> json) =>
    CategoryResultModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      discount: json['discount'] as num?,
      discountType: json['discount_type'] as String?,
    );

Map<String, dynamic> _$CategoryResultModelToJson(
        CategoryResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'image': instance.image,
      'discount_type': instance.discountType,
      'discount': instance.discount,
      'name': instance.name,
    };
