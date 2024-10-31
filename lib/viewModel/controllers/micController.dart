import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../models/customerModel.dart';
import '../Boxes/box.dart';

class MicController extends GetxController {
  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  bool isSearching = false;

  void addCustomer(dynamic widget) {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      final customer = CustomerModel(
        userId: widget.userId,
        name: nameController.text,
        phoneNumber: numberController.text,
        openingBalance: 0,
        closingBalance: 0,
      );
      Boxes.getData().add(customer);
      Get.back();
      nameController.clear();
      numberController.clear();
    }
  }
}


