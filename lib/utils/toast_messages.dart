import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastMessage{
 static  messagesRed(var title,var message){
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 1)

    );
  }
 static  messagesGreen(var title,var message,){
   Get.snackbar(
       title,
       message,
       snackPosition: SnackPosition.BOTTOM,
       colorText: Colors.white,
       backgroundColor: Colors.green,
     duration: const Duration(seconds: 1)

   );
 }
}