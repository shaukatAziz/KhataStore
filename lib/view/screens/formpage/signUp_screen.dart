import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Routes/routes_name.dart';
import '../../../viewModel/controllers/auth_controller/user_controller.dart';
import '../../widgets/custom_button.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final  controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 90,
            right: 20,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 180,
            left: 20,
            child: Form(
              child: Column(
                children: [
                  Text(
                    'Start With Personal Information',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter personal Information to proceed',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onChanged: (value) => controller.fullname.value = value,
                      decoration: InputDecoration(labelText: 'Full Name'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onChanged: (value) => controller.address.value = value,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) => controller.phoneNumber.value = value,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                  ),
                  SizedBox(height: 60),
                  RoundButton(
                    onpress: ()  {
                      Get.toNamed(RoutesName.signupscreentwo);
                    },
                    title: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
