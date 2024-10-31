import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khata_store/models/user_model.dart';

import '../../Routes/routes_name.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  bool validateLoginForm() {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and password are required!',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (!GetUtils.isEmail(email.value)) {
      Get.snackbar('Error', 'Invalid email format!',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  Future<void> loginUser() async {
    if (validateLoginForm()) {
      var box = await Hive.openBox<UserModel>('users');

      try {
        UserModel? user = box.values.firstWhere(
              (u) => u.email == email.value && u.password == password.value,
          orElse: () => throw Exception('User not found'),
        );

        Get.offAllNamed(RoutesName.tabbarscreen,  arguments: {'userId': user.id},);
      } catch (e) {
        Get.snackbar('Error', 'Invalid email or password!',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}