// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckInModelAdapter extends TypeAdapter<CheckInModel> {
  @override
  final int typeId = 4;

  @override
  CheckInModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckInModel(
      isCheckIN: fields[0] as bool?,
      checkIn: fields[1] as DateTime?,
      checkOut: fields[2] as DateTime?,
      user: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CheckInModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isCheckIN)
      ..writeByte(1)
      ..write(obj.checkIn)
      ..writeByte(2)
      ..write(obj.checkOut)
      ..writeByte(3)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckInModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInModel _$CheckInModelFromJson(Map<String, dynamic> json) => CheckInModel(
      isCheckIN: json['isCheckIN'] as bool?,
      checkIn: json['checkIn'] == null
          ? null
          : DateTime.parse(json['checkIn'] as String),
      checkOut: json['checkOut'] == null
          ? null
          : DateTime.parse(json['checkOut'] as String),
      user: json['user'] as String?,
    );

Map<String, dynamic> _$CheckInModelToJson(CheckInModel instance) =>
    <String, dynamic>{
      'isCheckIN': instance.isCheckIN,
      'checkIn': instance.checkIn?.toIso8601String(),
      'checkOut': instance.checkOut?.toIso8601String(),
      'user': instance.user,
    };
