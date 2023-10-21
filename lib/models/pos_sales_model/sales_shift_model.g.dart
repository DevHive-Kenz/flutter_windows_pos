// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_shift_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesShiftModelAdapter extends TypeAdapter<SalesShiftModel> {
  @override
  final int typeId = 7;

  @override
  SalesShiftModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesShiftModel(
      user: fields[0] as int?,
      check_in_time: fields[1] as String?,
      check_out_time: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SalesShiftModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.check_in_time)
      ..writeByte(2)
      ..write(obj.check_out_time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesShiftModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesShiftModel _$SalesShiftModelFromJson(Map<String, dynamic> json) =>
    SalesShiftModel(
      user: json['user'] as int?,
      check_in_time: json['check_in_time'] as String?,
      check_out_time: json['check_out_time'] as String?,
    );

Map<String, dynamic> _$SalesShiftModelToJson(SalesShiftModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'check_in_time': instance.check_in_time,
      'check_out_time': instance.check_out_time,
    };
