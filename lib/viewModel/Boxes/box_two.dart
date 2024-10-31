

import 'package:hive/hive.dart';

import '../../models/user_model.dart';

class userBox{
  static Box<UserModel>getData()=>Hive.box('users');
}