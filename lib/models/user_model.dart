import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullName;

  @HiveField(2)
  String? address;

  @HiveField(3)
  int? phoneNumber;

  @HiveField(4)
  String? shopName;

  @HiveField(5)
  String? shopCatogory;

  @HiveField(6)
  String? email;

  @HiveField(7)
  String? password;

  UserModel({
     this.id,
     this.fullName,
     this.address,
     this.phoneNumber,
     this.shopName,
     this.shopCatogory,
     this.email,
     this.password,
  });
}
