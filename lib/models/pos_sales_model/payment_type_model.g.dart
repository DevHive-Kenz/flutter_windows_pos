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
      amount: fields[1] as String?,
      paymentMethod: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentTypeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.paymentMethod)
      ..writeByte(1)
      ..write(obj.amount);
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
      amount: json['amount'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
    );

Map<String, dynamic> _$PaymentTypeModelToJson(PaymentTypeModel instance) =>
    <String, dynamic>{
      'paymentMethod': instance.paymentMethod,
      'amount': instance.amount,
    };
