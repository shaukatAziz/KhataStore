// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amountModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmountModelAdapter extends TypeAdapter<AmountModel> {
  @override
  final int typeId = 1;

  @override
  AmountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AmountModel(
      description: fields[0] as String,
      userId: fields[5] as String?,
      date: fields[4] as DateTime?,
      amount: fields[1] as double,
      type: fields[2] as String,
      customerId: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AmountModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.customerId)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
