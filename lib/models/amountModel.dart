import 'package:hive/hive.dart';

part 'amountModel.g.dart';

@HiveType(typeId: 1)
class AmountModel {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final dynamic customerId;

  @HiveField(4)
  final DateTime? date;
  @HiveField(5)
  final String? userId;
  AmountModel({
    required this.description,
    required this.userId,
    required this.date,
    required this.amount,
    required this.type,
    required this.customerId,
  });
}

