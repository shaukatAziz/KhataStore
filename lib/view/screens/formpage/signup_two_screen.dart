import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../Routes/routes_name.dart';
import '../../../viewModel/controllers/auth_controller/user_controller.dart';
import '../../widgets/custom_button.dart';


class SignUpTwoScreen extends StatefulWidget {
  const SignUpTwoScreen({super.key});

  @override
  State<SignUpTwoScreen> createState() => _SignUpTwoScreenState();
}

class _SignUpTwoScreenState extends State<SignUpTwoScreen> {
  final controller = Get.find<UserController>();


  @override
  void dispose() {

    super.dispose();
  }

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
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
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
                    'Account Details',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter information to protect your account',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onChanged: (value) => controller.shopName.value = value,
                      decoration: InputDecoration(labelText: 'Shop Name'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onChanged: (value) => controller.shopCategory.value = value,
                      decoration: InputDecoration(labelText: 'Shop Category'),
                    ),
                  ),
                  SizedBox(height: 60),
                  RoundButton(
                    onpress: () async {
                     Get.toNamed(RoutesName.signupscreenthree);
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
