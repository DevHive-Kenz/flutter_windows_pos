// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentTypeModelAdapter extends TypeAdapter<PaymentTypeModel> {
  @override
  final int typeId = 8;

  @override
  PaymentTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentTypeModel(
      order: fields[0] as String?,
      cash: fields[1] as String?,
      credit: fields[2] as String?,
      card: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentTypeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.order)
      ..writeByte(1)
      ..write(obj.cash)
      ..writeByte(2)
      ..write(obj.credit)
      ..writeByte(3)
      ..write(obj.card);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTypeModel _$PaymentTypeModelFromJson(Map<String, dynamic> json) =>
    PaymentTypeModel(
      order: json['order'] as String?,
      cash: json['cash'] as String?,
      credit: json['credit'] as String?,
      card: json['card'] as String?,
    );

Map<String, dynamic> _$PaymentTypeModelToJson(PaymentTypeModel instance) =>
    <String, dynamic>{
      'order': instance.order,
      'cash': instance.cash,
      'credit': instance.credit,
      'card': instance.card,
    };
