import 'package:hive/hive.dart';
part 'customerModel.g.dart';
@HiveType(typeId: 0)
class CustomerModel extends HiveObject{
  @HiveField(0)
  String? name;
  @HiveField(1)

  String? phoneNumber;
  @HiveField(2)
  double? openingBalance;
  @HiveField(3)
  double? closingBalance;
  @HiveField(4)
  String? userId;

  CustomerModel({
    required this.name,
    required this.phoneNumber,
    required this.openingBalance,
    required this.closingBalance,
    required this.userId
  });
}