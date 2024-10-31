import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata_store/Routes/routes_name.dart';
import 'package:uuid/uuid.dart';

import '../../../models/user_model.dart';
import '../../../utils/toast_messages.dart';


class UserController extends GetxController {
  var fullname = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;
  var shopName = ''.obs;
  var shopCategory = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  final uuid = Uuid();

  bool validateForm() {
    if (fullname.value.isEmpty ||
        address.value.isEmpty ||
        phoneNumber.value.isEmpty ||
        shopName.value.isEmpty ||
        shopCategory.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty) {
      ToastMessage.messagesRed('Error', 'Field Missing');
      return false;
    }

    if (!GetUtils.isEmail(email.value)) {
      Get.snackbar('Error', 'Invalid email format!',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (password.value.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long!',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  Future<void> submitForm() async {
    if (validateForm()) {
      var box = await Hive.openBox<UserModel>('users');
      var newUser = UserModel(
        id: uuid.v4(),
        fullName: fullname.value,
        address: address.value,
        phoneNumber: int.parse(phoneNumber.value),
        shopName: shopName.value,
        shopCatogory: shopCategory.value,
        email: email.value,
        password: password.value,
      );

      await box.add(newUser);
      ToastMessage.messagesGreen('Signup', 'Signup Successful');
      Get.toNamed(RoutesName.loginscreen, arguments: {'userId': newUser.id},);
    }
  }

  void logout() {

    fullname.value = '';
    address.value = '';
    phoneNumber.value = '';
    shopName.value = '';
    shopCategory.value = '';
    email.value = '';
    password.value = '';



    Get.offAllNamed(RoutesName.loginscreen);
  }
}

